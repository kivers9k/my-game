package;

class FlxCustomState extends FlxState {
    public static var onCreate:Void -> Void;
    public static var onCreatePost:Void -> Void;

    public static var onUpdate:Void -> Void;
    public static var onUpdatePost:Void -> Void;

    public var instance:FlxCustomState;

    public function new() {
        instance = this;
        super();
    }

    override function create() {
        onCreate();
        super.create();
        onCreatePost();
    }

    override function update(elapsed:Float) {
        onUpdate(elapsed);
        super.update(elapsed);
        onUpdatePost(elapsed);
    }
}