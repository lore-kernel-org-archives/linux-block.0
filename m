Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C0C433ED
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 09:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A959D61184
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 09:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbhERJrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 05:47:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3016 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbhERJrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 05:47:06 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkrfW2chnzlfkL;
        Tue, 18 May 2021 17:43:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:45:46 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 10:45:43 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
Date:   Tue, 18 May 2021 10:44:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210514022052.1047665-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/05/2021 03:20, Ming Lei wrote:
> In case of shared sbitmap, request won't be held in plug list any more
> sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
> tagset"), this way makes request merge from flush plug list & batching
> submission not possible, so cause performance regression.
> 
> Yanhui reports performance regression when running sequential IO
> test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
> is emulated with image stored on xfs/megaraid_sas.
> 
> Fix the issue by recovering original behavior to allow to hold request
> in plug list.

Hi Ming,

Since testing v5.13-rc2, I noticed that this patch made the hang I was 
seeing disappear:
https://lore.kernel.org/linux-scsi/3d72d64d-314f-9d34-e039-7e508b2abe1b@huawei.com/

I don't think that problem is solved, though.

So I wonder about throughput performance (I had hoped to test before it 
was merged). I only have 6x SAS SSDs at hand, but I see some significant 
changes (good and bad) for mq-deadline for hisi_sas:
Before 620K (read), 300K IOPs (randread)
After 430K (read), 460-490K IOPs (randread)

none IO sched is always about 450K (read) and 500K (randread)

Do you guys have any figures? Are my results as expected?

Thanks,
John

> 
> Cc: Yanhui Ma <yama@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: kashyap.desai@broadcom.com
> Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae7f5ee41cd3..baf7a9546068 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2236,8 +2236,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>   		/* Bypass scheduler for flush requests */
>   		blk_insert_flush(rq);
>   		blk_mq_run_hw_queue(data.hctx, true);
> -	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs ||
> -				!blk_queue_nonrot(q))) {
> +	} else if (plug && (q->nr_hw_queues == 1 ||
> +		   blk_mq_is_sbitmap_shared(rq->mq_hctx->flags) ||
> +		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
>   		/*
>   		 * Use plugging if we have a ->commit_rqs() hook as well, as
>   		 * we know the driver uses bd->last in a smart fashion.
> 

