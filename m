Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F7C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D0B21E92
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 10:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhADKnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:43:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2285 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbhADKnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 05:43:18 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8XFM5Fs9z67Xns;
        Mon,  4 Jan 2021 18:39:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 11:42:36 +0100
Received: from [10.47.2.42] (10.47.2.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 10:42:35 +0000
Subject: Re: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in
 hctx_may_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <20201227113458.3289082-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f8def27f-6709-143f-9864-8bc76e4ee052@huawei.com>
Date:   Mon, 4 Jan 2021 10:41:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201227113458.3289082-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.42]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/12/2020 11:34, Ming Lei wrote:
> In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
> q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.
> 
> So fix it.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-mq.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index c1458d9502f1..3616453ca28c 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -304,7 +304,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>   		struct request_queue *q = hctx->queue;
>   		struct blk_mq_tag_set *set = q->tag_set;
>   
> -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &q->queue_flags))
> +		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))

I wonder how this ever worked properly, as BLK_MQ_S_TAG_ACTIVE is bit 
index 1, and for q->queue_flags that means QUEUE_FLAG_DYING bit, which I 
figure is not set normally..

>   			return true;
>   		users = atomic_read(&set->active_queues_shared_sbitmap);
>   	} else {
> 

