import { Controller } from "@hotwired/stimulus"
import "tui-time-picker";
import "tui-calendar";
import Calendar from "tui-calendar";

export default class extends Controller {
  getCalendarData(){
    var schedules = JSON.parse(document.querySelector("#calendar").dataset.schedules);
    window.schedules = schedules;

    console.log(schedules)

    schedules.forEach(schedule => {
      if(schedule.task.starts_at == null){
        this.calendar.createSchedules([
          {
            id: schedule.task.id,
            calendarId: '1',
            title: schedule.task.title,
            category: 'task',
            start: schedule.task.ends_at,
            end: schedule.task.ends_at,
            bgColor: schedule.job.color,
          }
          ]);
      }else{
        this.calendar.createSchedules([
          {
            id: schedule.task.id,
            calendarId: '1',
            title: schedule.task.title,
            category: 'time',
            start: schedule.task.starts_at,
            end: schedule.task.ends_at,
            bgColor: schedule.job.color,
          }
          ]);
      }
    });

  }

  moveToNextOrPrevRange(event) {
    var val = parseInt(event.currentTarget.dataset.value);
    
    if (val === -1) {
    this.calendar.prev();
    } else if (val === 1) {
    this.calendar.next();
    }
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
      taskView: ['task'],
      scheduleView: ['time'],
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
          allday: function(schedule) {
              return schedule.title + ' <i class="fa fa-refresh"></i>';
          },
          time: function(schedule) {
              return schedule.title + ' <i class="fa fa-refresh"></i>' + schedule.start;
          },
          popupDetailBody: function(schedule) {
            return 'Note : ' + schedule.note;
          },
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
