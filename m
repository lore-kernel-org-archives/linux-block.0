Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBBC43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 12:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiFUMgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiFUMgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 08:36:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A041B7B7
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 05:36:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA8921F8A3;
        Tue, 21 Jun 2022 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655815001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaef/sNe18TRFc1L3e9W9JFHr6a/XvRR/DMPEIxoK4U=;
        b=Ms8h1CPs8BgnnBKQpBwenEQCfkxLtHKdTyViFbhlcQ/+OIOR0lgk4dX4calYR+CFD0mUEm
        UQ6X2XODzd3cqe/ng6DnwfTLWrskBi1dyd5bQDiBzXIxqSZGcC8f8X7eohbTQjj5iD71O4
        lWmdRi9TzIrAcaspQV8wB8mATqxlLqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655815001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaef/sNe18TRFc1L3e9W9JFHr6a/XvRR/DMPEIxoK4U=;
        b=2yYOlf1uRqLY6OIyzgvmBFrhNwU0ZhXYpXnmAZPzLvrwwO/CJBP26eoF/9gUgfmiBnQCiz
        rX3gO+t/xmOcttBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F4D02C141;
        Tue, 21 Jun 2022 12:36:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2DB4A062B; Tue, 21 Jun 2022 14:36:37 +0200 (CEST)
Date:   Tue, 21 Jun 2022 14:36:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Message-ID: <20220621123637.7jp3ifk2wmbmueur@quack3.lan>
References: <20220621102201.26337-1-jack@suse.cz>
 <20220621102455.13183-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621102455.13183-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 21-06-22 12:24:40, Jan Kara wrote:
> get_current_ioprio() operates only on current task. We will need the
> same functionality for other tasks as well. Generalize
> get_current_ioprio() for that and also move the bulk out of the header
> file because it is large enough.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Bah, I've messed up the prototype of the stub function for !CONFIG_BLOCK.
One more fixup will be needed here but let me wait if people have more
comments...

								Honza

> ---
>  block/ioprio.c         | 26 ++++++++++++++++++++++++++
>  include/linux/ioprio.h | 26 ++++++++++----------------
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2a34cbca18ae..c4e3476155a1 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -138,6 +138,32 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>  	return ret;
>  }
>  
> +/*
> + * If the task has set an I/O priority, use that. Otherwise, return
> + * the default I/O priority.
> + *
> + * Expected to be called for current task or with task_lock() held to keep
> + * io_context stable.
> + */
> +int __get_task_ioprio(struct task_struct *p)
> +{
> +	struct io_context *ioc = p->io_context;
> +	int prio;
> +
> +	if (p != current)
> +		lockdep_assert_held(&p->alloc_lock);
> +	if (ioc)
> +		prio = ioc->ioprio;
> +	else
> +		prio = IOPRIO_DEFAULT;
> +
> +	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> +		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
> +					 task_nice_ioprio(p));
> +	return prio;
> +}
> +EXPORT_SYMBOL_GPL(__get_task_ioprio);
> +
>  static int get_task_ioprio(struct task_struct *p)
>  {
>  	int ret;
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 61ed6bb4998e..788a8ff57068 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -46,24 +46,18 @@ static inline int task_nice_ioclass(struct task_struct *task)
>  		return IOPRIO_CLASS_BE;
>  }
>  
> -/*
> - * If the calling process has set an I/O priority, use that. Otherwise, return
> - * the default I/O priority.
> - */
> -static inline int get_current_ioprio(void)
> +#ifdef CONFIG_BLOCK
> +int __get_task_ioprio(struct task_struct *p);
> +#else
> +static inline int __get_task_ioprio(int ioprio)
>  {
> -	struct io_context *ioc = current->io_context;
> -	int prio;
> -
> -	if (ioc)
> -		prio = ioc->ioprio;
> -	else
> -		prio = IOPRIO_DEFAULT;
> +	return IOPRIO_DEFAULT;
> +}
> +#endif /* CONFIG_BLOCK */
>  
> -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> -					 task_nice_ioprio(current));
> -	return prio;
> +static inline int get_current_ioprio(void)
> +{
> +	return __get_task_ioprio(current);
>  }
>  
>  /*
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
