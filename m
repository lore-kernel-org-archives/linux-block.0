Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 11:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiGZLv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGZLv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 07:51:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1D2BB25;
        Tue, 26 Jul 2022 04:51:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 39C0A1FD62;
        Tue, 26 Jul 2022 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658836286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmXEb+MCaJzubCv0tA1KqSSjkQkT0I7HTn2jJIRu3uA=;
        b=YyxLwvdhMNHVl0jV0+3QHBUP1GBM0MxK5Pl/QuqoVMTpwInClhmngBFgqk2kXiCpoX2l3X
        Z1nLc/r7hti33W91noWGcNyBTfzPm4i1tliDZye+yIycvrXAiXcrMbMMHo/feqZ8vrv8RM
        9ZGdfxN3L/0OTHyZnlhC1p+XdzySt8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658836286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmXEb+MCaJzubCv0tA1KqSSjkQkT0I7HTn2jJIRu3uA=;
        b=AAXUUjyjw/ncV9bQHVU+IBQEn3+ZlGakAMXWCOxRuLNezLELBLQwHPzZV6zYhCrG9OeoVD
        zIhM/wSICdHb3eDw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CB44F2C15D;
        Tue, 26 Jul 2022 11:51:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C6A5A0680; Tue, 26 Jul 2022 13:51:24 +0200 (CEST)
Date:   Tue, 26 Jul 2022 13:51:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH RFC v4] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <20220726115124.cbmcs3xgeqfwv7qw@quack3>
References: <20220723024122.2990436-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723024122.2990436-1-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat 23-07-22 10:41:22, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are two problems can lead to lost wakeup:
> 
> 1) invalid wakeup on the wrong waitqueue:
> 
> For example, 2 * wake_batch tags are put, while only wake_batch threads
> are woken:
> 
> __sbq_wake_up
>  atomic_cmpxchg -> reset wait_cnt
> 			__sbq_wake_up -> decrease wait_cnt
> 			...
> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
> 			 atomic_cmpxchg
> 			 sbq_index_atomic_inc -> increase wake_index
> 			 wake_up_nr -> wake up and waitqueue might be empty
>  sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>  wake_up_nr -> invalid wake up because old wakequeue might be empty
> 
> To fix the problem, increasing 'wake_index' before resetting 'wait_cnt'.
> 
> 2) 'wait_cnt' can be decreased while waitqueue is empty
> 
> As pointed out by Jan Kara, following race is possible:
> 
> CPU1				CPU2
> __sbq_wake_up			 __sbq_wake_up
>  sbq_wake_ptr()			 sbq_wake_ptr() -> the same
>  wait_cnt = atomic_dec_return()
>  /* decreased to 0 */
>  sbq_index_atomic_inc()
>  /* move to next waitqueue */
>  atomic_set()
>  /* reset wait_cnt */
>  wake_up_nr()
>  /* wake up on the old waitqueue */
> 				 wait_cnt = atomic_dec_return()
> 				 /*
> 				  * decrease wait_cnt in the old
> 				  * waitqueue, while it can be
> 				  * empty.
> 				  */
> 
> Fix the problem by waking up before updating 'wake_index' and
> 'wait_cnt'.
> 
> With this patch, noted that 'wait_cnt' is still decreased in the old
> empty waitqueue, however, the wakeup is redirected to a active waitqueue,
> and the extra decrement on the old empty waitqueue is not handled.
> 
> Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

The patch looks good to me now (just one typo fix below). Thanks for the
fix! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 *
> +	 * Also pairs with the implicit barrier between becrementing wait_cnt
							^^^ decrementing

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
