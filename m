Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F01D61A3
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517013; cv=none; b=SKQbAJQDHt21a5ozzOWWuzkUgsaOsK3rlIeTzQpvLtmFAVLb8TOZH2s3IU4Nadf5URxtmSAi6n9rcdG8KpwroHkifhwfopASrfrGf8q/aCteIX8sMI8EImPPC0KHlBOy1JWyuVRWpCg5n0pGtFD6VCG/N3lWEbDq4izf0laoOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517013; c=relaxed/simple;
	bh=k2fg4fygwXeaXTMCftMLTPGnGLA7s5WQ47uP1VSiymE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5Yv8z2HqC25J5xGydBispWWm+j0otyQbQmI3mB8Vk09HnTQJaTPWlMF7T0He0DwpKn+XbPVgnPn2xfFvhEdCjc8vjz3KhyO5NzB0ExkMq3gwCi3aSqrU9CP1ZyLupuEoVrSEIL+xZ2djfR1iw/EAJfKYu4oxCAU1KQzuGDOAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7BLeqJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7BLeqJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9216C19421;
	Wed, 19 Nov 2025 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763517011;
	bh=k2fg4fygwXeaXTMCftMLTPGnGLA7s5WQ47uP1VSiymE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p7BLeqJ+MiSdv+XAbP8qlU5uZPgCw+yCHTX1MFDkS2/mMSXneUZLntkML4zRi2qpd
	 ZIyBmjSsSmWV7ObZRrpeqOKsBIQsH+EVJ7CQPGqTxFw9R1eAm29opL++9fH1DkkIeG
	 GcaDBOxr5kw8w0vWS7MWtOf4a60vBzSeKTX/hsTMcL+X+khGInCRZApvjXtgEOdIHG
	 TLTvto5r/t7wxtaT1qHF1Mof9XgoHrAbSAHp7snsLleJtmlK+xbfH69m0N0UyxciJ7
	 u21n26Kmr+QHgyVVTkVh9wiwAzjh8YC75F14zXOO07kJB08wVwMMK0D7jQzO9rnfbA
	 Dkf78iJqhOANA==
Message-ID: <7bf811d2-257a-4be0-b65d-e255717bcd35@kernel.org>
Date: Wed, 19 Nov 2025 10:50:09 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] zloop: clear REQ_NOWAIT before workqueue submission
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20251119003647.156537-1-ckulkarnilinux@gmail.com>
 <20251119003647.156537-2-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251119003647.156537-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 09:36, Chaitanya Kulkarni wrote:
> zloop advertises REQ_NOWAIT support via BLK_FEAT_NOWAIT (set by default
> for all blk-mq devices), but delegates I/O processing to workqueues
> where blocking operations are allowed.
> 
> Since REQ_NOWAIT is not valid in the workqueue context, clear the
> REQ_NOWAIT flag before handing the request over to the workqueue. This
> avoids unnecessary non-blocking constraints in a context where blocking
> is acceptable.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  drivers/block/zloop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 92be9f0af00a..22a245259622 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -620,6 +620,8 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	blk_mq_start_request(rq);
>  
> +	rq->cmd_flags &= ~REQ_NOWAIT;
> +

To be able to catch any potential issue with this function blocking, I think it
is preferable to unset REQ_NOWAIT only once we are in the context of the worker
thread.

So something like this:

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index d6dc672bda5f..9e4256824336 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -547,6 +547,10 @@ static void zloop_handle_cmd(struct zloop_cmd *cmd)
        struct request *rq = blk_mq_rq_from_pdu(cmd);
        struct zloop_device *zlo = rq->q->queuedata;

+       /* We can block in this context, so ignore REQ_NOWAIT. */
+        if (rq->cmd_flags & REQ_NOWAIT)
+               rq->cmd_flags &= ~REQ_NOWAIT
+
        switch (req_op(rq)) {
        case REQ_OP_READ:
        case REQ_OP_WRITE:

The same comment applies to loop as well. I think it is better to clear
REQ_NOWAIT only once the request is owned by the worker thread context.

-- 
Damien Le Moal
Western Digital Research
