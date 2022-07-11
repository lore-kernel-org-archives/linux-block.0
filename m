Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B06C43334
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiGKOUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGKOUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 10:20:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959E64E34;
        Mon, 11 Jul 2022 07:20:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF837228DA;
        Mon, 11 Jul 2022 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657549210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiTnZfzqK+vaJ506/FvXxN2Ij+2hfacNUNDwf2VMYjc=;
        b=D/EDII2w4VO91Gg7HnFQShFYhcanzqt4a14ZahAxOQBCoGYGugbrJ6mIQIBAeyiZmfG/Da
        IrZbVFyCn48wZyxlFdNFdFDh/7d/b9tlcD0Niv84izqeXgPV47uYpDnMn3OsYUszaEkrhj
        JmnUmnNlJvEIJ+iUk6ZGEdjN+/4291Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657549210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiTnZfzqK+vaJ506/FvXxN2Ij+2hfacNUNDwf2VMYjc=;
        b=JRD1Gq2k4lVEB/2UKz26tIOwUU8FgODCX8dGqY8fT3Pk9nQr/7iHIrilALMdaQcsnC+cXk
        gmxel9LwjcAwHeBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEA7E2C141;
        Mon, 11 Jul 2022 14:20:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77A39A063F; Mon, 11 Jul 2022 16:20:09 +0200 (CEST)
Date:   Mon, 11 Jul 2022 16:20:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz, kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC v3 1/3] sbitmap: fix that same waitqueue can be woken
 up continuously
Message-ID: <20220711142009.jz2ilqrxjgtwuvq6@quack3.lan>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
 <20220710042200.20936-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710042200.20936-2-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun 10-07-22 12:21:58, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> __sbq_wake_up		__sbq_wake_up
>  sbq_wake_ptr -> assume	0
> 			 sbq_wake_ptr -> 0
>  atomic_dec_return
> 			atomic_dec_return
>  atomic_cmpxchg -> succeed
> 			 atomic_cmpxchg -> failed
> 			  return true
> 
> 			__sbq_wake_up
> 			 sbq_wake_ptr
> 			  atomic_read(&sbq->wake_index) -> still 0
>  sbq_index_atomic_inc -> inc to 1
> 			  if (waitqueue_active(&ws->wait))
> 			   if (wake_index != atomic_read(&sbq->wake_index))
> 			    atomic_set -> reset from 1 to 0
>  wake_up_nr -> wake up first waitqueue
> 			    // continue to wake up in first waitqueue
> 
> Fix the problem by using atomic_cmpxchg() instead of atomic_set()
> to update 'wake_index'.
> 
> Fixes: 417232880c8a ("sbitmap: Replace cmpxchg with xchg")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I don't think this patch is really needed after the following patches.  As
I see it, wake_index is just a performance optimization (plus a fairness
improvement) but in principle the code in sbq_wake_ptr() is always prone to
races as the waitqueue it returns needn't have any waiters by the time we
return. So for correctness the check-and-retry loop needs to happen at
higher level than inside sbq_wake_ptr() and occasional wrong setting of
wake_index will result only in a bit of unfairness and more scanning
looking for suitable waitqueue but I don't think that really justifies the
cost of atomic operations in cmpxchg loop...

								Honza
> ---
>  lib/sbitmap.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 29eb0484215a..b46fce1beb3a 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -579,19 +579,24 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
>  static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>  {
> -	int i, wake_index;
> +	int i, wake_index, old_wake_index;
>  
> +again:
>  	if (!atomic_read(&sbq->ws_active))
>  		return NULL;
>  
> -	wake_index = atomic_read(&sbq->wake_index);
> +	old_wake_index = wake_index = atomic_read(&sbq->wake_index);
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>  
>  		if (waitqueue_active(&ws->wait)) {
> -			if (wake_index != atomic_read(&sbq->wake_index))
> -				atomic_set(&sbq->wake_index, wake_index);
> -			return ws;
> +			if (wake_index == old_wake_index)
> +				return ws;
> +
> +			if (atomic_cmpxchg(&sbq->wake_index, old_wake_index,
> +					   wake_index) == old_wake_index)
> +				return ws;
> +			goto again;
>  		}
>  
>  		wake_index = sbq_index_inc(wake_index);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
