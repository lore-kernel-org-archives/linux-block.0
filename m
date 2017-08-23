Return-Path: <vgoyal@redhat.com>
Date: Wed, 23 Aug 2017 15:21:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, tj@kernel.org,
	lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC] block/loop: make loop cgroup aware
Message-ID: <20170823192125.GB7935@redhat.com>
References: <dd357e1638021132cd39a11769a745a8318636d3.1503506490.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd357e1638021132cd39a11769a745a8318636d3.1503506490.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 11:15:15AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Not a merge request, for discussion only.
> 
> loop block device handles IO in a separate thread. The actual IO
> dispatched isn't cloned from the IO loop device received, so the
> dispatched IO loses the cgroup context.
> 
> I'm ignoring buffer IO case now, which is quite complicated.  Making the
> loop thread aware of cgroup context doesn't really help. The loop device
> only writes to a single file. In current writeback cgroup
> implementation, the file can only belong to one cgroup.
> 
> For direct IO case, we could workaround the issue in theory. For
> example, say we assign cgroup1 5M/s BW for loop device and cgroup2
> 10M/s. We can create a special cgroup for loop thread and assign at
> least 15M/s for the underlayer disk. In this way, we correctly throttle
> the two cgroups. But this is tricky to setup.
> 
> This patch tries to address the issue. When loop thread is handling IO,
> it declares the IO is on behalf of the original task, then in block IO
> we use the original task to find cgroup. The concept probably works for
> other scenarios too, but right now I don't make it generic yet.

Hi Shaohua, 

Can worker thread switch/move to the cgroup bio is in and do the submision
and then switch back. That way IO submitted by worker should be accounted
to the cgroup bio belongs to. Just a thought. I don't even know if that's
feasible.

Vivek

> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  block/bio.c                |  5 ++++-
>  drivers/block/loop.c       | 14 +++++++++++++-
>  drivers/block/loop.h       |  1 +
>  include/linux/blk-cgroup.h |  3 ++-
>  include/linux/sched.h      |  1 +
>  5 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e241bbc..8f0df3c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2058,7 +2058,10 @@ int bio_associate_current(struct bio *bio)
>  
>  	get_io_context_active(ioc);
>  	bio->bi_ioc = ioc;
> -	bio->bi_css = task_get_css(current, io_cgrp_id);
> +	if (current->cgroup_task)
> +		bio->bi_css = task_get_css(current->cgroup_task, io_cgrp_id);
> +	else
> +		bio->bi_css = task_get_css(current, io_cgrp_id);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bio_associate_current);
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ef83349..fefede3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -77,7 +77,7 @@
>  #include <linux/falloc.h>
>  #include <linux/uio.h>
>  #include "loop.h"
> -
> +#include <linux/sched/task.h>
>  #include <linux/uaccess.h>
>  
>  static DEFINE_IDR(loop_index_idr);
> @@ -471,6 +471,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
>  {
>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>  
> +	if (cmd->cgroup_task)
> +		put_task_struct(cmd->cgroup_task);
>  	cmd->ret = ret;
>  	blk_mq_complete_request(cmd->rq);
>  }
> @@ -502,11 +504,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	cmd->iocb.ki_complete = lo_rw_aio_complete;
>  	cmd->iocb.ki_flags = IOCB_DIRECT;
>  
> +	if (cmd->cgroup_task)
> +		current->cgroup_task = cmd->cgroup_task;
> +
>  	if (rw == WRITE)
>  		ret = call_write_iter(file, &cmd->iocb, &iter);
>  	else
>  		ret = call_read_iter(file, &cmd->iocb, &iter);
>  
> +	current->cgroup_task = NULL;
> +
>  	if (ret != -EIOCBQUEUED)
>  		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
>  	return 0;
> @@ -1705,6 +1712,11 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		break;
>  	}
>  
> +	if (cmd->use_aio) {
> +		cmd->cgroup_task = current;
> +		get_task_struct(current);
> +	} else
> +		cmd->cgroup_task = NULL;
>  	kthread_queue_work(&lo->worker, &cmd->work);
>  
>  	return BLK_STS_OK;
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index 2c096b9..eb98d4d 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -73,6 +73,7 @@ struct loop_cmd {
>  	bool use_aio;           /* use AIO interface to handle I/O */
>  	long ret;
>  	struct kiocb iocb;
> +	struct task_struct *cgroup_task;
>  };
>  
>  /* Support for loadable transfer modules */
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 9d92153..38a5517 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -232,7 +232,8 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
>  {
>  	if (bio && bio->bi_css)
>  		return css_to_blkcg(bio->bi_css);
> -	return task_blkcg(current);
> +	return task_blkcg(current->cgroup_task ?
> +			current->cgroup_task : current);
>  }
>  
>  static inline struct cgroup_subsys_state *
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8337e2d..a5958b0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -897,6 +897,7 @@ struct task_struct {
>  	struct css_set __rcu		*cgroups;
>  	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
>  	struct list_head		cg_list;
> +	struct task_struct		*cgroup_task;
>  #endif
>  #ifdef CONFIG_INTEL_RDT_A
>  	int				closid;
> -- 
> 2.9.5
