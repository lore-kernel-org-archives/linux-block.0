Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461EECE59D
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 01:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E4B2067D
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 01:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfJPBfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:35:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731322AbfJPBfj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 21:35:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3FDB82A9BF714588488C;
        Wed, 16 Oct 2019 09:35:37 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 09:35:29 +0800
Subject: Re: [PATCH V3] io_uring: consider the overflow of sequence for
 timeout req
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20191015135929.30912-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <df96c0e3-873f-6a54-9e71-0c57d3b6720d@huawei.com>
Date:   Wed, 16 Oct 2019 09:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191015135929.30912-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/10/15 21:59, yangerkun wrote:
> Now we recalculate the sequence of timeout with 'req->sequence =
> ctx->cached_sq_head + count - 1', judge the right place to insert
> for timeout_list by compare the number of request we still expected for
> completion. But we have not consider about the situation of overflow:
> 
> 1. ctx->cached_sq_head + count - 1 may overflow. And a bigger count for
> the new timeout req can have a small req->sequence.
> 
> 2. cached_sq_head of now may overflow compare with before req. And it
> will lead the timeout req with small req->sequence.
> 
> This overflow will lead to the misorder of timeout_list, which can lead
> to the wrong order of the completion of timeout_list. Fix it by reuse
> req->submit.sequence to store the count, and change the logic of
> inserting sort in io_timeout.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/io_uring.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 76fdbe84aff5..c9512da06973 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1884,7 +1884,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>   
>   static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>   {
> -	unsigned count, req_dist, tail_index;
> +	unsigned count;
>   	struct io_ring_ctx *ctx = req->ctx;
>   	struct list_head *entry;
>   	struct timespec64 ts;
> @@ -1907,21 +1907,36 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>   		count = 1;
>   
>   	req->sequence = ctx->cached_sq_head + count - 1;
> +	/* reuse it to store the count */
> +	req->submit.sequence = count;
>   	req->flags |= REQ_F_TIMEOUT;
>   
>   	/*
>   	 * Insertion sort, ensuring the first entry in the list is always
>   	 * the one we need first.
>   	 */
> -	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
> -	req_dist = req->sequence - tail_index;
>   	spin_lock_irq(&ctx->completion_lock);
>   	list_for_each_prev(entry, &ctx->timeout_list) {
>   		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
> -		unsigned dist;
> +		unsigned nxt_sq_head;
> +		long long tmp, tmp_nxt;
>   
> -		dist = nxt->sequence - tail_index;
> -		if (req_dist >= dist)
> +		/*
> +		 * Since cached_sq_head + count - 1 can overflow, use type long
> +		 * long to store it.
> +		 */
> +		tmp = (long long)ctx->cached_sq_head + count - 1;
> +		nxt_sq_head = nxt->sequence - nxt->submit.sequence + 1;
> +		tmp_nxt = (long long)nxt_sq_head + nxt->submit.sequence - 1;
> +
> +		/*
> +		 * cached_sq_head may overflow, and it will never overflow twice
> +		 * once there is some timeout req still be valid.
> +		 */
> +		if (ctx->cached_sq_head < nxt_sq_head)
> +			tmp_nxt += UINT_MAX;

Maybe there is a mistake, it should be tmp. So sorry about this.

> +
> +		if (tmp >= tmp_nxt)
>   			break;
>   	}
>   	list_add(&req->list, entry);
> 

