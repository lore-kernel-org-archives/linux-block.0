Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiA0JgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:36:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiA0JgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:36:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 720CA1F37C;
        Thu, 27 Jan 2022 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643276166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/w4bAJeOaJmmmdwbvaSLUVT5ppSmXe1Cf0v3R6xJYEg=;
        b=fRg7FTGa5jVYSPRDcSDztzRqvKojDX7UN+1zrNI4nEciO/sN/OHziLJpT19+Q85kYou2jz
        pgF4qjeEzAo2HTrxbfL2b3y9m9D0MpicSP35SswtlN6xqkDVUd8CJ1Lcz77x763HbuAQHt
        kEEx9fqOGB9qv9+y+UG6VdOSVJRmrEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643276166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/w4bAJeOaJmmmdwbvaSLUVT5ppSmXe1Cf0v3R6xJYEg=;
        b=ikIL1hDLIbAt2qxf729HqSgrszxH0G9C4Ekm9iXcKyccjr3f4dhT1Oi73qR9QZ/t/50eMp
        v1jwUyMH+5It94BA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BF97A3B81;
        Thu, 27 Jan 2022 09:36:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 530FBA05E6; Thu, 27 Jan 2022 10:36:00 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:36:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/8] loop: de-duplicate the idle worker freeing code
Message-ID: <20220127093600.qrlk7hi3bi2vkso4@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:33, Christoph Hellwig wrote:
> Use a common helper for both timer based and uncoditional freeing of idle
> workers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 73 +++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 01cbbfc4e9e24..b268bca6e4fb7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -804,7 +804,6 @@ struct loop_worker {
>  
>  static void loop_workfn(struct work_struct *work);
>  static void loop_rootcg_workfn(struct work_struct *work);
> -static void loop_free_idle_workers(struct timer_list *timer);
>  
>  #ifdef CONFIG_BLK_CGROUP
>  static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
> @@ -888,6 +887,39 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
>  	spin_unlock_irq(&lo->lo_work_lock);
>  }
>  
> +static void loop_set_timer(struct loop_device *lo)
> +{
> +	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
> +}
> +
> +static void loop_free_idle_workers(struct loop_device *lo, bool delete_all)
> +{
> +	struct loop_worker *pos, *worker;
> +
> +	spin_lock_irq(&lo->lo_work_lock);
> +	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> +				idle_list) {
> +		if (!delete_all &&
> +		    time_is_after_jiffies(worker->last_ran_at +
> +					  LOOP_IDLE_WORKER_TIMEOUT))
> +			break;
> +		list_del(&worker->idle_list);
> +		rb_erase(&worker->rb_node, &lo->worker_tree);
> +		css_put(worker->blkcg_css);
> +		kfree(worker);
> +	}
> +	if (!list_empty(&lo->idle_worker_list))
> +		loop_set_timer(lo);
> +	spin_unlock_irq(&lo->lo_work_lock);
> +}
> +
> +static void loop_free_idle_workers_timer(struct timer_list *timer)
> +{
> +	struct loop_device *lo = container_of(timer, struct loop_device, timer);
> +
> +	return loop_free_idle_workers(lo, false);
> +}
> +
>  static void loop_update_rotational(struct loop_device *lo)
>  {
>  	struct file *file = lo->lo_backing_file;
> @@ -1022,7 +1054,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
>  	INIT_LIST_HEAD(&lo->idle_worker_list);
>  	lo->worker_tree = RB_ROOT;
> -	timer_setup(&lo->timer, loop_free_idle_workers,
> +	timer_setup(&lo->timer, loop_free_idle_workers_timer,
>  		TIMER_DEFERRABLE);
>  	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
>  	lo->lo_device = bdev;
> @@ -1086,7 +1118,6 @@ static void __loop_clr_fd(struct loop_device *lo)
>  {
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
> -	struct loop_worker *pos, *worker;
>  
>  	/*
>  	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
> @@ -1116,15 +1147,7 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
>  	destroy_workqueue(lo->workqueue);
> -	spin_lock_irq(&lo->lo_work_lock);
> -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> -				idle_list) {
> -		list_del(&worker->idle_list);
> -		rb_erase(&worker->rb_node, &lo->worker_tree);
> -		css_put(worker->blkcg_css);
> -		kfree(worker);
> -	}
> -	spin_unlock_irq(&lo->lo_work_lock);
> +	loop_free_idle_workers(lo, true);
>  	del_timer_sync(&lo->timer);
>  
>  	spin_lock_irq(&lo->lo_lock);
> @@ -1871,11 +1894,6 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  	}
>  }
>  
> -static void loop_set_timer(struct loop_device *lo)
> -{
> -	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
> -}
> -
>  static void loop_process_work(struct loop_worker *worker,
>  			struct list_head *cmd_list, struct loop_device *lo)
>  {
> @@ -1924,27 +1942,6 @@ static void loop_rootcg_workfn(struct work_struct *work)
>  	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
>  }
>  
> -static void loop_free_idle_workers(struct timer_list *timer)
> -{
> -	struct loop_device *lo = container_of(timer, struct loop_device, timer);
> -	struct loop_worker *pos, *worker;
> -
> -	spin_lock_irq(&lo->lo_work_lock);
> -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> -				idle_list) {
> -		if (time_is_after_jiffies(worker->last_ran_at +
> -						LOOP_IDLE_WORKER_TIMEOUT))
> -			break;
> -		list_del(&worker->idle_list);
> -		rb_erase(&worker->rb_node, &lo->worker_tree);
> -		css_put(worker->blkcg_css);
> -		kfree(worker);
> -	}
> -	if (!list_empty(&lo->idle_worker_list))
> -		loop_set_timer(lo);
> -	spin_unlock_irq(&lo->lo_work_lock);
> -}
> -
>  static const struct blk_mq_ops loop_mq_ops = {
>  	.queue_rq       = loop_queue_rq,
>  	.complete	= lo_complete_rq,
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
