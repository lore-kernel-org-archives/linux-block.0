Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362E2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 09:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiEXJ3K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiEXJ3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 05:29:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D13336E
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 02:29:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C54791F8DA;
        Tue, 24 May 2022 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653384546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vCs/vduhx2r67vEcqBIz6EJ1n/i9Q3Qofxi3OTBiHA=;
        b=uLiw+sQKXbmEBp/kzzdgoqIpCSQsXny+gjEV2PGH23YKhiFip5vc7rNlt9o9MU4xTneI+L
        Q5eKUbob4ZlEcnjLBomEVRWRbcBW77YxXLulqqzxldDZA2sQFYliLv2kHBHNE1s2HIadIn
        oEOqtF3wYY7BAoBI+IkdxW1NoNZNyVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653384546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vCs/vduhx2r67vEcqBIz6EJ1n/i9Q3Qofxi3OTBiHA=;
        b=pldmxdlvsPQpXr6YjeAG6zln20+LoyqvAehervtngAOPPOaPOKsj0fOfEngz47Sycf5kkB
        FadanJEaz5Dg7zDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6251F13ADF;
        Tue, 24 May 2022 09:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ica5FGKljGJJBAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 May 2022 09:29:06 +0000
Message-ID: <9f988597-77b7-de53-79f4-ed2e70a0eaab@suse.de>
Date:   Tue, 24 May 2022 11:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20220524083325.833981-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220524083325.833981-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/22 10:33, Christoph Hellwig wrote:
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
>   block/blk-mq-debugfs.c  |  8 ++------
>   block/blk-mq-debugfs.h  |  5 -----
>   block/blk-rq-qos.c      |  2 --
>   block/blk-sysfs.c       | 15 +++++++--------
>   kernel/trace/blktrace.c |  3 ---
>   5 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 7e4136a60e1cc..f7eaa5405e4b5 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -713,6 +713,8 @@ void blk_mq_debugfs_register(struct request_queue *q)
>   
>   void blk_mq_debugfs_unregister(struct request_queue *q)
>   {
> +	/* all entries were removed by the caller */
> +	q->rqos_debugfs_dir = NULL;
>   	q->sched_debugfs_dir = NULL;
>   }
>   
> @@ -833,12 +835,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>   	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
>   }
>   
> -void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
> -{
> -	debugfs_remove_recursive(q->rqos_debugfs_dir);
> -	q->rqos_debugfs_dir = NULL;
> -}
> -
>   void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
>   					struct blk_mq_hw_ctx *hctx)
>   {
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 69918f4170d69..401e9e9da640b 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -36,7 +36,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>   
>   void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
>   void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
> -void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
>   #else
>   static inline void blk_mq_debugfs_register(struct request_queue *q)
>   {
> @@ -87,10 +86,6 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>   static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>   {
>   }
> -
> -static inline void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
> -{
> -}
>   #endif
>   
>   #ifdef CONFIG_BLK_DEBUG_FS_ZONED
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index e83af7bc75919..d3a75693adbf4 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -294,8 +294,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>   
>   void rq_qos_exit(struct request_queue *q)
>   {
> -	blk_mq_debugfs_unregister_queue_rqos(q);
> -
>   	while (q->rq_qos) {
>   		struct rq_qos *rqos = q->rq_qos;
>   		q->rq_qos = rqos->next;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb593..c02fec8e9a3f6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -779,14 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
>   	if (queue_is_mq(q))
>   		blk_mq_release(q);
>   
> -	blk_trace_shutdown(q);
> -	mutex_lock(&q->debugfs_mutex);
> -	debugfs_remove_recursive(q->debugfs_dir);
> -	mutex_unlock(&q->debugfs_mutex);
> -
> -	if (queue_is_mq(q))
> -		blk_mq_debugfs_unregister(q);
> -
>   	bioset_exit(&q->bio_split);
>   
>   	if (blk_queue_has_srcu(q))
> @@ -951,5 +943,12 @@ void blk_unregister_queue(struct gendisk *disk)
>   
>   	mutex_unlock(&q->sysfs_dir_lock);
>   
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_trace_shutdown(q);
> +	debugfs_remove_recursive(q->debugfs_dir);
> +	if (queue_is_mq(q))
> +		blk_mq_debugfs_unregister(q);
> +	mutex_unlock(&q->debugfs_mutex);
> +
Odd.
Calling debugfs_remove_recursive(q->debugfs_dir) for all queue types, 
but setting q->debugfs_dir to NULL only for mq?
Care to explain?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
