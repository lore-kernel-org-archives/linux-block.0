Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4007DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiA0Jpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:45:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54696 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiA0Jpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:45:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27D09218D9;
        Thu, 27 Jan 2022 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643276733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PE+hIjSotUsBaRUC2mFTNl8Sl4oC3ER/Nuk3uXtDXEg=;
        b=Kmre6kkTRpNgL29JB44Gd4mUFqV6c+Eeao9NeLjGYNt6pojsTGexOswjwjFJt2eoUoqge8
        wdKI64TbYm0I6tEMj6LyjSrbfG0Dkq5cwkLNOOqhlXQBxeKUTsbjuyJ6UCqF65g+0fFZSh
        bz4DuXzOrANFfjABGuZfiJQBDncogmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643276733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PE+hIjSotUsBaRUC2mFTNl8Sl4oC3ER/Nuk3uXtDXEg=;
        b=CmlQQZSvojTarv+u+s8ev2OGwMud+/EyC8tucmtcRaCIGFry9//sCGcCwSveucx44rI7qc
        LbCnrOaHkngylDBw==
Received: from quack3.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19B6CA3B8C;
        Thu, 27 Jan 2022 09:45:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4945AA05E6; Thu, 27 Jan 2022 10:45:30 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:45:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/8] loop: initialize the worker tracking fields once
Message-ID: <20220127094530.wpneoub2nkdxzxmq@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:34, Christoph Hellwig wrote:
> There is no need to reinitialize idle_worker_list, worker_tree and timer
> every time a loop device is configured.  Just initialize them once at
> allocation time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b268bca6e4fb7..6ec55a5d9dfc4 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1052,10 +1052,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  
>  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
> -	INIT_LIST_HEAD(&lo->idle_worker_list);
> -	lo->worker_tree = RB_ROOT;
> -	timer_setup(&lo->timer, loop_free_idle_workers_timer,
> -		TIMER_DEFERRABLE);
>  	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
>  	lo->lo_device = bdev;
>  	lo->lo_backing_file = file;
> @@ -1957,6 +1953,9 @@ static int loop_add(int i)
>  	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
>  	if (!lo)
>  		goto out;
> +	lo->worker_tree = RB_ROOT;
> +	INIT_LIST_HEAD(&lo->idle_worker_list);
> +	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
>  	lo->lo_state = Lo_unbound;
>  
>  	err = mutex_lock_killable(&loop_ctl_mutex);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
