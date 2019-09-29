Return-Path: <SRS0=NP29=XY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1207C4360C
	for <linux-block@archiver.kernel.org>; Sun, 29 Sep 2019 01:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958B214D8
	for <linux-block@archiver.kernel.org>; Sun, 29 Sep 2019 01:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfI2BrO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:47:14 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:41841 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2BrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Sep 2019 21:47:14 -0400
X-QQ-mid: bizesmtp24t1569721628t6vggnr9
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Sun, 29 Sep 2019 09:47:07 +0800 (CST)
X-QQ-SSF: 00400000002000S0YT90B00A0000000
X-QQ-FEAT: lRUSrEWtKQBH01dRnJzc+lBBd3eK50OfVuDuFLZKu3cWIP9mxIG9ZDpmt0b5f
        sPaM250dYNW7e+2hST+mxwonJPhChT3D6w6DK3GqYWBSTvokQmILoMTril+Xl09NCw6s9X2
        +yzmDGynG01z4A8sv8oDXrheC41JTLPPDH12vzm7b4ldxUWPeL8cSvhH2mSkOYeTfbRjm25
        UPn3aT7MovQoOBz+CfTk0Ehfy+BXXK0q0U8wPzUGrHP2g6c+c479eKrL+ZK2FjL6PWI3Vh7
        q2btfLKhLd3d3mBtAesVVYKOxuHKAOX1bNUn4Y/USY2QYj4z94VcDBrCWD+MiCljM39AXUe
        +pJf+Dv1CsbrRu149k=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] io_uring: run dependent links inline if possible
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <e736649e-8360-ad69-8151-3cf3cf78b50f@kernel.dk>
Date:   Sun, 29 Sep 2019 09:47:07 +0800
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <793C733D-D492-43BF-A32A-39C1C5CB76A6@kylinos.cn>
References: <e736649e-8360-ad69-8151-3cf3cf78b50f@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 在 2019年9月29日，07:23，Jens Axboe <axboe@kernel.dk> 写道：
> 
> Currently any dependent link is executed from a new workqueue context,
> which means that we'll be doing a context switch per link in the chain.
> If we are running the completion of the current request from our async
> workqueue and find that the next request is a link, then run it directly
> from the workqueue context instead of forcing another switch.
> 
> This improves the performance of linked SQEs, and reduces the CPU
> overhead.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> 2-3x speedup doing read-write links, where the read often ends up
> blocking. Tested with examples/link-cp.c
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index aa8ac557493c..742d95563a54 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -667,7 +667,7 @@ static void __io_free_req(struct io_kiocb *req)
> 	kmem_cache_free(req_cachep, req);
> }
> 
> -static void io_req_link_next(struct io_kiocb *req)
> +struct io_kiocb *io_req_link_next(struct io_kiocb *req)
> {
> 	struct io_kiocb *nxt;
> 
> @@ -686,9 +686,19 @@ static void io_req_link_next(struct io_kiocb *req)
> 		}
> 
> 		nxt->flags |= REQ_F_LINK_DONE;
> +		/*
> +		 * If we're in async work, we can continue processing this,
> +		 * we can continue processing the chain in this context instead
> +		 * of having to queue up new async work.
> +		 */
> +		if (current_work())
> +			return nxt;
> 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
> 		io_queue_async_work(req->ctx, nxt);
> +		nxt = NULL;
> 	}
> +
> +	return nxt;
> }
> 
> /*
> @@ -707,8 +717,10 @@ static void io_fail_links(struct io_kiocb *req)
> 	}
> }
> 
> -static void io_free_req(struct io_kiocb *req)
> +static struct io_kiocb *io_free_req(struct io_kiocb *req)
> {
> +	struct io_kiocb *nxt = NULL;
> +
> 	/*
> 	 * If LINK is set, we have dependent requests in this chain. If we
> 	 * didn't fail this request, queue the first one up, moving any other
> @@ -719,16 +731,30 @@ static void io_free_req(struct io_kiocb *req)
> 		if (req->flags & REQ_F_FAIL_LINK)
> 			io_fail_links(req);
> 		else
> -			io_req_link_next(req);
> +			nxt = io_req_link_next(req);
> 	}
> 
> 	__io_free_req(req);
> +	return nxt;
> }
> 

LGTM, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

The function io_free_req has been used not only for free req, but also for the task
of finding the next link entry. I think it is possible to change a name to avoid
confusion, of course, only personal opinion.

--
BR, Jackie Liu



