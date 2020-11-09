<img align="center" src="/src/Gif_PeppoHacker/PeppoHacker.gif"/>

# AS3: *.GIF support [![license-badge]][license]
Contains some dependencies used to run GIF files in your AS3 project.

## Languages
![as3-language-badge] ![flex-language-badge]

## Intro
Firstly, you need to know what is the [`*.GIF`][ref-1] extension:
> A GIF is a lossless format for image files that supports both animated and static images. It was the standard for 8-bit colour images on the internet until PNG became a viable alternative. You may have seen them used often in email signatures. Animated GIFs are several images or frames combined into a single file.

In other words, you can actually split your GIF file into a collection of several frames, whose could be exported as `*.PNG` format type.

## Tutorial
- **Step 1** - split your GIF file into a collection of several frames

   This is the first step needed to properly setup GIF support for your AS3 project, you can use [EZGIF.com - GIF frame extractor][ref-3] or any other online tool, as long you have all desired frames from your GIF.
   
- **Step 2** - setup a template for your GIF

   With your GIF frames in hands, create a new folder (to keep it organised) and place all frames there.
   
   ![media-1]
   
- **Step 3** - create a new file for your GIF class

   This class will be responsible to extends most used GIF behaviors like:
   - [**`GIF::play()`**][dref-1] - play the GIF frames loop; and
   - [**`GIF::stop()`**][dref-2] - stop the GIF frames loop.
   
   Your class file might look like example below (if you have various frames to process, checkout this [script][ref-6]):
   
   > :bulb: **Note:** you can control the frame delay speed with parameter `frameDelay` on [**`GIF::constructor()`**][dref-3].
   
```actionscript
import GIF;

import mx.core.BitmapAsset;

public class PeppoHackerGIF extends GIF {
    [Embed(source="frame_00_delay-0.07s.gif")]
    private const frame0:Class;
    [Embed(source="frame_01_delay-0.07s.gif")]
    private const frame1:Class;
    [Embed(source="frame_02_delay-0.07s.gif")]
    private const frame2:Class;
    
    // ... frames declaration scope
    
    [Embed(source="frame_19_delay-0.07s.gif")]
    private const frame19:Class;

    public function PeppoHackerGIF() {
        super(70, new <BitmapAsset>[
            new this.frame0 as BitmapAsset,
            new this.frame1 as BitmapAsset,
            new this.frame2 as BitmapAsset,
            
            // ... frames assign
            
            new this.frame19 as BitmapAsset
        ]);
    }
}
```
- **Step 4** - usage of your GIF class in action

   It's done. You can now control your GIF dynamically and attach to your [`Sprite`][ref-4] using [`Object::AddChild()`][ref-5].
   
```actionscript
var peppoGIF:GIF = new PeppoHackerGIF();
peppoGIF.start();
this.addChild(peppoGIF);
```

---

## C# code: this is used at [rextester.com][ref-2] to make it dynamic formatting

Make sure to change pattern of your file name and also amout of frames that'll be generated with this code using variables `attributePattern` and `amount`, see output for more details how it does behave.

> :warning: **Note:** this C# program execution is optional, just in case you have tons of frames to process in a single file.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Rextester
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var attributePattern = "[Embed(source=\"frame_{frame_index}_delay-0.07s.gif\")]";
            var propertyPattern = "private const frame{frame_index}:Class;";
            var vectorPattern = "new <BitmapAsset>[\n{frames}\n]";
            var frames = new StringBuilder();
            var amount = 3;
            for (var i = 0; i <= amount; i++) {
                frames.Append($"\tnew this.frame{i} as BitmapAsset{(i + 1 > amount ? "" : ",\n")}");
                Console.WriteLine(
                    $"{attributePattern.Replace("{frame_index}", i.ToString("00"))}" +
                    $"\n{propertyPattern.Replace("{frame_index}", i.ToString())}"
                );
            }

            Console.WriteLine($"\n{vectorPattern.Replace("{frames}", frames.ToString())}");
        }
    }
}
```

<details open>
<summary>output</summary>

```actionscript
[Embed(source="frame_00_delay-0.07s.gif")]
private const frame0:Class;
[Embed(source="frame_01_delay-0.07s.gif")]
private const frame1:Class;
[Embed(source="frame_02_delay-0.07s.gif")]
private const frame2:Class;
[Embed(source="frame_03_delay-0.07s.gif")]
private const frame3:Class;

new <BitmapAsset>[
	new this.frame0 as BitmapAsset,
	new this.frame1 as BitmapAsset,
	new this.frame2 as BitmapAsset,
	new this.frame3 as BitmapAsset
]
```
</details>

### Contributors
- [@Devwarlt][devwarlt-ref]

[devwarlt-ref]: https://github.com/Devwarlt

[as3-language-badge]: https://img.shields.io/badge/ActionScript-3.0-yellow?logo=adobe&style=plastic
[flex-language-badge]: https://img.shields.io/badge/FLEX-gray?logo=adobe&style=plastic

[license-badge]: https://img.shields.io/badge/License-WTFPL-black?style=plastic
[license]: /LICENSE

[dref-1]: https://github.com/Devwarlt/as3-gif-support/blob/cdcae582acab567d138b03cc083f310ab387a3a0/src/GIF.as#L31-L37
[dref-2]: https://github.com/Devwarlt/as3-gif-support/blob/cdcae582acab567d138b03cc083f310ab387a3a0/src/GIF.as#L39-L46
[dref-3]: https://github.com/Devwarlt/as3-gif-support/blob/cdcae582acab567d138b03cc083f310ab387a3a0/src/GIF.as#L9

[ref-1]: https://digitalcommunications.wp.st-andrews.ac.uk/2019/06/14/what-is-a-gif-file/#:~:text=A%20GIF%20is%20a%20lossless,combined%20into%20a%20single%20file.
[ref-2]: https://rextester.com
[ref-3]: https://ezgif.com/split
[ref-4]: https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Sprite.html
[ref-5]: https://help.adobe.com/pt_BR/FlashPlatform/reference/actionscript/3/mx/states/AddChild.html
[ref-6]: #c-code-this-is-used-at-rextestercom-to-make-it-dynamic-formatting

[media-1]: /media/gif_template_1.PNG
