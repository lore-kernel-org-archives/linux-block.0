Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589927;
	b=CBQ3Q4kKCRG9KGwrnDhOF5T43XtP++bIaZpelRoheb5kcUpwc8FvQg5dCaPDPOeqFyxY
	 szVF2KIK+ZKADoDWo5vDwBynfeHLiB2N8wUMN5ss7GkIuTBGUSGl2qK2v9hbqg3CnhZZB
	 EF0ZZiol1fM0MVZS7i8o0tETi2+zmdWpIwQZqx/l9Yryilq/IWub5cqwAYMsBDz+Qrsup
	 wyTjnrXRfoVxq6HmKNsyHj4VOYQ1koSBpaU4GmsfT63fV5V+6Bdgp+GyYFU0jbMx1rL6s
	 0N93g4pZIFuQ+oVE//ZPAE0AVxVqLXQaNI0MVmy8qk4s+2QqR44gWtAhGEUuRgz2uOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
	b=mYxDEHiBrCtMRHqr8aDxTomDmM98/vU1Tult4nh71bbFD3qq0uq3fmDtLtsfotaBgz0e
	 Tz/DcbH9fV8SoS4/KINcorjU1RKMDv2wFXS+ULcJXKvQYUovjXMbdAuSNUBsbJQAS+6Hc
	 Cci05H8/zwrm4G5X5RAnCN1Tjw1fr/wzrIBPmXUfBD8Qn3Y8Yq8et+uRP+9y7wljBJctL
	 C0GkHa3LrWeYAX5+r67ostGMkKpu2MCZrATZz/LxNUSGFp6VAtfyBWHYi5SELDBcvxWsg
	 /B/+9ok2aDTJHBHLBe7CG1Hv9qU6gHpHXOfxyCfjngQPTR/5iFOkG1dPTHGxMGYe80w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXCMSsEE;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B1606A31A
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 13:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 075B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXCMSsEE
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6798d4ab549so696712d50.0
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792589926; x=1793194726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
        b=jXCMSsEESFZVjdjzfNi/bSWJKOk17XHYGmVTOCwIqZR8IXFZ6JaIxgj94S01mE6lUN
         kq3GZopQP4XE3Aac2PnfcyXRLRPRbsLLJlSf0T32r8vh0qDFMoYAopIX+TKjG29ZXM4Y
         zSN3qBw5x1XAQ0jrz5EGFddq+djTNyr7mu+NuNf3Ur43I54hi5uxGp5PO8CHc3EHyN2D
         0y82te8fXM447P4Sc40m4ZsRGzrgXJrH0EneZrcrRHAfmJdkkg5hVh0O0HidBJREB09b
         ctxtwOFsO1hWk+J6+BL8H+WgneHn54rwRdrGbnWvyYGAgknwA5yY1RVuSI55SmggxVAX
         8U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589926; x=1793194726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
        b=f370NQu0yLnjIm4/9mKnG4PFF9WIaQ0wDutifnP/eg1+/Xi9g0jnA1+gblUzJNjnsQ
         nWIWKgGcvspR2MU2HLDGNk/VjSoYzrlH9VcXoBk8UP9LvDrug1QsQE9wGp1CEQQjwdm6
         axc3EUoOPhvq+D2nZLpt4b14ElhHj0uxY4P4KJzbHQlQPlv12vAG+RVH3V4kB+CQpcto
         RtsmoSgc8wBiPK72GYKfj60ZPI9+iMDoW5KDAKWh4OWN2RMlNoCv5lypbkUbowExyDCR
         BqqZEyc0KnhD0387VZNtmiOPdf/tD9OkWWm4JOl6hlfNJ1nr1nXnIvIUUpsr7MQplvba
         pNRg==
X-Forwarded-Encrypted: i=1; AKwUvBzgP6UGi0pmWcKygDLYzwUhjXw7P6FRq2FI2WBzrSA7U1vP2u6h9czFES7+1vWYt6PeVYRHMkbJnomgZw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKN35ULA8NZGH8z38JcfFYeIixZyViTmFyENYcSZGhulLvkZ58
	m+LjlBpexNgJKwzEfDtguXt53N/KnHpYq+Zul9463/ON4MGIg/zpXoen
X-Gm-Gg: AYBFou3Q9qvN32K5SfPkeC/jRD5WUxzHyKU9OBP+QaY9b83Rc0aGvkVhAsdd7uBlwMJ
	srVgGrXLzuHYhXeBYym1xMabIVE+47WCVDdDSrIjHOtF96MzfJe/RyUmQ+tg0gJkM1M0opQxVqZ
	Cj7Lj4xh2fSR3TsSbBBYqCIsnu6lMxitc+k95Cmpk1qxKTKFf+ieNl0g/JhqwFGPxcFA+9fGcrL
	h36tvtogwoeMS7o9PoEclTJRyDSP11zlkXyVh34275uBS3i3qTzx0P7KMgi6onIYEUOMFtYcc/x
	VIiGsxN2vahxb2jlWwpsdfnA1/86ef2x6d94Ll+5BskdybZhc/oFdVeoR7sqXuHpjI0TzxZ/eOF
	0AZGuZOqMvOYgfavap0xqDeMotJ0cdPP9IjpQ2CP1ZIfTe7fbML1VcGvyVlNP6u6iGqG42momrg
	yZc47hobuIhVRx1eQJTHmYZvrGOQhKjXkcXSxJXRlHfeHjJqcY4gsOhxtBKbPpeswFxmMyK3aR6
	K9jxBQWaNgKYxakh2RyQBTqO2q63bm+lAxOfDCZLPJJDxutO93hOr6kapIQUAxPe20C/bU25imF
	KZhWuanBI8akjEwXpHsT4CKA2y4pwe7XOFLr2mofEdVhqi9Qd04Gso+vDhfQMg==
X-Received: by 2002:a05:690e:d8b:b0:679:bf13:c01a with SMTP id 956f58d0204a3-67a0ddf103fmr945125d50.0.1792589925959;
        Wed, 21 Oct 2026 06:38:45 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e501c01sm1052477d50.15.2026.10.21.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:38:45 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:38:37 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, dwagner@suse.de, frederic@kernel.org,
	tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <atjAXSTH2aRligiA@fedora-laptop>
References: <20261016052203.489760-1-atomlin@atomlin.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016052203.489760-1-atomlin@atomlin.com>

On Fri, Oct 16, 2026 at 01:22:03AM -0400, Aaron Tomlin wrote:
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
> 
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().
> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay (e.g. upon
> hardware queue congestion, tag/resource exhaustion returning
> BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> the local isolated CPU's worker pool. This causes the local per-CPU
> high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> in addition to introducing unwanted latency jitter on nohz_full cores,
> thereby defeating the original objective of commit a46c27026da1.
> 
> Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> cpumask_any_and_distribute() when executing on an isolated CPU, and
> otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> unbound fallback paths in blk_mq_hctx_next_cpu()
> 
> This ensures that:
>     1.  When executing on an isolated CPU, deferred queue work is
>         cleanly offloaded to an online housekeeping CPU across single-queue
>         devices, hardware queues with empty cpumasks, and offline CPU
>         fallback paths.
> 
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled, avoiding priority inversion and latency jitter.
> 
>     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
>         preserved, maintaining optimal local execution with zero CPU
>         bouncing.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")

The current code follows behavior of schedule_work() and other related
wq APIs. If you think it is wrong, care to fix schedule_work() too,
otherwise it confuses people, IMHO.


Thanks,
Ming
