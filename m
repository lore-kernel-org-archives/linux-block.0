Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F75125D0
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456152; cv=none; b=HLl2BuPGnUvJwc476uSfWTx3rGKBlrRpbCOENfu6lu2YV6ccHGbYiJVs5OENh4YiHUgZ7fSPmGMjchaAo7NH+rcJDYgF5hngZHKFbe1zxnMR13WdUSt4FfxeEDtGsvz98nb/6bzzKVo8NTk3wxhafXnjQnZFll8dTEXYdSYRMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456152; c=relaxed/simple;
	bh=lkj+ngCulR1DGsrEFD6J+Al56ZX8zxycT4OcncRsl58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3ilBtNin28qNZ7ISd5kXDkSc/d9VRLkB8yC5oiKq5ofyRHrdn+XsmsMntTT6eAKEBg/Do9i9w3UQCf5oDAI0j7xCeZ11awLM0tQ4mBstFCiVyLTvIsL5LG3g3hCsmq6xJqEObFhoE6zzNuwrlyYwed/fnICp7QWyYA38JL1ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XjN9m1Ac; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjN9m1Ac"
Message-ID: <73000e7f-14a7-40be-a137-060e5c2c49dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766456146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JYLQphHkHhc+TsJBvOUTEPuArWJ7oSHXKFUYWfY75I=;
	b=XjN9m1Acw1vW2E+BxTN/Hk7tqQHJwFAmtBdMDXenlPrmk6ZiRB3pbdBEs4+Blc3JfsO2/P
	pPptdT0ol+DBAkOzZusVXhrCEHRuw41fYxIP7WLttWzUnXLAiWIc/87aS5n+N8u/J8jgLW
	9tloDKuQG33yQNNkN1tvmuXjT4/uXxM=
Date: Tue, 23 Dec 2025 10:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] block/blk-mq: fix RT kernel regression with
 queue_lock in hot path
To: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, ionut.nechita@windriver.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashal@kernel.org, stable@vger.kernel.org, ming.lei@redhat.com
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
 <20251222201541.11961-2-ionut.nechita@windriver.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20251222201541.11961-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/23 04:15, Ionut Nechita (WindRiver) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>
> Commit 679b1874eba7 ("block: fix ordering between checking
> QUEUE_FLAG_QUIESCED request adding") introduced queue_lock acquisition
> in blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks.
>
> On RT kernels (CONFIG_PREEMPT_RT), regular spinlocks are converted to
> rt_mutex (sleeping locks). When multiple MSI-X IRQ threads process I/O
> completions concurrently, they contend on queue_lock in the hot path,
> causing all IRQ threads to enter D (uninterruptible sleep) state. This
> serializes interrupt processing completely.
>
> Test case (MegaRAID 12GSAS with 8 MSI-X vectors on RT kernel):
> - Good (v6.6.52-rt):  640 MB/s sequential read
> - Bad  (v6.6.64-rt):  153 MB/s sequential read (-76% regression)
> - 6-8 out of 8 MSI-X IRQ threads stuck in D-state waiting on queue_lock
>
> The original commit message mentioned memory barriers as an alternative
> approach. Use full memory barriers (smp_mb) instead of queue_lock to
> provide the same ordering guarantees without sleeping in RT kernel.
>
> Memory barriers ensure proper synchronization:
> - CPU0 either sees QUEUE_FLAG_QUIESCED cleared, OR
> - CPU1 sees dispatch list/sw queue bitmap updates
>
> This maintains correctness while avoiding lock contention that causes
> RT kernel IRQ threads to sleep in the I/O completion path.
>
> Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>   block/blk-mq.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5da948b07058..5fb8da4958d0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2292,22 +2292,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   
>   	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>   
> +	/*
> +	 * First lockless check to avoid unnecessary overhead.
> +	 * Memory barrier below synchronizes with blk_mq_unquiesce_queue().
> +	 */
>   	need_run = blk_mq_hw_queue_need_run(hctx);
>   	if (!need_run) {
> -		unsigned long flags;
> -
> -		/*
> -		 * Synchronize with blk_mq_unquiesce_queue(), because we check
> -		 * if hw queue is quiesced locklessly above, we need the use
> -		 * ->queue_lock to make sure we see the up-to-date status to
> -		 * not miss rerunning the hw queue.
> -		 */
> -		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> +		/* Synchronize with blk_mq_unquiesce_queue() */

Memory barriers must be used in pairs. So how to synchronize?

> +		smp_mb();
>   		need_run = blk_mq_hw_queue_need_run(hctx);
> -		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> -
>   		if (!need_run)
>   			return;
> +		/* Ensure dispatch list/sw queue updates visible before execution */
> +		smp_mb();

Why we need another barrier? What order does this barrier guarantee?

Thanks.
>   	}
>   
>   	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {

