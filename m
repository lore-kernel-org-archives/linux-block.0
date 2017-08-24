Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 24 Aug 2017 16:49:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH v2] blk-mq-debugfs: Add names for recently added flags
Message-ID: <20170824234915.GD6964@vader.DHCP.thefacebook.com>
References: <20170818225254.30706-1-bart.vanassche@wdc.com>
 <1503617445.2899.129.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503617445.2899.129.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 24, 2017 at 11:30:46PM +0000, Bart Van Assche wrote:
> On Fri, 2017-08-18 at 15:52 -0700, Bart Van Assche wrote:
> > The symbolic constants QUEUE_FLAG_SCSI_PASSTHROUGH, QUEUE_FLAG_QUIESCED
> > and REQ_NOWAIT are missing from blk-mq-debugfs.c. Add these to
> > blk-mq-debugfs.c such that these appear as names in debugfs instead of
> > as numbers.
> 
> Hi Jens,
> 
> Have you already had the time to have a look at this patch?
> 
> Thanks,
> 
> Bart.

Reviewed-by: Omar Sandoval <osandov@fb.com>

FWIW
