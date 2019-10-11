Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2173C4360C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975BA214E0
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfJKCYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:24:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727813AbfJKCYv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 22:24:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6EB6227C270FC752ADD8;
        Fri, 11 Oct 2019 10:24:50 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 10:24:48 +0800
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     Jackie Liu <liuyun01@kylinos.cn>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
Date:   Fri, 11 Oct 2019 10:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191009011959.2203-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/10/9 9:19, Jackie Liu wrote:
> __io_get_deferred_req is used to get all defer lists, including defer_list
> and timeout_list, but io_sequence_defer should be only cares about the sequence.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   fs/io_uring.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 8a0381f1a43b..8ec2443eb019 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>   static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>   				     struct io_kiocb *req)
>   {
> -	/* timeout requests always honor sequence */
> -	if (!(req->flags & REQ_F_TIMEOUT) &&
> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>   		return false;
>   
>   	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>   		return NULL;
>   
>   	req = list_first_entry(list, struct io_kiocb, list);
> -	if (!io_sequence_defer(ctx, req)) {
> -		list_del_init(&req->list);
> -		return req;
> -	}
> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
> +		return NULL;
Hi,

For timeout req, we should also compare the sequence to determine to 
return NULL or the req. But now we will return req directly. Actually, 
no need to compare req->flags with REQ_F_TIMEOUT.

Another problem, before this change, a timeout req can also drain the 
sqe(io_queue_sqe->io_req_defer and add to refer list), i am not sure is 
it a right or wrong logic, but your patch fix that.

Thanks,
Kun.
>   
> -	return NULL;
> +	list_del_init(&req->list);
> +	return req;
>   }
>   
>   static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
> 

