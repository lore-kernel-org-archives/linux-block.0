Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0130C4CECD
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB00F214AF
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfIRCK7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:10:59 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:56006 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfIRCK6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:10:58 -0400
X-QQ-mid: bizesmtp18t1568772621tdfa04l9
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 18 Sep 2019 10:10:20 +0800 (CST)
X-QQ-SSF: 00400000002000R0YS90000A0000000
X-QQ-FEAT: RUJ7g7zpdcHzhxwlCdfhn8AQ5+3eiJ9ebdvr6OgNKy8H3qV2dINV9iy7MK000
        9+LCo+Gq6B1+DaFw0qSF5FEdHuYPPZdl21B7ABfk6Brq8laQ+lH6KFWhrLGSRqnCQRSCX4V
        tgcc5a8EFE9QRsXBPWYyJeCtjNNqqrUefUaGrxU+5414BKvlt0NqsuCD8F8fugBtHlrto1v
        fF00o8ln3XHbp2da1lHY8x+I2GWO3tXrpVa2d/GqKAW+dJ7JC52BGLQ4NzWo7jl+K7veS+3
        oegWQ/dNzTBTdvKK7NCFEjGoujDeILhfF4eEgUaAS8PEJTzfwNn6uvTuhBPqJo6kXKoOVDu
        GD4jCX0MTjV7+0clBE=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] io_uring: IORING_OP_TIMEOUT support
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <afda2462-d192-7f95-6a26-b2e604d57463@kernel.dk>
Date:   Wed, 18 Sep 2019 10:10:19 +0800
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2B8F505A-4501-422C-A93D-7FBA559AE43B@kylinos.cn>
References: <afda2462-d192-7f95-6a26-b2e604d57463@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2019年9月18日，03:38，Jens Axboe <axboe@kernel.dk> 写道：
> 
> There's been a few requests for functionality similar to io_getevents()
> and epoll_wait(), where the user can specify a timeout for waiting on
> events. I deliberately did not add support for this through the system
> call initially to avoid overloading the args, but I can see that the use
> cases for this are valid.
> 
> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
> when waiting for events, simply submit one of these timeout commands
> with your wait call (or before). This ensures that the application
> sleeping on the CQ ring waiting for events will get woken. The timeout
> command is passed in as a pointer to a struct timespec. Timeouts are
> relative.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> V2
> 
> - Ensure any timeout will result in a return to userspace from
>  io_cqring_wait().
> - Improve commit message
> - Add ->file to struct io_timeout
> - Kill separate 'kt' value, use timespec_to_kt() directly
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 0dadbdbead0f..02db09b89e83 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -216,6 +216,7 @@ struct io_ring_ctx {
> 		struct wait_queue_head	cq_wait;
> 		struct fasync_struct	*cq_fasync;
> 		struct eventfd_ctx	*cq_ev_fd;
> +		atomic_t		cq_timeouts;
> 	} ____cacheline_aligned_in_smp;
> 
> 	struct io_rings	*rings;
> @@ -283,6 +284,11 @@ struct io_poll_iocb {
> 	struct wait_queue_entry		wait;
> };
> 
> +struct io_timeout {
> +	struct file			*file;
> +	struct hrtimer			timer;
> +};
> +
> /*
>  * NOTE! Each of the iocb union members has the file pointer
>  * as the first entry in their struct definition. So you can
> @@ -294,6 +300,7 @@ struct io_kiocb {
> 		struct file		*file;
> 		struct kiocb		rw;
> 		struct io_poll_iocb	poll;
> +		struct io_timeout	timeout;
> 	};
> 
> 	struct sqe_submit	submit;
> @@ -1765,6 +1772,35 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> 	return ipt.error;
> }
> 
> +static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
> +{
> +	struct io_kiocb *req;
> +
> +	req = container_of(timer, struct io_kiocb, timeout.timer);
> +	atomic_inc(&req->ctx->cq_timeouts);
> +	io_cqring_add_event(req->ctx, req->user_data, 0);
> +	io_put_req(req);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct timespec ts;
> +
> +	if (sqe->flags || sqe->ioprio || sqe->off || sqe->buf_index)
> +		return -EINVAL;
> +	if (sqe->len != 1)
> +		return -EINVAL;

Should we need this?

if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
	return -EINVAL;

Otherwise it will be queue by io_iopoll_req_issued.

> +	if (copy_from_user(&ts, (void __user *) sqe->addr, sizeof(ts)))
> +		return -EFAULT;
> +
> +	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	req->timeout.timer.function = io_timeout_fn;
> +	hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
> +			HRTIMER_MODE_REL);
> +	return 0;
> +}
> +

--
BR, Jackie Liu



