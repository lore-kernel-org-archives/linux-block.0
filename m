Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6B368D55
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573240; cv=none; b=YYxIvmEDRV1owaOqFKyPU4Xb5YnUNWd+uwShrNmFhJEdlu517aOzIyWybE2kI+TXRHmhxJwD8PYyTOAT/WkwYWvPeIQ/0tykgiz6NQCt0Lz4fx3HLFP2gRk3ObdKntSOWn6eCWI5TXs2YKymdrlkv51vuKyt5n15Rh5rlEdn+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573240; c=relaxed/simple;
	bh=jAgQG7EAsC36kPwVxZzWPi1dqHCRuBg4xd0zcyE/2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQK8ZxW2SS7DZaBz0JMKCMCeFBTNiCWz6GZw9Pp36tFj8ITQ9Kdam4bfgI7OPQWaYmgki08IWkwdABANPjx7ESPK8XmnsI6Dzn2GuioE3CvMvbYiFOvVZsdKcButWao8oYOPNAVRHk7v3ST32/XmvF8P1BtiOI6kA7qHCV6CVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHtIGK8N; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHtIGK8N"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479d593a0c3so4453432b6e.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573237; x=1779178037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdojfavMRM36mRqPBUNav0nKv8uWwk4QyGdy/Q3s4jo=;
        b=DHtIGK8N99liEslDW+UlteRa+ixhktYXmjJJlC5j1K3GQu5HN/9fOSKhbUb7ej9e5z
         GGXD9rBrVoBdarAMnWT3yLwWvlSI5yLAFFwU7qJW+yU7N6mIuCF+r4G/5G3WtFVWJsYm
         2mTrOvFPFvErglJlYSANjrDjWJ12Am6Buz58yVP/Y3H0smbsy6zICqkrnSUoluHzvFJr
         tN0rUkQj2i5z+s9v4AF3N8phcATfp0kp4JiHBgYfmeHvXn58nnNuWNIxChApszpj0Igl
         j4C0kIfWMofBEkzqxZQq0+m1LcQGSRFSKtJuXuB9lGi/MCNx6GnLkJyhbwVLRUR/Nfd9
         6/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573237; x=1779178037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdojfavMRM36mRqPBUNav0nKv8uWwk4QyGdy/Q3s4jo=;
        b=c33xLzuMD6SasKhNEndScRdPScZ/+Yssc1J64n0Ladf/iBBgorJ5A/idOb/XisEWbu
         ImAIzNXxpGLFwgGt943AkNykJD42x1Fa8Tf577FlYIlV6XWnHY3gNdkHimXO8scrLICF
         sllmbYQdX7gGjM3cdEY7XCcj/SbqBa6totWS+ImNQHfIov56gMSUcHFcTbMLHjWKC+IW
         iRo7dss+uQIfQY3pDKESsehYwNuTTilYso4r1EhdwdyjBTTyFxWY/0inufoz5SAqQVXp
         nq34nRv3hPIXD7Fb66ndktbgv3GF4t7Izn5/ji3NBRIPqkJRlshsbdrHJOCMRORyR+t5
         5nKA==
X-Forwarded-Encrypted: i=1; AFNElJ8f/+0jqcA0suL0Ctd49AKUMoiv25d470PGPG0U6QW+0qDwJUL8W0I0fenAWj+XjpM8n90q+kUfMPIsog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuPc/Ua9CDOi6X66VKLK+GFHiK4P9aRLGk1/ak6g7LcjMmkW/
	cBi6ROq+hYqPt2tATS4eGtduItMmynyOGg3L0OUKPvjLPEWRoLaOcpYG
X-Gm-Gg: Acq92OHi/Y/0QvStLl/Xlq0f7q5LmcEqyc2ItWjaLNfYEqyRsCx5oN5UPXcyJJEpeVX
	hgKBlMcUoep0bJs8bLweiTTd8ZilhH3xHsoqDgOfnIteCe1KqXPk0V/fx3B9gosrTHF2xPkYH22
	3oU5EXojYF6Y9eTLXdlTofdP8qQLvfFgut62qsb1C+lqiAJLIPmoBw5BOn3WneFlE4t6FMKd1FZ
	ktH/d3PCZwDhi0gqAXEMgU6onCVHUtZuLBIckf4YS7mKO6VEj8c54qQBwWVtcsl8whDJBBatjUQ
	XuchmD6wcTjBComvqT6zJVWMPEkA3O66M8mtvjsYPBVjKezxwaZ+7O57ZTxP2LzcSVKV3eg04gM
	6OXacHdQ+vAxji61SnNFHCnTzVTQnlJ1HLXakgUON5wGsuqvCf4Bv8yrzvOblhYF1Frckmck8+o
	BVk2KK6b5QSWIIGaAlY6+o3PBs7CrVG5ualfcmKYr/8GPolLYPSIkWsVEFoA0IwF5bwP2aq6gc2
	OF6rtmLHrkHo85NpLkKnBFKXr1KWdA=
X-Received: by 2002:a05:6808:c171:b0:47c:be57:7fb0 with SMTP id 5614622812f47-48293c21669mr2066853b6e.9.1778573237226;
        Tue, 12 May 2026 01:07:17 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4824f8f1964sm6030932b6e.7.2026.05.12.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:07:16 -0700 (PDT)
Date: Tue, 12 May 2026 16:07:11 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Xiaosen <xiaosen.he@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Wu <michael@allwinnertech.com>
Subject: Re: [PATCH] sched: disable preemption around blk_flush_plug in
 sched_submit_work
Message-ID: <agLfr9kPHJUrZUex@fedora>
References: <20260423125528.2917171-1-tom.leiming@gmail.com>
 <5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com>

On Tue, May 12, 2026 at 01:56:55PM +0800, Xiaosen wrote:
> There is another deadlock caused by preemption during calling
> blk_flush_plug() in sched_submit_work().
> blk_mq_dispatch_list
>   percpu_ref_get(&this_hctx->queue->q_usage_counter)
>     percpu_ref_get_many(ref, 1);
>           rcu_read_lock()
>             __rcu_read_lock()
>             rcu_lock_acquire
>                   lock_acquire
>                     preempt_schedule_irq  --> writeback worker got
> preempted here and be scheduled out in D state
> 
> 1. task kworker/u32:6 had dirty pages from f2fs node inode submitted to
> block layer and the corresponding request was added to plug list of the
> current task.
> 2. task snpe-net-run acquired gc_lock waiting for the request that
> contained page from node inode to be completed.
> 3. task kworker/u32:6 needed to acquire gc_lock to perform foreground
> GC, since the gc_lock had already been acquired by task snpe-net-run, so
> it called blk_flush_plug() in sched_submit_work() before sleeping to
> avoid deadlocks, but task kworker/u32:6 got preempted in RCU critical
> section before running hw queue to issue plugged requests. so the
> plugged requests were pending in local request list. task kworker/u32:6
> was scheduled out waiting to be woken up by the release of gc_lock.
> 4. so, there is a deadlock to cause RCU STALL.
> 
> I think task kworker/u32:6 should not be scheduled out before returning
> from blk_flush_plug(), and I think this patch should be able to fix such
> deadlocks.

This patch isn't enough, because the current task could be preempted
anytime before calling into blk_flush_plug(), even before schedule().

One quick way is to fix schedule_preempt_disabled(), I will prepare one
formal patch later.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..18ef6ed71b4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7336,6 +7336,7 @@ asmlinkage __visible void __sched schedule_user(void)
  */
 void __sched schedule_preempt_disabled(void)
 {
+       blk_flush_plug(current->plug, true);
        sched_preempt_enable_no_resched();
        schedule();
        preempt_disable();


Thanks,
Ming
