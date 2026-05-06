Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B33DEFE6;
	Wed,  6 May 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053684; cv=none; b=PusZTktsgk11GO7ZkNVEdCOaMV9TuZDzfAZa3oqEAhVbft25iTzyv5wycjFtjXlrr5XwUB4FCbCLEzGifoUcnEjN1Y13YjOY5fiA+hUaLGniJfgUpY4wF8pqVCVTUUmNYOBgyxL39IC0dXuihV0xe9pPk3Vrk123LStga5vmqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053684; c=relaxed/simple;
	bh=6d2k4p+SGUdlq5rmtOl/4L5HtwcZD/Jwy6bdOgroPVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO6ks2lqhRWLDAtOYurfSnesM9ku3kvJ+uVH/Ha1yLD3tK45VCJHTb2xBWH81cFIXa5TNmx3zmc0d78JgoY6KSLwcgBENP6gpxcroBZDdzWNBs1VXJYa1UahjN8vzTFjQAynRAGn6btA7bODGjpAi6QnrF/o7NPO1YRCip9WtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DsMAZnSb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GAMDAi1X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DsMAZnSb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GAMDAi1X"
Date: Wed, 6 May 2026 09:47:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778053680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBJlc62CljBch3EtHz0CTqrU2a50TB/3SkRgjHbAKSU=;
	b=DsMAZnSbltaoqe/62EqBYHHLcQAmZZJtn21XxBF/0UsMDqm1TynQktNpR+YBUpJnrpc13U
	7Tnc++d6mNNuSwJ3nIKrrtdElccAFeXu55dalcJus6GcphG1gbxM4LhekWYgQ7eg9r8mZx
	DmSzZxzMq5fxQUK6XtMy9ODGYKMNGJ3mh8dJWZpTn3OhEbNrR90gH1IYaNq9i+M9ukM/IG
	f9qPIOlQ3kpOWDu+3FU4l6HYknebbppbZQ2wPJMBEZke/A0RvFs3Ex9GAU3VroYWwiNL0b
	4dFbgvU8bKCFvgwkDzXykdg4RQ63UdMEoeffkCw+7i5vCxRKFPcanerP+XHZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778053680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBJlc62CljBch3EtHz0CTqrU2a50TB/3SkRgjHbAKSU=;
	b=GAMDAi1XKJx0QwQmNjR2tJ6WHpk2HCHddopkHlOdccPqqrpYFI/QM4MlKNgErWKEvEzkdG
	1IeKr44U0vlwvABg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org, clrkwllms@kernel.org,
	rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, chris.friesen@windriver.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
Message-ID: <20260506074758.8zEg1ZBh@linutronix.de>
References: <cover.1778048987.git.ionut.nechita@windriver.com>
 <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
 <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>

On 2026-05-06 09:14:33 [+0200], Bart Van Assche wrote:
> On 5/6/26 8:56 AM, Ionut Nechita (Wind River) wrote:
> >   void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> >   {
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&q->queue_lock, flags);
> > -	if (!q->quiesce_depth++)
> > -		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> > -	spin_unlock_irqrestore(&q->queue_lock, flags);
> > +	atomic_inc(&q->quiesce_depth);
> > +	/*
> > +	 * Pairs with smp_rmb() in blk_mq_run_hw_queue(): make the
> > +	 * incremented quiesce_depth observable to readers re-checking
> > +	 * the quiesce state, so they don't dispatch on a quiesced queue.
> > +	 */
> > +	smp_mb__after_atomic();
> >   }
> 
> No, this is not sufficient to guarantee that blk_mq_run_hw_queue() sees
> the latest value of q->quiesce_depth. If you want to achieve that I
> think the only option is to protect the atomic_inc() above with
> hctx->queue->queue_lock.
> 
> > @@ -2362,17 +2365,15 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> >   	need_run = blk_mq_hw_queue_need_run(hctx);
> >   	if (!need_run) {
> > -		unsigned long flags;
> > -
> >   		/*
> > -		 * Synchronize with blk_mq_unquiesce_queue(), because we check
> > -		 * if hw queue is quiesced locklessly above, we need the use
> > -		 * ->queue_lock to make sure we see the up-to-date status to
> > -		 * not miss rerunning the hw queue.
> > +		 * Re-check the quiesce state after a read barrier. Pairs with
> > +		 * smp_mb__after_atomic() in blk_mq_quiesce_queue_nowait() and
> > +		 * blk_mq_unquiesce_queue() so we don't miss rerunning the hw
> > +		 * queue when a concurrent unquiesce has just dropped the
> > +		 * quiesce_depth to zero.
> >   		 */
> > -		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> > +		smp_rmb();
> >   		need_run = blk_mq_hw_queue_need_run(hctx);
> > -		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> 
> If the atomic_inc() in blk_mq_quiesce_queue_nowait() is protected by
> hctx->queue->queue_lock then the above code doesn't have to be modified.

But wouldn't the atomic_inc + barrier avoid the need to have the lock?
Isn't this a normal pattern? If the lock is kept, we could use
non-atomic ops here then. But this avoids having the lock.

> Thanks,
> 
> Bart.

Sebastian
