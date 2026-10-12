Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D538AC90
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770181; cv=pass; b=TmkthCWhYrAuhsyDQTQktqGgsNEEblFGsM+pZVrhT9r4j6Pp0nYTH0kCK/T8whroqQaVDHrI7DpbuuwZAm5OgaBQ+B+T9eYZd3wroNrOHgvsGsAOPuxzu4mpXZqq5hP7H7YDlKo23dUwiZtLgW/RKufwGZ4ddh4dQDTS6EJTa/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770181; c=relaxed/simple;
	bh=ItBCubvI6RrUGFR+jychln1nrX1byTfSLBkItkPeKgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgAn7Z1rV9zqul6V2Yo1TcUxhWjl3SDSQOttR7V+VmHDFsV4ycL3QXgXp7QrqchbzFtoKV+4JJ2XQuORdfhbUCPsK2AMbmB9pp07flVMPlQidEDKfJTN7HMVWLLLd364Uqw3hB8DTFcPrSRz0XbNaPoE01PkSY5HIIlcdIiSdCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+EJpkeh; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+EJpkeh"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f5e6517982so479208b6e.2
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 18:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791770179; cv=none;
        d=google.com; s=arc-20260327;
        b=dWjpC1zp4VYiqTAsmpm3/zZmyDyqx+5WwkjhC0F+FUF+4aZsltQcTv+dYq3fNSpXEh
         0MmIm/oSq9HohXcm4OtqNmMxWUa7bpjy5ZzeTSDtzR3l7fHKytJ0LPlFZ6ANKhZIdbkn
         LHc9ZHv98DiDzhKUej4mcq21+cXiphBJAfI4nVEpu4wUuxFv/Maar4W5nFYsv4eldYEf
         5jSY7oUB9Z+p2JdL4rBGStwA4N99FzyHT08YhSsmsOvPAWndrrObJIQQZKE4bJISQGnh
         BONXCmNclrOLQjFVYGa7zaFao+yA1PcPkm+SPBfI1bbOrGkRQ/Xglb3skWJhy1De3c1R
         gSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        fh=2mPgttz37EQehFzml+vJJUAuzhg95zN29G6CT4Ruxgg=;
        b=VOrUv/BCITD+gzrDbkpcgr72pLNZXhs1P1jkg1MZ2ErxQ3mTg2tBjx8U0kuwimS7WR
         vhSrazdl8jWg8a8HVZqrNJnX7ST/zDSrA2UWuAF/DdeKDfOLFWiKcnH9gj4IcGVrv8xg
         r0uDTqTLWEjW+FnHLPOCdgWv5df9vF9k95N22p7Sv5qc/su7RUqxDOvGvXroDchimYoH
         Q54ExpVh9UxSkq1eM7cHeky0vS0+pI8KT5jt8hPR1305frGX39rVZxHk/VIDHSEqKFVn
         2b5SSyH1sazZ302ZrtLKMnYMLVrWcb7me/qH9IMIOeBxYVJSC33gyz2jt+zDaN1RAnxb
         LRKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770179; x=1792374979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        b=Q+EJpkeh4PUr02R/B969/LmQEtKTNZggJUld4ol8shbzvOMiFOApEn9BsLNJ59JBsU
         ZC3Z9k1+QLhTTwqMqry+eC+D+j4HiDviG7OC3b+M8flV+nMY3l4LDoFaCV8g+RL1P591
         d3wIVClDgky8LlZoVmgSEKHVn/fjhZCqXJ3esijU8WUUlVyzz9yxhGRLceXExjSlJXtL
         Is+Cvzuqr3vG6n+T5pYAR0zGALv+ruT4jVbDFetaQeFiOM0dT0gufD0uri3XuKdV+cDZ
         3eV2qdBbe0PoSth0DKJ73NdkoZSgt7xSnzF/GCTNo0lEJIvrTvDRP/jiVB6Kin6GhfSc
         tS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770179; x=1792374979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVDLMccIAgoQGAe8a9PiHLfmc8KenWgKbO4m7BVbc5w=;
        b=XJPjDfpZyz7g+f57oqNVkbd6BuOKpUDZyOvMZQAAWuT3bRbNVhZwhMAsth1mq9IDZi
         CVNgffZ4siVm6NiBKTmcrN8ldfn3vHJ0/ZaOOudRH9NbUX5mqq0EeSE9840YP98foEAo
         naItc1ZCPBa+1XBuWwYYPoLkVmBDLq8IzCcJKW4gleSvLO5WfqlwJlSVyp16et/4HuTO
         4Sg3NBuqgHZqbaj88SrM4CGX3KobwNJQa54ZekdXwhId+cD3UIYkc79Mol07F8jzitwJ
         UtZz/6u4f8Nb0O6ZnM/zuVuVzWSHk5qwd+JXmzpntQQOZLvXwysQmM1E5gKfbuhOXSyY
         3nHw==
X-Forwarded-Encrypted: i=1; AKwUvBzTkS0EFDZrVs4GxO78bHVu6XG4EONsFxMjO8dz+vRKyIixGSZsK8q6lsnjCXqlQy0HHGzgZdevyUXBqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJh+wzElO+qc2qk9/vtNITiN8bmSGsO96dqDHRc2Gna0/0zPjrx
	7c6DPezP25B6gDVLnViDTHbH8FVTc1mLkOBx4lAxqfooESbd/8T6HP2dUbAGTJ61iuVOsy5PD6e
	cxh0n5qfH85p5edj8ePXw/dZxmsXDh7o=
X-Gm-Gg: AYBFou3SUhFcBLU7oXqsdwQqIZFfuFaMe3kOj+reF1WDmeDq3jgo0RqFgpRaXb1J0IG
	RkbRYRsVN+YuQghHqTLW3IjKyWiu6kTrRdmbsQXEOAmGWV9j6YBetFRD57PSTpRo4AU6k8I1JUH
	ClKY8qpIozpX5kCgtZAEYCEhKTSztVSPROlHEFsuTTic3a4C36sWX7Nz5HuDuSYBfkU5lPrHFiV
	062xnUtUGaBF11duWAu/tYh1cyIe8ypol9ITyFNp5Ii/83VuXqLUHCP/dBYA3qm0dJIF+fTx1ll
	+bMZRN0FjVSdUYdidsv6T/83FFL2QiUQ33iDzYvQH6Kdv9t2XV4Lox6uSe5EiJHPklfgoR2u0Hb
	5XR1mkye9XfrhU15cIujJKhmigM7+fu3SBnP/Qu8PF6zjDPc+N4wrAdw=
X-Received: by 2002:a05:6808:318f:b0:4d6:92b3:5c86 with SMTP id
 5614622812f47-50c58710420mr6758060b6e.67.1791770179315; Sun, 11 Oct 2026
 18:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012012905.267920-1-atomlin@atomlin.com>
In-Reply-To: <20261012012905.267920-1-atomlin@atomlin.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 11 Oct 2026 20:56:07 -0500
X-Gm-Features: AclHuK-0IDhvx-vXBL80m0PiQwaU3cgV-Y37jAMo4r-4F6vwZ3d7JdKF22seZMM
Message-ID: <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 8:29=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
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

Then it looks like you need to fix WORK_CPU_UNBOUND, which has more wide us=
es,
if you think it is one problem.

> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
> is queued directly onto the local isolated CPU's worker pool. This

If your theory is correct, why do botter to change to
housekeeping_any_cpu(HK_TYPE_TIMER)
if the user is submitting IO from an isolated CPU?

> causes the local per-CPU high-priority kworker
> (e.g. "kworker/6:1H-kblockd") to be scheduled on the isolated CPU,
> introducing unwanted latency jitter and execution delays, thereby
> defeating the original objective of commit a46c27026da1.
>
> Rectify this by selecting an online housekeeping CPU via
> housekeeping_any_cpu(HK_TYPE_TIMER) when blk_mq_hctx_empty_cpumask(hctx)
> is true. This ensures that:
>     1.  The delayed work is cleanly offloaded to a housekeeping CPU.
>
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled.
>
>     3.  Hardware queues with valid mapped CPUs preserve their per-CPU
>         locality and batch round-robin behaviour.
>
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CP=
Us")
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  block/blk-mq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..9480c3aac898 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2252,8 +2252,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_c=
tx *hctx)
>         bool tried =3D false;
>         int next_cpu =3D hctx->next_cpu;
>
> -       /* Switch to unbound if no allowable CPUs in this hctx */
> -       if (hctx->queue->nr_hw_queues =3D=3D 1 || blk_mq_hctx_empty_cpuma=
sk(hctx))
> +       /* Switch to housekeeping CPU if no allowable CPUs in this hctx *=
/
> +       if (blk_mq_hctx_empty_cpumask(hctx))
> +               return housekeeping_any_cpu(HK_TYPE_TIMER);
> +
> +       if (hctx->queue->nr_hw_queues =3D=3D 1)
>                 return WORK_CPU_UNBOUND;

Why is SQ so special here to keep WORK_CPU_UNBOUND?


Thanks,
Ming Lei
