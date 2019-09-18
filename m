Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04538C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C968621897
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CGTZ7Xqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfIRC1X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:27:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRC1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:27:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so3075331pgi.6
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hfup0cB7SVrlidEnhFvTreXwpckxfjVKxN1o5ZG4/VE=;
        b=CGTZ7XqsIyHKF5sIZ7adVse4al2NRdPEIyn89Q/Y5iQbeVja2gf3oaOlkhjkNLkHHu
         tp77WNyikT9GvuhHygx6eFLsWhKTa/s+0iXkKfRsr1Y8hlsoaNGWpJkyWvdA2w+YzcKo
         CRh2+IxRzeFTk82GrfRrwvbKUI13K6bW3c+orPk+VMfNvObnAuBcJzrjPirktO5VMCvh
         upcr6HmuFYvYbdB93qjNtkILErz9Q8vhoXRvCXbjA2O1NNPkdCbXt8LstiXTpnfOedvr
         saPUw8KRdFhZBAw1M9R+nWBVB3BzMUJgi7tEYYVY+8SxSSUulxLAo1OZ7h9Hk+Ji4HsH
         xqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hfup0cB7SVrlidEnhFvTreXwpckxfjVKxN1o5ZG4/VE=;
        b=UaiATuUJCkwa6m/r4mkjoQlyXN5/BUj9Gu81tUJ+VxOpdOj2ocwkKEXZa2WjwFOAVG
         Q0XrUOVXP3LYoY+7vDfhpiESD0LJuSDqVPFy7O29QUsbPHdqoNUGkXdDrMdXQfVFsLwr
         IWM047qKX1lytJLNRa71C/wfmIFUWP1PAhxEv7QYiubIwm51BdyQ8vChTtDd8NBOZElY
         L7fpdYnlQb069tu93t+OsX4YXZSbXcEJHP875fIx0xzezwIqS/gLmP2aFk3mMyOR82AI
         QJRGuFRTMWe8EmKQ0zA6RxxONj7OU02u+rAbFjWTdq13szWKqysLGGF1DrKBIRnA+RRF
         SyEA==
X-Gm-Message-State: APjAAAXheRPqjSi6c9beoPRyIsNv6Uceo5A787ifrruAEWg53ROiP2oe
        CHm1IqQ7y0pgQVaOhcxDB6nr0OdcD2jk9Q==
X-Google-Smtp-Source: APXvYqyiWrS/YyPAstgUQG1kgMBSyOQVg5Z9hGGKxw6h/L6Fr0sf8MecEBtlfjJisa+OIe9HdhClvw==
X-Received: by 2002:a65:5546:: with SMTP id t6mr1748124pgr.441.1568773640247;
        Tue, 17 Sep 2019 19:27:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k5sm4033604pfi.142.2019.09.17.19.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 19:27:19 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: IORING_OP_TIMEOUT support
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <afda2462-d192-7f95-6a26-b2e604d57463@kernel.dk>
 <2B8F505A-4501-422C-A93D-7FBA559AE43B@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e581a49c-dca2-b89b-a463-a005fec27322@kernel.dk>
Date:   Tue, 17 Sep 2019 20:27:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2B8F505A-4501-422C-A93D-7FBA559AE43B@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 8:10 PM, Jackie Liu wrote:
> 
> 在 2019年9月18日，03:38，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> There's been a few requests for functionality similar to io_getevents()
>> and epoll_wait(), where the user can specify a timeout for waiting on
>> events. I deliberately did not add support for this through the system
>> call initially to avoid overloading the args, but I can see that the use
>> cases for this are valid.
>>
>> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
>> when waiting for events, simply submit one of these timeout commands
>> with your wait call (or before). This ensures that the application
>> sleeping on the CQ ring waiting for events will get woken. The timeout
>> command is passed in as a pointer to a struct timespec. Timeouts are
>> relative.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> V2
>>
>> - Ensure any timeout will result in a return to userspace from
>>   io_cqring_wait().
>> - Improve commit message
>> - Add ->file to struct io_timeout
>> - Kill separate 'kt' value, use timespec_to_kt() directly
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 0dadbdbead0f..02db09b89e83 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -216,6 +216,7 @@ struct io_ring_ctx {
>> 		struct wait_queue_head	cq_wait;
>> 		struct fasync_struct	*cq_fasync;
>> 		struct eventfd_ctx	*cq_ev_fd;
>> +		atomic_t		cq_timeouts;
>> 	} ____cacheline_aligned_in_smp;
>>
>> 	struct io_rings	*rings;
>> @@ -283,6 +284,11 @@ struct io_poll_iocb {
>> 	struct wait_queue_entry		wait;
>> };
>>
>> +struct io_timeout {
>> +	struct file			*file;
>> +	struct hrtimer			timer;
>> +};
>> +
>> /*
>>   * NOTE! Each of the iocb union members has the file pointer
>>   * as the first entry in their struct definition. So you can
>> @@ -294,6 +300,7 @@ struct io_kiocb {
>> 		struct file		*file;
>> 		struct kiocb		rw;
>> 		struct io_poll_iocb	poll;
>> +		struct io_timeout	timeout;
>> 	};
>>
>> 	struct sqe_submit	submit;
>> @@ -1765,6 +1772,35 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> 	return ipt.error;
>> }
>>
>> +static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
>> +{
>> +	struct io_kiocb *req;
>> +
>> +	req = container_of(timer, struct io_kiocb, timeout.timer);
>> +	atomic_inc(&req->ctx->cq_timeouts);
>> +	io_cqring_add_event(req->ctx, req->user_data, 0);
>> +	io_put_req(req);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +{
>> +	struct timespec ts;
>> +
>> +	if (sqe->flags || sqe->ioprio || sqe->off || sqe->buf_index)
>> +		return -EINVAL;
>> +	if (sqe->len != 1)
>> +		return -EINVAL;
> 
> Should we need this?
> 
> if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
> 	return -EINVAL;
> 
> Otherwise it will be queue by io_iopoll_req_issued.

Good point. I did actually think of the polled case, but yeah we don't
want it to get added to the poll list. Since polled never waits, I
think we're fine disallowing it on polled rings.

I'll make that change, thanks.

-- 
Jens Axboe

