Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHdhOE_USCASpiRd6dHzcNvo29ipeJ2LhVbEsxnyMow1A@mail.gmail.com>
 <20180704090801.GA19175@ming.t460p> <070d4e6dda0e9eae93b5d6e67827697b@mail.gmail.com>
 <20180705022802.GA4442@ming.t460p>
In-Reply-To: <20180705022802.GA4442@ming.t460p>
MIME-Version: 1.0
Date: Thu, 5 Jul 2018 15:25:40 +0530
Message-ID: <d3dccdc5d63551be08cc85969117f94d@mail.gmail.com>
Subject: RE: [RFC] bypass scheduler for no sched is set
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-scsi <linux-scsi@vger.kernel.org>, Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> >
> > Ming,
> >
> > Your patch was trigger for me to review block layer changes as I did
not
> > expected performance boost having multiple submission queue for IT/MR
> HBA
> > due to pseudo parallelism via more hctx.
>
> OK, I guess the driver may not support to submit requests concurrently,
is
> it right?

Driver support concurrent processing but it eventually submit to one h/w
queue only. IT and MR HBA is single h/w submission queue.

>
> >
> > Performance bottleneck is obvious, if we have *one* single scsi_device
> > which can goes upto 1M IOPS.  If we have more number of drives in
topology
> > which requires more number of outstanding IOs to hit max Performance,
we
> > will see gloab tag[2] will be a bottleneck.  In case of global tag
[2],
> > hctx to cpu mapping was just round robin since we can use blk-mq-pci
APIs.
>
> If I remember correctly, the whole tags in this megaraid_sas is ~5K, and
in
> your test there are 8 SSD drives, so in case of dual socket system, you
still
> get 2.5K tags for all 8 SSDs. In theory, it is quite enough to reach
each SSD's
> top performance if the driver .queuecommand() doesn't take too much
time.

We have iMR and MR version of controllers. iMR supports 1.6K queue depth
for Ventura Family controllers.
Same iMR Invader family controller supports 1K queue depth.

>
> There are at least two benefits with global tags:
>
> 1) hctx is NUMA locality, and ctx is accessed in NUMA locality too

As of now hctx is not NUMA locality. It is doing round robin CPU
assignment. Am I missing anything ? See below output.

# cat
/sys/devices/pci0000:85/0000:85:00.0/0000:86:00.0/host14/target14:2:63/14:
2:63:0/block/sdd/mq/0/cpu_list
0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38,
40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70

# cat
/sys/devices/pci0000:85/0000:85:00.0/0000:86:00.0/host14/target14:2:63/14:
2:63:0/block/sdd/mq/1/cpu_list
1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39,
41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 36 37 38 39 40 41
42 43 44 45 46 47 48 49 50 51 52 53
node 1 cpus: 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 54 55
56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71


>
> 2) issue directly in case of none

Agree. This is what we want for SSDs based VD as default scheduler.
Currently I am doing this through manual settings.

>
> >
> > There are a benefit of keeping nr_hw_queue = 1 as explained below.
> >
> > More than  one nr_hw_queue will reduce tags per hardware context
(higher
> > the physical socket we will have more trouble of distributing HBA
> > can_queue) and also it will not allow any IO scheduler to be attached.
We
>
> Right, if there is too many NUMA nodes, don't expect this HBA works
> efficiently, since it only has single tags among all nodes & CPUs.
>
> And 2 or 4 nodes should be more popular, you still get >1K tags for
> one single hw queue in case of 4 nodes, which looks not too low.

My current testing is on higher HBA queue depth Controllers, but as I
commented above..we have controller (iMR) which works in lower HBA QD.
On 4 Socket server +  iMR controller case, driver will assign 256 nr_tags
per hctx context.

One more thing, in case of MR we create N drives VD and for that we need
accumulated  per device queue depth.  8 drive R0 VD at least need 256
queue depth.

>
> > will end up seeing performance issue for HDD based setup w.r.t
sequential
> > profile. I already worked with upstream and block layer fix was part
of
> > 4.11 kernel. See below link for more detail.
> > https://lkml.org/lkml/2017/1/30/381 - To have this fix, we need
> > mq-deadline scheduler. This scheduler is not available if we call our
self
> > as multi-hardware queue.
> >
> > I reconfirm once again that above mentioned issue (IO sorting issue)
is
> > only resolved if I use <mq-deadline> scheduler. It means using
nr_hw_queue
> > >  1 will reintroduce IO sorting issue.
> >
>
> But all your current test is on none IO scheduler instead of
mq-deadline,
> right?

Correct. I am currently checking SSD based test case, but soon I will be
doing some HDD based test as well.

>
> > Ideally, we need nr_hw_queue = 1 to get use of io scheduler. MR and IT
> > controller of Broadcom do not want to by-pass IO scheduler all the
time.
>
> You may set io scheduler in case of 'nr_hw_queue > 1', please see
> __blk_mq_try_issue_directly(), in which request will be inserted to
> scheduler queue if 'q->elevator' isn't NULL.
>
> >
> > If we mark nr_hw_queue > 1 for IT/MR controller, we will not find any
IO
> > scheduler due to below code @ elevator_init_mq and we need io
scheduler
> > for HDD based storages.
> >
> > int elevator_init_mq(struct request_queue *q)
> > {
> >         struct elevator_type *e;
> >         int err = 0;
> >
> >         if (q->nr_hw_queues != 1)
> >                 return 0;
>
> You may switch io scheduler via /sys/block/sdN/queue/scheduler in real
> MQ case.

Got it. Kernel will not call blk_mq_init_sched if we are nr_hw_queue > 1,
but still we can switch through sysfs since elevator_switch() is not
checking about nr_hw_queue.
>
> >
> > Using request_queue->tag_set->flags method, we can cherry pick IO
> > scheduler.  Block layer will not attach any IO scheduler due to below
code
> > @ blk_mq_init_allocated_queue().
> > Eventually, it looks better not to go through IO scheduler in
submission
> > path based on same flag settings.
> >
> > if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
> > 		int ret;
> >
> > 		ret = blk_mq_sched_init(q);
> > 		if (ret)
> > 			return ERR_PTR(ret);
> > }
>
> Usually BLK_MQ_F_NO_SCHED is set for admin queues, and if you take this
> approach, no any IO schedulers can be applied on this queue any more.
>
> >
> >
> >
> > > I will double check the 'global tags' patches, meantime could you or
> > > Laurence help to check if global tags[2] works in expected way if
> > > you'd like to?
> > >
> > > [1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v5
> > > [2] https://github.com/ming1/linux/commits/v4.18-rc-host-tags-v8
> >
> > Yesterday I manually did this merging your v4.16-rc-host-tags-v5 to
4.18
> > branch.  For one particular test run, impact of global tags [2] and
RFC
> > was same.  RFC and global tags
> > 2] uses new path via blk_mq_try_issue_directly. Performance drop of
global
> > tags [2] will be visible if we have more physical sockets and single
numa
> > node exhaust all nr_tags.
> > Most likely negative performance if we have large HDD based setup
using
> > global tag[2].
>
> Global tags should be fine for HDD since small tags is enough for HDD,
for
> example, SATA often has 32 tags. Number of tags should be important
> for SSD which need to apply parallelism on the internal NAND chip.
>
> >
> > Performance drop due to reduced nr_tags can be completely avoided if
we
> > use RFC.
>
> If each drive's average tags is more than 256, and you still may not get
> good performance, I suggest to investigate driver's IO path, maybe
> somewhere takes too long. Because from SSD's view, 256 should be enough
> to reach its top performance.

One of the case I am trying now is using iMR controller (HBA QD = 1000.)

OLTP work load. ( I will send you the fio script.)

Using global tags[2] patch -
12 SSDs in single drive R0 mode
IOPS read 890K/ write 440K (host_busy = ~490 because nr_tags = 494)
24 SSDs in single drive R0 mode
1312k/ 649k
IOPS read 1312K/ write 649K (host_busy = ~490 because nr_tags = 494)

Using RFC -
12 SSDs in single drive R0 mode
IOPS read 1050K/ write 510K (host_busy = ~750 because nr_tags = 988)
24 SSDs in single drive R0 mode
IOPS read 1650K/ write 855K (host_busy = ~988 because nr_tags = 988)

~25% performance drop is contributed just because of not having enough
tags. Most likely similar drop can be easily visible whenever we have
large topology and Max IOPs saturated @HBA level ( host_busy reaching to
can_queue.)

I agree that mq-deadline selection is still possible in global tags[2]
patch, but major concern is dividing can_queue to nr_tags per ctx.
I don't think we will need any scheduler operation for SSD (having said
that "none" scheduler for SSD case should be not an issue),.
Using BLK_MQ_F_NO_SCHED *only* for nonrotatioal media is still good
choice.

In summary, We need interface to use blk_mq_try_issue_directly for device
connected to scsi stack with nr_hw_queue  = 1.  We can achieve that using
your global tag[2] patch, but that is dividing can_queue and  we may see
high performance issue if performance really need max HBA queue depth
should be outstanding.  RFC patch is making thing simple and serving the
same purpose of calling blk_mq_try_issue_directly, if low level driver
wants. It will continue working in same hctx context without dividing
can_queue. I see that not dividing can_queue is much needed.

Kashyap

>
> Thanks,
> Ming
