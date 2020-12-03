Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACBC63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02AB208A9
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgLCGoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:44:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:48530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbgLCGoO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 01:44:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25361ABCE;
        Thu,  3 Dec 2020 06:43:32 +0000 (UTC)
Subject: Re: [PATCH V2 2/3] nvme-loop: use blk_mq_hctx_set_fq_lock_class to
 set loop's lock class
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20201203012638.543321-1-ming.lei@redhat.com>
 <20201203012638.543321-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cf239d2b-3d40-f3d7-5247-555f45705744@suse.de>
Date:   Thu, 3 Dec 2020 07:43:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203012638.543321-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 2:26 AM, Ming Lei wrote:
> Set nvme-loop's lock class via blk_mq_hctx_set_fq_lock_class for avoiding
> lockdep possible recursive locking, then we can remove the dynamically
> allocated lock class for each flush queue, finally we can avoid horrible
> SCSI probe delay.
> 
> This way may not address situation in which one nvme-loop is backed on
> another nvme-loop. However, in reality, people seldom uses this way
> for test. Even though someone played in this way, it is just one
> recursive locking false positive, no real deadlock issue.
> 
> Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reported-by: Qian Cai <cai@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/target/loop.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index f6d81239be21..07806016c09d 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -211,6 +211,8 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
>   			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
>   }
>   
> +static struct lock_class_key loop_hctx_fq_lock_key;
> +
>   static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   		unsigned int hctx_idx)
>   {
> @@ -219,6 +221,14 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   
>   	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
>   
> +	/*
> +	 * flush_end_io() can be called recursively for us, so use our own
> +	 * lock class key for avoiding lockdep possible recursive locking,
> +	 * then we can remove the dynamically allocated lock class for each
> +	 * flush queue, that way may cause horrible boot delay.
> +	 */
> +	blk_mq_hctx_set_fq_lock_class(hctx, &loop_hctx_fq_lock_key);
> +
>   	hctx->driver_data = queue;
>   	return 0;
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
