package state.substate;

class FlxCustomSubState extends FlxSubState {
	public var hxArray:Array<HScript> = [];
	private var substatePath:String;
	public static var instance:FlxCustomSubState;
	
	public function new(subStateName:String) {
		instance = this;
		substatePath = subStateName;
		super();
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('substates/$substatePath.hx'))) {
			hxArray.push(new HScript(Paths.getPath('substates/$substatePath.hx')));
		} else {
			SUtil.alert('Error on loading substate', "couldn't load substate $substatePath");
			close();
		}

        super.create();

		callOnHx('create', []);
	}
	
	override function update(elapsed:Float) {
		super.update(elapsed);

		callOnHx('update', [elapsed]);
	}
	
	override function destroy() {
		for (hx in hxArray) {
		    if (hx != null) {
			    hx.call('destroy', []);
			    hx.stop();
			    hx = null;
		    }
		}
		super.destroy();
	}

	public function callOnHx(name:String, args:Array<Dynamic>):Dynamic {
        var result:Dynamic = null;
		for (hx in hxArray) {
			result = hx.call(name, args);
		}
		return result;
	}
}