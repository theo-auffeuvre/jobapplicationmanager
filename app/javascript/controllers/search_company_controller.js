import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "searchbar", "results", "logourl" ]

  change() {
    const url = `/companies/search_company/?search=${this.searchbarTarget.value}`;
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";
      data.forEach((company) => {
        this.resultsTarget.innerHTML += `
        <li class="rounded-b-md px-3" data-action="click->search-company#select">
          <div class="flex items-center h-full justify-between">
            <div>${company.name}</div>
            <img src="${company.logo}" alt="logo" class="object-cover h-8 w-8">
          </div>
        </li>`
      });
      this.resultsTarget.insertAdjacentHTML("beforeend", `
      <li class="flex rounded-b-md px-3 justify-between" data-action="click->search-company#select">
        <div class="flex items-center h-full justify-between">
          <div>${this.searchbarTarget.value}</div>
          <span class="text-sm">Add custom company</span>
          <img src="" alt="logo" hidden>
        </div>
      </li>`)
      });
  }

  select(event) {
    const company = event.currentTarget.firstElementChild.firstElementChild.innerText;
    const logo = event.currentTarget.firstElementChild.firstElementChild.nextElementSibling.src;
    this.searchbarTarget.value = company;
    this.logourlTarget.value = logo;
    this.resultsTarget.innerHTML = "";
  }
}
