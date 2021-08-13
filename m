Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00984C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16E960F00
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 09:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhHMJks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:40:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14201 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbhHMJks (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 05:40:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GmJSL2kdMz1CWN4;
        Fri, 13 Aug 2021 17:40:02 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 17:40:19 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 13 Aug 2021 17:40:19 +0800
Subject: Re: [PATCH] block: don't decrement flush request refcount if it's
 state is idle in flush_end_io()
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210808070330.763177-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e251976b-eab8-1c79-0891-25d48b31d4db@huawei.com>
Date:   Fri, 13 Aug 2021 17:40:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210808070330.763177-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, jens

Can you please consider to apply this patch?

Thanks
Kuai

On 2021/08/08 15:03, Yu Kuai wrote:
> flush_end_io() currently decrement request refcount unconditionally.
> However, it's possible that the request is already idle and it's
> refcount is zero since that flush_end_io() can be called concurrently.
> 
> For example, nbd_clear_que() can be called concurrently with normal
> io completion or io timeout.
> 
> Thus check idle before decrement to avoid refcount_t underflow
> warning.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-flush.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 1002f6c58181..9b65dc43702c 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -222,7 +222,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>   	/* release the tag's ownership to the req cloned from */
>   	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>   
> -	if (!refcount_dec_and_test(&flush_rq->ref)) {
> +	if (blk_mq_rq_state(flush_rq) == MQ_RQ_IDLE ||
> +	    !refcount_dec_and_test(&flush_rq->ref)) {
>   		fq->rq_status = error;
>   		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>   		return;
> 
