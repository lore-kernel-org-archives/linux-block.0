Return-Path: <jthumshirn@suse.de>
Date: Tue, 29 May 2018 10:16:31 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] nvmet: implement the changed namespaces log
Message-ID: <20180529081631.mct6zjk54xjl4d6p@linux-x5ow.site>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
 <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
 <20180529081712.GD1416@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180529081712.GD1416@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 29, 2018 at 10:17:12AM +0200, Christoph Hellwig wrote:
> On Mon, May 28, 2018 at 08:53:42AM +0200, Johannes Thumshirn wrote:
> > Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > 
> > As a side note, what happens if more than 1024 Namespaces are changed
> > (apart from setting the 1st element to 0xffffffff and zeroing out the
> > rest)?
> > 
> > The Spec is pretty silent in this regard.
> 
> The spec is completly clear on this:
> 
> From 5.14.1.4:
> 
> "If more than 1024 namespaces have changed attributes since the last time the
>  log page was read, the first entry in the log page shall be set to FFFFFFFFh
>  and the remainder of the list shall be zero-filled."
> 
> Once we don't know what changed we'll have to do a full rescan using
> Identify.

The "full rescan" part was what I couldn't read out of the spec.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
