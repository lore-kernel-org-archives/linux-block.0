Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F9C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29143208E4
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 00:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDBAxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfDBAxd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 20:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A60A6C057F5D;
        Tue,  2 Apr 2019 00:53:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEDB86134B;
        Tue,  2 Apr 2019 00:53:24 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:53:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] block: Fix a race between request queue freezing and
 running queues
Message-ID: <20190402005318.GC21944@ming.t460p>
References: <20190401212014.192753-1-bvanassche@acm.org>
 <20190401212014.192753-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401212014.192753-3-bvanassche@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Apr 2019 00:53:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 02:20:12PM -0700, Bart Van Assche wrote:
> Any request queue data structure may change while a queue is frozen.
> Hence make sure that blk_mq_run_hw_queues() does not access any hw
> queue while a request queue is frozen.
> 
> After blk_cleanup_queue() has marked a queue as dead it is no longer
> safe to access the hardware queue data structures. This patch avoids
> that blk_mq_run_hw_queues() crashes when called during or after
> blk_cleanup_queue() has freed the hardware queues. This patch is a
> variant of a patch posted by Hannes Reinecke ("[PATCH] block: don't
> call blk_mq_run_hw_queues() for dead or dying queues "). This patch
> is similar in nature to commit c246e80d8673 ("block: Avoid that
> request_fn is invoked on a dead queue"; v3.8). An example of a crash
> that is fixed by this patch:
> 
> BUG: unable to handle kernel NULL pointer dereference at (null)
> IP: [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
> Call Trace:
>  [<ffffffff81303a88>] blk_mq_run_hw_queues+0x48/0x90
>  [<ffffffff813053cc>] blk_mq_requeue_work+0x10c/0x120
>  [<ffffffff81098cb4>] process_one_work+0x154/0x410
>  [<ffffffff81099896>] worker_thread+0x116/0x4a0
>  [<ffffffff8109edb9>] kthread+0xc9/0xe0
>  [<ffffffff81619b05>] ret_from_fork+0x55/0x80
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: <stable@vger.kernel.org>
> Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller") # v4.17.
> Reported-by: James Smart <james.smart@broadcom.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b49969..652d0c6d5945 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1499,12 +1499,20 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
>  
> +	/*
> +	 * Do not run any hardware queues if the queue is frozen or if a
> +	 * concurrent blk_cleanup_queue() call is removing any data
> +	 * structures used by this function.
> +	 */
> +	if (!percpu_ref_tryget(&q->q_usage_counter))
> +		return;
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (blk_mq_hctx_stopped(hctx))
>  			continue;
>  
>  		blk_mq_run_hw_queue(hctx, async);
>  	}
> +	percpu_ref_put(&q->q_usage_counter);
>  }
>  EXPORT_SYMBOL(blk_mq_run_hw_queues);

I don't see it is necessary to add percpu_ref_tryget()/percpu_ref_put()
in the fast path if we simply release all hctx resource in hctx's
release handler by the following patch:

https://lore.kernel.org/linux-block/20190401044247.29881-2-ming.lei@redhat.com/T/#u

Even we can kill the percpu_ref_tryget_live()/percpu_ref_put() in
scsi_end_request().

Thanks,
Ming
