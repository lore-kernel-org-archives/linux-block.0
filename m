Return-Path: <hare@suse.de>
Subject: Re: [PATCH] sbitmap: boundary checks for resized bitmap
To: Omar Sandoval <osandov@osandov.com>
References: <1487157042-5621-1-git-send-email-hare@suse.de>
 <20170228191512.GA28004@vader.DHCP.thefacebook.com>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <45968daf-5424-d273-d38d-d5c7f992f562@suse.de>
Date: Wed, 1 Mar 2017 16:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170228191512.GA28004@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/28/2017 08:15 PM, Omar Sandoval wrote:
> On Wed, Feb 15, 2017 at 12:10:42PM +0100, Hannes Reinecke wrote:
>> If the sbitmap gets resized we need to ensure not to overflow
>> the original allocation. And we should limit the search in
>> sbitmap_any_bit_set() to the available depth to avoid looking
>> into unused space.
> 
> Hey, Hannes, I don't really like this change. It's easy enough for the
> caller to keep track of this and check themselves if they really care. I
> even included a comment in sbitmap.h to that effect:
> 
Okay.

> /**
>  * sbitmap_resize() - Resize a &struct sbitmap.
>  * @sb: Bitmap to resize.
>  * @depth: New number of bits to resize to.
>  *
>  * Doesn't reallocate anything. It's up to the caller to ensure that the new
>  * depth doesn't exceed the depth that the sb was initialized with.
>  */
> 
> 
> As for the sbitmap_any_bit_set() change, the bits beyond the actual
> depth should all be zero, so I don't think that change is worth it,
> either.
> 
Hmm. That would be okay if we can be sure that the remaining bits really
are zero. Which probably would need to be checked by the caller, too.

So yeah, if you don't like it, okay.
Just ignore it then.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
