Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D501DFED;
	Fri,  6 Sep 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634134; cv=none; b=OiwC+AxEi5NprxGTkv0+fzi3L20h6Uqn93QdbP6J8c8QmxyH06+0L1YkQHmqw/vfGdgoK2yUJCZ99cBLA6sGbzcj6s79uFVpOZm/mN1tXIktfUqOc9466FYCkB/We9UHlxH90peg7PmhN1ys+bc3abz0iyYTJZZ1YTKdYRe2sBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634134; c=relaxed/simple;
	bh=fK1t4GAcYw7JqYAxfcdgUYGCNSLDKVBV6oAWCAK6WY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSUkKNK1YV1O2rstcrXwaw/Sxi2/3h/79OWdjxcAWaXWCMHY3zT1HJXrCULZE5WGWyiQJlk/HHrKUa1e/YXc+U54Oez9V6DC6Pk0PCzUtWSPz1ziiC6X5MjTo+MgKSv2QsOvV/dxEq0hsTJQr2oto/T+9bc1bBGvy9UBZyRsh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBPtqeH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2SrhoML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBPtqeH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2SrhoML"
Date: Fri, 6 Sep 2024 16:48:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725634131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjYdrmWb8B7Lqn3O4p2uhfzWQUvPQifXxSBjVbE9f6Y=;
	b=GBPtqeH59E94mjW/op1PCoyYrGT9yPsHwn0QGa+osMCDBdXDSxmtOO3f+mnOCCwbdNgHeO
	m1YJTHk+NSSVujN+Ft3iPLmuEvazam/L+qaGT2dFQeB0yqo8YuVKIhMhaPTNh0r9tktpcz
	WNur+MZN4PmKq/6slzZS4EZam/WWZSvA2S48XYK6hpHfxqAV/SMbCFMlcHJGl4ax1e7bH1
	PcQO68rJXDeTycBKC+n9noVOVnBx0mAMYzeU1K8zE8Ug1VoGwLhWs/+o27kNLVgHr5jDVZ
	DPNzuK8RarOScFiCPr32JWTRq5yNBpz130htGJ2UDdpL/nGGruPfbDg0sHcPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725634131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjYdrmWb8B7Lqn3O4p2uhfzWQUvPQifXxSBjVbE9f6Y=;
	b=a2SrhoMLLZvFVx7diGONamlt9WQzXJkdCafQ5Zeubya7UWGLl9g6sAwP4+xEhsBh2AFxhs
	mgz39j1SYJmeqODg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240906144849.HrQCoqvn@linutronix.de>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
 <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>

On 2024-09-06 08:31:23 [-0600], Jens Axboe wrote:
> On 9/6/24 8:14 AM, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > this is follow up to the previous posting, making the lock
> > unconditionally. The original problem with bit spinlock is that it
> > disabled preemption and the following operations (within the atomic
> > section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> > that he would like to keep using zram on PREEMPT_RT.
> 
> Looks good to me:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
Thank you.
This is routed via your tree, right?

Sebastian
