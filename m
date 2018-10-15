Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Mon, 15 Oct 2018 10:40:06 +0200
Message-ID: <4055590.4i3nx3fRmo@blindfold>
In-Reply-To: <20181015065637.1860-1-hch@lst.de>
References: <20181015065637.1860-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Christoph,

[CC'ing also Anton, he improved the old driver a lot.]

Anton, this patch is based on:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/?h=mq-conversions

Am Montag, 15. Oktober 2018, 08:56:37 CEST schrieb Christoph Hellwig:
> There is no good reason to create a scatterlist in the ubd driver,
> it can just iterate the request directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Now that we have the blk-mq conversion something like the patch below
> should help to simplify the driver even further.

hm, this breaks UML.
Every filesystem fails to mount.

I did some very rough tests, it seems that the driver fails to read
data correctly as soon the upper layer tries to get more than 4096 bytes
at once out of the block device.

IOW:
dd if=/dev/ubda bs=4096 count=1 skip=0 2>/dev/null| md5sum -
is good.
As soon I set bs to something greater it returns garbage.

Later this day I might have some cycles left to debug further.

Thanks,
//richard
