Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD9C64E7B
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C57620709
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgLCGnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:43:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:48430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgLCGnh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 01:43:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 660BFAC55;
        Thu,  3 Dec 2020 06:42:55 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] blk-mq: add new API of
 blk_mq_hctx_set_fq_lock_class
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20201203012638.543321-1-ming.lei@redhat.com>
 <20201203012638.543321-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <997e071a-bc6b-3a8a-6784-66324e9ff09e@suse.de>
Date:   Thu, 3 Dec 2020 07:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203012638.543321-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 2:26 AM, Ming Lei wrote:
> flush_end_io() may be called recursively from some driver, such as
> nvme-loop, so lockdep may complain 'possible recursive locking'.
> Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> request queue flushing") tried to address this issue by assigning
> dynamically allocated per-flush-queue lock class. This solution
> adds synchronize_rcu() for each hctx's release handler, and causes
> horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> 
> Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> we just need to use driver specific lock class for avoiding the
> lockdep warning of 'possible recursive locking'.
> 
> Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reported-by: Qian Cai <cai@redhat.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-flush.c      | 25 +++++++++++++++++++++++++
>   include/linux/blk-mq.h |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 9507dcdd5881..bf51588762d8 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -490,3 +490,28 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
>   	kfree(fq->flush_rq);
>   	kfree(fq);
>   }
> +
> +/*
> + * Allow driver to set its own lock class to fq->mq_flush_lock for
> + * avoiding lockdep complaint.
> + *
> + * flush_end_io() may be called recursively from some driver, such as
> + * nvme-loop, so lockdep may complain 'possible recursive locking' because
> + * all 'struct blk_flush_queue' instance share same mq_flush_lock lock class
> + * key. We need to assign different lock class for these driver's
> + * fq->mq_flush_lock for avoiding the lockdep warning.
> + *
> + * Use dynamically allocated lock class key for each 'blk_flush_queue'
> + * instance is over-kill, and more worse it introduces horrible boot delay
> + * issue because synchronize_rcu() is implied in lockdep_unregister_key which
> + * is called for each hctx release. SCSI probing may synchronously create and
> + * destroy lots of MQ request_queues for non-existent devices, and some robot
> + * test kernel always enable lockdep option. It is observed that more than half
> + * an hour is taken during SCSI MQ probe with per-fq lock class.
> + */
> +void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
> +		struct lock_class_key *key)
> +{
> +	lockdep_set_class(&hctx->fq->mq_flush_lock, key);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_hctx_set_fq_lock_class);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 794b2a33a2c3..5f639240760e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -5,6 +5,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/sbitmap.h>
>   #include <linux/srcu.h>
> +#include <linux/lockdep.h>
>   
>   struct blk_mq_tags;
>   struct blk_flush_queue;
> @@ -594,5 +595,7 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
>   }
>   
>   blk_qc_t blk_mq_submit_bio(struct bio *bio);
> +void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
> +		struct lock_class_key *key);
>   
>   #endif
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
