Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D0C433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4197121D7B
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgDdN91A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOKJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 06:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgIOKJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 06:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600164567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdDg2pjCC1KO+TUvMWkfeC2WUdGQqFaBVYhe3QgT7QY=;
        b=RgDdN91ArItGJQNzVDzkk1mGoEUo3KCIRe98rZU4dP4HHDVUw0V1qUg2jcXP88LXbVdQEY
        17fIz9NRf5H46kwiWFKLDpxRpko3WdcVUzN2ieVZxCTSMgZdg9yT3ogPpp+nk8c1pMcfbD
        AZ8Qi7W0ZIm+7/dGmjzcnY4oaivegVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-i4tnr8mlNySNxm8s9VW8NA-1; Tue, 15 Sep 2020 06:09:26 -0400
X-MC-Unique: i4tnr8mlNySNxm8s9VW8NA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B4FA8030CC;
        Tue, 15 Sep 2020 10:09:25 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2AB560C0F;
        Tue, 15 Sep 2020 10:09:18 +0000 (UTC)
Date:   Tue, 15 Sep 2020 18:09:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] block: Fix use-after-free issue while accessing
 ioscheduler lock
Message-ID: <20200915100908.GA764869@T590>
References: <1600161062-43793-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600161062-43793-1-git-send-email-ppvk@codeaurora.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 02:41:02PM +0530, Pradeep P V K wrote:
> Observes below crash while accessing (use-after-free) lock member
> of bfq data.
> 
> context#1			context#2
> 				process_one_work()
> kthread()			blk_mq_run_work_fn()
> worker_thread()			 ->__blk_mq_run_hw_queue()
> process_one_work()		  ->blk_mq_sched_dispatch_requests()
> __blk_release_queue()		    ->blk_mq_do_dispatch_sched()

Just found __blk_release_queue killed in v5.9 cycle.

> ->__elevator_exit()
>   ->blk_mq_exit_sched()
>     ->exit_sched()
>       ->kfree()
>       					->bfq_dispatch_request()
> 					  ->spin_unlock_irq(&bfqd->lock)

Actually not sure if the above race is easy to trigger in recent kernel,
because we do call cancel_delayed_work_sync() in blk_mq_hw_sysfs_release(),
which is usually called before __elevator_exit() from
blk_exit_queue()/blk_release_queue().

So can you share your kernel version in which the issue is reproduced?
And can you reproduce this issue on v5.8 or v5.9-rc5?

> 
> This is because of the kblockd delayed work that might got scheduled
> around blk_release_queue() and accessed use-after-free member of
> bfq_data.
> 
> 240.212359:   <2> Unable to handle kernel paging request at
> virtual address ffffffee2e33ad70
> ...
> 240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
> 240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
> 240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
> 240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
> ...
> Call trace:
> 240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
> 240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
> 240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
> 240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
> 240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
> 240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
> 240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
> 240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
> 240.212963:   <2>  process_one_work+0x280/0x460
> 240.212973:   <2>  worker_thread+0x27c/0x4dc
> 240.212986:   <2>  kthread+0x160/0x170
> 
> Fix this by cancelling the delayed work if any before elevator exits.
> 
> Changes since V1:
> - Moved the logic into blk_cleanup_queue() as per Ming comments.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  block/blk-mq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4abb714..890fded 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2598,6 +2598,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  			break;
>  		blk_mq_debugfs_unregister_hctx(hctx);
>  		blk_mq_exit_hctx(q, set, hctx, i);
> +		cancel_delayed_work_sync(&hctx->run_work);
>  	}
>  }

It should be better to move cancel_delayed_work_sync() into
blk_mq_exit_hctx(), exactly before adding hctx into unused list.


Thanks,
Ming

