Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 5 Oct 2018 15:37:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet
 been started
Message-ID: <20181005223718.GL25437@vader>
References: <20181004173524.52712-1-bvanassche@acm.org>
 <a3f6a55e-eaa5-6a65-8360-9d85c7566961@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a3f6a55e-eaa5-6a65-8360-9d85c7566961@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 05, 2018 at 08:18:00AM -0600, Jens Axboe wrote:
> On 10/4/18 11:35 AM, Bart Van Assche wrote:
> > When debugging e.g. the SCSI timeout handler it is important that
> > requests that have not yet been started or that already have
> > completed are also reported through debugfs.
> 
> Thanks, I like this better - applied. BTW, what's up with the
> reverse ordering on this:
> 
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> 
> For some reason that really annoys me, and I see it in various
> patches these days. IMHO the SOB should be last, with whatever
> acks, reviews, CC, before that.

I could've sworn that this guideline was even documented somewhere, but
I can't find it now ¯\_(ツ)_/¯
