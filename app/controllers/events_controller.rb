# frozen_string_literal: true

class EventsController < ApplicationController
  ERROR_LOGS_AMOUNT = 10

  def show
    @customers = PointsReportQuery.call
    @logs = EventErrorLog.last(ERROR_LOGS_AMOUNT)
  end

  def create
    ProcessEventsWorker.perform_async(permitted_params)
    redirect_to event_path
  end

  private

  def permitted_params
    JSON.parse(params[:event_data], symbolize_names: true)[:events]
  end
end
