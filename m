Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131F35BDAA;
	Thu, 12 Feb 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907727; cv=none; b=vCx7CgUM2FBWn+qYKTmib6f9NyyVNegrg2acq/4DGDkkd+uveEBe5uycXtSrrGyh5GAZcHav+3kjKvS9PsGejqMPRA59Y/ytaCm94vRDFQ4P5FoRjNHSWL/WgXdbo84jY1r4TnEuRtFTZHfqIbQVVI3HU2SFbbi4eMeUVvcldLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907727; c=relaxed/simple;
	bh=dFavjR5pdXwlc9K6evsuvIUExi633TuD2Y58C+AQzB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+CCfcUaH1cOBzE2tGYPEUr56JvbH6AG4D5i9x9rA3RLuSlzCt1S7qX69Nfp3ZiLkDUShpQoA+ryYLyRDaOaPBqoG6tUlm2f6s/5gxp3Z1gspUzrB3wGOz7nrnfb3I6PvqPGz+hDH6VSLXNLMWvXve+DQT5gPVOzpkwnp2VlXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nu6uB5eE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZEeMQVK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nu6uB5eE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZEeMQVK"
Date: Thu, 12 Feb 2026 15:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770907723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyKLveYLx2s5utbcVS0AmPY44PgTdWydUyC5yig1Ys8=;
	b=nu6uB5eE+Ig0CPqWNXdLCsQ4n2Pr7jnNrODwcr/C3EfMXtifqh20fWjeNDYigRZ9LJfWI4
	J9oNH6bKq+IrcFwMPRlwbojTOhyJdhhLBD9Kcwv4Jt4k5hzXTrfjprKANFmiqpcZTFHVmP
	gF54kA51mbEQ7oYyq3eKSihBpi0j06cwRqVcbvGyWx525MS2jxffgPf9XHE+XSIKQaIbEn
	D76MyToOQ5UXTXBXSln7simIfKp7kIzImdQew+KfC6sI7oTbCg0Q5lR1R392szl56PWjbL
	hEYmMXCgnoMnKXrKPvkIHvxWxUSunDHJIG5l8Bvc81XhKKZBaGq3eI1u5NStEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770907723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyKLveYLx2s5utbcVS0AmPY44PgTdWydUyC5yig1Ys8=;
	b=CZEeMQVKcntcOvBwuUCfscuZPYwPbNP3RVFpqIsyORAkGv5NVdGuxmRYHtb4ATm1ykgc7I
	D5IzSCTjC0H/m3Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, chris.friesen@windriver.com,
	stable@vger.kernel.org, sunlightlinux@gmail.com,
	ionut_n2001@yahoo.com
Subject: Re: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
Message-ID: <20260212144841.95-yCgJm@linutronix.de>
References: <20260211203928.324307-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211203928.324307-2-ionut.nechita@windriver.com>

On 2026-02-11 22:39:29 [+0200], Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering
> between checking QUEUE_FLAG_QUIESCED request adding") causes severe
=E2=80=A6

> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUI=
ESCED request adding")
This is
         6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QU=
IESCED request adding")

in my tree. I don't have your hash anywhere. The hash at the top in the
email is also affected.

> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Otherwise
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -314,21 +314,18 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>   */
>  void blk_mq_unquiesce_queue(struct request_queue *q)
>  {
> -	unsigned long flags;
> -	bool run_queue =3D false;
> +	int depth;
> =20
> -	spin_lock_irqsave(&q->queue_lock, flags);
> -	if (WARN_ON_ONCE(q->quiesce_depth <=3D 0)) {
> -		;
> -	} else if (!--q->quiesce_depth) {
> -		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> -		run_queue =3D true;
> -	}
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	depth =3D atomic_dec_if_positive(&q->quiesce_depth);
> +	if (WARN_ON_ONCE(depth < 0))
> +		return;

Ah. That is cute.

> -	/* dispatch requests which are inserted during quiescing */
> -	if (run_queue)
> +	if (depth =3D=3D 0) {
> +		/* Ensure the decrement is visible before running queues */
> +		smp_mb__after_atomic();
> +		/* dispatch requests which are inserted during quiescing */
>  		blk_mq_run_hw_queues(q, true);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
> =20

Sebastian
