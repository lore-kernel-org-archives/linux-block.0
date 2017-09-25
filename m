Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 06:51:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 5/6] block: Make SCSI device suspend and resume work
 reliably
Message-ID: <20170925225119.GB18137@ming.t460p>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
 <20170922221405.22091-6-bart.vanassche@wdc.com>
 <20170925022621.GB6434@ming.t460p>
 <1506356419.2641.11.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506356419.2641.11.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:20:20PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-25 at 10:26 +0800, Ming Lei wrote:
> > On Fri, Sep 22, 2017 at 03:14:04PM -0700, Bart Van Assche wrote:
> > > +int blk_queue_enter(struct request_queue *q, bool nowait, bool preempt)
> > >  {
> > >  	while (true) {
> > >  		int ret;
> > >  
> > > -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> > > -			return 0;
> > > +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> > > +			/*
> > > +			 * Ensure read order of q_usage_counter and the
> > > +			 * PREEMPT_ONLY queue flag.
> > > +			 */
> > > +			smp_rmb();
> > > +			if (preempt || !blk_queue_preempt_only(q))
> > > +				return 0;
> > > +			else
> > > +				percpu_ref_put(&q->q_usage_counter);
> > > +		}
> > 
> > Now you introduce one smp_rmb() and test on preempt flag on
> > blk-mq's fast path, which should have been avoided, so I
> > think this way is worse than my patchset.
> 
> So that means that you have not noticed that it is safe to leave out that
> smp_rmp() call because blk-mq queue freezing and unfreezing waits for a grace
> period and hence waits until all CPUs have executed a full memory barrier?

No, memory barrier has to be pair, this barrier has to be there, another
one before unfreeze/freeze can be removed because it is implied inside
freeze/unfreeze.

Actually it should have been smp_mb() between writing the percpu-refcount
and reading preempt_only flag, otherwise if the two op is reordered,
queue freeze/unfreeze may see the counter is zero, and this normal I/O
still can be observed even after queue is freezed and SCSI is put into
quiesced.

-- 
Ming
