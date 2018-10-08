Return-Path: <jthumshirn@suse.de>
Date: Mon, 8 Oct 2018 11:15:03 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@osandov.com>,
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet
 been started
Message-ID: <20181008091503.GA8074@linux-x5ow.site>
References: <20181004173524.52712-1-bvanassche@acm.org>
 <a3f6a55e-eaa5-6a65-8360-9d85c7566961@kernel.dk>
 <20181005223718.GL25437@vader>
 <499d4461-5452-26c5-5b47-b1f9ec5877d8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <499d4461-5452-26c5-5b47-b1f9ec5877d8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 05, 2018 at 07:13:32PM -0600, Jens Axboe wrote:
> On 10/5/18 4:37 PM, Omar Sandoval wrote:
> > On Fri, Oct 05, 2018 at 08:18:00AM -0600, Jens Axboe wrote:
> >> On 10/4/18 11:35 AM, Bart Van Assche wrote:
> >>> When debugging e.g. the SCSI timeout handler it is important that
> >>> requests that have not yet been started or that already have
> >>> completed are also reported through debugfs.
> >>
> >> Thanks, I like this better - applied. BTW, what's up with the
> >> reverse ordering on this:
> >>
> >>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Cc: Ming Lei <ming.lei@redhat.com>
> >>> Cc: Hannes Reinecke <hare@suse.com>
> >>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> >>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> >>
> >> For some reason that really annoys me, and I see it in various
> >> patches these days. IMHO the SOB should be last, with whatever
> >> acks, reviews, CC, before that.
> > 
> > I could've sworn that this guideline was even documented somewhere, but
> > I can't find it now ¯\_(ツ)_/¯
> 
> My guess is that it's some newer git thing - but if it is, it's really
> annoying and should be reverted. I end up fixing these up by hand.

Isn't it the way patchwork adds the tags? And yes I also thought this is the
correct way of adding the Ccs, etc..

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
