Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA4371045;
	Wed,  6 May 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051696; cv=none; b=K/Ad8utuRmkxaB6P5dSN0qatWFoD6Xl9I+p5e3iU3Wh2NsBGCGktD0iMSf0mll00/CjO/B/MNy0BPkydJNmmRDen93fjZlF1lNpHOp+i4rTqdYrFJt7npO90XQM5rZ/peXkB/VCptY/h5IvUSZa+Ci+1Jn4EfTJU3br8hhVT9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051696; c=relaxed/simple;
	bh=oiLfJnBpP8paIDRaqOxibrdvXg0OP6R68Uq8hSs/4bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGFIZSfLGUQMA4pU3sg7NzoG1Txq/JjI6sgn9XkmuItNZIs8autfLsR/iGM6LeYaq0wZMQBQYgQVA5b8h3ij+ZMOvYUY6nDjBMOEXpXtMOvD9YQX30HMVJ16KMWk9Beuqyir3CP3y2HOLG5AVy3XK2MaMsO5r2T8BTEWpRGfFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HgLT9vei; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HgLT9vei"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g9RTn4zBpz1XM5kD;
	Wed,  6 May 2026 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778051684; x=1780643685; bh=E9gVIx7qpK9ZWf+0jQrzOUzj
	URf3+hUPA7+/vACoBmA=; b=HgLT9veiAkbzOzuB9xaTi+wF/qAUYZVWH1qviWk1
	it4/eIZZvzmaZnmuEJXJZAdWg9MTDlXIKzNT3ZTV9TPZTg/EpLdDIZPl1riUX0wP
	ti8Ly/6I3S0t/AKcnMQ29X7YA7vwHWWO4/wnaz4nDa+AdxCNaI6LF15n4zUuXbTa
	2/LQd4BNWotU/XYIw7IjObOTzdAF16Hy+nWHuYFDUO7Z+8BTTiITPZO8wVnjcEM3
	P030oxwGHPADRNYq/WLKasEh8C/Y5XOo6JaXiirh+lFShCIjW6YNvM1rk7r6rlIv
	WUHP8fUAcoeomwAW8suAorpznJGFHEYWlsKsDYOa/VSRKg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6E-AuBj1atIm; Wed,  6 May 2026 07:14:44 +0000 (UTC)
Received: from [10.211.9.52] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g9RTT14LRz1XM5jn;
	Wed,  6 May 2026 07:14:36 +0000 (UTC)
Message-ID: <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>
Date: Wed, 6 May 2026 09:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 ming.lei@redhat.com, muchun.song@linux.dev, mkhalfella@purestorage.com,
 chris.friesen@windriver.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <cover.1778048987.git.ionut.nechita@windriver.com>
 <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/26 8:56 AM, Ionut Nechita (Wind River) wrote:
>   void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>   {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&q->queue_lock, flags);
> -	if (!q->quiesce_depth++)
> -		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	atomic_inc(&q->quiesce_depth);
> +	/*
> +	 * Pairs with smp_rmb() in blk_mq_run_hw_queue(): make the
> +	 * incremented quiesce_depth observable to readers re-checking
> +	 * the quiesce state, so they don't dispatch on a quiesced queue.
> +	 */
> +	smp_mb__after_atomic();
>   }

No, this is not sufficient to guarantee that blk_mq_run_hw_queue() sees
the latest value of q->quiesce_depth. If you want to achieve that I
think the only option is to protect the atomic_inc() above with
hctx->queue->queue_lock.

> @@ -2362,17 +2365,15 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   
>   	need_run = blk_mq_hw_queue_need_run(hctx);
>   	if (!need_run) {
> -		unsigned long flags;
> -
>   		/*
> -		 * Synchronize with blk_mq_unquiesce_queue(), because we check
> -		 * if hw queue is quiesced locklessly above, we need the use
> -		 * ->queue_lock to make sure we see the up-to-date status to
> -		 * not miss rerunning the hw queue.
> +		 * Re-check the quiesce state after a read barrier. Pairs with
> +		 * smp_mb__after_atomic() in blk_mq_quiesce_queue_nowait() and
> +		 * blk_mq_unquiesce_queue() so we don't miss rerunning the hw
> +		 * queue when a concurrent unquiesce has just dropped the
> +		 * quiesce_depth to zero.
>   		 */
> -		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> +		smp_rmb();
>   		need_run = blk_mq_hw_queue_need_run(hctx);
> -		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);

If the atomic_inc() in blk_mq_quiesce_queue_nowait() is protected by
hctx->queue->queue_lock then the above code doesn't have to be modified.

Thanks,

Bart.
