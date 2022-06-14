Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC622C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiFNIYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352348AbiFNIX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 04:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7253437A3D
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655195036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Qh1io3QuQZYn/JMLZesCtApVZxMMN/zCVCzUhG2Xjc=;
        b=ayiLc2LLSI0TB6WHo95pe2puNsi2Z9DGAm5ih38hnrrvQFGXpae/TLOPPmr6aucwKLQemR
        5bKUn+k8YEbRvKuuz4K65CsQujAo2CU3l0CwWObINg4334J8avg4e48robePPamBbUJrnO
        23dv7oLfpvRZo1EWXNMubDwCAKL+qCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-9xlAmKzEN7G23NEZ0Nd44g-1; Tue, 14 Jun 2022 04:23:51 -0400
X-MC-Unique: 9xlAmKzEN7G23NEZ0Nd44g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90FFE802E5B;
        Tue, 14 Jun 2022 08:23:50 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1D911415103;
        Tue, 14 Jun 2022 08:23:44 +0000 (UTC)
Date:   Tue, 14 Jun 2022 16:23:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Message-ID: <YqhFiDx0/IW25bSp@T590>
References: <20220614074827.458955-1-hch@lst.de>
 <20220614074827.458955-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614074827.458955-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 09:48:24AM +0200, Christoph Hellwig wrote:
> The elevator is only used for file system requests, which are stopped in
> del_gendisk.  Move disabling the elevator and freeing the scheduler tags
> to the end of del_gendisk instead of doing that work in disk_release and
> blk_cleanup_queue to avoid a use after free on q->tag_set from
> disk_release as the tag_set might not be alive at that point.
> 
> Move the blk_qos_exit call as well, as it just depends on the elevator
> exit and would be the only reason to keep the not exactly cheap queue
> freeze in disk_release.
> 
> Fixes: e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")
> Reported-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
> ---
>  block/blk-core.c | 13 -------------
>  block/genhd.c    | 39 +++++++++++----------------------------
>  2 files changed, 11 insertions(+), 41 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 06ff5bbfe8f66..27fb1357ad4b8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -322,19 +322,6 @@ void blk_cleanup_queue(struct request_queue *q)
>  		blk_mq_exit_queue(q);
>  	}
>  
> -	/*
> -	 * In theory, request pool of sched_tags belongs to request queue.
> -	 * However, the current implementation requires tag_set for freeing
> -	 * requests, so free the pool now.
> -	 *
> -	 * Queue has become frozen, there can't be any in-queue requests, so
> -	 * it is safe to free requests now.
> -	 */
> -	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> -		blk_mq_sched_free_rqs(q);
> -	mutex_unlock(&q->sysfs_lock);
> -
>  	/* @q is and will stay empty, shutdown and put */
>  	blk_put_queue(q);
>  }
> diff --git a/block/genhd.c b/block/genhd.c
> index 27205ae47d593..e0675772178b0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -652,6 +652,17 @@ void del_gendisk(struct gendisk *disk)
>  
>  	blk_sync_queue(q);
>  	blk_flush_integrity();
> +	blk_mq_cancel_work_sync(q);
> +
> +	blk_mq_quiesce_queue(q);

quiesce queue adds a bit long delay in del_gendisk, not sure if this way may
cause regression in big machines with lots of disks.

> +	if (q->elevator) {
> +		mutex_lock(&q->sysfs_lock);
> +		elevator_exit(q);
> +		mutex_unlock(&q->sysfs_lock);
> +	}
> +	rq_qos_exit(q);
> +	blk_mq_unquiesce_queue(q);

Also tearing down elevator here has to be carefully, that means any
elevator reference has to hold rcu read lock or .q_usage_counter,
meantime it has to be checked, otherwise use-after-free may be caused.

Unfortunately, there are some cases which looks not safe, such as,
__blk_mq_update_nr_hw_queues() and blk_mq_has_sqsched().

Another example is bfq_insert_request()<-bfq_insert_requests():

static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
                               bool at_head)
{
		...
        spin_unlock_irq(&bfqd->lock);

        bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
                                cmd_flags);
}

If last 'rq' is done between unlocking bfqd->lock and calling bfq_update_insert_stats,
del_gendisk() may tear down elevator, and UAF is caused.


Thanks,
Ming

