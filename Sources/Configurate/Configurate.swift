
public struct Configurate {
    
    public static func withDefaults<Provider: KeyedAccessCollection>(_ provider: Provider) -> Config
        where Provider.Key == String,
        Provider.Value == Any {
     
        return Config(provider)
    }
    
    public static func withDefaults(_ provider: [String: Any]) -> Config {
            
        return Config(provider)
    }
    
    private init() { }
}
