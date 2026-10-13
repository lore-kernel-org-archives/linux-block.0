Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F23EDAA3
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900477; cv=none; b=mC8/emJFGx3aO/Wqj4DjAXfBcItwqugl5ik0Fwh/6bAmEpuB4pgr8ymzRhiBLodiHbGMJO6TGBZCpFA2jNvjKWEgfT6Fe/NuCm3v1D3jYViTETkb7Ix47r5BVT2L7EDHQ0JBFiUyzavy9jc/mhekBuEJuubIN3wqmH/7pjLUdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900477; c=relaxed/simple;
	bh=OzuAp0rlEJdsfQomS5ope4HzayW0l3aekZR9Acx0XzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on/lwToBykEU0HBbRKh793PUbTwaBP+2TvMVH6EJb5oDORuD0BQ5Kwx4EStTZtvk+3v5gZRzAV7SsDCc4DKhc8ghG2gLSXHE21y063hrj+LUMbkHwbW7q7odBseHMCLvQ4JBpxasHlhLns1jhpzsOlpipX8DysWbbzkGOzqTfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUk/GI4W; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUk/GI4W"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82374c2d7aeso2215437a34.1
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900475; x=1792505275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8sNOFg4Wj9OYyKeIVnikxJmvj26NKKSzvljXjsvUtTY=;
        b=BUk/GI4WpKFi1kxDhm1sTBlrEmU1Co3SCKtDsEDF/5wUMztCOSMxHgUVwS43gvXJnP
         OxUTyaD8xK6TXM1Xwm2ICoxAvtfq3YSBN1XmMvinoJKhhxLvVBdGchn3QyKelCtGVzy9
         fiNNvfXTTwnsGRtUSWVfyKrhL1q/i/UjrX0KnVlhLFCpEvCTGzkRY0xYAKDAdR3fUpCQ
         OoSIKPhgvfarvqswKWvSs2SkZ+Cc9CcyhFt9u/6u1TyjRpElE2K8WqFVb3gtiY5qVZdg
         ip8PJKep9E4oQDFly2RsT3VvvOr3n+QJSj1rDVw78Or0oaVFunzBdXkO41FBPj0lDbKt
         c60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900475; x=1792505275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8sNOFg4Wj9OYyKeIVnikxJmvj26NKKSzvljXjsvUtTY=;
        b=isPWt4CHfhh9rxj3d4b0waoY23lTNu031KL5M+WPo5J2Zk4m+uixJk7Q/4Bf7Y4Dym
         /jA37scWgEcmgMbJJlfJan6xKA+TGjsqYHOKR2R1LKiWcLECWhVLttlwbKnLVqptQmXk
         AwsmlQSlvBTKi9PgiCJdzaFdC6l1ywiNjrZUV80T7+Vf0ymgR9wCKLqVN00AiCrkK2Cu
         uGFTqyhEQiCCNs5wXAvh6/ugaF14TVhbhJ1w/akMc3LmFHyK7kYzjnJRdkhPp4pMpwp9
         A18kGpY3smts5gvZd2e6JE7PT6+XXTjXn1evuauHO73Y24gqybpvibY5BZ2/W1t57fw/
         2aiw==
X-Forwarded-Encrypted: i=1; AKwUvBw9oVpT7JZC45c4CHK3M2zPmVG3rJyRNIbOjcheEYMexFhF6k8zzg8qIwf/wsd33XQLl1HtjDaznchvNg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLFnXCoLuFfIjjpVISMCQulE2UzJBEwSUMghJw3EJ8fhITIMWOH
	FEzapxP3tGDW4GaCm9JZp9sFQWHnsyZtEQzO8FACbGvaxObLq9AMMCUi
X-Gm-Gg: AYBFou34GlBqRhMhXDUX2DCu66HVcVJyulbnB95DN2XK5Kgv8aMFnKOhyLMWyN5Y4MQ
	hAARqTGA0DmW6lyyjDXKctrHMNZsCm6oZ4O3CRkUek5VJQQhmHDvZPfM948re4KoxV2ZKtbzXpq
	o0AGGG+ejINHlVbWwPWqmTX5NPuM6f7wagLGkseVc10tu4XPfLhfNVI+qQjVLJg8LdXuSjDeTBl
	iRPh+PlW+b/DqRBxm5erKT+BzPssy4oysK0k+9taxQksfz3utJBCrAtdldBpEctIIU2xqZycMIv
	Gghm7Mog/4vrR0rFEfpQNkEm2d2zbS1F7uSKAiFWLtNdPRxrdTdMHJmgOCvwXYj4nr9K06/LCsc
	Ciq9ZxdUqOdom3v7o/lzGGKrBwZIjGqhYaJG65+0EB7MCz4Cd6dByCM68z5QABUuuEb9NqMA/fD
	z+6E667hLsgguImLBIShyEoRlhsGoPZ/VAPD1a7k1FWA7B8GZSuVHXbsCia118mzX2GvTTrRtMI
	K/LTzx6mvRhc+emhElbwT0sJl4yvvJpE72imkCCm/rB6E1lOpUOVW7LdHqCtop9S70r+TNhkS15
	kTI=
X-Received: by 2002:a05:6830:854b:10b0:839:c62a:1661 with SMTP id 46e09a7af769-839c6398053mr1807548a34.7.1791900474853;
        Tue, 13 Oct 2026 07:07:54 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm12646295a34.18.2026.10.13.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:07:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:07:46 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org,
	neelx@suse.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <as47Mma7pksi_i9C@fedora-laptop>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
 <as4j_Zk7zcNsBuo1@fedora-laptop>
 <i4xh6jsm222rtn7pka57fuo3scelrlzywrvq5kor5sy2jjlrmq@tkqbbrzimfrd>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4xh6jsm222rtn7pka57fuo3scelrlzywrvq5kor5sy2jjlrmq@tkqbbrzimfrd>

On Tue, Oct 13, 2026 at 09:33:42AM -0400, Aaron Tomlin wrote:
> On Tue, Oct 13, 2026 at 07:28:45AM -0500, Ming Lei wrote:
> > No.
> > 
> > For example, schedule_work() is queue_work_on(WORK_CPU_UNBOUND, system_percpu_wq),
> > a WQ_PERCPU workqueue, so every schedule_work() from an isolated CPU runs
> > on that CPU. blk-mq isn't special here; this is the general tradeoff of
> > submitting IO from an isolated CPU.
> 
> Fair point regarding schedule_work(). I concede that mechanically,
> kblockd_workqueue is not unique in accepting WORK_CPU_UNBOUND on a per-CPU
> workqueue. schedule_work() indeed directs WORK_CPU_UNBOUND to
> system_percpu_wq, which resolves to raw_smp_processor_id() within
> __queue_work().
> 
> However, the crucial distinction lies in the semantic contract and intent.
> Callers of schedule_work() seek local (or best-effort local) execution;
> there is neither an assumption nor a guarantee that schedule_work() avoids
> isolated CPUs.

Then you admit the same generic problem, nothing different with blk-mq.

> 
> By contrast, blk-mq has an explicit architectural contract to avoid running
> block kworkers on isolated CPUs. In commit a46c27026da1 ("blk-mq: don't
> schedule block kworker on isolated CPUs"), the intent was to deliberately
> excluded isolated CPUs from hctx->cpumask precisely because:
> 
>     "blk-mq kworker shouldn't be scheduled on isolated CPUs."

I am pretty sure that the pre-condition is that IO isn't submitted from isolated
CPU. You can send a patch to make the point explicitly.

> 
> Furthermore, blk_mq_run_hw_queue() explicitly honours this policy:
> 
>     if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
>         blk_mq_delay_run_hw_queue(hctx, 0);
>         return;
>     }
> 
> When executing on an isolated core (!cpumask_test_cpu(...)), blk-mq
> deliberately refrains from inline dispatch specifically to offload the work
> asynchronously via blk_mq_delay_run_hw_queue().
> 
> When all CPUs mapped to that hardware queue are isolated
> (blk_mq_hctx_empty_cpumask(hctx)), commit a46c27026da1 added:
> 
>     /* Switch to unbound if no allowable CPUs in this hctx */
>     if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
>         return WORK_CPU_UNBOUND;
> 
> The express intention of that change was to switch away from the isolated
> CPUs. However, because kblockd_workqueue is WQ_PERCPU, returning
> WORK_CPU_UNBOUND inadvertently resolves to raw_smp_processor_id(), queuing
> the work right back onto the isolated CPU that blk-mq just went out of its
> way to avoid.
> 
> That is why blk-mq is in an unusual position; it intended to avoid isolated
> cores, but relied on WORK_CPU_UNBOUND to achieve that on a bound per-CPU
> workqueue where that mechanism cannot take effect.
> 
> > You already disturb isolated CPUs by submitting IO via syscall in this
> > case, so why does it matter here to dispatch on same isolated CPU one more
> > time?
> 
> There is a fundamental difference between synchronous syscall execution and
> asynchronous background kworker execution:
> 
>     1.  When an isolated user task issues a synchronous I/O request (e.g.
>         via write(2)), execution occurs synchronously within the task's own
>         context and CPU accounting. The application remains in control of
>         when this overhead is incurred.
> 
>     2.  When dispatch must be deferred (e.g. BLK_STS_RESOURCE), blk-mq
>         queues &hctx->run_work. A background kworker runs under
>         SCHED_NORMAL. On isolated cores, workloads typically execute under
>         real-time scheduling classes (SCHED_FIFO, SCHED_RR, SCHED_DEADLINE)
>         or tight polling loops. A SCHED_FIFO task executing on that core
>         will completely starve the local kworker. Consequently,
>         blk_mq_run_work_fn() never runs, hardware dispatch stalls, pending
>         completions cannot occur, and the I/O pipeline hangs indefinitely.
> 
>     3.  Even where starvation is avoided (e.g. via the EEVDF scheduler's
>         Fair server or cooperative yielding), queuing bound work on a
>         nohz_full isolated core forces the scheduler tick to re-activate,
>         injecting unwanted jitter and defeating deterministic isolation
>         guarantees.
> 
> Steering deferred queue dispatch to an online housekeeping CPU via
> housekeeping_any_cpu(HK_TYPE_TIMER) sidesteps these pitfalls entirely.
> The kworker executes promptly on a housekeeping core without priority
> inversion, hardware dispatch proceeds unhindered, and the isolated CPU's
> low-latency domain is preserved.

Any user visible effect? Both are a piece of code running on isolated CPU,
the choice is in application. If they want to run IO on isolated CPU, we
do it in same way. Otherwise, we won't schedule work on isolated CPU for
respecting the kernel interface.


Thanks,
Ming
