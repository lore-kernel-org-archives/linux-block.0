Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D32F1FC7;
	Fri, 10 Jul 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696924; cv=none; b=iFVjUy0m+IVNfKUwYLBJNgZq9HY+O7g1WOiDnpqDr/xXotOLcIwl5TUpSEQl3Z5BqvA1lP6X03kyGwMsfoE5RwyoC3u1pIBzvvw7sOaBUORjjxR1gMnM2nQ6+q2aAcsjpynOHi7jdv+oL+Vr/8s/vMl6vmZegk1kEJtHz98mt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696924; c=relaxed/simple;
	bh=L8SZg1lBThqdL7xQR0M3sD0Uvjd2chAEnG332BBzWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D261HJ5FRfCPEEVolY+4Xg67BBe//5Mh4pVAipZBt/Wj9IdI42QDI87juEXBi7pz+jmM9eGBLZI9r25XQqfk49kSb00AiUlHfNVlo3wXvJwFXYbfBFM/+XSO4CTSBpJSXG8x7/JVmaIYhrDs7W1mL/bJMiJXGYZPbAS/eJJcJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGr9f4H3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxQDn4Om; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGr9f4H3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxQDn4Om"
Date: Fri, 10 Jul 2026 17:21:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783696921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaaY8U87ePxlXjp/pqAurhBDN/9c3JthtGcyh/SO81U=;
	b=nGr9f4H3tnykLjVlv7Apn5CURFsynW91zphErq3SnlHfxe5A90z2p4wFDf43W2wgzy12Tv
	pxos3wCwnsQYD6MbG00x+vhiDbezoTGTDJ/1LMyTuGZgkZ2FhHayfk03WCPq/xLkwSHGXN
	tMnVjT9EPmKcziG8Wg+0W7bH1ka/Ada1KgiVTrbS6QlHiB2Bm0XWL54I0UUHCkEaXHxJpK
	W7NGE/Nwd2KvLiRZeIhBksIxl+E2V0iFolkISJjuZVLrIvK3D5YpcHWrE6ZO+k+7NzyUep
	x0u3gH2T66WxmuyZhVsJEavdpK0VFxcCtb1eOzXodOqPijDSvvy18QAkaHmFcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783696921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaaY8U87ePxlXjp/pqAurhBDN/9c3JthtGcyh/SO81U=;
	b=pxQDn4Om7l24Mrri4XziQxMAp40YIwMW62KuzjOEBDoOMX4uT6YG8neSGtipdXFBS8WYwY
	9tt3ttYSMKC/rnBA==
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
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <20260710152159.Xl-dY-J6@linutronix.de>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>

On 2026-05-21 19:29:48 [-0400], Aaron Tomlin wrote:
> Hi,
Hi,

> I have decided to drive this series forward on behalf of Daniel Wagner, the
> original author. The series has been rebased on v7.1-rc4-100-g8bc67e4db64a.
> 
> This series introduces a new CPU isolation feature, "isolcpus=io_queue",
> designed to protect isolated cores from the disruptive hardware interrupts
> generated by high-performance multi-queue devices.
> 
> When enabled, it fundamentally alters how the generic IRQ subsystem and the
> block layer (blk-mq) map hardware queues:
> 
>     1.  Restricted IRQ Affinity: Managed hardware interrupts are strictly
>         confined to online housekeeping CPUs.
> 
>     2.  Transparent I/O Submission: Applications running on isolated CPUs
>         can still seamlessly submit I/O requests; however, the resulting
>         hardware completion interrupts are safely routed to a designated
>         housekeeping CPU.
> 
>     3.  Topology-Aware Queue Allocation: The generic CPU-to-hardware-queue
>         mapping logic is extended to distribute hardware contexts evenly
>         among the available housekeeping CPUs, preventing MSI-X vector
>         exhaustion while maintaining optimal cache locality where possible.
> 
> To prevent I/O stalls, the block layer is additionally hardened to reject
> hot-plug requests that attempt to offline a housekeeping CPU if it is the
> last remaining CPU actively serving an online isolated core.
> 
> The complex "top-down" mask plumbing introduced in v12, which modified
> struct irq_affinity and expanded block layer APIs, has been abandoned. It
> is replaced by a centralised approach: direct isolation querying via
> housekeeping_cpumask(HK_TYPE_IO_QUEUE) within the genirq/affinity
> subsystem. This architectural simplification successfully decouples core
> changes from driver-specific implementations.
> 
> Please let me know your thoughts.

I think I asked this or wanted to: Why not mage managed_irqs consider
this? Or is there a case where those two options want a different thing?
With managed_irqs you specify a mask but this is may not be respected if
you have more IRQs than you specify. This means the IRQs will still be
routed to isolated CPUs.
This option is intended to avoid any interrupts on isolated CPUs.
Wouldn't it be possible to allow managed_irqs to restrict a device to
two CPUs only and use two queues only instead of the available 64 or do
I miss something fundamental why those two need to be separate?

Sebastian
