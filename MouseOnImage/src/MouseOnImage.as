package
{
	import flash.display.Sprite;
	
	public class MouseOnImage extends Sprite
	{
		public function MouseOnImage()
		{
			
		}
		
		/**
		 *显示初使化 
		 */		
		private function initShow():void
		{
			var idx:int = 0;
			var length:uint = 0;
			var srcW:int = int( params.privilege_imgs_param.imgW );
			var srcH:int = int( params.privilege_imgs_param.imgH );
			
			length = privilege_imgs.length;
			for ( idx = 0; idx < length; ++idx )
			{
				var image:UIImage = privilege_imgs[ idx ].img;
				image.selectImageToShow( idx );
				image.fnOnOver = onOverPrivilegeImg;
				image.controlData = String( idx );
				privilege_imgs[ idx ].visible = true;
				
				var shape:Shape = new Shape(); 
				shape.graphics.beginFill( 0xffffff, 0.3 ); 
				shape.graphics.drawRoundRect( 0, 0, srcW, srcH, 8, 8 ); 
				shape.graphics.endFill();
				shape.visible = false;
				privilege_imgs[ idx ].addChild( shape );
				_privilege_imgsShape [ idx ] = shape;
			}
			refreshPrivilegeImgs( params.privilege_imgs_param.sel );
		}
		/**
		 * 指向图片时触发
		 */		
		private function onOverPrivilegeImg( ui:UIComponent, event:MouseEvent ):void
		{
			_______Statistics______.begin(arguments,arguments.callee);
			if ( event.type == MouseEvent.MOUSE_OVER )
			{
				refreshPrivilegeImgs( int( ui.controlData ) );
			}
			_______Statistics______.end(arguments.callee);
		}
		/**
		 * 刷新相关图片
		 * @param selectedIdx 当前选中或指向的图片
		 */		
		private function refreshPrivilegeImgs( selectedIdx:int ):void
		{
			var idx:int = 0;
			var length:int = 0;
			var midSizeIdx:int = 0;
			var refreshParam:Object = params.privilege_imgs_param;
			
			if ( selectedIdx >= privilege_imgs.length )
			{
				_______Statistics______.end(arguments.callee);
				return;
			}
			
			var endX:int = 0;
			var endY:int = 0;
			var prevWidth:int = 0;
			var prevHeight:int = 0;
			
			if ( selectedIdx == 0 )
				_mouseDir = 1;
			else if ( selectedIdx == privilege_imgs.length - 1 )
				_mouseDir = -1;
			
			midSizeIdx = selectedIdx + _mouseDir;
			
			for ( idx = 0; idx < privilege_imgs.length; ++idx )
			{
				var scale:Number = 1;
				var srcW:int = int( refreshParam.imgW );
				var srcH:int = int( refreshParam.imgH );
				var group:UIComponent = privilege_imgs[ idx ];
				
				if ( idx == midSizeIdx )
					scale = refreshParam.scales[ 1 ];
				else if ( idx == selectedIdx )
					scale = refreshParam.scales[ 2 ];
				else
					scale = refreshParam.scales[ 0 ];
				
				var shape:Shape = _privilege_imgsShape[ idx ];
				if ( shape != null )
					shape.visible = ( idx != selectedIdx );	
				
				if ( idx > 0 )
					endX += prevWidth;
				else
					endX = group.x;
				
				prevWidth = srcW * scale;
				prevHeight = srcH * scale;
				endY = int( refreshParam.zeroLineY ) - int( prevHeight / 2 );
				
				TweenLite.to( group, 0.5, { x:endX, y:endY, scaleX:scale, scaleY:scale } );
			}
		}
	}
}