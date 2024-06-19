Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AC156C69;
	Wed, 19 Jun 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819574; cv=none; b=g0Qt6tS8+DOkOU8+TS2oplFYGSlVo77/W9LqG9jHKR2kvnRMlbsTK4PjgqLrjGfKhEaP6Nyc9IcMJSCPum5qgCNR8LcbZ6ZK18nP5ee5cATpb2vHwYwZ2Z2j5NCCjjLiEE2c6mo64C1dpS0LDhY2DQadBrfzxGSD3qJrT1/s9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819574; c=relaxed/simple;
	bh=MkTAzWwpU7fYBjUXFaGZNFMLvsjS73BMzgeedjou7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1r6zmO8YGkOj/8vSKzn714klxDYODacwrj1T4nmDeaPMhtod3bBR3VaYCVPw5iDclFNjz7e3fVweA0j6b6nXfVEFIYyv1MpCb/rGUM3VSmnVrpaUdO5TPld4JMlg8gkt4NG+I04g0uandeoasrH+WUmXUuJpLmAO8I0WR+Ibrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x26/vIWM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XMO3KI02; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x26/vIWM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XMO3KI02"
Date: Wed, 19 Jun 2024 19:52:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718819570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxbi7LprCB/g3u4kI7swUbmNmwOv06b3apNPVfkfxY=;
	b=x26/vIWMK8qcF+R6VSIPE5xFNrmtdB1PgIcPGdF9lWbf9cIYUvJ6Xuc6v1Mvf6BnDDSN21
	c7Dncrsa9RvUqvNCJbwIXJOYDcLGOKQA+cnYAcWol8omteaUbyQMZ2+Flpj0wFnXUpZ7Bt
	LEUpBTcHQgEVlcVh1Tai8udVaRt69lGP36rIvYV51iFtg+0r5smbCaLUBzFx52QvSqj6ZW
	UjkUVL52/uDXYgDDVWJrYpxsl4/3Jrms0m/aBKPJYp9xgXku7WB56HKew/d/ENFMCCW6oQ
	2tNB9CsJISH48yYS/GkNG2EItS72+lLR+4QuH5sSw7NertREMIeZmsh6sGSD2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718819570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxbi7LprCB/g3u4kI7swUbmNmwOv06b3apNPVfkfxY=;
	b=XMO3KI02HCkANmngXWlFL838cyZCdR486pd/jUC507OsEMv6RVXTmG1dVUzjWzzSKWjyXg
	2SC3PMU0AildLmCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
Message-ID: <20240619175249.lK51lGOx@linutronix.de>
References: <20240619150814.BRAvaziM@linutronix.de>
 <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>

On 2024-06-19 11:34:23 [-0600], Jens Axboe wrote:
> On 6/19/24 9:08 AM, Sebastian Andrzej Siewior wrote:
> > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > 
> > The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> > lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> > section, zs_free() acquires a zs_pool::lock, and there is access to
> > zram::wb_limit_lock.
> > 
> > Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
> > the lock has been acquired/ dropped.
> 
> The conditional code depending on CONFIG_PREEMPT_RT is nasty. Why not
> just get rid of that and use the CONFIG_PREEMPT_RT variants for
> everything? They are either good enough to work well in general, or it
> should be redone such that it is.

That would increase the struct size with lockdep for !RT. But it is
probably not a concern. Also other bits (besides ZRAM_LOCK) can not be
added but that wasn't needed in the last few years.
Okay, let me redo it.

Sebastian
