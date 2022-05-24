Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC0C433F5
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiEXOpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEXOpD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 10:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40DA067D25
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653403501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v1zaIYaQrDrPxbC+KLmMvvJEWAHoUnmv+gjHr0SP3UY=;
        b=STVqgG7ljKe2Rwp4/08IZLuxEftXQ1TVkE7x8Kbehm5pYM7y8JuF2GFFmiFjwBLBHFROuZ
        473hL4lMOmsPHQwAPeK9eJcwv6GXpaV/Oyu4qS51Xtjwo7XmOEllr4G40hkHlk022uz/5V
        K4+AJJB1IXAV+QTjs4Twi2CcqeASnYk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-3YPe3jpJNhycb5QcrEV6Ow-1; Tue, 24 May 2022 10:44:55 -0400
X-MC-Unique: 3YPe3jpJNhycb5QcrEV6Ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED31384F80A;
        Tue, 24 May 2022 14:44:55 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EE2E40470C2;
        Tue, 24 May 2022 14:44:49 +0000 (UTC)
Date:   Tue, 24 May 2022 22:44:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <YozvXP9/hVhTQt+D@T590>
References: <20220524083325.833981-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524083325.833981-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 10:33:25AM +0200, Christoph Hellwig wrote:
> The block debugfs files are created in blk_register_queue, which is
> called by add_disk and use a naming scheme based on the disk_name.
> After del_gendisk returns that name can be reused and thus we must not
> leave these debugfs files around, otherwise the kernel is unhappy
> and spews messages like:
> 
> 	Directory XXXXX with parent 'block' already present!
> 
> and the newly created devices will not have working debugfs files.
> 
> Move the unregistration to blk_unregister_queue instead (which matches
> the sysfs unregistration) to make sure the debugfs life time rules match
> those of the disk name.
> 
> As part of the move also make sure the whole debugfs unregistration is
> inside a single debugfs_mutex critical section.
> 
> Note that this breaks blktests block/002, which checks that the debugfs
> directory has not been removed while blktests is running, but that
> particular check should simply be removed from the test case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-debugfs.c  |  8 ++------
>  block/blk-mq-debugfs.h  |  5 -----
>  block/blk-rq-qos.c      |  2 --
>  block/blk-sysfs.c       | 15 +++++++--------
>  kernel/trace/blktrace.c |  3 ---
>  5 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 7e4136a60e1cc..f7eaa5405e4b5 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -713,6 +713,8 @@ void blk_mq_debugfs_register(struct request_queue *q)
>  
>  void blk_mq_debugfs_unregister(struct request_queue *q)
>  {
> +	/* all entries were removed by the caller */
> +	q->rqos_debugfs_dir = NULL;
>  	q->sched_debugfs_dir = NULL;
>  }
>  
> @@ -833,12 +835,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>  	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
>  }
>  
> -void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
> -{
> -	debugfs_remove_recursive(q->rqos_debugfs_dir);
> -	q->rqos_debugfs_dir = NULL;
> -}
> -
>  void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
>  					struct blk_mq_hw_ctx *hctx)
>  {
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 69918f4170d69..401e9e9da640b 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -36,7 +36,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>  
>  void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
>  void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
> -void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
>  #else
>  static inline void blk_mq_debugfs_register(struct request_queue *q)
>  {
> @@ -87,10 +86,6 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>  static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>  {
>  }
> -
> -static inline void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
> -{
> -}
>  #endif
>  
>  #ifdef CONFIG_BLK_DEBUG_FS_ZONED
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index e83af7bc75919..d3a75693adbf4 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -294,8 +294,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>  
>  void rq_qos_exit(struct request_queue *q)
>  {
> -	blk_mq_debugfs_unregister_queue_rqos(q);
> -
>  	while (q->rq_qos) {
>  		struct rq_qos *rqos = q->rq_qos;
>  		q->rq_qos = rqos->next;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb593..c02fec8e9a3f6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -779,14 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
>  	if (queue_is_mq(q))
>  		blk_mq_release(q);
>  
> -	blk_trace_shutdown(q);
> -	mutex_lock(&q->debugfs_mutex);
> -	debugfs_remove_recursive(q->debugfs_dir);
> -	mutex_unlock(&q->debugfs_mutex);
> -
> -	if (queue_is_mq(q))
> -		blk_mq_debugfs_unregister(q);
> -
>  	bioset_exit(&q->bio_split);
>  
>  	if (blk_queue_has_srcu(q))
> @@ -951,5 +943,12 @@ void blk_unregister_queue(struct gendisk *disk)
>  
>  	mutex_unlock(&q->sysfs_dir_lock);
>  
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_trace_shutdown(q);
> +	debugfs_remove_recursive(q->debugfs_dir);

The above line code may cause kernel panic in the following code paths:

1) blk_mq_debugfs_unregister_hctxs() called from __blk_mq_update_nr_hw_queues()

2) blk_mq_debugfs_unregister_sched_hctx() called from blk_mq_exit_sched()


Thanks, 
Ming

