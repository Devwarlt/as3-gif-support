import flash.display.Bitmap;
import flash.display.Sprite;
import flash.utils.clearInterval;
import flash.utils.setInterval;

import mx.core.BitmapAsset;

public class GIF extends Sprite {
    public function GIF(frameDelay:int, frames:Vector.<BitmapAsset>) {
        this._frameDelay = frameDelay;
        this._frames = frames;

        this._currentFrame = 0;
        this._maxFrames = frames.length;
        this._isPlaying = false;

        this._bitmap = new Bitmap();
        this._bitmap.bitmapData = frames[0].bitmapData;

        addChild(this._bitmap);
    }

    private var _bitmap:Bitmap;
    private var _maxFrames:int;
    private var _frameDelay:int;
    private var _frames:Vector.<BitmapAsset>;
    private var _id:uint;
    private var _isPlaying:Boolean;
    private var _currentFrame:int;

    public function play():void {
        if (this._isPlaying)
            return;

        this._isPlaying = true;
        this._id = setInterval(this.playFrames, this._frameDelay);
    }

    public function stop():void {
        if (!this._isPlaying)
            return;

        this._isPlaying = false;

        clearInterval(this._id);
    }

    private function playFrames():void {
        if (this._currentFrame >= this._maxFrames)
            this._currentFrame = 0;

        this._bitmap.bitmapData = this._frames[this._currentFrame++].bitmapData;
    }
}
