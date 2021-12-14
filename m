Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD0DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhLNQB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 11:01:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhLNQB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 11:01:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 19F711F383;
        Tue, 14 Dec 2021 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639497687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3ekWvhMehh73GkZVCxfKmDc4I3m/60wCz+HM3I+518=;
        b=nZV1KbOW4/YCfHWDWvroOfT6F1jdK1JJPUaTOj79uNkpT8tdXLabxK93B59SUQj2hdaaYz
        EXOZFOYbWr3hFRcSnBMqSugvEisXQzudk4tJ9HBEzi/FLn6JLV0iB1yO8gTPdbQUCer8gT
        J/KYBntlDHNVdvfzA+66VBIP1xZZepo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639497687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3ekWvhMehh73GkZVCxfKmDc4I3m/60wCz+HM3I+518=;
        b=TG09fXX7fWsveVRxhBBxshqP1n8BqDCfi8MGgJsQQdkRCRaT3IAuWPRgzl9Ob1n7dj0P1R
        /4KINzgNTHMyOGDQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 0DE23A3B85;
        Tue, 14 Dec 2021 16:01:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DED291F2C7E; Tue, 14 Dec 2021 17:01:26 +0100 (CET)
Date:   Tue, 14 Dec 2021 17:01:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/11] block: fold create_task_io_context into
 ioc_find_get_icq
Message-ID: <20211214160126.GK14044@quack2.suse.cz>
References: <20211209063131.18537-1-hch@lst.de>
 <20211209063131.18537-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063131.18537-11-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-12-21 07:31:30, Christoph Hellwig wrote:
> Fold create_task_io_context into the only remaining caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-ioc.c | 43 ++++++++++++-------------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index cff0e3bdae53c..dc7fb064fd5f7 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -238,36 +238,6 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
>  	return ioc;
>  }
>  
> -static struct io_context *create_task_io_context(struct task_struct *task,
> -		gfp_t gfp_flags, int node)
> -{
> -	struct io_context *ioc;
> -
> -	ioc = alloc_io_context(gfp_flags, node);
> -	if (!ioc)
> -		return NULL;
> -
> -	/*
> -	 * Try to install.  ioc shouldn't be installed if someone else
> -	 * already did or @task, which isn't %current, is exiting.  Note
> -	 * that we need to allow ioc creation on exiting %current as exit
> -	 * path may issue IOs from e.g. exit_files().  The exit path is
> -	 * responsible for not issuing IO after exit_io_context().
> -	 */
> -	task_lock(task);
> -	if (!task->io_context &&
> -	    (task == current || !(task->flags & PF_EXITING)))
> -		task->io_context = ioc;
> -	else
> -		kmem_cache_free(iocontext_cachep, ioc);
> -
> -	ioc = task->io_context;
> -	if (ioc)
> -		get_io_context(ioc);
> -	task_unlock(task);
> -	return ioc;
> -}
> -
>  int set_task_ioprio(struct task_struct *task, int ioprio)
>  {
>  	int err;
> @@ -426,9 +396,20 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
>  	struct io_cq *icq = NULL;
>  
>  	if (unlikely(!ioc)) {
> -		ioc = create_task_io_context(current, GFP_ATOMIC, q->node);
> +		ioc = alloc_io_context(GFP_ATOMIC, q->node);
>  		if (!ioc)
>  			return NULL;
> +
> +		task_lock(current);
> +		if (current->io_context) {
> +			kmem_cache_free(iocontext_cachep, ioc);
> +			ioc = current->io_context;
> +		} else {
> +			current->io_context = ioc;
> +		}
> +
> +		get_io_context(ioc);
> +		task_unlock(current);
>  	} else {
>  		get_io_context(ioc);
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
