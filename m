Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B491263F25
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836046; cv=none; b=tqB1xApYGE29G0NI7mQk9m+iPQ9y+/yr9xPoWxca/6wX4q2XLBKx2+sZ3QBYaq4snonrYynsCdu3gqBKciNkyu7DHmDlAeuqE2A6noAz4w+r9RxiBz7UsvAhz2rp4G6f0b2ItR4WLveVRI9uIaQc6hGlkTY0ObiFaFw52YJIdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836046; c=relaxed/simple;
	bh=eYtsiwjeNEZ4vCtG9v/6b6k88XeSLro/NUCX3xaVuSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iue2hVC9PS0+CIG+jzhtXflDNMSzdloOzwgAC4UCsqiQIltMQIRcJH5V5LwcMl76tbtBRsSuCp8IcWkUaMKgYLlApkIOS2SJD4LLfskra4sXAcOb+CNzIeCSgSX8DUPdNt0fSkEMfsKK7VMnjQAu0UWEFpXwDp4sMcxDhlqKkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ig8OJOVS; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ig8OJOVS"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-6f7031ea11cso46773997b3.2
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742836042; x=1743440842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MTEgzo9s24Q59ut9KgXVbo84mVDv9y8Rso8lfUqhP8=;
        b=Ig8OJOVSsxMBHQjo6CdddGRjT0rtaeR6e/KZiUBX/Upd5g9/OZl+cX8tCEk45m6Dkf
         Y1sYZejH+VaXUS1+DrXuh76Q0avA8fX6wVBbk7qGfSNVxTY4C6KbH3n9CfAAhkmmvGJb
         TQhmw2rZ5o94PBrp1YGMwSzSjcjw4AeXRjt5yeBfixkUMNipkhehrr03E0DS/3tqX7HN
         mSRYxJu/87pN0/8aUslJnoZ7DsUGtZzInHlNHTwVWQwTHk9FD8dN6eU0ApefHeHoyxU3
         OvrOq+3f9m4WsHB3gpBrODs/S7GrqMZ3tiwqGnU+/ZQnfLGpTsKln5fOE/qa4res677R
         HfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742836042; x=1743440842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MTEgzo9s24Q59ut9KgXVbo84mVDv9y8Rso8lfUqhP8=;
        b=KOQUtgYnJ9IeqozWFNPQuCYPG7Ae3tDtLnDRzFimJI0l23C/P7GyG9yCYPAe8TkTHO
         pAikSdg93Ln/Wlv2kEmqLUD2EPyDqXNxRh9gfa3Q7q6qO58O9EjOlQcIsQKHSckupQY4
         ZzlOVAQUijOCjANP8dgCeG1afDRD4AVvw2WLNEOr/3RGYeE2ppbBa7WOK57duvVY+pNX
         KCy/BvoKU1HoH2+QBTnicXM2FarLDL8riSFEO/fqYE+phzsi1YkhJwZhIHdnDiIZJgZm
         5+mvUkDhKf6z4e6eccz2AczR37yLBhX87SrO2ClhIDzIeGkaxcxp69xMIbTOdTTVR/4j
         x3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcQ4ftLIemAElPVXpgCgKPfZgkHAPRCemtUSl3ObuNWf6xELbowUoa25kT78GYWHxt1kmGGk4KF8LYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVUtHEMFZTb+c6exMW2Fm/tuNyS1TMM9tf3AewVFe58wxQULq
	UBtM2HuSV+IGH7kr4Vlffx0XTpclywlN4gi41HPXL/36WQ+2WE27/Ki68uVrfVeZHLqxzRsFL5x
	YPoC4QMxa0kvzcAM2k1eo1Mbixc0YwEd5UOQrRIgy6WVlY+/d
X-Gm-Gg: ASbGncsNxpIj52QdqfokZAocv0O68ZBwW4+cq5QeoBHgboXa9rKpXD7k+Cm31LsK4E3
	4UNrSifPqaNUCnJSLXRCOT+5PxfOR80mU7r9Fvh628Lxl03y9EabGfW8uWXk6m/kLD7OFnri+q+
	ug0z3ZorK33ulJgSAAF/1h6CPgLME1MBUTmYenv05ju4GUgXcxJCyLJifKOkzPKTlKdnoZb43JL
	ZT7wj5PjAF99yuGaU8Okzokg7Zq2wMJx8ynz7TRnRnhc2mlzFDEYRzs0/M0hCvB/4XfKuYFAoVa
	cgzlnL2YnOXmdEgSw8zGoDQSQvaGM/N7rS8=
X-Google-Smtp-Source: AGHT+IHyq7QjGXwniSNPQD041x2j4dm37lR5YQd0sIYjdaYaUzTlYTl3OPYJz6DyCpPs0T+h7VGKsX5WosG4
X-Received: by 2002:a05:690c:9a05:b0:6fb:277f:f022 with SMTP id 00721157ae682-700bac63638mr190779207b3.15.1742836042307;
        Mon, 24 Mar 2025 10:07:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba6da137sm2800397b3.3.2025.03.24.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:07:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6C732340332;
	Mon, 24 Mar 2025 11:07:21 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 611DCE4021A; Mon, 24 Mar 2025 11:07:21 -0600 (MDT)
Date: Mon, 24 Mar 2025 11:07:21 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6/8] ublk: implement ->queue_rqs()
Message-ID: <Z+GRSWrSvE+bEq8Q@dev-ushankar.dev.purestorage.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-7-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324134905.766777-7-ming.lei@redhat.com>

On Mon, Mar 24, 2025 at 09:49:01PM +0800, Ming Lei wrote:
> Implement ->queue_rqs() for improving perf in case of MQ.
> 
> In this way, we just need to call io_uring_cmd_complete_in_task() once for
> one batch, then both io_uring and ublk server can get exact batch from
> client side.
> 
> Follows IOPS improvement:
> 
> - tests
> 
> 	tools/testing/selftests/ublk/kublk add -t null -q 2 [-z]
> 
> 	fio/t/io_uring -p0 /dev/ublkb0
> 
> - results:
> 
> 	more than 10% IOPS boost observed

Nice!

> 
> Pass all ublk selftests, especially the io dispatch order test.
> 
> Cc: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 85 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 53a463681a41..86621fde7fde 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -83,6 +83,7 @@ struct ublk_rq_data {
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
>  	u16 tag;
> +	struct rq_list list;
>  };

I think you'll have a hole after tag here and end up eating the full 32
bytes on x86_64. Maybe put list before tag to leave a bit of space for
some small fields?

Separately I think we should try to consolidate all the per-IO state. It
is currently split across struct io_uring_cmd PDU, struct request and
its PDU, and struct ublk_io. Maybe we can store everything in struct
ublk_io and just put pointers to that where needed.

>  
>  /*
> @@ -1258,6 +1259,32 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
>  }
>  
> +static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> +		unsigned int issue_flags)
> +{
> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +	struct ublk_queue *ubq = pdu->ubq;
> +	struct request *rq;
> +
> +	while ((rq = rq_list_pop(&pdu->list))) {
> +		struct ublk_io *io = &ubq->ios[rq->tag];
> +
> +		ublk_rq_task_work_cb(io->cmd, issue_flags);

Maybe rename to ublk_dispatch_one_rq or similar?

> +	}
> +}
> +
> +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> +{
> +	struct request *rq = l->head;
> +	struct ublk_io *io = &ubq->ios[rq->tag];
> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> +
> +	pdu->ubq = ubq;
> +	pdu->list = *l;
> +	rq_list_init(l);
> +	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);
> +}
> +
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> @@ -1296,16 +1323,13 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> -static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> -		const struct blk_mq_queue_data *bd)
> +static blk_status_t ublk_prep_rq_batch(struct request *rq)
>  {
> -	struct ublk_queue *ubq = hctx->driver_data;
> -	struct request *rq = bd->rq;
> +	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
>  	blk_status_t res;
>  
> -	if (unlikely(ubq->fail_io)) {
> +	if (unlikely(ubq->fail_io))
>  		return BLK_STS_TARGET;
> -	}
>  
>  	/* fill iod to slot in io cmd buffer */
>  	res = ublk_setup_iod(ubq, rq);
> @@ -1324,17 +1348,58 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;
>  
> +	if (unlikely(ubq->canceling))
> +		return BLK_STS_IOERR;
> +
> +	blk_mq_start_request(rq);
> +	return BLK_STS_OK;
> +}
> +
> +static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> +		const struct blk_mq_queue_data *bd)
> +{
> +	struct ublk_queue *ubq = hctx->driver_data;
> +	struct request *rq = bd->rq;
> +	blk_status_t res;
> +
>  	if (unlikely(ubq->canceling)) {
>  		__ublk_abort_rq(ubq, rq);
>  		return BLK_STS_OK;
>  	}
>  
> -	blk_mq_start_request(bd->rq);
> -	ublk_queue_cmd(ubq, rq);
> +	res = ublk_prep_rq_batch(rq);
> +	if (res != BLK_STS_OK)
> +		return res;
>  
> +	ublk_queue_cmd(ubq, rq);
>  	return BLK_STS_OK;
>  }
>  
> +static void ublk_queue_rqs(struct rq_list *rqlist)
> +{
> +	struct rq_list requeue_list = { };
> +	struct rq_list submit_list = { };
> +	struct ublk_queue *ubq = NULL;
> +	struct request *req;
> +
> +	while ((req = rq_list_pop(rqlist))) {
> +		struct ublk_queue *this_q = req->mq_hctx->driver_data;
> +
> +		if (ubq && ubq != this_q && !rq_list_empty(&submit_list))
> +			ublk_queue_cmd_list(ubq, &submit_list);
> +		ubq = this_q;
> +
> +		if (ublk_prep_rq_batch(req) == BLK_STS_OK)
> +			rq_list_add_tail(&submit_list, req);
> +		else
> +			rq_list_add_tail(&requeue_list, req);
> +	}
> +
> +	if (ubq && !rq_list_empty(&submit_list))
> +		ublk_queue_cmd_list(ubq, &submit_list);
> +	*rqlist = requeue_list;
> +}
> +
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>  		unsigned int hctx_idx)
>  {
> @@ -1347,6 +1412,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>  
>  static const struct blk_mq_ops ublk_mq_ops = {
>  	.queue_rq       = ublk_queue_rq,
> +	.queue_rqs      = ublk_queue_rqs,
>  	.init_hctx	= ublk_init_hctx,
>  	.timeout	= ublk_timeout,
>  };
> @@ -3147,6 +3213,9 @@ static int __init ublk_init(void)
>  	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
>  			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
>  
> +	BUILD_BUG_ON(sizeof(struct ublk_uring_cmd_pdu) >
> +			sizeof_field(struct io_uring_cmd, pdu));
> +

Consider putting this near the struct ublk_uring_cmd_pdu definition or
in ublk_get_uring_cmd_pdu. There are helpers provided by io_uring
(io_uring_cmd_private_sz_check and io_uring_cmd_to_pdu) you can use.

>  	init_waitqueue_head(&ublk_idr_wq);
>  
>  	ret = misc_register(&ublk_misc);
> -- 
> 2.47.0
> 
