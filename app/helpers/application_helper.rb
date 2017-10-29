module ApplicationHelper
  # `ActiveSupport::Inflector.parameterize` supports ASCII symbols only (non-ASCII should
  # be transliterated first). We don't want to transliterate for SEO reasons, thus we
  # duplicate the logic here with Unicode support.
  def parameterize(string)
    string.gsub(/[^\p{L}]+/, "-").chomp("-").downcase
  end

  def book_title(book)
    author_aliases = book.works.to_a.uniq(&:person_alias_id).map do |work|
      person_alias(work.person_alias)
    end

    "#{author_aliases.join ", "} «#{book.title}»"
  end

  # Gender-aware work type name
  def work_type_name(work)
    case work.person.gender
    when "female" then work.type.name_feminine
    when "male" then work.type.name_masculine
    end
  end

  def person_alias(person_alias)
    "#{person_alias.first_name} #{person_alias.last_name}"
  end
end
