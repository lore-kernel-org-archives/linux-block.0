Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34023EEAF6;
	Sat, 16 May 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778952836; cv=none; b=ML2hRWDUlECeBPgXpQxSW3kzxQ4tqBn2KnJC0xrY8B34oHPJt4oQqSzNdU7nwsLA9kEXXXFhEV2OHrjkwuqJyiDI9mFvnzo58FLQVDocTS9X79d41/vShJ+Sqny+g7cAdJJscuaSLHAP4QkVP6OPgo84iNyAxyXQNqG8wqhRc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778952836; c=relaxed/simple;
	bh=IBRnt0HoVR+u2jOciieDU1zX9chIXBQjELO39KBWtyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+Fx1UixbCykGktE+rpcuJi4XF0wD6p4tKMbE6mWaY8TSvLCx9DZmj1wY+/E8oXW0Zb1UnivMP9BovioEl0aAOplOtwbQiBuGW2Llx2YEHO1xK/n+t26J9y3M334gr99uS6iL2/VKlrZTfQ3gPjm8rpgYT4Yd1ntdpauGoCA0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=Xal0ACJU; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="Xal0ACJU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E95A3DAE3E;
	Wed, 13 May 2026 11:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1778665406; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=811N5mr881MwGe6zoRbXSbkVBM6MUCB54Vz9Fm4w6ws=;
	b=Xal0ACJUKl2FaF1bSBrELJenPRf30vRvkzW74c6w64UDcusrkW+twab7m+jCYqTkN26GaS
	jClKq0ohbycoBcByfZdsuyibFvs761UX8E/qbXgF3mNRVPXjJfNETtzTLZ3ivMMOF5PB8J
	KyvPv//WV9827ACZC0Tul8ugMENAa+gDE24BDrcRCCEv70OQXeM098XxSTIhOswQ5WAAoU
	1Ienav6+6k1sIP+9CScCocIWCmgCl72EwxHYVnyMLaJJtYTuJ2mVSBBesbm1dQQgVJMvd7
	0GVhFff7wdNe87I4aTPsI5dp2P6tsCDYT+NNAJ8VfkQ5j8X17xge/9trif8Paw==
Date: Wed, 13 May 2026 11:42:46 +0200
From: Daniel Wagner <wagi@monom.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <3af2cd18-1221-4ff6-aa7f-6dab74460eab@nitrogen.local>
References: <20260513005509.135966-1-atomlin@atomlin.com>
 <20260513005509.135966-6-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513005509.135966-6-atomlin@atomlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, May 12, 2026 at 08:55:06PM -0400, Aaron Tomlin wrote:
> +static void blk_mq_map_fallback(struct blk_mq_queue_map *qmap)
> +{
> +	unsigned int cpu;
> +
> +	/*
> +	 * Map all CPUs to the first hctx of this specific map to ensure
> +	 * at least one online CPU is serving it, respecting the map's
> +	 * boundaries so secondary maps do not route into the default map.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		qmap->mq_map[cpu] = qmap->queue_offset;
> +}

I think this should also check if the CPU is online. The fallback should
ensure the system will boot.
