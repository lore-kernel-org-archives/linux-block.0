Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DD4F55DF
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894538; cv=none; b=KAzetfaHk1ROHQ2ubdBH0KawRtPLd93dBOb66G/ZR/3Ux2f4QSG2rVhSbb4feHc5kO6y1cKR4G8fBSg3Z8MHawm7ZcGQ5SXCfsVx64tGMsbshh2UYKCggOBDjgHrbNKaHXp74+iWa8wjBV9zbF9RCPpFMQYKoHonIDdSD58rC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894538; c=relaxed/simple;
	bh=YveNTi8ah6bA5pnf4dMIhjxq/suH8nT/i2ueA0M6OQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ2Ddf7fVof58Fb6UX1Uz7dGIudjRc6+0Orsj9YStuUECP2rz+tQxn5FxYNaY1+aGkApyMUBxP1Y9XjyJpc2s5lRDvGhgwFn7M8eEo6YrS8h2hIsq6rzvHb89+HvYySL12yzBnFAlgYvaB6yE1P539DyGvzgPaHoRtO/GlGf6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm0BIgro; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm0BIgro"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c350db5a761so309311166b.1
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791894535; x=1792499335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MSrW2QsU5sD6aU9GldcitIknJmBTZQB6L4UNDgWjpRU=;
        b=qm0BIgroWB4dNBPgaUZBIptiUeHsQhlj0vMDwR/abHdMbwQWVqoimkiQysDhLEnlr8
         mhLJTGKV/wnmyJUZhpcjL0r2xudr1DwQ11BLDQVV3Ph8azHg+nYNY3hlpZfP5qjFqUab
         W09v72fEJjPVkC6iLlpVto0EQUQ8HDUlkABiKC6lBUfGJADltaAW2pTKcnb4k9Fa2RSd
         ZfXjy/1f3EcNqS8X5p97aFo1ty4bIslQGAKwsS0dH0zH3RZQwhYukCRfYR9AIPw5FN5J
         /h74FEDGUZ7S5v5NuCpWQis+53+x5x4wmnkatBhmkzEKXDEBPB7wKbHFz+OMy/a1+y3q
         jkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894535; x=1792499335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSrW2QsU5sD6aU9GldcitIknJmBTZQB6L4UNDgWjpRU=;
        b=LE0Ech7/gOT5Tmwdb7v/ZuRqocRHCA0vSDAKaxQfVgBjE9cjqTJ6xuvubOukuIR8Fm
         18/qWyJoRGqKfAGE9RPQ99S5IvhBdM0mUPbxPZpZX8WjOauoqjp54ARVHGPGko8e0H6X
         xqKfh46h4qOUOUCc8nKDRTab4OZhFZ0A/e2ymag88siTrL9rLuF87ZcfX6EYB5bEb+LC
         1uLgHvF8hoh61T29CFFfXZ235duPz/kf9E5ZvciuuiwnWZTZKXhhtlJYOLaln/ZURg9j
         HYTwsw4iFPrWMX5+3BBBox/F0Fx/GlX+7gtG1Mm2DGCWUH2A7quXtcDWXQKFPl98tUf1
         JKqg==
X-Forwarded-Encrypted: i=1; AKwUvBxaQAcREo+6tN5Qwl3r0ptAUpZPnC4X+wocKFHkU3aRo5y4XxRF9WwpogJBpgX8XPlqL8gCX8K/tSzXgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJyM2KBroiaGXY2GYUIUcdR1m5IGU0dxsC765wwY+0lLCet/1f0
	U4rc8zScBeEGgK3SxWzVrLzKq7OswnTHw8iod7PPv86XB7r9tkZ7eXcR
X-Gm-Gg: AYBFou0+/HYsWdSQLzp+VdUZoUtAk5LMDrbT3vV9Hm9mNA7H0Mn8QxYWNUmB0MQAw2M
	zP2mKT/N70bz00eJLZa4pACOs1YjtZxcZVulZd3Q9GohNrpzE8AY0TlcZG+xMc2Zbzd/TAyXEie
	cGiqhn4t/3+SupD2K6F92olVBIxORhllEvlef87yjqWCZ4j1LxYfO7cmaksggwZiwopoZoRkdf+
	+Qg8aPCrIl8Gk1fkshfMxjzGWVLflRQTTiM70z+m94vP15OzGGkXjYLUt19EvqWwmfcFOOPClPb
	a/yLo4RbZ0QVCwZETWSwB43wml2sgNy/JfTUe25NWoNXEFAK0Mi1zYykF49krhZBdH8hGSTBkKS
	3ZVqDnWI9AhBIci3cn7HGpsBaqqK4zUsMZ2VolQqG373yaZVT7VlgLnfW/cFrEq0lkoAAlcyAYj
	2upcMQHvyAsEzpzd5SxIGQZxg+hkPOUGUhrbJqLrdyzebIVQ8twdETz8HTNxPmPTu1FvtZBjfmV
	F/nqHBwgd9DqUZ4NWlQ7ZpGFQyrqHvbzM2aoxQqDDNahSDpcvX/cCdOcKKbw5wgOPusc1doZiC8
	MY0=
X-Received: by 2002:a17:907:7f90:b0:c26:1648:a061 with SMTP id a640c23a62f3a-c31aa04aabamr1238002866b.28.1791894535091;
        Tue, 13 Oct 2026 05:28:55 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9766743sm577597466b.4.2026.10.13.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:28:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:28:45 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org,
	neelx@suse.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <as4j_Zk7zcNsBuo1@fedora-laptop>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>

On Mon, Oct 12, 2026 at 12:06:25PM -0400, Aaron Tomlin wrote:
> On Sun, Oct 11, 2026 at 09:51:25PM -0500, Ming Lei wrote:
> > > Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
> > > to provide a non-isolated CPU when dispatching &hctx->run_work, no?
> > 
> > Does every WORK_CPU_UNBOUND user have to handle it?
> 
> [Adding Tejun Heo]
> 
> No, because almost all other subsystems passing WORK_CPU_UNBOUND do so on
> unbound workqueues (e.g. system_unbound_wq).
> 
> In kernel/workqueue.c, when WORK_CPU_UNBOUND is queued on a WQ_UNBOUND
> workqueue, workqueue core already handles CPU isolation automatically via
> wq_select_unbound_cpu(), which respects wq_unbound_cpumask and steers the
> work item to a housekeeping CPU.
> 
> kblockd_workqueue is unique in that it is allocated as WQ_PERCPU to
> preserve per-CPU locality for multi-queue devices. For WQ_PERCPU
> workqueues, workqueue core cannot silently migrate WORK_CPU_UNBOUND to a
> remote CPU because callers of bound per-CPU workqueues expect local per-CPU
> execution. Thus, blk-mq is in the unusual position of passing
> WORK_CPU_UNBOUND to a bound per-CPU workqueue with the expectation that it
> avoids isolated cores.

No.

For example, schedule_work() is queue_work_on(WORK_CPU_UNBOUND, system_percpu_wq),
a WQ_PERCPU workqueue, so every schedule_work() from an isolated CPU runs
on that CPU. blk-mq isn't special here; this is the general tradeoff of
submitting IO from an isolated CPU.

> 
> > > I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
> > > architecturally necessary and fully aligned with the rest of the kernel,
> > > no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
> > > defers execution to a background workqueue. That work runs asynchronously
> > > at some indeterminate time in the future, long after the thread has
> > > returned to its time-critical user loop. Having a kworker suddenly preempt
> > > the thread later is likely not desired.
> > 
> > We are talking about `if a task executing on an isolated CPU submits I/O `.
> > 
> > If the task has been submitting IO on isolated CPU, why can't we keep
> > scheduling WQ on isolated CPU for running blk-mq queue? I am not sure your change
> > makes any difference from user viewpoint.
> 
> When a task submits I/O, synchronous submission occurs directly in syscall
> context. Note, in the following example, IOCB_DIRECT is applied since the
> file was opened with file->f_flags & O_DIRECT:
> 
>   __x64_sys_write
>     ksys_write
>       vfs_write
>         else if (file->f_op->write_iter)
>           new_sync_write(file, buf, count, pos)
>             // filp->f_op->write_iter(&kiocb, &iter)
>             ext4_file_write_iter
>               if (iocb->ki_flags & IOCB_DIRECT)
>                ext4_dio_write_iter(iocb, from) 
>                  iomap_dio_rw(iocb, from, &ext4_iomap_ops,
>                               &ext4_dio_write_ops, dio_flags, NULL, 0)
>                    __iomap_dio_rw
>                      ...
>                      iomap_dio_submit_bio
>                        blk_crypto_submit_bio(bio)
>                          if (!bio_has_crypt_ctx(bio) ...)
>                            submit_bio(bio)
>                             ...
>                              __submit_bio
>                                blk_mq_submit_bio(bio)
>                                  // blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq))
>                                  __blk_mq_run_dispatch_ops(q, true blk_mq_try_issue_directly(hctx, rq))
>                                    blk_mq_try_issue_directly(hctx, rq)
>                                      __blk_mq_issue_directly(hctx, rq, true)
>                                        // q->mq_ops->queue_rq(hctx, &bd)
> 
> 
> However, if dispatch must be deferred (e.g. BLK_STS_RESOURCE),
> blk-mq queues &hctx->run_work. Now, if &hctx->run_work is queued on the
> isolated CPU, it must be executed by the local kworker. Because that
> kworker runs under SCHED_NORMAL, the user's SCHED_FIFO task completely
> starves the kworker. As a result, blk_mq_run_work_fn() never executes,
> hardware dispatch stalls, and the I/O pipeline hangs indefinitely.
> Albeit, I believe an enabled Fair server, under the EEVDF scheduler, will
> prevent this stall.
> 
> Anyhow, offloading deferred dispatch to an online housekeeping CPU allows
> the kworker to run immediately and complete dispatch without priority
> inversion. As noted in commit a46c27026da1:
>     "it isn't expected to let block IO disturb these CPUs. blk-mq kworker
>      shouldn't be scheduled on isolated CPUs."

You already disturb isolated CPUs by submitting IO via syscall in this
case, so why does it matter here to dispatch on same isolated CPU one more
time?


Thanks,
Ming
