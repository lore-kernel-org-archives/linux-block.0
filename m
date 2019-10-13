Return-Path: <SRS0=CX+6=YG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E5C4360C
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1578520659
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tn6Eatfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfJMVp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:45:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41873 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfJMVp7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 17:45:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so9217453pfh.8
        for <linux-block@vger.kernel.org>; Sun, 13 Oct 2019 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OE4N+iAWgP3zrDTxiyq3P6aolRKGLK+hoU/hjxMmr9o=;
        b=tn6EatfnZYS1SvQ113ILywdJYZn4Mv9CAhl2o7uqELCWHp3VnJ1MlyCiKzm2POegLZ
         5r1fzbm3Kn51TlMSpuNC2+2b7bg08x6fCFXBR0vR/OC1cYeoKE1EBVQLt6kmLhrlS2bw
         22sD5+mCtHo+xb0wChgCRUTxMtAaVL/Kqi8r6VHnWvtFUpTEpuHjMqhyE9HBpiMaWopm
         S1PX5FfeJl71FtXfmiJZTnB6it9D/P7SSG7thyZez2xblNRedLJnmKuMVI+3JEilMXSN
         1SEMdNnLa9VuVMKca82shXgknwqSJbJJ0E+8PCb+s0eQ3D2DRev8SQAVWF8Fk8l+k75h
         pyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OE4N+iAWgP3zrDTxiyq3P6aolRKGLK+hoU/hjxMmr9o=;
        b=J275ZARXP3Z0gUL/WZKf+t1x+3FzKv0ZjH1kdL8c+jFKzP8d7JC1LQjw0KBrhTdtFt
         0DM/ZZx8j+tFIzR9xHQI2MYC/t1OpNmpfJ46JbhNqbAugYDL4+Rpph14z7vq+YQb0gqv
         HR0kZVr018Wi9JJcGClwSRdptqcevX3XQri9+BZD289+wTynj8Sy7DlWDfMG89cHEx3q
         CjSkrf1cVoE0TutFQj/nMLIm7FRbrKF9psjsXwgtXcKVGtnlV+jfgoua9FxKynqlx0xD
         XCGqPypr7HI88Bkt7l3I0nlQIFe9qCOGBJHp2qsc786tYNIP58KmRDa6ejzV5LKAoFLk
         cMxA==
X-Gm-Message-State: APjAAAVuL8GGr/ZmSFAKgCCea2MXfLRkKLlicBnHiMl8kS0XrbrLFAaK
        f3A+jUZTJu6TXUIrixS4DaX03QJ1QBZsDg==
X-Google-Smtp-Source: APXvYqwBWkVgAXi0v9bHIO8+fQO2NZbiW9apYai7cyDrQEbJAnPrBsBumZ0vzPJ7BmfUGHHof1A0FA==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr9048908pge.303.1571003157495;
        Sun, 13 Oct 2019 14:45:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c8sm19277229pfi.117.2019.10.13.14.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 14:45:56 -0700 (PDT)
Subject: Re: [RFC v2] io_uring: add set of tracing events
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, linux-block@vger.kernel.org
References: <20191013154245.23538-1-9erthalion6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d4f1a2d-ac8a-7884-2aaf-0b611114e159@kernel.dk>
Date:   Sun, 13 Oct 2019 15:45:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013154245.23538-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/19 9:42 AM, Dmitrii Dolgov wrote:
> To trace io_uring activity one can get an information from workqueue and
> io trace events, but looks like some parts could be hard to identify via
> this approach. Making what happens inside io_uring more transparent is
> important to be able to reason about many aspects of it, hence introduce
> the set of tracing events.
> 
> All such events could be roughly divided into two categories:
> 
> * those, that are helping to understand correctness (from both kernel
>    and an application point of view). E.g. a ring creation, file
>    registration, or waiting for available CQE. Proposed approach is to
>    get a pointer to an original structure of interest (ring context, or
>    request), and then find relevant events. io_uring_queue_async_work
>    also exposes a pointer to work_struct, to be able to track down
>    corresponding workqueue events.
> 
> * those, that provide performance related information. Mostly it's about
>    events that change the flow of requests, e.g. whether an async work
>    was queued, or delayed due to some dependencies. Another important
>    case is how io_uring optimizations (e.g. registered files) are
>    utilized.

I like this in general, a few questions below.

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bfbb7ab3c4e..730f7182b2a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -71,6 +71,9 @@
>   #include <linux/sizes.h>
>   #include <linux/hugetlb.h>
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/io_uring.h>
> +
>   #include <uapi/linux/io_uring.h>
>   
>   #include "internal.h"
> @@ -483,6 +486,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
>   		}
>   	}
>   
> +	trace_io_uring_queue_async_work(ctx, rw, req, &req->work, req->flags);
>   	queue_work(ctx->sqo_wq[rw], &req->work);
>   }
>   
> @@ -707,6 +711,7 @@ static void io_fail_links(struct io_kiocb *req)
>   {
>   	struct io_kiocb *link;
>   
> +	trace_io_uring_fail_links(req);
>   	while (!list_empty(&req->link_list)) {
>   		link = list_first_entry(&req->link_list, struct io_kiocb, list);
>   		list_del(&link->list);

Doesn't look like you have completion events, which makes it hard to
tell which dependants got killed when failing the links. Maybe a good
thing to add?

> @@ -1292,6 +1297,7 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
>   						iovec, iter);
>   #endif
>   
> +	trace_io_uring_import_iovec(ctx, buf);
>   	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
>   }
>   

Not sure I see much merrit in this trace event.

> @@ -2021,6 +2027,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   	req->submit.sqe = sqe_copy;
>   
>   	INIT_WORK(&req->work, io_sq_wq_submit_work);
> +	trace_io_uring_defer(ctx, req, false);
>   	list_add_tail(&req->list, &ctx->defer_list);
>   	spin_unlock_irq(&ctx->completion_lock);
>   	return -EIOCBQUEUED;
> @@ -2327,6 +2334,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
>   	} else {
>   		if (s->needs_fixed_file)
>   			return -EBADF;
> +		trace_io_uring_file_get(ctx, fd);
>   		req->file = io_file_get(state, fd);
>   		if (unlikely(!req->file))
>   			return -EBADF;
> @@ -2357,6 +2365,8 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>   				INIT_WORK(&req->work, io_sq_wq_submit_work);
>   				io_queue_async_work(ctx, req);
>   			}
> +			else
> +				trace_io_uring_add_to_prev(ctx, req);
>   
>   			/*
>   			 * Queued up for async execution, worker will release

Maybe put this one in io_add_to_prev_work()? Probably just using the
'ret' as part of the trace, to avoid a branch for this?

Failing that, the style is off a bit, should be:

	} else {
		trace_io_uring_add_to_prev(ctx, req);
	}

> @@ -4194,6 +4210,9 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>   	mutex_lock(&ctx->uring_lock);
>   	ret = __io_uring_register(ctx, opcode, arg, nr_args);
>   	mutex_unlock(&ctx->uring_lock);
> +	if (ret >= 0)
> +		trace_io_uring_register(ctx, opcode, ctx->nr_user_files,
> +								ctx->nr_user_bufs, ctx->cq_ev_fd != NULL);

Just trace 'ret' as well?

> + * io_uring_add_to_prev - called after a request was added into a previously
> + * 						  submitted work
> + *
> + * @ctx:	pointer to a ring context structure
> + * @req:	pointer to a request, added to a previous
> + *
> + * Allows to track merged work, to figure out how oftern requests are piggy

often

-- 
Jens Axboe

