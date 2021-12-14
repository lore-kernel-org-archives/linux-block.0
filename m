Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C79C433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhLNP40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:56:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhLNP4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 10:56:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50C7721136;
        Tue, 14 Dec 2021 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639497382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBAXG88ds40dDSc/+5tBHd2JLrBPM8T0624LrZOiMsk=;
        b=iBmBsiGf9LeoTdLJGkm9n+dVurrcicX6uIXem0E7BU271sl2akwctkLx4MiGW5sgIIlRJy
        rU91MOX0HCw7JhrCTF5LHCimO+DzfbEfZTiAy91G0WOBY8PG3STHZo32EXb1uA113qlMCY
        VMPu/PK6F+JM/eE+QsR8S2nDWtbECcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639497382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBAXG88ds40dDSc/+5tBHd2JLrBPM8T0624LrZOiMsk=;
        b=1O3Ro5Lw8ZgGIXqeQu/JteiwAmY9HWNNipwUJ/qrE1veFUxbNqF3KyTBIV3LS7AFqz6C5h
        bk/gyEgF3hCOZMDw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 443B1A3B8E;
        Tue, 14 Dec 2021 15:56:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1D6591F2C7E; Tue, 14 Dec 2021 16:56:22 +0100 (CET)
Date:   Tue, 14 Dec 2021 16:56:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/11] block: open code create_task_io_context in
 set_task_ioprio
Message-ID: <20211214155622.GJ14044@quack2.suse.cz>
References: <20211209063131.18537-1-hch@lst.de>
 <20211209063131.18537-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063131.18537-10-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-12-21 07:31:29, Christoph Hellwig wrote:
> The flow in set_task_ioprio can be simplified by simply open coding
> create_task_io_context, which removes a refcount roundtrip on the I/O
> context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

OK, why not :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-ioc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 1ba7cfedca2d9..cff0e3bdae53c 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -291,12 +291,18 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
>  		struct io_context *ioc;
>  
>  		task_unlock(task);
> -		ioc = create_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
> -		if (ioc) {
> -			ioc->ioprio = ioprio;
> -			put_io_context(ioc);
> +
> +		ioc = alloc_io_context(GFP_ATOMIC, NUMA_NO_NODE);
> +		if (!ioc)
> +			return -ENOMEM;
> +
> +		task_lock(task);
> +		if (task->io_context || (task->flags & PF_EXITING)) {
> +			kmem_cache_free(iocontext_cachep, ioc);
> +			ioc = task->io_context;
> +		} else {
> +			task->io_context = ioc;
>  		}
> -		return 0;
>  	}
>  	task->io_context->ioprio = ioprio;
>  	task_unlock(task);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
