Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723873;
	b=T28spxaE+w7s0HtoZT2M+VJg7HYOIlhFWloUU0bpaCBWe5k8l/mZZzxyi5uAKDl9tKjE
	 siRcgu7y3mXT6TYlyk8xEkgZfGXcQBc8DymxOKmFsaiMIXtaIaIXZJ8msIv62OZrKK7DX
	 QUSHcsR6p0H3g1MNTd0uBCM78dkcIYqFKNVwxIgbRmEpalKY3siP6p26POOz53IJBsYqe
	 /XqgFiQn+pF/UWwuPHsGmfB2LRXE3bnQpg5UtyfYenwjXlP6ugxpPJPvjRrbl6JYnIHqq
	 vr6w+uwI+1+3DifIKmwu72uJTUdoFORTIjHn7G8UPvrHtc4wpFA7nk7OpcwN+B1DvNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723873;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=;
	b=svtNRk+4UBphrz3kjrCHzNs6nrZAHc+CTNDYBd79eipU5p+qTBCxnQ3Kv0j5YxxHgxPS
	 KT/Q8/uH22h7W5KIo0P1s3EjilRLzjhRcSvzcpAk6rlAHX2WDqeZbEkeyp/X/8gVblowh
	 cqBKlXMI7bTHY+UWX8qIPayr2+Gr40cuEyU6WSHQFZalBxvZ1JRosWULZvmkbf4FyeDM0
	 SlkRMAQB2TwN3KbcbfB0TeBj9QsZ+6PWb7GfkPIkgtEHkpEyyx+a9SezXagXyWZm4V6ZS
	 a6Msqu493b2HKcL7OHRw7Es7CLqY5hW7hWTVesmlBi6Bf9AthhtHjipiIOFF6diMf7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=atRW3Zru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zfOEnjXA;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2D606D803;
	Tue,  3 Nov 2026 16:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC2D606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=atRW3Zru;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zfOEnjXA
Date: Tue, 3 Nov 2026 17:37:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793723870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=;
	b=atRW3Zru1162usoPNm4G3VNsF00yxh5DxTWu1Pkse7bR5Qk38dmYmpYCSAHarrpa+hUThY
	2aEY4K6aa/+lwSSulZPs+6ag6I31p85pk7WWKgBZsmOV/YWahLdhBfFlC4M30/rR80Mws+
	xd5dhU94ff59mFBWeLpZzLRZ5r1oSpYBZOF7JS6woeHdd+Ll4TTz8JiftlzBr5CzgpYjK8
	j8ekaSAeO+cfjGPZ6GZMlVIb8OrzxLIz+KJBWsYK00imInfHgn/8jjfqRxRBeiAWlbPlFH
	gbbNXb4UEeV4mcgPYK3jLa/xGjiX5lRpngEs5/fT43do3V78Dlm7t8RQE4PfPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793723870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FixADKgbVOGXVyy2SsnJfi/e9OWk3UakRXlJZ09PJsA=;
	b=zfOEnjXAvUZr3mHiG4/sRWWMJ4KK5ZDQzf5cGwVOYUf2xc9Ue7J68eQMpKx8+LEOtfeWH+
	vWHH9kRTzEofa/Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <20261103163748.qDpZjKj8@linutronix.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>

On 2026-11-03 15:57:22 [+0100], Daniel Wagner wrote:
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -717,6 +717,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  }
>  EXPORT_SYMBOL(blk_mq_alloc_request);
>  
> +/*
> + * Return an online CPU which is neither isolated from the scheduler domains
> + * nor from managed interrupts, or nr_cpu_ids if there is none.
> + */
> +static unsigned int blk_mq_housekeeping_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (!cpu_is_isolated(cpu) &&
> +		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
> +			break;
> +	}

What about
	guard(rcu);
	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
		if (!cpu_is_isolated(cpu)
			break;
	}

this ends up with one less function call ;)

> +	rcu_read_unlock();
> +
> +	return cpu;
> +}
> +
>  struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>  {

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
