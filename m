Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF50C43217
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhK3R3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 12:29:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbhK3R3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 12:29:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67E901FD58;
        Tue, 30 Nov 2021 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638293178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpXR8cesEpaXwf1l0yApMqvd7vXLbxaojNWyd3jEXho=;
        b=SUa1UuHi7RsBdnhufWt9HOmW+/cbUrFFt//JvbQU0dxNGVGsEPoz0ItVgonJmydbdmacdG
        1zYd0HqSFCOgu8jJMC7anCCFTfK7JkG0LAoj24YXRCodCZ7EzvcdF8wivj2in6lGjw2hGT
        XyvJCbLJQWq6Cb27MZjENMND++LjPnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638293178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpXR8cesEpaXwf1l0yApMqvd7vXLbxaojNWyd3jEXho=;
        b=UKWGOAr6/u8xxNo7nWBsUuGiTXtdu0go0FyJVYUzw3GBIuYdOvzzgExyYn9dDxh1gUqXT6
        mJ/5oSPgSqvo9VBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 0EFC7A3B87;
        Tue, 30 Nov 2021 17:26:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9A5AC1E1494; Tue, 30 Nov 2021 18:26:13 +0100 (CET)
Date:   Tue, 30 Nov 2021 18:26:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/7] block: cleanup ioc_clear_queue
Message-ID: <20211130172613.GL7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:35, Christoph Hellwig wrote:
> Fold __ioc_clear_queue into ioc_clear_queue, remove the spurious RCU
> criticial section and unify the irq locking style.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-ioc.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 902bca2b273ba..32ae006e1b3e8 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -192,27 +192,6 @@ void exit_io_context(struct task_struct *task)
>  	}
>  }
>  
> -static void __ioc_clear_queue(struct list_head *icq_list)
> -{
> -	unsigned long flags;
> -
> -	rcu_read_lock();
> -	while (!list_empty(icq_list)) {
> -		struct io_cq *icq = list_entry(icq_list->next,
> -						struct io_cq, q_node);
> -		struct io_context *ioc = icq->ioc;
> -
> -		spin_lock_irqsave(&ioc->lock, flags);
> -		if (icq->flags & ICQ_DESTROYED) {
> -			spin_unlock_irqrestore(&ioc->lock, flags);
> -			continue;
> -		}
> -		ioc_destroy_icq(icq);
> -		spin_unlock_irqrestore(&ioc->lock, flags);
> -	}
> -	rcu_read_unlock();
> -}
> -
>  /**
>   * ioc_clear_queue - break any ioc association with the specified queue
>   * @q: request_queue being cleared
> @@ -227,7 +206,15 @@ void ioc_clear_queue(struct request_queue *q)
>  	list_splice_init(&q->icq_list, &icq_list);
>  	spin_unlock_irq(&q->queue_lock);
>  
> -	__ioc_clear_queue(&icq_list);

> +	while (!list_empty(&icq_list)) {
> +		struct io_cq *icq =
> +			list_entry(icq_list.next, struct io_cq, q_node);

I'm not quite sure about dropping the rcu protection here. This function
generally runs without any protection so what guards us against icq being
freed just after we've got its pointer from the list?

								Honza

> +
> +		spin_lock_irq(&icq->ioc->lock);
> +		if (!(icq->flags & ICQ_DESTROYED))
> +			ioc_destroy_icq(icq);
> +		spin_unlock_irq(&icq->ioc->lock);
> +	}
>  }
>  
>  static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
