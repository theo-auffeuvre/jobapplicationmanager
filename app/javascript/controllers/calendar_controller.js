import { Controller } from "@hotwired/stimulus"
import "tui-time-picker";
import "tui-calendar";
import Calendar from "tui-calendar";

export default class extends Controller {
  getCalendarData(){
    var schedules = JSON.parse(document.querySelector("#calendar").dataset.schedules);
    window.schedules = schedules;
    schedules.forEach(schedule => {
    this.calendar.createSchedules([
    {
      id: schedule.id,
      calendarId: '1',
      title: schedule.title,
      category: 'time',
      start: schedule.starts_at,
      end: schedule.ends_at
    }
    ])
    });
  }

  connect() {
    this.calendar = new Calendar(document.getElementById('calendar'), {
      id: "1",
      name: "My Calendar",
      defaultView: 'week',
      color: '#00a9ff',
        bgColor: '#00a9ff',
        dragBgColor: '#00a9ff',
        borderColor: 'red',

      useCreationPopup: false,
      useDetailPopup: true,
      taskView: false,
      alldayView: false,
      template: {

        popupDetailRepeat: function(schedule) {
          return 'Repeat : ' + schedule.recurrenceRule;
        },

        popupStateFree: function() {
          return 'Free';
        },
          milestone: function(schedule) {
              return '<span style="color:red;"><i class="fa fa-flag"></i> ' + schedule.title + '</span>';
          },
          milestoneTitle: function() {
              return 'Milestone';
          },
          task: function(schedule) {
              return '&nbsp;&nbsp;#' + schedule.title;
          },
          taskTitle: function() {
              return '<label><input type="checkbox" />Task</label>';
          },
          allday: function(schedule) {
              return schedule.title + ' <i class="fa fa-refresh"></i>';
          },
          alldayTitle: function() {
              return 'All Day';
          },
          time: function(schedule) {
              return schedule.title + ' <i class="fa fa-refresh"></i>' + schedule.start;
          }
      },
      month: {
          daynames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
          startDayOfWeek: 0,
          narrowWeekend: true
      },
      week: {
          daynames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
          startDayOfWeek: 0,
          narrowWeekend: true
      }
    });

    this.getCalendarData()
  }


}
