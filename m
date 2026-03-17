Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2E3C278D
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751614; cv=none; b=p6qMuXnhPNXuXuPoy0TRXKbMMil53+78l+zkiq4Q2v4FGOBxSrsYS7WhTVnHZ/twvqJHnVZclJT7xhNawmuRA7Y02KMvZnXva9gZpmPPm+MSLdEpZdv/pYLfgQfaxPfnASOmMwmqAgLt4KAftKPm0c5F8QHRodl+OQE3ipzHUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751614; c=relaxed/simple;
	bh=bpOHCBvAKfamuf87j4130QYup0vHYalafqGEHsPgK3M=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jo3sWEoGpg7EXlk4JUIoY+OWbNTzhR1ALhuqxlV9OGtHgzjEuuavpH+HQqXiS+1fqu036+LjxCqfPNQgfPctxboVMEcCEtjmBWydxFanC2/vUVOOdUvKiGKkfK/u9P1QlxaHt7ynsxgzt/ipI8l4ZSGgFilPe2uswA6c1D9d8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IX6s99Qy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IX6s99Qy"
Cc: shawn.lin@linux.dev, ulf.hansson@linaro.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773751610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIvkfeWW7o3q5upahJb9knMzgwQdHybTen/YHq4j4hs=;
	b=IX6s99Qy2R4Z1Vx9StxiYNG0HfOkyH/TJmruWeYEJpKHDdlM67U6p6QYM8HHphyuCc6Ym3
	KS3OyejW5v5BgeU57yUKzhhhbaKuVifstOl9o0Y0A9JAqX7zhkToVkwwl/iguzafPujZnR
	muQ393BOIgdi6TtZHYWg0ZIOroSH8bA=
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
References: <20260310160408.3976760-1-b-liu@ti.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
Message-ID: <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
Date: Tue, 17 Mar 2026 20:46:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310160408.3976760-1-b-liu@ti.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/03/11 星期三 0:04, Bin Liu 写道:
> Due to errata i2493[0], multi-block write would still fail in retries.
> 
> This patch reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.

MMC core natively retries single for multi block read. So I assume
what you are trying to do is make it the same for write path. We didn't
resort to upper block layer for help for read case in the past, so  I
think you could still achieve that within the scope of MMC core.

More importantly, what is the failure rate of this issue? If it occurs
frequently, we should consider this a significant hardware defect. In
that case, the host driver could register a multi_io_quirk to apply
certain restrictions on the write path. This approach has been used
previously on TI OMAP platforms.

> 
> [0] https://www.ti.com/lit/pdf/sprz582
> Signed-off-by: Bin Liu <b-liu@ti.com>
> ---
>   block/blk-mq-debugfs.c   |  1 +
>   drivers/mmc/core/block.c | 12 ++++++++++--
>   include/linux/blk-mq.h   |  3 +++
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 28167c9baa55..5f97d07fa3c8 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
>   	RQF_NAME(ZONE_WRITE_PLUGGING),
>   	RQF_NAME(TIMED_OUT),
>   	RQF_NAME(RESV),
> +	RQF_NAME(XFER_SINGLE_BLK),
>   };
>   #undef RQF_NAME
>   
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..00016584d70d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>   		    rq_data_dir(req) == WRITE &&
>   		    (md->flags & MMC_BLK_REL_WR);
>   
> +	if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> +		recovery_mode = 1;
> +
>   	memset(brq, 0, sizeof(struct mmc_blk_request));
>   
>   	mmc_crypto_prepare_req(mqrq);
> @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>   		err = 0;
>   
>   	if (err) {
> -		if (mqrq->retries++ < MMC_CQE_RETRIES)
> +		if (mqrq->retries++ < MMC_CQE_RETRIES) {
> +			if (rq_data_dir(req) == WRITE)
> +				req->rq_flags |= RQF_XFER_SINGLE_BLK;
>   			blk_mq_requeue_request(req, true);
> -		else
> +		} else {
>   			blk_mq_end_request(req, BLK_STS_IOERR);
> +		}
>   	} else if (mrq->data) {
>   		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
>   			blk_mq_requeue_request(req, true);
> @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
>   	} else if (!blk_rq_bytes(req)) {
>   		__blk_mq_end_request(req, BLK_STS_IOERR);
>   	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> +		if (rq_data_dir(req) == WRITE)
> +			req->rq_flags |= RQF_XFER_SINGLE_BLK;
>   		blk_mq_requeue_request(req, true);
>   	} else {
>   		if (mmc_card_removed(mq->card))
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..06b6e1c4fca3 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -64,6 +64,7 @@ enum rqf_flags {
>   	/* ->timeout has been called, don't expire again */
>   	__RQF_TIMED_OUT,
>   	__RQF_RESV,
> +	__RQF_XFER_SINGLE_BLK,
>   	__RQF_BITS
>   };
>   
> @@ -85,6 +86,8 @@ enum rqf_flags {
>   			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
>   #define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
>   #define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
> +#define RQF_XFER_SINGLE_BLK	\
> +			((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
>   
>   /* flags that prevent us from merging requests: */
>   #define RQF_NOMERGE_FLAGS \
> 
