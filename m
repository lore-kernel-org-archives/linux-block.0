Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035218;
	b=LDXiUc9NYXPrRTtGbR+Ntc0ANx46HowniKXByuYZ2Fv84B9GYqttIfGhjh9ZfiIN4LND
	 EXtEsqspHe/osBemksNiGD/4re7KsjFoGKsO6mkQ2WkkIQB+nrPJkJc1yNy+ePVOhke/o
	 dJTgvViua5ux3GKyxNEtclrxrM0y08PjuHTpdiiB5MJ3OX1icRujgPmlxHwXVwoT+pN2v
	 EEk4jiOq7K8q0+Kv5V8jFo4T7nQUz6DRDZzQsFnl+nxB4If8B/777u0UFol5hTlY1A/Pi
	 mPiOeESRMsc0GAKeNYhOn4idf7XO6piPfcqdv82qK+QCzTIgreCPs8D2qie7EsOv65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035218;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lSS/+OrsC0MWVPBeuddqvOCZShw9SdT0MJx0+39UScI=;
	b=Z0mGdy9lj50OzLJxRNAa/K9Mi60KXXAKtkkvwrpJBoDhT4QjIKCcmp+umucNm69bQhAb
	 bM8FSrf6d0pb/TbChBRmBZxSXTNa5UgAbEbj/3d+FgGSZzKE5onGNBBmD/KpTWRygzv5H
	 dIqZ6E0FfOFLQPC3ZWG3W2+D25XF2b/z5oDlpkwAg62gDYc6YBIwgPQ7qDPzq8TDkvRJs
	 NrsOoJUr88xyUcGID8cxB0grTnhdx3lfKyQLG+Uio6s/cfSLx3sTqNH0ORPgW1b4bgJeq
	 kOylJq1uX0Q8h8TEh90nRDj/YRtLpsxp/tgd6TJob9zYTE/QjrJ6s/95ETtBpwOFqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=he+E0rQH;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBED606A337;
	Wed, 18 Nov 2026 20:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBED606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=he+E0rQH
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id CBA0D20B7169; Wed, 18 Nov 2026 12:53:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBA0D20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795035211;
	bh=lSS/+OrsC0MWVPBeuddqvOCZShw9SdT0MJx0+39UScI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he+E0rQHYWr51ghBxN0sYPYSY0CIIZJam2nzAYIKJC3IuwzPZ/A2T8z9K3/okl7Sy
	 LTubPWXmN4m2msegkD6nSbn8vlrl0byymf7LWCIsGvpRTw53tpmpfCApYHnTJQiS1u
	 nD4bb67/QX7teHsI5npFa3MhjiDzBxEV/66LVz68=
Date: Wed, 18 Nov 2026 15:53:31 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
Message-ID: <av4QS4NK1qL1QPCt@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>

On Thu, Nov 19, 2026 at 12:58:44AM +0530, Srivatsa S. Bhat (Microsoft) wrote:
> Add NULL pointer validation in blk_mq_complete_request_remote() to
> prevent kernel crashes when block drivers pass freed request structures.
> 

This looks a lot like a driver bug, so it's probably best to hunt that
down instead of trying to work around it here.

> When NVMe devices experience hardware failures or firmware bugs,
> completion queue corruption can occur, leading to scenarios where
> drivers attempt to complete already-freed requests. The NVMe genctr
> validation in nvme_find_rq() catches most stale completions, but when
> corruption produces a command_id whose genctr bits happen to match,
> the freed request passes validation and reaches the block layer. The
> block layer's __blk_mq_free_request() sets rq->mq_hctx to NULL,
> but blk_mq_complete_request_remote() lacks validation before
> dereferencing this pointer.
> 
> This manifests as a kernel crash like shown below (the stack trace
> was obtained from a crash observed in a Linux VM on Hyper-V):
> 
>   nvme nvme0: resetting controller due to AER
>   nvme nvme0: request 0xe3 genctr mismatch (got 0x0 expected 0x5)
>   nvme nvme0: invalid id 227 completed on queue 6
>   nvme nvme0: request 0x26 genctr mismatch (got 0xb expected 0x9)
>   nvme nvme0: invalid id 45094 completed on queue 94
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000000fe
>   RIP: 0010:blk_mq_complete_request_remote+0x1b/0x150
>   Call Trace:
>    <IRQ>
>    nvme_irq+0x182/0x320 [nvme]
>    __handle_irq_event_percpu+0x47/0x180
>    handle_irq_event+0x38/0x60
>    handle_edge_irq+0x87/0x1a0
>    __common_interrupt+0x3f/0xa0
>    common_interrupt+0x42/0xa0
> 
> The crash occurs at offset 0xfe when accessing rq->mq_hctx->nr_ctx,
> where mq_hctx is NULL.
> 
> Add a NULL check that returns true (signaling to callers that the
> request has been handled) to gracefully drop freed requests, with a
> WARN_ONCE to flag the condition for diagnosis.
> 
> Fixes: 40d09b53bfc5 ("blk-mq: add a new blk_mq_complete_request_remote API")
> Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
> ---
> I'd like to call out a few unresolved aspects about this patch for
> review attention:
> 
> 1. I'm not sure if the NULL ptr check should be placed before or after
> the rq->state update to MQ_RQ_COMPLETE. Do we need to update that
> state even if we don't proceed with the complete-request operation?
> 
> 2. While this was a real bug that I hit in one of my systems, I don't
> have a way to repro that same scenario anymore (i.e., hardware/firmware
> bug that introduces the corruption), so validating this kernel fix
> against the original crash has been a bit of a challenge.
> 
> Still, I wanted to post this patch to report the bug and seek guidance
> on how best to fix it and harden blk-mq against this NULL ptr dereference.
> 
> Thank you!
> ---
>  block/blk-mq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5ae22d556540..5dc9d7d806b5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1307,6 +1307,15 @@ static void blk_mq_raise_softirq(struct request *rq)
>  
>  bool blk_mq_complete_request_remote(struct request *rq)
>  {
> +	/*
> +	 * Validate request is not freed (__blk_mq_free_request() sets
> +	 * mq_hctx = NULL).
> +	 */
> +	if (unlikely(!rq->mq_hctx)) {
> +		WARN_ONCE(1, "%s: attempt to complete freed request", __func__);
> +		return true;
> +	}
> +
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  
>  	/*
> 
> ---
> base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
> change-id: 20261118-fix-blk-mq-null-ptr-deref-7f376cd5ad90
> 
> Regards,
> Srivatsa
> 
