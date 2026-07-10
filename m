Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F22F99B8;
	Fri, 10 Jul 2026 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696461; cv=none; b=LB4cT9w2chF1VZmYxtRoH91HFethuK4ze+5EyKWu+YaBKyfRfK9i3+lm2NjlrJZAuOGAMpGDe8+3CWk6KYA7U01ZgeyhjChsN15Ab3WLvpw/m2MLxdt3B0/xtuuzA00TGKGgn7j9pkVr8l66lqql9QpJB7oFw1xYirpgZqWIPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696461; c=relaxed/simple;
	bh=H2e9Sa0yI+gI97I2wiKSZ89w9hJMwf3GzylF92ZHRq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSlC9WwTyJBnM/WaSPJhVm82lb2q0lt4JeQfgaEARaV9r0LaJ2/AZRuN03OJiDmmGd2Kbix030hEGIVfAd1LQrs0uoXqhJ/uw/+9tZYxk07zfCDy/nIP90bKQTHxgpFrD3nFsjPm6FBPAeF/VViOAAEKLGESpsyF8lCSd8vjA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CzeX2noU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27VQu9Rn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CzeX2noU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27VQu9Rn"
Date: Fri, 10 Jul 2026 17:14:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783696458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqsE5p9HjqeLbaFg5SLX8DvlOVL0+0pYsT5UlEYujaw=;
	b=CzeX2noUayUWRot78+xGtjCuNSN+8T7x3q8ebhXMWwxe2G3aNU4u+X26EraZZVQmQ6se/+
	ARgwNpT28Uv7+Q9QMY8qI8tDLFBO0RBdqZcBu+0amY53LxTbLZz4coUGF4YzNSux4o/cEE
	wOHeQ8HlOTotVvDJhA88s2kkuA4BP3I5Mix43uXTavQOavZbDxJno09UzhTrEXn8iYRbff
	kiiUO2ftha3OjUw5jjhQ6F9pEAemdBOnX+oBHri9BkhB/0fSkw2qrVMFrILNQCY/xmA+/D
	lzTBDHA5+ffRd4SHgs+IaPQhLYFIfjtuPjsLplCjGC9srfszBPyeVujry+j7FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783696458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqsE5p9HjqeLbaFg5SLX8DvlOVL0+0pYsT5UlEYujaw=;
	b=27VQu9RnIgE2r22wg9fz/ZiVRV7R2GywEOQifcC/bQHzYygdUyFMG0LobgZLlcD8S7mgqv
	uSeQ/6+Comhb08AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, hare@suse.de, aacraid@microsemi.com,
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
	longman@redhat.com, chenridong@huawei.com, kch@nvidia.com,
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co,
	sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	nick.lange@gmail.com, marco.crivellari@suse.com,
	rishil1999@outlook.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <20260710151416.uWp1vZmU@linutronix.de>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <olynqvtm7faqrw3qc2cwvup6vj3rqrr7acbagrgxn5yly7vlpz@yszlwd7afjak>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <olynqvtm7faqrw3qc2cwvup6vj3rqrr7acbagrgxn5yly7vlpz@yszlwd7afjak>

On 2026-06-17 07:01:24 [-0400], Aaron Tomlin wrote:
> Hi everyone,
Hi,

> I would greatly appreciate it if anyone has the bandwidth to review this
> new approach. Please let me know your thoughts or if there are any further
> refinements needed.

I assume this is the latest. If so I would try to look at this next MON.

> Thank you for your time and guidance.
> 
> Kind regards,

Sebastian
