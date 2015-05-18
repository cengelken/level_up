class ProgressSummary

  attr_reader :enrollments, :end_date, :start_date

  def initialize(enrollments, options = {})
    @enrollments  = enrollments
    @end_date     = as_date(options.fetch(:end_date, Date.today))
    @start_date   = as_date(options.fetch(:start_date, enrollments.minimum(:created_at)))
  end

  def to_a
    @enrollments.map do |enrollment|
      summarize_progress_for_enrollment(enrollment)
    end
  end

  def summarize_progress_for_enrollment(enrollment)
    { course_name: enrollment.course.name, progress: progress_burndown(enrollment) }
  end
  private :summarize_progress_for_enrollment

  def as_date(val)
    return val if val.kind_of? Date
    return val.to_date if val.respond_to? :to_date
    return Date.parse(val) if val.kind_of? String
    raise InvalidArgumentError
  end
  private :as_date

  def progress_burndown(enrollment)
    skills_left = enrollment.course.skills.count
    start_date.upto(end_date).each_with_object({}) do |date, hash|
      hash[date] = skills_left
    end
  end
  private :progress_burndown

  #
  # [
  #   {
  #     course_name: '',
  #     progress: {
  #       '2015-01-01' : 50,
  #       '2015-01-02' : 48,
  #     }
  #   },
  #   ...
  # ]
  #

end
