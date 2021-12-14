Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744FEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Dec 2021 15:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhLNPuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:50:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhLNPuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 10:50:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 18D9C1F37C;
        Tue, 14 Dec 2021 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639497015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIvMwP5MKkA34lORH464PwL7zRzWHgvBRRWqXVOooZ0=;
        b=d9nw10TDlpNQejExogstBPsU7WgDrZFJZJb6ll28pjfQFmI1+ffbbU9BHMft9PBZJY9Rt9
        RZJl18d7aEf7pG8tZQ2gViaCzjhkXDBhi+UKsGilI4ZG81JaP74i3Jbffx7bgLsRI6fWnq
        PSbOqKqwTZImWXIZzpDKSez6xVwjzrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639497015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIvMwP5MKkA34lORH464PwL7zRzWHgvBRRWqXVOooZ0=;
        b=IPk4hhLvuzMYQ8eOsvKo7i64VR0BraTV3n9jBiD5qqkBOnCSH50EoYuBnlGybrHPpD9o+8
        N7rCwkLSl9y+OKAA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 042E1A3B88;
        Tue, 14 Dec 2021 15:50:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 668B51F2C7E; Tue, 14 Dec 2021 16:50:09 +0100 (CET)
Date:   Tue, 14 Dec 2021 16:50:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/11] block: cleanup ioc_clear_queue
Message-ID: <20211214155009.GG14044@quack2.suse.cz>
References: <20211209063131.18537-1-hch@lst.de>
 <20211209063131.18537-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209063131.18537-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-12-21 07:31:26, Christoph Hellwig wrote:
> Fold __ioc_clear_queue into ioc_clear_queue and switch to always
> use plain _irq locking instead of the more expensive _irqsave that
> is not needed here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-ioc.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index ca996214c10a6..f98a29ee8f362 100644
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
> @@ -227,7 +206,17 @@ void ioc_clear_queue(struct request_queue *q)
>  	list_splice_init(&q->icq_list, &icq_list);
>  	spin_unlock_irq(&q->queue_lock);
>  
> -	__ioc_clear_queue(&icq_list);
> +	rcu_read_lock();
> +	while (!list_empty(&icq_list)) {
> +		struct io_cq *icq =
> +			list_entry(icq_list.next, struct io_cq, q_node);
> +
> +		spin_lock_irq(&icq->ioc->lock);
> +		if (!(icq->flags & ICQ_DESTROYED))
> +			ioc_destroy_icq(icq);
> +		spin_unlock_irq(&icq->ioc->lock);
> +	}
> +	rcu_read_unlock();
>  }
>  
>  static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
