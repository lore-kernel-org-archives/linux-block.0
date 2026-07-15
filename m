Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414B3F39CC;
	Wed, 15 Jul 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111142; cv=none; b=Ed39MF9AvdhPRkmYuZLL4ypysjpKkddzIpLqc/l2fgbWDGEssTTQ8HVTOK6PneF330Rh0/aOCortm5F2DgLc3gBKgZ1GGT0cdjMZn9l/LgUJ0IxvVEx06Ixk7WYVhJxg8l7XA4tRtGKt1/JDAW5BuUgQLC2W3wZn+XLjvbvitTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111142; c=relaxed/simple;
	bh=lKyOfRRutnTzJyXJlIb8c1DVixKQ+e5963lSZhzSM04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFOGgDJoPwMK6MfJTryUs/Ssk9qnjoyLOhH8t7xyPi/z5q70o3BK6raJIPQCCHBhgY3qH5VSA7HEGQM0EJRkHFdSwm4lv3QfRUcC590LisfYxRzb7cHfvrxJiSv87RUbwLEDNoVAm9A7KL1jwRxVo+pqJoLfulLQmMWroYn84hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOC4tneF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6w0AiVNJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOC4tneF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6w0AiVNJ"
Date: Wed, 15 Jul 2026 12:25:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784111137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ve3cu21pnpE429q6ERuXXltweAb4h/zuUdkIAfpkj2k=;
	b=sOC4tneFfgVzkeWRpfg2XWKqAqT9f4FENiCbJX7haoWWCzfHAcXqGb9iiuga1Xm2LfYvoY
	D7gZ9M/2SGJP0LLhvZJJXVib3EYpksHICDzfK342ccRtLT10oZgfy3N/2/fybSWAnUJgRv
	1Q8IjnrgScgNBtHDheqE0Y8i6x+LmNGtPKbIP4wCI/AGDfSTlyYpjCeM14hZdbxOHy4pbw
	GjWahEkcZ+u2y/Ia3AX/ZVNRzPkU6u/a4+Rj9ionTq/t0oLj0fr90azbQKucafA1jPs5Wh
	2G6ntW/j7MJ4BRUxHamNzSE2nf60ftSvblqtvkX05fhItrsTVdKlx1sLZDtEjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784111137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ve3cu21pnpE429q6ERuXXltweAb4h/zuUdkIAfpkj2k=;
	b=6w0AiVNJWhuShHzdbEmuSxbk+FBPsJoOXXF8gXEC9qTN9ppKzhCT5e1t5vKCj4VwSYAPmD
	ocyrtZfMQfJtsAAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com,
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com,
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com,
	rishil1999@outlook.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 8/8] docs: add io_queue flag to isolcpus
Message-ID: <20260715102535.STkb5tE8@linutronix.de>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-9-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521232956.553287-9-atomlin@atomlin.com>

On 2026-05-21 19:29:56 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> The io_queue flag informs multiqueue device drivers where to place
> hardware queues. Document this new flag in the isolcpus
> command-line argument description.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> [atomlin:
>     - Refined io_queue kernel parameter documentation
>     - Removed an inaccurate claim in the documentation stating
>       that io_queue takes precedence over managed_irq]
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

From high level, this looks like managed_irq with the exception that you
can limit the number of assigned interrupts while managed_irq is best
effort. Is this true or do I oversimplify something?

If so, can this be integrated?

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..fb828bb60b9e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2815,6 +2814,31 @@ Kernel parameters
>  			  housekeeping CPUs has no influence on those
>  			  queues.
>  
> +			io_queue
> +			  Applicable to managed IRQs only. Restrict
> +			  multiqueue hardware queue allocation to online
> +			  housekeeping CPUs. This guarantees that all
> +			  managed hardware completion interrupts are routed
> +			  exclusively to housekeeping cores, shielding
> +			  isolated CPUs from I/O interruptions even if they
> +			  initiated the request.
> +
> +			  Note: Using io_queue restricts the number of
> +			  allocated hardware queues to match the number of
> +			  housekeeping CPUs. This prevents MSI-X vector
> +			  exhaustion and forces isolated CPUs to share
> +			  submission queues.
> +
> +			  Note: Offlining housekeeping CPUs which serve
> +			  isolated CPUs will fail. The isolated CPUs must
> +			  be offlined before offlining the housekeeping
> +			  CPUs.
> +
> +			  Note: When I/O is submitted by an application on
> +			  an isolated CPU, the hardware completion
> +			  interrupt is handled entirely by a housekeeping
> +			  CPU.

This is named io_queue but it does affect I/O in general unless the
driver uses managed_irqs. This may or may not be clear to the user.
So the io_queue might not be the perfect name given that affects alles
devices in the system. We do have just I/O devices using it right now.

I think this still deserves an explanation in
Documentation/core-api/irq/managed_irq.rst like how to use it, what is
the expected outcome and how does it interact with the managed_irq
argument. Does it make sense to use both, is it exclusive or, what would
be the use case for both arguments.

>  			The format of <cpu-list> is described above.
>  
>  	iucv=		[HW,NET]
> -- 
> 2.51.0
> 
