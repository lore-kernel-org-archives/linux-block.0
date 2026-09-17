Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C24B4033;
	Thu, 17 Sep 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638700; cv=none; b=A1MNaKWZweTeCWmgmK5g23pNPe1KMXtlav6+H50aJCNhf29cCbTtUHlM8Vj0mZ6sgGHslZ7paWKuRQBN9r8bapG6Jdx6aWodFf7ixtX4wJZZI55LGKzHElaWM8HstH+g29aXdVH3iAlK5kuLe8Z9otBKvYEinGi//ihSuPVX18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638700; c=relaxed/simple;
	bh=WfehuPBPz7RRpv7qw+JGUyZJjxV5Vk+P+G5zv0VfH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9JALxoArN4FWPj+T1XloGQ2oqpebNki63DVpIXuC/+bO/0YrBp87Y60rODtBoEo4KNuQp8zyn18UpIIlSQCVe8jfxua8thYkTDMKMBxNmBi/kjNGasrvaKuY4EQnBgUuKOTbmMArBC1WhlJECQj8O/Tc7ojjiLjFUSuzrTRPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iH2X0iGB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ir9Tu6DJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iH2X0iGB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ir9Tu6DJ"
Date: Thu, 17 Sep 2026 11:51:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789638671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4k5q/B9Yhz4IzRdp5uZt+cqVsxHZlip+voh968VmPrc=;
	b=iH2X0iGBDg5sI1tVhgxXXZQ+flmsIUaa13MY46K3uQeU2GAE104ao0eeE+lBQV3VXefbWF
	qUbNVL/7iCSSjjJD0H+847xufns6bfsuMD9LXqRlwmfFK+4sSsg2ybDS/2Oz56NY6NSnXH
	oBPgzd+KeQj+oLrp2ETyP7VsxZd3inus1TSCDORjt99dnQ0ubNX8T9HK5ScmmTlLIhMjkB
	+Xv2Savd5VxL1kPYCh7ney64r3H5uaifDt3ohebZQIWNHGoIUs4qqiTbN8+4jLFPmsPqYL
	ojDODPrzU8lz2OloRp40gFIjSE8IjTODNLUWfh/8qy1Vx8xP8g7bx+iT6EHe0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789638671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4k5q/B9Yhz4IzRdp5uZt+cqVsxHZlip+voh968VmPrc=;
	b=Ir9Tu6DJAyYaiH+KSuOlprValYZ3aGP0G1YzW7oFhp5Cju3SYCRzCRFbWLG/xyQ2fafGDQ
	Dk8pNFLUy0Fg3TCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	wanghui33@xiaomi.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] tick/block: Add BLOCK_SOFTIRQ to the hotplug safe mask
Message-ID: <20260917095110.Yxq3FCrB@linutronix.de>
References: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904064506.671203-1-wangshuaiwei1@xiaomi.com>

On 2026-09-04 14:45:06 [+0800], Wang Shuaiwei wrote:
> During CPU-hotplug stress testing combined with an I/O
> workload, the following message is observed:
> 
>   "NOHZ tick-stop error: local softirq work is pending, handler #10!!!"
> 
> On CPU offline, ksoftirqd is parked at CPUHP_AP_SMPBOOT_THREADS while
> the CPU still takes interrupts. A block completion raised after that
> point stays pending, and if the dying CPU goes idle before teardown,
> report_idle_softirq() sees it, keeps the tick alive and prints the
> error above.
> 
> Such pending block completions on the outgoing CPU are drained later by
> blk_softirq_cpu_dead() (CPUHP_BLOCK_SOFTIRQ_DEAD), so a pending
> BLOCK_SOFTIRQ is harmless here. Add it to SOFTIRQ_HOTPLUG_SAFE_MASK
> like the other teardown-covered vectors.
> 
> Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Should this go via nohz, softirq or block?

Sebastian
