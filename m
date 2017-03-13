Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33585 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbdCMVqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 17:46:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so21724137wrg.0
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2017 14:46:06 -0700 (PDT)
Subject: Re: NULL deref in cpu hot unplug on jens for-linus branch
To: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
References: <a4e0cb7c-c779-b681-e66c-2159c5f2b09f@grimberg.me>
 <54f833f1-ab98-5d22-e7d4-5e6059a4c467@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f6f85d2f-ac94-874e-e247-ccf9ffbe4b9e@grimberg.me>
Date: Mon, 13 Mar 2017 23:46:02 +0200
MIME-Version: 1.0
In-Reply-To: <54f833f1-ab98-5d22-e7d4-5e6059a4c467@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Are you saying your code works on top of 4.11-rc2, but not on top of my
> for-linus?

I was actually on Linus 4.11-rc1 before I rebased on top of your
for-linus.

> That seems odd. Looking at the oops, you are crashing with
> !tags in __blk_mq_tag_idle. The below should work around it, but I'm
> puzzled why this is new.

I got it just once (out of a single run :)), but maybe it is
possible that its racy and not really new.

But another example where this can happen:
blk_mq_realloc_hw_ctxs explicitly checks on hctx->tags != NULL
but right after calls blk_mq_exit_hctx() which goes in the
same route, won't this happen there too? Or is it assumed that
hctx->state does not have BLK_MQ_S_TAG_ACTIVE on here?

> Is it related to the other path you fixed in this patch:
>
> commit 0067d4b020ea07a58540acb2c5fcd3364bf326e0
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Mon Mar 13 16:10:11 2017 +0200
>
>     blk-mq: Fix tagset reinit in the presence of cpu hot-unplug
>
> Since that's also handling hctx->tags == NULL.

The above patch prevented a NULL deref earlier when the
tags were reinitialized, now we are all setup and we
happen to remove an old namespace.

> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9d97bfc4d465..1283f74bfdfb 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -54,9 +54,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		return;
>
> -	atomic_dec(&tags->active_queues);
> +	if (tags) {
> +		atomic_dec(&tags->active_queues);
>
> -	blk_mq_tag_wakeup_all(tags, false);
> +		blk_mq_tag_wakeup_all(tags, false);
> +	}
>  }
>
>  /*
>

I'll see if I can test it out later this week. thanks.
