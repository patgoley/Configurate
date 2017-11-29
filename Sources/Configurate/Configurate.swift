
public struct Configurate {
    
    public static func with<Provider: KeyedAccessCollection>(_ provider: Provider) -> Config
        where Provider.Key == String,
        Provider.Value == Any {
     
        return Config(provider)
    }
    
    private init() { }
}
