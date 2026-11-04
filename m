Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777834;
	b=QWqhnnsJpL4niscPw1t2fBLErfI3MnePMol5rZUwJbit+XeET7XSwG+i3cT9rDLkqDJ5
	 J5teTW9WAERy6cdbt4l7/XG9mUz6x+fKCrzhNVh1cs9xRg/H+m8dIg7lJiled1xAwxHHh
	 NeQ4SZ0IHs4VPGdMmP/Sp63iDZqtMkjhCPJrAPFZG3u4IwmBOP6H6Tm2dhbl9stjAWQRh
	 9FfCM5n0nEtUBE57M2kmsYvsLLTc9Kn+FdnD9DqLYUAosArVfWgYy0BBDKYC6kl8nQUxK
	 JdqoXjAfb0Quhqgf7bmFUlNApVkUIT+SR8AA/+yvhXrlnUpymyjX608+T/MCmjkeslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777834;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=;
	b=fv0QScjIFanJwOaxmwtFjfQaycLLpKMTyqOd5oJ7oQ1vWO1aEhnW2PLarrItnT5QG/a7
	 YSfFj/1wcSCsbDd1dbtOsDJe/yMWK6mVzKxMMZQtS1v8dxNh7X9AGATwYJU3qACDICB7F
	 l3jnHboYZjkNVxlPuxQFce9o7Wd+njvHu1YI/U40+v9qmeA7BAJ/vtLYO3Vk2VR/70Nkv
	 5Cs2dhjz6diagBLWKBF6ehbuhcusyyMdMbOi/efagFw+nhmENDj14X/JktVZBVjyEWPKl
	 XNyl/t+n+kW7kIrKgHfAoAAxEhXhZ7Cmc2IRrVA50q7J+YhZSg9L5zfW3uh9yhigO/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BgO1Xsj6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5fLGN7uT;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60281606A332;
	Wed,  4 Nov 2026 07:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60281606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BgO1Xsj6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5fLGN7uT
Date: Wed, 4 Nov 2026 08:37:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793777832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=;
	b=BgO1Xsj6UVvItDbkKR7DF62E98m3dvPI+mk5pF8NY4o+sygzv3liHbPn/Ust4nPxeVf55J
	07JVZVihODGmN2UvZPK478aAbJJV2hgZY7BVd6GPmxVgpfWddXeaX4k3RuK6/ahu6l2cdM
	XGG5g92pz3A+SwsKc6iqsI9Eu2rScoYLJ5vyQ93H/GNpNb02pa3Ue3lohqDxmS37ho3Ty2
	dEt9LwD7oHSNcVVDAfkH7sgkRvfDZsUAayYsjaQMTqSablNp7Vl2R3MoopS2CoTeNz5tY3
	DEZbKWa6m+zH5nBZitr0ArTPZjbVItYaYivT4MbN1FQb7HgbWNqoSgpFPCZdMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793777832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5bZ2lIZiEkVoZLtojIf8IXJVOMItCBOSHoLzBHJXI8=;
	b=5fLGN7uTtzDfUk8Ypn+enBJObhEK8ZoIGSIFUdB73ea7ijV9e5PLm+s0K8a1alIwP+FdsS
	FHQOw+pSO+wEriAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <20261104073710.kTUsM3JV@linutronix.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <20261103163748.qDpZjKj8@linutronix.de>
 <20261104071703.GC28939@lst.de>
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
In-Reply-To: <20261104071703.GC28939@lst.de>

On 2026-11-04 08:17:03 [+0100], Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> > What about
> > 	guard(rcu);
> > 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> > 		if (!cpu_is_isolated(cpu)
> > 			break;
> > 	}
> > 
> > this ends up with one less function call ;)
> 
> Please avoid this completely unreadable and unaditable guard crap.

If you/ block prefers to avoid guard() then fine. I usually get punched
the other way around.

> How is anyone supposed to understand that above mess?

I can show you code where you start crying. Anyway. My main selling
point was for_each_cpu_and().

Sebastian
