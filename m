Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA5EC4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310E20673
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfJNL0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:26:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfJNL0m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 07:26:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 374E53B3CE22D9684EBC;
        Mon, 14 Oct 2019 19:26:37 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 19:26:27 +0800
Subject: Re: [PATCH] io_uring: consider the overflow of sequence for timeout
 req
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20191014080824.43260-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <b1ddc9e7-59ae-6cec-bdb2-20171935dd4d@huawei.com>
Date:   Mon, 14 Oct 2019 19:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191014080824.43260-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/10/14 16:08, yangerkun wrote:
> The sequence for timeout req may overflow, and it will lead to wrong
> order of timeout req list. And we should consider two situation:
> 
> 1. ctx->cached_sq_head + count - 1 may overflow;
> 2. cached_sq_head of now may overflow compare with before
> cached_sq_head.
> 
> Fix the wrong logic by add record of count and use type long long to
> record the overflow.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/io_uring.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 76fdbe84aff5..9cc96f68b370 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -288,6 +288,7 @@ struct io_poll_iocb {
>   struct io_timeout {
>   	struct file			*file;
>   	struct hrtimer			timer;
> +	unsigned			count;
>   };
>   
>   /*
> @@ -1884,7 +1885,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>   
>   static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>   {
> -	unsigned count, req_dist, tail_index;
> +	unsigned count;
>   	struct io_ring_ctx *ctx = req->ctx;
>   	struct list_head *entry;
>   	struct timespec64 ts;
> @@ -1907,21 +1908,39 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>   		count = 1;
>   
>   	req->sequence = ctx->cached_sq_head + count - 1;
> +	req->timeout.count = count;
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
> +		/* count bigger than before should break directly. */
> +		if (count >= nxt->timeout.count)
> +			break;
> +
> +		/*
> +		 * Since cached_sq_head + count - 1 can overflow, use type long
> +		 * long to store it.
> +		 */
> +		tmp = (long long)ctx->cached_sq_head + count - 1;
> +		nxt_sq_head = nxt->sequence - nxt->timeout.count + 1;
> +		tmp_nxt = (long long)nxt_sq_head + nxt->timeout.count - 1;
> +
> +		/*
> +		 * cached_sq_head may overflow, and it will never overflow twice
> +		 * once there is some timeout req still be valid.
> +		 */
> +		if (ctx->cached_sq_head < nxt_sq_head)
> +			tmp_nxt += UINT_MAX;

Should be "tmp += UINT_MAX;"
So sorry for this, will resend the patch.


> +
> +		if (tmp >= tmp_nxt)
>   			break;
>   	}
>   	list_add(&req->list, entry);
> 

