Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DB31D362
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773494; cv=none; b=sEQdMi0X/9KebTR3xy6RhX6f1Fjk9c3scNC/h6bg+MVTLpZHsNHQg8smmBzm/PrFR1xMtG6D9o9H2PPGPiHcVPqf6c021i/6Tr2q0v3cDwPmYSq/D7Fn6hcFsKuH1e2VF0tiaczP1Rn9siT9Xp3XDfGmv+gUqLZZhvChwZo2MDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773494; c=relaxed/simple;
	bh=Sww+UUx5AYubitoQIeYufXbeUtumr3OSOSv9MKMXWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9DTMrdJiGXfy6PFs2UTqL5gvQxNFC0PFOkYMj17s6AXSbr0P9iI+6nUolZCUvc3trlF9WuXvAf2u2cQ+TJmhWNCED4/ZfJhpYMM1b9rpExPn3HeyqCP5ZpI857efYfE8mIB1+wn8hYagYfqXDpBOj2b5cl+Nr8/CmXhC8GvagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwCYtSxe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwCYtSxe"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-823545ce223so1257402a34.2
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773492; x=1792378292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDR1U1wZKI643QEmYiqX+7ava8dEd6FhSZ+FNDoTc9o=;
        b=AwCYtSxeZEfR3S8BjBjSaqNqHJz0bpVqLe9oL5X7VXDrYTpF2GDp0p+ZxbfEZGSEXc
         rWB0xlELxXn1TNUnytBZrKDwqVw17hbYlUwL2KFEWpcLk6rApgWl4+yFAQVRPKdAO8wB
         qxEUGaWvqvP0uHIWdt1LOHCS1v0canGlx4ijT28HSkYzpNXaXWMD/fRPYHQ+lQw91Ee6
         RMZTwhRvC9KBp+YycehRQESwEmiADt8qCdT97j8Hb/j6LtI5G/nL0K/4QHWcleOv/ban
         olrerEHDLhHFxhX8fnNgWXLELlu5zPKLaUJYY7NZctlCyBYZEQITr0Y4c2/QbgGsaTnc
         v92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773492; x=1792378292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hDR1U1wZKI643QEmYiqX+7ava8dEd6FhSZ+FNDoTc9o=;
        b=HiJNMIqgnazfYl8OmiKS8NHag+Rxe/cWw70BA/05g8K9K+0/TOP7wNMDO1HRvJ9Ztn
         uARojJJfxeIeBE7Fz90yPSm0UL6TO+WIq7EOxO65YQPR2hN6ifjI5IVJAHVgzCJsnJN6
         sIcIE0ldsVAdCju6P+R5FuhmoqWIbbJjjwFfIFVtUGqj71PcY4tieQ7DyTbPm+4BxzCM
         HCUeIuecZmU8DgUfF8iMBinCXhmYyYncg+eC9FEcy0xu6bdRc757jCnEpcPI6Kn8nr1s
         YqdP1KjPFvzMCmFD9cUBjmYDzcqCQO8/sHprZKksWY6isG6mgvRsYI3cLIuEv405jzom
         sXKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTQElwqKhGe7EBgMH/HFb4uIihrNubEjql1f8b/WYnz5fNOt+LvJ2XBkJBHENXX0Nx+ylZF7AdbW6Syw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7ze8V6mYMooTNH11dceSI64OnHDRehDFmDH7wHa5IH95kQ2vh
	7HHoemY5Ekt/4S8djF+/+B9b/8qUN5mnVjXRwV9pBMV6Kz9ugtXA2lpU
X-Gm-Gg: AYBFou2LVVWVBLhnLtJcMZc+2d/HihIYGbkd0hQNTLw+1+69McwzaT5WBv5QKjR/hIv
	Ihcj6e17rcWb4cjk1Pgo9dVZtw+KeGedHq0vZtxVdMuZegnRzFraDkYiXZ7OQRyYZLcl4xh7YRA
	DTyTdGz5pZKOnuaG9hJUwYLTEaystwXoeJbYd01lJHf8fisXmrCz3AZWMt5Wu2jHFKMLjEWUOVb
	hn//mLexTBcJdA/ZtlytbyFYw7afPKbPSo3px60rxDfb0jEX6FiZT+kQt75GiY6hFsHkRoYgU+u
	i8KDnvwt6viUSczsD7uGmuYPNP8lA+VtDuQp1jb1YzcqHhmkKbMVRrFYfMLMSxgQHXnJwU9eS1W
	bsvGhHfrBAV388F3BBauVOGNy/FAlzXqao7QRN1QVxddjHXesqobemtgEdrEmKpYVr5wXKwD9pD
	0m02TiR+nIpB+MC4hEh+bZjOv2nc7n2aocis7s5k5PgGtWHkNxhUck1ApIlx8XhBeMFQgM8jVMT
	NM1azayCDliqUROf1DJ0Cihf0bkA+52yA7cpfrxugY1b2qBZEx5pVyTwtwATRlAWlwP8iZFru/W
	5eMfIFqdCLT7hg==
X-Received: by 2002:a05:6830:673b:b0:7fa:ac4f:79c with SMTP id 46e09a7af769-830977800c6mr8028072a34.24.1791773491871;
        Sun, 11 Oct 2026 19:51:31 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e016sm8539170a34.17.2026.10.11.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:51:31 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:51:25 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <asxLLWOQQzolER0a@fedora-laptop>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>

On Sun, Oct 11, 2026 at 10:21:01PM -0400, Aaron Tomlin wrote:
> On Sun, Oct 11, 2026 at 08:56:07PM -0500, Ming Lei wrote:
> > On Sun, Oct 11, 2026 at 8:29 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> > >
> > > Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> > > CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> > > threads from executing block work on isolated CPUs. When all CPUs mapped
> > > to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> > > evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> > > the intention of offloading execution.
> > >
> > > However, kblockd_workqueue is allocated as a per-CPU workqueue
> > > (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> > > workqueue core resolves the target CPU via raw_smp_processor_id().
> > 
> > Then it looks like you need to fix WORK_CPU_UNBOUND, which has more wide uses,
> > if you think it is one problem.
> 
> Hi Ming,
> 
> Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
> to provide a non-isolated CPU when dispatching &hctx->run_work, no?

Does every WORK_CPU_UNBOUND user have to handle it?

> 
> > > Consequently, if a task executing on an isolated CPU submits I/O and
> > > triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
> > > is queued directly onto the local isolated CPU's worker pool. This
> > 
> > If your theory is correct, why do botter to change to
> > housekeeping_any_cpu(HK_TYPE_TIMER)
> > if the user is submitting IO from an isolated CPU?
> 
> I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
> architecturally necessary and fully aligned with the rest of the kernel,
> no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
> defers execution to a background workqueue. That work runs asynchronously
> at some indeterminate time in the future, long after the thread has
> returned to its time-critical user loop. Having a kworker suddenly preempt
> the thread later is likely not desired.

We are talking about `if a task executing on an isolated CPU submits I/O `.

If the task has been submitting IO on isolated CPU, why can't we keep
scheduling WQ on isolated CPU for running blk-mq queue? I am not sure your change
makes any difference from user viewpoint.


Thanks,
Ming
