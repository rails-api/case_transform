# frozen_string_literal: true

RSpec.describe CaseTransform2::HashExt do
  it do
    hash = { foo: "Bar" }
    subject.deep_transform_keys!(hash) { |k| "_#{k}".to_sym }
    expect(hash).to eq(_foo: "Bar")

    hash = { "baz" => "Bar" }
    subject.deep_transform_keys!(hash) { |k| "_#{k}" }
    expect(hash).to eq("_baz" => "Bar")

    hash = { "baz" => "Bar" }
    subject.deep_transform_keys!(hash, &:capitalize)
    expect(hash).to eq("Baz" => "Bar")

    obj = [{ foo: "bar" },
           { qwe: "qwe" }]

    subject.deep_transform_keys!(obj) { |key| "...#{key}".to_sym }
    expect(obj).to eq([{ :'...foo' => "bar" },
                       { :'...qwe' => "qwe" }])
  end
end
