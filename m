Return-Path: <jack@suse.cz>
Date: Tue, 8 Nov 2016 14:02:39 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 4/8] writeback: track if we're sleeping on progress in
 balance_dirty_pages()
Message-ID: <20161108130239.GO32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-5-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 01-11-16 15:08:47, Jens Axboe wrote:
> Note in the bdi_writeback structure whenever a task ends up sleeping
> waiting for progress. We can use that information in the lower layers
> to increase the priority of writes.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev-defs.h | 2 ++
>  mm/backing-dev.c                 | 1 +
>  mm/page-writeback.c              | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index c357f27d5483..dc5f76d7f648 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -116,6 +116,8 @@ struct bdi_writeback {
>  	struct list_head work_list;
>  	struct delayed_work dwork;	/* work item used for writeback */
>  
> +	unsigned long dirty_sleep;	/* last wait */
> +
>  	struct list_head bdi_node;	/* anchored at bdi->wb_list */
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8fde443f36d7..3bfed5ab2475 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -310,6 +310,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  	spin_lock_init(&wb->work_lock);
>  	INIT_LIST_HEAD(&wb->work_list);
>  	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
> +	wb->dirty_sleep = jiffies;
>  
>  	wb->congested = wb_congested_get_create(bdi, blkcg_id, gfp);
>  	if (!wb->congested)
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 439cc63ad903..52e2f8e3b472 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1778,6 +1778,7 @@ static void balance_dirty_pages(struct address_space *mapping,
>  					  pause,
>  					  start_time);
>  		__set_current_state(TASK_KILLABLE);
> +		wb->dirty_sleep = now;
>  		io_schedule_timeout(pause);
>  
>  		current->dirty_paused_when = now + pause;
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
