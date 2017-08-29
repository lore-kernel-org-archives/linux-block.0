Return-Path: <shli@kernel.org>
Date: Tue, 29 Aug 2017 08:22:36 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lizefan@huawei.com,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC] block/loop: make loop cgroup aware
Message-ID: <20170829152236.vvtxahdrwqgmzmm7@kernel.org>
References: <dd357e1638021132cd39a11769a745a8318636d3.1503506490.git.shli@fb.com>
 <20170828225459.GE491396@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170828225459.GE491396@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 03:54:59PM -0700, Tejun Heo wrote:
> Hello, Shaohua.
> 
> On Wed, Aug 23, 2017 at 11:15:15AM -0700, Shaohua Li wrote:
> > loop block device handles IO in a separate thread. The actual IO
> > dispatched isn't cloned from the IO loop device received, so the
> > dispatched IO loses the cgroup context.
> 
> Ah, right.  Thanks for spotting this.
> 
> > I'm ignoring buffer IO case now, which is quite complicated.  Making the
> > loop thread aware of cgroup context doesn't really help. The loop device
> > only writes to a single file. In current writeback cgroup
> > implementation, the file can only belong to one cgroup.
> 
> Yeah, writeback tracks the most active cgroup and associates writeback
> ios with that cgroup.  For buffered loop devices, I think it'd be fine
> to make the loop driver forward the cgroup association and let the
> writeback layer determine the matching association as usual.

Doing this means we must forward cgroup info to page, not bio. I need to check
if we can make the mechanism work for memcg.
 
> > For direct IO case, we could workaround the issue in theory. For
> > example, say we assign cgroup1 5M/s BW for loop device and cgroup2
> > 10M/s. We can create a special cgroup for loop thread and assign at
> > least 15M/s for the underlayer disk. In this way, we correctly throttle
> > the two cgroups. But this is tricky to setup.
> > 
> > This patch tries to address the issue. When loop thread is handling IO,
> > it declares the IO is on behalf of the original task, then in block IO
> > we use the original task to find cgroup. The concept probably works for
> > other scenarios too, but right now I don't make it generic yet.
> 
> The overall approach looks sound to me.  Some comments below.
> 
> > @@ -2058,7 +2058,10 @@ int bio_associate_current(struct bio *bio)
> >  
> >  	get_io_context_active(ioc);
> >  	bio->bi_ioc = ioc;
> > -	bio->bi_css = task_get_css(current, io_cgrp_id);
> > +	if (current->cgroup_task)
> > +		bio->bi_css = task_get_css(current->cgroup_task, io_cgrp_id);
> > +	else
> > +		bio->bi_css = task_get_css(current, io_cgrp_id);
> 
> Do we need a full pointer field for this?  I think we should be able
> to mark lo writers with a flag (PF or whatever) and then to
> kthread_data() to get the lo struct which contains the target css.
> Oh, let's do csses instead of tasks for consistency, correctness
> (please see below) and performance (csses are cheaper to pin).

Forwarding css sounds better.

> > @@ -502,11 +504,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >  	cmd->iocb.ki_complete = lo_rw_aio_complete;
> >  	cmd->iocb.ki_flags = IOCB_DIRECT;
> >  
> > +	if (cmd->cgroup_task)
> > +		current->cgroup_task = cmd->cgroup_task;
> > +
> >  	if (rw == WRITE)
> >  		ret = call_write_iter(file, &cmd->iocb, &iter);
> >  	else
> >  		ret = call_read_iter(file, &cmd->iocb, &iter);
> >  
> > +	current->cgroup_task = NULL;
> > +
> >  	if (ret != -EIOCBQUEUED)
> >  		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
> >  	return 0;
> 
> Hmm... why do we need double forwarding (original issuer -> aio cmd ->
> ios) in loop?  If we need this, doesn't this mean that we're missing
> ownership forwarding in aio paths and should make the forwarding
> happen there?

what do you mean double forwarding?
> 
> > @@ -1705,6 +1712,11 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  		break;
> >  	}
> >  
> > +	if (cmd->use_aio) {
> > +		cmd->cgroup_task = current;
> > +		get_task_struct(current);
> > +	} else
> > +		cmd->cgroup_task = NULL;
> 
> What if %current isn't the original issuer of the io?  It could be a
> writeback worker trying to flush to a loop device and we don't want to
> attribute those ios to the writeback worker.  We should forward the
> bi_css not the current task.

Makes sense.

Thanks,
Shaohua
