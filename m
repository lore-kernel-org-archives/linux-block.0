Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 16:32:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 7/7] block: Make SCSI device suspend and resume work
 reliably
Message-ID: <20170926083252.GB518@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170925202924.16603-8-bart.vanassche@wdc.com>
 <20170925225911.GC18137@ming.t460p>
 <1506381226.2641.60.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506381226.2641.60.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 11:13:47PM +0000, Bart Van Assche wrote:
> On Tue, 2017-09-26 at 06:59 +0800, Ming Lei wrote:
> > On Mon, Sep 25, 2017 at 01:29:24PM -0700, Bart Van Assche wrote:
> > > +int blk_queue_enter(struct request_queue *q, bool nowait, bool preempt)
> > >  {
> > >  	while (true) {
> > >  		int ret;
> > >  
> > > -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> > > -			return 0;
> > > +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> > > +			/*
> > > +			 * Since setting the PREEMPT_ONLY flag is followed
> > > +			 * by a switch of q_usage_counter from per-cpu to
> > > +			 * atomic mode and back to per-cpu and since the
> > > +			 * switch to atomic mode uses call_rcu_sched(), it
> > > +			 * is not necessary to call smp_rmb() here.
> > > +			 */
> > 
> > rcu_read_lock is held only inside percpu_ref_tryget_live().
> > 
> > Without one explicit barrier(smp_mb) between getting the refcounter
> > and reading the preempt only flag, the two operations(writing to
> > refcounter and reading the flag) can be reordered, so
> > unfreeze/unfreeze may be completed before this IO is completed.
> 
> Sorry but I disagree. I'm using RCU to achieve the same effect as a barrier
> and to move the cost of the barrier from the reader to the updater. See also
> Paul E. McKenney, Mathieu Desnoyers, Lai Jiangshan, and Josh Triplett,
> The RCU-barrier menagerie, LWN.net, November 12, 2013
> (https://lwn.net/Articles/573497/).

Let me explain it in a bit details:

1) in SCSI quiesce path:

We can think there is one synchronize_rcu() in freeze/unfreeze.

Let's see the RCU document:

Documentation/RCU/whatisRCU.txt:

	void synchronize_rcu(void);

    Marks the end of updater code and the beginning of reclaimer
    code.  It does this by blocking until all pre-existing RCU
    read-side critical sections on all CPUs have completed.
    Note that synchronize_rcu() will -not- necessarily wait for
    any subsequent RCU read-side critical sections to complete.
    For example, consider the following sequence of events:

So synchronize_rcu() in SCSI quiesce path just waits for completion
of pre-existing read-side critical section, and subsequent RCU
read-side critical sections won't be waited.

2) in normal I/O path of blk_enter_queue()

- only rcu read lock is held in percpu_ref_tryget_live(), and the lock
is released when this helper returns.

- there isn't explicit barrier(smp_mb()) between percpu_ref_tryget_live()
and checking flag of preempt only, so writing to percpu_ref counter
and reading the preempt flag can be reordered as the following:

	-- check flag of preempt only 

		current process preempt out now, and just at the exact
		time, SCSI quiesce is run from another process, then
		freeze/unfreeze is completed because no pre-exit read-side
		critical sections, and the percpu_ref isn't held too.

		finally this process is preeempt in, and try to grab one ref
		and submit I/O after SCSI is quiesced(which shouldn't be
		allowed)

	-- percpu_ref_tryget_live()


-- 
Ming
