
struct Configurate {
    
    static func with<ProviderSequence: Sequence>(_ providers: ProviderSequence) -> Config
        where ProviderSequence.Element: KeyedAccessCollection,
        ProviderSequence.Element.Key == String,
        ProviderSequence.Element.Value == Any {
     
        return Config(providers)
    }
    
    private init() { }
}
