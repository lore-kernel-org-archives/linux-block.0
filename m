Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 21 Aug 2017 11:47:52 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, kzak@redhat.com, axboe@kernel.dk,
	hare@suse.de
Subject: Re: [PATCH] loop: Fix freeze if configured block size is not
 supported
Message-ID: <20170821184752.GB16030@vader.DHCP.thefacebook.com>
References: <20170818130733.11254-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170818130733.11254-1-gmazyland@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 18, 2017 at 03:07:33PM +0200, Milan Broz wrote:
> The commit f2c6df7dbf9a60e1cd9941f9fb376d4d9ad1e8dd
> 
>     loop: support 4k physical blocksize
> 
> adds support for loop block size with only specific block sizes.
> 
> If the size is not supported, the code returns -EINVAL keeping
> the loop queue frozen. This causes that device could be locked
> for a long time by processes trying to scan device (udev).
> (And also causing subsequent LOOP_CLR_FD operations noop.)
> 
> Fix it by using goto to proper exit location with queue unfreeze.
> 
> (The same bug is for setting crypt attribute but this code is
> probably no more used. Patch fixes it as well though.)
> 
> Signed-off-by: Milan Broz <gmazyland@gmail.com>

Heh, I sent the same patch [1] only hours before :) v2 is here [2] if
you want to give it a reviewed-by.

1: https://marc.info/?l=linux-block&m=150303694018659&w=2
2: https://marc.info/?l=linux-block&m=150308446732748&w=2
