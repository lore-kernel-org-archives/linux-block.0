Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912EC4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 00:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44921721
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 00:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gJ41/ASI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfI3Amg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Sep 2019 20:42:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35258 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfI3Amg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Sep 2019 20:42:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id y10so3211877plp.2
        for <linux-block@vger.kernel.org>; Sun, 29 Sep 2019 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SvpMojpfVMdnnZs7JomcWyQFcaJjMBD8PpLPdZWSZZU=;
        b=gJ41/ASIINSj2Qqmtwh7Y0p32hlySZygaiNsuXmsBgKbObtpqa3fhER5uGpGTZhPM1
         DJofWxhriFDnR/FFRuOkfYUiurNLVzcj9FhMPzjDWg/3WZJe65WJOiQbPJ1Qefk18fPl
         +u5tNNwf/bk6UK6n2kdZrurvPW5WGgPfvvts7at/ZCmA4zXI0OhuhrudCqoYI8h+ZqRG
         USquNClAcyuZfEw90kHq2hHbmds6uL7HooVcrr/2bEvxFUUia4OMJUopHUa4scZcSzAC
         QNsWQ6yQ3eTzkt+qBHszJvbQyff99hPEWObFixZakFTAbARIizmc7NfyNwj4vqTN5SV4
         NpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvpMojpfVMdnnZs7JomcWyQFcaJjMBD8PpLPdZWSZZU=;
        b=nnwEyBVpn9+jMSL+Does3/emhvUpjYi5C8RwRa0HzWi+C3tpsDwE7KnKHBZLmWZYlU
         DcCTJfgsE9Y+y6kgAFeleDKQuwqu7eNueDPFGbrRB51eWYgJyg6/EC1GlMiCT0UhigFk
         mLwkjQomxXEHnaHNI3lH+wTOPaW/jGU6ixPEhqhecZKX221fWHPyvGN0ePNzU170AFgt
         /xFyp0p16P9BT/lfK9iiWsqZGfFEhfTzHEzq1kmvPD8YRb7XsvslKi9VlCGjRjjaU5Qt
         nhsvSlxOJ1Wb8B9Lsive/MRcKrRcqX9c6EDRKgYKPdaOyhr04qfNsvZbJiW0uYWxT7Eh
         uAgQ==
X-Gm-Message-State: APjAAAVayVuUAtwV3oaUxED1smof0/NUvS4/8tLfZiycgIqwZzow+9NJ
        BFSSp7Ti4LCqCsxqV+RkUD7X9H5ic1fdOg==
X-Google-Smtp-Source: APXvYqwDrfWk+i1gLWSMhzlyOoo6UpLReNIpan7c+eRtpylVgKCfiraxf90Nt9jjlzi9EEzNn1v4SA==
X-Received: by 2002:a17:902:7d92:: with SMTP id a18mr17345347plm.243.1569804152893;
        Sun, 29 Sep 2019 17:42:32 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 8sm11979603pgd.87.2019.09.29.17.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 17:42:31 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: run dependent links inline if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d1413db4-7ba5-2d4a-7f46-8734da452222@kernel.dk>
 <6D11D22A-52CC-4089-962A-CECA4F49C418@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d26d5585-0f31-c6c1-b139-ab0a8a1bfd4e@kernel.dk>
Date:   Sun, 29 Sep 2019 18:42:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6D11D22A-52CC-4089-962A-CECA4F49C418@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 2:37 AM, Jackie Liu wrote:
> 
> 
>> 在 2019年9月29日，22:54，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> Currently any dependent link is executed from a new workqueue context,
>> which means that we'll be doing a context switch per link in the chain.
>> If we are running the completion of the current request from our async
>> workqueue and find that the next request is a link, then run it directly
>> from the workqueue context instead of forcing another switch.
>>
>> This improves the performance of linked SQEs, and reduces the CPU
>> overhead.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> v2:
>> - Improve naming
>> - Improve async detection
>> - Harden cases where we could miss req return
>> - Add support for fsync/sync_file_range/recvmsg/sendmsg
>>
>> 2-3x speedup doing read-write links, where the read often ends up
>> blocking. Tested with examples/link-cp.c
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index aa8ac557493c..742d95563a54 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -667,7 +667,7 @@ static void __io_free_req(struct io_kiocb *req)
>> 	kmem_cache_free(req_cachep, req);
>> }
>>
>> -static void io_req_link_next(struct io_kiocb *req)
>> +struct io_kiocb *io_req_link_next(struct io_kiocb *req)
>> {
>> 	struct io_kiocb *nxt;
>>
>> @@ -686,9 +686,19 @@ static void io_req_link_next(struct io_kiocb *req)
>> 		}
>>
>> 		nxt->flags |= REQ_F_LINK_DONE;
>> +		/*
>> +		 * If we're in async work, we can continue processing this,
>> +		 * we can continue processing the chain in this context instead
>> +		 * of having to queue up new async work.
>> +		 */
>> +		if (current_work())
>> +			return nxt;
>> 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
>> 		io_queue_async_work(req->ctx, nxt);
>> +		nxt = NULL;
>> 	}
>> +
>> +	return nxt;
>> }
>>
>> /*
>> @@ -707,8 +717,10 @@ static void io_fail_links(struct io_kiocb *req)
>> 	}
>> }
>>
>> -static void io_free_req(struct io_kiocb *req)
>> +static struct io_kiocb *io_free_req(struct io_kiocb *req)
>> {
>> +	struct io_kiocb *nxt = NULL;
>> +
>> 	/*
>> 	 * If LINK is set, we have dependent requests in this chain. If we
>> 	 * didn't fail this request, queue the first one up, moving any other
>> @@ -719,16 +731,30 @@ static void io_free_req(struct io_kiocb *req)
>> 		if (req->flags & REQ_F_FAIL_LINK)
>> 			io_fail_links(req);
>> 		else
>> -			io_req_link_next(req);
>> +			nxt = io_req_link_next(req);
>> 	}
>>
>> 	__io_free_req(req);
>> +	return nxt;
>> }
>>
>> -static void io_put_req(struct io_kiocb *req)
>> +static struct io_kiocb *__io_put_req(struct io_kiocb *req)
>> {
>> 	if (refcount_dec_and_test(&req->refs))
>> -		io_free_req(req);
>> +		return io_free_req(req);
>> +
>> +	return NULL;
>> +}
>> +
>> +static void io_put_req(struct io_kiocb *req)
>> +{
>> +	struct io_kiocb *nxt;
>> +
>> +	nxt = __io_put_req(req);
>> +	if (nxt) {
>> +		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
>> +		io_queue_async_work(nxt->ctx, nxt);
>> +	}
>> }
>>
>> static unsigned io_cqring_events(struct io_rings *rings)
>> @@ -934,7 +960,7 @@ static void kiocb_end_write(struct kiocb *kiocb)
>> 	}
>> }
>>
>> -static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>> +static void io_complete_rw_common(struct kiocb *kiocb, long res)
>> {
>> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>>
>> @@ -943,9 +969,24 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>> 	if ((req->flags & REQ_F_LINK) && res != req->result)
>> 		req->flags |= REQ_F_FAIL_LINK;
>> 	io_cqring_add_event(req->ctx, req->user_data, res);
>> +}
>> +
>> +static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>> +{
>> +	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>> +
>> +	io_complete_rw_common(kiocb, res);
>> 	io_put_req(req);
>> }
>>
>> +static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
>> +{
>> +	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>> +
>> +	io_complete_rw_common(kiocb, res);
>> +	return __io_put_req(req);
>> +}
>> +
>> static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
>> {
>> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>> @@ -1128,6 +1169,15 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
>> 	}
>> }
>>
>> +static void call_io_rw_done(struct kiocb *kiocb, ssize_t ret,
>> +			    struct io_kiocb **nxt, bool in_async)
>> +{
>> +	if (in_async && ret >= 0 && nxt && kiocb->ki_complete == io_complete_rw)
>> +		*nxt = __io_complete_rw(kiocb, ret);
>> +	else
>> +		io_rw_done(kiocb, ret);
>> +}
>> +
>> static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
>> 			   const struct io_uring_sqe *sqe,
>> 			   struct iov_iter *iter)
>> @@ -1344,7 +1394,7 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
>> }
>>
>> static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
>> -		   bool force_nonblock)
>> +		   bool force_nonblock, struct io_kiocb **nxt)
>> {
>> 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
>> 	struct kiocb *kiocb = &req->rw;
>> @@ -1391,7 +1441,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
>> 			ret2 = -EAGAIN;
>> 		/* Catch -EAGAIN return for forced non-blocking submission */
>> 		if (!force_nonblock || ret2 != -EAGAIN) {
>> -			io_rw_done(kiocb, ret2);
>> +			call_io_rw_done(kiocb, ret2, nxt, s->needs_lock);
>> 		} else {
>> 			/*
>> 			 * If ->needs_lock is true, we're already in async
>> @@ -1407,7 +1457,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
>> }
>>
>> static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
>> -		    bool force_nonblock)
>> +		    bool force_nonblock, struct io_kiocb **nxt)
>> {
>> 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
>> 	struct kiocb *kiocb = &req->rw;
>> @@ -1465,7 +1515,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
>> 		else
>> 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
>> 		if (!force_nonblock || ret2 != -EAGAIN) {
>> -			io_rw_done(kiocb, ret2);
>> +			call_io_rw_done(kiocb, ret2, nxt, s->needs_lock);
>> 		} else {
>> 			/*
>> 			 * If ->needs_lock is true, we're already in async
>> @@ -1968,7 +2018,8 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
>> }
>>
>> static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>> -			   const struct sqe_submit *s, bool force_nonblock)
>> +			   const struct sqe_submit *s, bool force_nonblock,
>> +			   struct io_kiocb **nxt)
>> {
>> 	int ret, opcode;
>>
>> @@ -1985,18 +2036,18 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>> 	case IORING_OP_READV:
>> 		if (unlikely(s->sqe->buf_index))
>> 			return -EINVAL;
>> -		ret = io_read(req, s, force_nonblock);
>> +		ret = io_read(req, s, force_nonblock, nxt);
>> 		break;
>> 	case IORING_OP_WRITEV:
>> 		if (unlikely(s->sqe->buf_index))
>> 			return -EINVAL;
>> -		ret = io_write(req, s, force_nonblock);
>> +		ret = io_write(req, s, force_nonblock, nxt);
>> 		break;
>> 	case IORING_OP_READ_FIXED:
>> -		ret = io_read(req, s, force_nonblock);
>> +		ret = io_read(req, s, force_nonblock, nxt);
>> 		break;
>> 	case IORING_OP_WRITE_FIXED:
>> -		ret = io_write(req, s, force_nonblock);
>> +		ret = io_write(req, s, force_nonblock, nxt);
>> 		break;
>> 	case IORING_OP_FSYNC:
>> 		ret = io_fsync(req, s->sqe, force_nonblock);
>> @@ -2081,6 +2132,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>> 		struct sqe_submit *s = &req->submit;
>> 		const struct io_uring_sqe *sqe = s->sqe;
>> 		unsigned int flags = req->flags;
>> +		struct io_kiocb *nxt = NULL;
>>
>> 		/* Ensure we clear previously set non-block flag */
>> 		req->rw.ki_flags &= ~IOCB_NOWAIT;
>> @@ -2101,7 +2153,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>> 			s->has_user = cur_mm != NULL;
>> 			s->needs_lock = true;
>> 			do {
>> -				ret = __io_submit_sqe(ctx, req, s, false);
>> +				ret = __io_submit_sqe(ctx, req, s, false, &nxt);
>> 				/*
>> 				 * We can get EAGAIN for polled IO even though
>> 				 * we're forcing a sync submission from here,
>> @@ -2125,6 +2177,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>> 		/* async context always use a copy of the sqe */
>> 		kfree(sqe);
>>
>> +		/* if a dependent link is ready, do that as the next one */
>> +		if (!ret && nxt) {
>> +			req = nxt;
>> +			continue;
>> +		}
>> +
>> 		/* req from defer and link list needn't decrease async cnt */
>> 		if (flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
>> 			goto out;
>> @@ -2271,7 +2329,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>> {
>> 	int ret;
>>
>> -	ret = __io_submit_sqe(ctx, req, s, force_nonblock);
>> +	ret = __io_submit_sqe(ctx, req, s, force_nonblock, NULL);
>> 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
>> 		struct io_uring_sqe *sqe_copy;
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> Hi Jens, are you sure this is version 2, why is it the same as v1?
> Is Link [1] is the correct one?
> 
> Link: [1] http://git.kernel.dk/cgit/linux-block/patch/?id=39b0f9f8e295b98bbcfd448709fa298f5545e28c

Yeah the link is the right one, that's odd. Below for reference!


commit 98bb8de9e72fc61210976db3368dd3ad2549fa3c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Sep 28 11:36:45 2019 -0600

    io_uring: run dependent links inline if possible
    
    Currently any dependent link is executed from a new workqueue context,
    which means that we'll be doing a context switch per link in the chain.
    If we are running the completion of the current request from our async
    workqueue and find that the next request is a link, then run it directly
    from the workqueue context instead of forcing another switch.
    
    This improves the performance of linked SQEs, and reduces the CPU
    overhead.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index aa8ac557493c..83a07a47683d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -667,7 +667,7 @@ static void __io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
-static void io_req_link_next(struct io_kiocb *req)
+static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
 	struct io_kiocb *nxt;
 
@@ -686,8 +686,16 @@ static void io_req_link_next(struct io_kiocb *req)
 		}
 
 		nxt->flags |= REQ_F_LINK_DONE;
-		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
-		io_queue_async_work(req->ctx, nxt);
+		/*
+		 * If we're in async work, we can continue processing the chain
+		 * in this context instead of having to queue up new async work.
+		 */
+		if (nxtptr && current_work()) {
+			*nxtptr = nxt;
+		} else {
+			INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+			io_queue_async_work(req->ctx, nxt);
+		}
 	}
 }
 
@@ -707,7 +715,7 @@ static void io_fail_links(struct io_kiocb *req)
 	}
 }
 
-static void io_free_req(struct io_kiocb *req)
+static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
 {
 	/*
 	 * If LINK is set, we have dependent requests in this chain. If we
@@ -719,16 +727,39 @@ static void io_free_req(struct io_kiocb *req)
 		if (req->flags & REQ_F_FAIL_LINK)
 			io_fail_links(req);
 		else
-			io_req_link_next(req);
+			io_req_link_next(req, nxt);
 	}
 
 	__io_free_req(req);
 }
 
-static void io_put_req(struct io_kiocb *req)
+/*
+ * Drop reference to request, return next in chain (if there is one) if this
+ * was the last reference to this request.
+ */
+static struct io_kiocb *io_put_req_find_next(struct io_kiocb *req)
 {
+	struct io_kiocb *nxt = NULL;
+
 	if (refcount_dec_and_test(&req->refs))
-		io_free_req(req);
+		io_free_req(req, &nxt);
+
+	return nxt;
+}
+
+static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
+{
+	struct io_kiocb *nxt;
+
+	nxt = io_put_req_find_next(req);
+	if (nxt) {
+		if (nxtptr) {
+			*nxtptr = nxt;
+		} else {
+			INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+			io_queue_async_work(nxt->ctx, nxt);
+		}
+	}
 }
 
 static unsigned io_cqring_events(struct io_rings *rings)
@@ -768,7 +799,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
 			} else {
-				io_free_req(req);
+				io_free_req(req, NULL);
 			}
 		}
 	}
@@ -934,7 +965,7 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_common(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
@@ -943,7 +974,22 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, req->user_data, res);
-	io_put_req(req);
+}
+
+static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	io_complete_rw_common(kiocb, res);
+	io_put_req(req, NULL);
+}
+
+static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	io_complete_rw_common(kiocb, res);
+	return io_put_req_find_next(req);
 }
 
 static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
@@ -1128,6 +1174,15 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 	}
 }
 
+static void kiocb_done(struct kiocb *kiocb, ssize_t ret, struct io_kiocb **nxt,
+		       bool in_async)
+{
+	if (in_async && ret >= 0 && nxt && kiocb->ki_complete == io_complete_rw)
+		*nxt = __io_complete_rw(kiocb, ret);
+	else
+		io_rw_done(kiocb, ret);
+}
+
 static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iov_iter *iter)
@@ -1344,7 +1399,7 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 }
 
 static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
-		   bool force_nonblock)
+		   struct io_kiocb **nxt, bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1391,7 +1446,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
+			kiocb_done(kiocb, ret2, nxt, s->needs_lock);
 		} else {
 			/*
 			 * If ->needs_lock is true, we're already in async
@@ -1407,7 +1462,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 }
 
 static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
-		    bool force_nonblock)
+		    struct io_kiocb **nxt, bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *kiocb = &req->rw;
@@ -1465,7 +1520,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
+			kiocb_done(kiocb, ret2, nxt, s->needs_lock);
 		} else {
 			/*
 			 * If ->needs_lock is true, we're already in async
@@ -1493,7 +1548,7 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 		return -EINVAL;
 
 	io_cqring_add_event(ctx, user_data, err);
-	io_put_req(req);
+	io_put_req(req, NULL);
 	return 0;
 }
 
@@ -1513,7 +1568,7 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		    bool force_nonblock)
+		    struct io_kiocb **nxt, bool force_nonblock)
 {
 	loff_t sqe_off = READ_ONCE(sqe->off);
 	loff_t sqe_len = READ_ONCE(sqe->len);
@@ -1540,7 +1595,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req);
+	io_put_req(req, nxt);
 	return 0;
 }
 
@@ -1562,6 +1617,7 @@ static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 static int io_sync_file_range(struct io_kiocb *req,
 			      const struct io_uring_sqe *sqe,
+			      struct io_kiocb **nxt,
 			      bool force_nonblock)
 {
 	loff_t sqe_off;
@@ -1586,13 +1642,13 @@ static int io_sync_file_range(struct io_kiocb *req,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req);
+	io_put_req(req, nxt);
 	return 0;
 }
 
 #if defined(CONFIG_NET)
 static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			   bool force_nonblock,
+			   struct io_kiocb **nxt, bool force_nonblock,
 		   long (*fn)(struct socket *, struct user_msghdr __user *,
 				unsigned int))
 {
@@ -1622,26 +1678,28 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req);
+	io_put_req(req, nxt);
 	return 0;
 }
 #endif
 
 static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      struct io_kiocb **nxt, bool force_nonblock)
 {
 #if defined(CONFIG_NET)
-	return io_send_recvmsg(req, sqe, force_nonblock, __sys_sendmsg_sock);
+	return io_send_recvmsg(req, sqe, nxt, force_nonblock,
+				__sys_sendmsg_sock);
 #else
 	return -EOPNOTSUPP;
 #endif
 }
 
 static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      struct io_kiocb **nxt, bool force_nonblock)
 {
 #if defined(CONFIG_NET)
-	return io_send_recvmsg(req, sqe, force_nonblock, __sys_recvmsg_sock);
+	return io_send_recvmsg(req, sqe, nxt, force_nonblock,
+				__sys_recvmsg_sock);
 #else
 	return -EOPNOTSUPP;
 #endif
@@ -1701,7 +1759,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req);
+	io_put_req(req, NULL);
 	return 0;
 }
 
@@ -1742,7 +1800,7 @@ static void io_poll_complete_work(struct work_struct *work)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
-	io_put_req(req);
+	io_put_req(req, NULL);
 }
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -1767,7 +1825,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 		io_cqring_ev_posted(ctx);
-		io_put_req(req);
+		io_put_req(req, NULL);
 	} else {
 		io_queue_async_work(ctx, req);
 	}
@@ -1859,7 +1917,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (mask) {
 		io_cqring_ev_posted(ctx);
-		io_put_req(req);
+		io_put_req(req, NULL);
 	}
 	return ipt.error;
 }
@@ -1883,7 +1941,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 
 	io_cqring_ev_posted(ctx);
 
-	io_put_req(req);
+	io_put_req(req, NULL);
 	return HRTIMER_NORESTART;
 }
 
@@ -1968,7 +2026,8 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   const struct sqe_submit *s, bool force_nonblock)
+			   const struct sqe_submit *s, struct io_kiocb **nxt,
+			   bool force_nonblock)
 {
 	int ret, opcode;
 
@@ -1985,21 +2044,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_read(req, s, force_nonblock);
+		ret = io_read(req, s, nxt, force_nonblock);
 		break;
 	case IORING_OP_WRITEV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
-		ret = io_write(req, s, force_nonblock);
+		ret = io_write(req, s, nxt, force_nonblock);
 		break;
 	case IORING_OP_READ_FIXED:
-		ret = io_read(req, s, force_nonblock);
+		ret = io_read(req, s, nxt, force_nonblock);
 		break;
 	case IORING_OP_WRITE_FIXED:
-		ret = io_write(req, s, force_nonblock);
+		ret = io_write(req, s, nxt, force_nonblock);
 		break;
 	case IORING_OP_FSYNC:
-		ret = io_fsync(req, s->sqe, force_nonblock);
+		ret = io_fsync(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_POLL_ADD:
 		ret = io_poll_add(req, s->sqe);
@@ -2008,13 +2067,13 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_poll_remove(req, s->sqe);
 		break;
 	case IORING_OP_SYNC_FILE_RANGE:
-		ret = io_sync_file_range(req, s->sqe, force_nonblock);
+		ret = io_sync_file_range(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_SENDMSG:
-		ret = io_sendmsg(req, s->sqe, force_nonblock);
+		ret = io_sendmsg(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_RECVMSG:
-		ret = io_recvmsg(req, s->sqe, force_nonblock);
+		ret = io_recvmsg(req, s->sqe, nxt, force_nonblock);
 		break;
 	case IORING_OP_TIMEOUT:
 		ret = io_timeout(req, s->sqe);
@@ -2081,6 +2140,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		struct sqe_submit *s = &req->submit;
 		const struct io_uring_sqe *sqe = s->sqe;
 		unsigned int flags = req->flags;
+		struct io_kiocb *nxt = NULL;
 
 		/* Ensure we clear previously set non-block flag */
 		req->rw.ki_flags &= ~IOCB_NOWAIT;
@@ -2101,7 +2161,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 			s->has_user = cur_mm != NULL;
 			s->needs_lock = true;
 			do {
-				ret = __io_submit_sqe(ctx, req, s, false);
+				ret = __io_submit_sqe(ctx, req, s, &nxt, false);
 				/*
 				 * We can get EAGAIN for polled IO even though
 				 * we're forcing a sync submission from here,
@@ -2115,16 +2175,22 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		}
 
 		/* drop submission reference */
-		io_put_req(req);
+		io_put_req(req, NULL);
 
 		if (ret) {
 			io_cqring_add_event(ctx, sqe->user_data, ret);
-			io_put_req(req);
+			io_put_req(req, NULL);
 		}
 
 		/* async context always use a copy of the sqe */
 		kfree(sqe);
 
+		/* if a dependent link is ready, do that as the next one */
+		if (!ret && nxt) {
+			req = nxt;
+			continue;
+		}
+
 		/* req from defer and link list needn't decrease async cnt */
 		if (flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
 			goto out;
@@ -2271,7 +2337,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	int ret;
 
-	ret = __io_submit_sqe(ctx, req, s, force_nonblock);
+	ret = __io_submit_sqe(ctx, req, s, NULL, force_nonblock);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
@@ -2298,14 +2364,14 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	}
 
 	/* drop submission reference */
-	io_put_req(req);
+	io_put_req(req, NULL);
 
 	/* and drop final reference, if we failed */
 	if (ret) {
 		io_cqring_add_event(ctx, req->user_data, ret);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req);
+		io_put_req(req, NULL);
 	}
 
 	return ret;
@@ -2319,7 +2385,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_defer(ctx, req, s->sqe);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_free_req(req);
+			io_free_req(req, NULL);
 			io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		}
 		return 0;
@@ -2347,7 +2413,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_defer(ctx, req, s->sqe);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_free_req(req);
+			io_free_req(req, NULL);
 			io_cqring_add_event(ctx, s->sqe->user_data, ret);
 			return 0;
 		}
@@ -2395,7 +2461,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	ret = io_req_set_file(ctx, s, state, req);
 	if (unlikely(ret)) {
 err_req:
-		io_free_req(req);
+		io_free_req(req, NULL);
 err:
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
 		return;

-- 
Jens Axboe

