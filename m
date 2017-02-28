Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 28 Feb 2017 11:15:12 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] sbitmap: boundary checks for resized bitmap
Message-ID: <20170228191512.GA28004@vader.DHCP.thefacebook.com>
References: <1487157042-5621-1-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487157042-5621-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 12:10:42PM +0100, Hannes Reinecke wrote:
> If the sbitmap gets resized we need to ensure not to overflow
> the original allocation. And we should limit the search in
> sbitmap_any_bit_set() to the available depth to avoid looking
> into unused space.

Hey, Hannes, I don't really like this change. It's easy enough for the
caller to keep track of this and check themselves if they really care. I
even included a comment in sbitmap.h to that effect:

/**
 * sbitmap_resize() - Resize a &struct sbitmap.
 * @sb: Bitmap to resize.
 * @depth: New number of bits to resize to.
 *
 * Doesn't reallocate anything. It's up to the caller to ensure that the new
 * depth doesn't exceed the depth that the sb was initialized with.
 */


As for the sbitmap_any_bit_set() change, the bits beyond the actual
depth should all be zero, so I don't think that change is worth it,
either.

Thanks!
