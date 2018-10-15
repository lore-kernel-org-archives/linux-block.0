Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Mon, 15 Oct 2018 21:17:46 +0200
Message-ID: <20263939.GgfHUqOn1T@blindfold>
In-Reply-To: <20181015084541.GA27159@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <4055590.4i3nx3fRmo@blindfold> <20181015084541.GA27159@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Am Montag, 15. Oktober 2018, 10:45:41 CEST schrieb Christoph Hellwig:
> On Mon, Oct 15, 2018 at 10:40:06AM +0200, Richard Weinberger wrote:
> > hm, this breaks UML.
> > Every filesystem fails to mount.
> > 
> > I did some very rough tests, it seems that the driver fails to read
> > data correctly as soon the upper layer tries to get more than 4096 bytes
> > at once out of the block device.
> > 
> > IOW:
> > dd if=/dev/ubda bs=4096 count=1 skip=0 2>/dev/null| md5sum -
> > is good.
> > As soon I set bs to something greater it returns garbage.
> > 
> > Later this day I might have some cycles left to debug further.
> 
> It probably needs this on top:

Sadly not. I'm checking now what exactly is broken.
BTW: Why are you using for_each_bio() with bio_for_each_segment()?
I thought we have rq_for_each_segment() for that.
 
Thanks,
//richard
