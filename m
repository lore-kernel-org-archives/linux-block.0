Return-Path: <ming.lei@redhat.com>
Date: Thu, 5 Jul 2018 10:28:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [RFC] bypass scheduler for no sched is set
Message-ID: <20180705022802.GA4442@ming.t460p>
References: <CAHsXFKHdhOE_USCASpiRd6dHzcNvo29ipeJ2LhVbEsxnyMow1A@mail.gmail.com>
 <20180704090801.GA19175@ming.t460p>
 <070d4e6dda0e9eae93b5d6e67827697b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <070d4e6dda0e9eae93b5d6e67827697b@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi Kashyap,

On Wed, Jul 04, 2018 at 04:07:45PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Wednesday, July 4, 2018 2:38 PM
> > To: Kashyap Desai
> > Cc: linux-block@vger.kernel.org; Jens Axboe; Omar Sandoval; Christoph
> > Hellwig; Hannes Reinecke; linux-scsi; Laurence Oberman
> > Subject: Re: [RFC] bypass scheduler for no sched is set
> >
> > On Wed, Jul 04, 2018 at 01:29:50PM +0530, Kashyap Desai wrote:
> > > Hi,
> > >
> > > Ming Lei posted below patch series and performance improved for
> > > megaraid_sas driver. I used the same kernel base and figure out some
> more
> > > possible performance improvement in block layer. This RFC improves
> > > performance as well as CPU utilization. If this patch fits the design
> > > aspect of the blk-mq and scsi-mq, I can convert it into PATCH and
> submit
> > > the same/modified version.
> > >
> > > https://marc.info/?l=linux-block&m=153062994403732&w=2
> > >
> > > Description of change -
> > >
> > > Do not insert request into software queue if BLK_MQ_F_NO_SCHED is set.
> > > Submit request from blk_mq_make_request to low level driver directly
> as
> > > depicted through below function call.
> > >
> > > blk_mq_try_issue_directly
> > >
> > >
> > > __blk_mq_try_issue_directly
> > >
> > >                  scsi_queue_rq
> >
> > Hi Kashyap,
> >
> > When I sent you the patches[1] which include 'global tags' support,
> MegaRAID
> > is converted to per-node queues and becomes real MQ(q->nr_hw_queues >
> > 1), IO
> > should have been issued direclty, please see the branch of '(plug &&
> > !blk_queue_nomerges(q))' and '(q->nr_hw_queues > 1 && is_sync)' in
> > blk_mq_make_request().
> 
> I observed this while working on performance issue with you and from your
> earlier patch 'global tags'.
> 
> >
> > But looks not see any improvement from your test result, even though
> huge
> > improvement can be observed on null_blk/scsi_debug. Maybe somewhere is
> > wrong,
> > and days ago I talked with Laurence about doing this kind of test again.
> >
> 
> Ming,
> 
> Your patch was trigger for me to review block layer changes as I did not
> expected performance boost having multiple submission queue for IT/MR HBA
> due to pseudo parallelism via more hctx.

OK, I guess the driver may not support to submit requests concurrently, is
it right?

> 
> Performance bottleneck is obvious, if we have *one* single scsi_device
> which can goes upto 1M IOPS.  If we have more number of drives in topology
> which requires more number of outstanding IOs to hit max Performance, we
> will see gloab tag[2] will be a bottleneck.  In case of global tag [2],
> hctx to cpu mapping was just round robin since we can use blk-mq-pci APIs.

If I remember correctly, the whole tags in this megaraid_sas is ~5K, and in
your test there are 8 SSD drives, so in case of dual socket system, you still
get 2.5K tags for all 8 SSDs. In theory, it is quite enough to reach each SSD's
top performance if the driver .queuecommand() doesn't take too much time.

There are at least two benefits with global tags:

1) hctx is NUMA locality, and ctx is accessed in NUMA locality too

2) issue directly in case of none

> 
> There are a benefit of keeping nr_hw_queue = 1 as explained below.
> 
> More than  one nr_hw_queue will reduce tags per hardware context (higher
> the physical socket we will have more trouble of distributing HBA
> can_queue) and also it will not allow any IO scheduler to be attached.  We

Right, if there is too many NUMA nodes, don't expect this HBA works
efficiently, since it only has single tags among all nodes & CPUs.

And 2 or 4 nodes should be more popular, you still get >1K tags for
one single hw queue in case of 4 nodes, which looks not too low.

> will end up seeing performance issue for HDD based setup w.r.t sequential
> profile. I already worked with upstream and block layer fix was part of
> 4.11 kernel. See below link for more detail.
> https://lkml.org/lkml/2017/1/30/381 - To have this fix, we need
> mq-deadline scheduler. This scheduler is not available if we call our self
> as multi-hardware queue.
> 
> I reconfirm once again that above mentioned issue (IO sorting issue) is
> only resolved if I use <mq-deadline> scheduler. It means using nr_hw_queue
> >  1 will reintroduce IO sorting issue.
> 

But all your current test is on none IO scheduler instead of mq-deadline,
right?

> Ideally, we need nr_hw_queue = 1 to get use of io scheduler. MR and IT
> controller of Broadcom do not want to by-pass IO scheduler all the time.

You may set io scheduler in case of 'nr_hw_queue > 1', please see
__blk_mq_try_issue_directly(), in which request will be inserted to
scheduler queue if 'q->elevator' isn't NULL.

> 
> If we mark nr_hw_queue > 1 for IT/MR controller, we will not find any IO
> scheduler due to below code @ elevator_init_mq and we need io scheduler
> for HDD based storages.
> 
> int elevator_init_mq(struct request_queue *q)
> {
>         struct elevator_type *e;
>         int err = 0;
> 
>         if (q->nr_hw_queues != 1)
>                 return 0;

You may switch io scheduler via /sys/block/sdN/queue/scheduler in real
MQ case.

> 
> Using request_queue->tag_set->flags method, we can cherry pick IO
> scheduler.  Block layer will not attach any IO scheduler due to below code
> @ blk_mq_init_allocated_queue().
> Eventually, it looks better not to go through IO scheduler in submission
> path based on same flag settings.
> 
> if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
> 		int ret;
> 
> 		ret = blk_mq_sched_init(q);
> 		if (ret)
> 			return ERR_PTR(ret);
> }

Usually BLK_MQ_F_NO_SCHED is set for admin queues, and if you take this
approach, no any IO schedulers can be applied on this queue any more.

> 
> 
> 
> > I will double check the 'global tags' patches, meantime could you or
> > Laurence help to check if global tags[2] works in expected way if
> > you'd like to?
> >
> > [1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v5
> > [2] https://github.com/ming1/linux/commits/v4.18-rc-host-tags-v8
> 
> Yesterday I manually did this merging your v4.16-rc-host-tags-v5 to 4.18
> branch.  For one particular test run, impact of global tags [2] and RFC
> was same.  RFC and global tags
> 2] uses new path via blk_mq_try_issue_directly. Performance drop of global
> tags [2] will be visible if we have more physical sockets and single numa
> node exhaust all nr_tags.
> Most likely negative performance if we have large HDD based setup using
> global tag[2].

Global tags should be fine for HDD since small tags is enough for HDD, for
example, SATA often has 32 tags. Number of tags should be important
for SSD which need to apply parallelism on the internal NAND chip.

> 
> Performance drop due to reduced nr_tags can be completely avoided if we
> use RFC.

If each drive's average tags is more than 256, and you still may not get
good performance, I suggest to investigate driver's IO path, maybe
somewhere takes too long. Because from SSD's view, 256 should be enough
to reach its top performance.

Thanks,
Ming
