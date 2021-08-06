Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB83C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064CC61185
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhHFBrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:47:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13285 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhHFBrs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 21:47:48 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GgpBk5Jlqz82sP;
        Fri,  6 Aug 2021 09:42:38 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:47:31 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:47:31 +0800
Subject: Re: [PATCH] blk-mq: clear active_queues before clearing
 BLK_MQ_F_TAG_QUEUE_SHARED
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210731062130.1533893-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <96727791-f4f9-4ad7-a922-82e49ab9d939@huawei.com>
Date:   Fri, 6 Aug 2021 09:47:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210731062130.1533893-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/07/31 14:21, Yu Kuai wrote:
> We run a test that delete and recover devcies frequently(two devices on
> the same host), and we found that 'active_queues' is super big after a
> period of time.
> 
> If device a and device b share a tag set, and a is deleted, then
> blk_mq_exit_queue() will clear BLK_MQ_F_TAG_QUEUE_SHARED because there
> is only one queue that are using the tag set. However, if b is still
> active, the active_queues of b might never be cleared even if b is
> deleted.
> 
> Thus clear active_queues before BLK_MQ_F_TAG_QUEUE_SHARED is cleared.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c4ac51e54eb..2fe396385a4a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2994,10 +2994,12 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>   	int i;
>   
>   	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (shared)
> +		if (shared) {
>   			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> -		else
> +		} else {
> +			blk_mq_tag_idle(hctx);
>   			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> +		}
>   	}
>   }
>   
> 

ping...
