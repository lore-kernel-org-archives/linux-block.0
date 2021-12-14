Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 15:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhLNPwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:52:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhLNPwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 10:52:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E0BD1F37C;
        Tue, 14 Dec 2021 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639497157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKkTPSQMWhPs+DXI2OzDdyBavAnA2qN/FrDMJ0/O3V8=;
        b=JHeEOrfZ31Vcurf3UwtLFuxzcn0RzCnoyR4xgpsyl7N4/lm3ZxvLJUopz2j8C5aViuqS4y
        0+o8Juy70J4U9mk7boNKWjl87q1yLxx3HvE2N4JvsnHx0p17AyCvGbfbPiyHk9M3mqafQI
        EmvPB1q9Jro9Dq29x9VhPo8dL9vCBF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639497157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKkTPSQMWhPs+DXI2OzDdyBavAnA2qN/FrDMJ0/O3V8=;
        b=/UOCAZ8IKeQWOEnlhnbB1EK+D+ooCGScb43bHIOunZJtm0VdFzoZbBGKdRhq+7TgZ9sQT/
        X9sqAdiKaya3tFBA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 1EE1CA3B85;
        Tue, 14 Dec 2021 15:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B274D1F2C7E; Tue, 14 Dec 2021 16:52:36 +0100 (CET)
Date:   Tue, 14 Dec 2021 16:52:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/11] block: fold get_task_io_context into
 set_task_ioprio
Message-ID: <20211214155236.GI14044@quack2.suse.cz>
References: <20211209063131.18537-1-hch@lst.de>
 <20211209063131.18537-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063131.18537-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-12-21 07:31:28, Christoph Hellwig wrote:
> Fold get_task_io_context into its only caller, and simplify the code
> as no reference to the I/O context is required to just set the ioprio
> field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-ioc.c | 52 +++++++++++++------------------------------------
>  1 file changed, 14 insertions(+), 38 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index c25ce2f3eb191..1ba7cfedca2d9 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -268,41 +268,9 @@ static struct io_context *create_task_io_context(struct task_struct *task,
>  	return ioc;
>  }
>  
> -/**
> - * get_task_io_context - get io_context of a task
> - * @task: task of interest
> - * @gfp_flags: allocation flags, used if allocation is necessary
> - * @node: allocation node, used if allocation is necessary
> - *
> - * Return io_context of @task.  If it doesn't exist, it is created with
> - * @gfp_flags and @node.  The returned io_context has its reference count
> - * incremented.
> - *
> - * This function always goes through task_lock() and it's better to use
> - * %current->io_context + get_io_context() for %current.
> - */
> -static struct io_context *get_task_io_context(struct task_struct *task,
> -		gfp_t gfp_flags, int node)
> -{
> -	struct io_context *ioc;
> -
> -	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
> -
> -	task_lock(task);
> -	ioc = task->io_context;
> -	if (unlikely(!ioc)) {
> -		task_unlock(task);
> -		return create_task_io_context(task, gfp_flags, node);
> -	}
> -	get_io_context(ioc);
> -	task_unlock(task);
> -	return ioc;
> -}
> -
>  int set_task_ioprio(struct task_struct *task, int ioprio)
>  {
>  	int err;
> -	struct io_context *ioc;
>  	const struct cred *cred = current_cred(), *tcred;
>  
>  	rcu_read_lock();
> @@ -318,13 +286,21 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
>  	if (err)
>  		return err;
>  
> -	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
> -	if (ioc) {
> -		ioc->ioprio = ioprio;
> -		put_io_context(ioc);
> -	}
> +	task_lock(task);
> +	if (unlikely(!task->io_context)) {
> +		struct io_context *ioc;
>  
> -	return err;
> +		task_unlock(task);
> +		ioc = create_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
> +		if (ioc) {
> +			ioc->ioprio = ioprio;
> +			put_io_context(ioc);
> +		}
> +		return 0;
> +	}
> +	task->io_context->ioprio = ioprio;
> +	task_unlock(task);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(set_task_ioprio);
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
