Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56456282F1D
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140876; cv=none; b=AzsKHB24QsjkLo3vOWADJyYOaKRu3lAFdAgef2/FYcdMw+uPrhyVvl6MHGckz25pCA8lmNA2z4E3rVWtyw4aB7MZJFyP8C6lyXhXWbRqNq6Ibpqu1GPxJGeLVwDNR9rkJ9naXGfvMW1Oz900Xk016vJih9G+HFcfZjftyf441VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140876; c=relaxed/simple;
	bh=E+J09Xq85GRReMtNz7xiHKa0FuOgC3/TnFnR0m1+vBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWr/Xc3/F3mgobaNxiRCcT+gGmPJF+cqdC+jSBqgxHin0G3e78rY9y4bNXYUvG9E657P93SS+DkCXHm8lDVtfeccplukLbfLjXKSlE0DuhpV4q128O+817xK6G/sj2fZ8BabSKmq6m3T5V5O+MY5R7kGjiCokgi3mp9CqTzekLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XMZal2sx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMZal2sx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1538911a12.3
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792140872; x=1792745672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tm0sQY97x/sO1vfolLCcmx0x50wapUOdk8gJkzj/4Rc=;
        b=XMZal2sxCSeSCPj/G1trUJ/xv3bkEpM/4jZ4z8fGayrOk89MoIwxZ3yuIWVnOAayni
         Bwd8ipzddLFuKfLIQ+uHXfPukYQYGAusDZJbtN+8fSEZ9kUjhNFIDBS7Y0zESB2M/cc7
         c9pf2TwL7XkkOsrL/f+cLqgl3+yqDu3S1HWoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140872; x=1792745672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tm0sQY97x/sO1vfolLCcmx0x50wapUOdk8gJkzj/4Rc=;
        b=Jl/SFTrbgLeeTtG0VNSgw5Sd1TTXsQ3xWIcZ6n17jkeMJ6hu6uTOiRjoAALGCgztaI
         ijx2xp1wod2hioZ4Ij1BuwhK/3a6AuZXgese13QGfYc7q/AQsmfu43UE5m7blBCwQotL
         zXrfCOFGcrhOUHWZ7NtNX+5WhggLavLS+bzf3uLTlT5oMKChm00kbHMdIo93QgUQ55gt
         e8H7HjRspmUazMybEYcEDiWOjd/8Mjq1/gAJ+V4SXFCwRkPvC2NIJX/a5BzG9MJBhzNk
         Myi8/DQbI8cHmUHeGzwtCl/XJh6HkLcJ01lxHX1Jy/9m6Ag8ZSQGfFumaah2jBIMdf5F
         lfVQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7s3bTV1luyZixXsGa/dOwnZmzEmiGVMWEbc6G9FJAcXVnQN5iK9K4/Xt46um9w5RxTcqkQvl93/ovDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKUZn252vQ7LoF5p5bKCaUeuLkjtx90tcd1iA2AsGlImUp9PNtR
	wBrp2rdLZPQneL0zGjQH3E4yFPAsO6ZWEu6eFxIWDv5DBo3rN2LwPj+tofsIkpV3MQ==
X-Gm-Gg: AYBFou0qrgf1qd6ZNbFCAMsR1AfOQM/fueSaqBOP9ltP6HrxeLrFmo/zB26gN2dEaRY
	e9OUHLklPBw3gJiv+ish/BDc7O5EuMzJZPF2lxbLOB2KeQ/vnAbhUvlFIPs+E7sYU7jfcg6H7tI
	GeqMpnfSEtMpnXNQe4m1fDzUVJYXMvxhSCYjFEuPBsbd2P6Y8+JtHg2HqZX0i2PiqoT1whRU7m0
	/qfRIph+1oSn2JnHKIyaVjkb0R1xy1wW2fAKsJfJeE4Dvf2Kl5cU9s0EHspZznPFZmfFc4Kf15A
	O78GT6zpk4935/dkwEHWt8D90KYHpSmfudwdhO71d2abGQe3h0+wG5K7ayndMTD/4agmoKqH175
	HmRWoJ0M4tZI+pf/l1RlLR0lGy+NqkLM5amHFMp3IrMlMR/IC44JZNBiGBjH+erUGcWCbAknMd8
	PSx2IAB5njMFung79oREcg1xwhU4xMi/s9KbjwjMqQulLJA5qd2fvMnLE9vEu4l99qDnZJWkpYB
	wotxW2Y+K45TlN1sgk+WaQgXbFGgD9+YvlwN41elklwUXVMgDaxK4Nozk8Pwbtaynib3AnhN5zp
	Pp05UxvUoFmSP8dGvxoq9n9ArtrMqBcywEzyPLRbYA==
X-Received: by 2002:a17:90b:3a48:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3ab3ac790dfmr19469341a91.52.1792140870404;
        Fri, 16 Oct 2026 01:54:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm8425589a91.3.2026.10.16.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:54:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:54:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	akpm@linux-foundation.org, baohua@kernel.org, bgeffon@google.com, minchan@kernel.org, 
	richardycc@google.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atHftz13hWzGludk@google.com>
References: <atBh9xfpOji_A7A_@google.com>
 <20261015112440.1491168-1-zhangbo56@xiaomi.com>
 <atGPwJL6XzlRaMva@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atGPwJL6XzlRaMva@google.com>

On (26/10/16 11:50), Sergey Senozhatsky wrote:
> > zstd backend, same A/B workload, on top of 9+10+kmalloc:
> > 
> >                        9+10+kmalloc   + preempt-disable
> >   cwrite_contended     14,880         48          (-99.7%)
> >   cwrite_wait_ns_total 137 s          0.32 s      (-99.8%)
> >   cwrite_wait_ns_max   243 ms         43 ms       (-82%)
> >   dexcl_contended      15,919         54          (-99.7%)
> >   dexcl_wait_ns_total  109.6 s        0.68 s      (-99.4%)
> >   dexcl_wait_ns_max    145 ms         34.6 ms     (-76%)
> > 
> > zstd stays 100% exclusive either way; the win comes purely from the
> > holder no longer being preempted/migrated, so the hold time stays short.
> > It's the same mechanism that took lzo-rle read contention from 24,749 to
> > 406 earlier. So the two are complementary: shared reads remove
> > reader-vs-reader queuing for stateless backends, and preempt-disable
> > covers the exclusive/write serialization that stateful backends can't
> > avoid.
> > 
> > Quick and dirty, for discussion only - Patch below.
> 
> Yeah... I need to think about it, before I can join discussions
> in a meaningful way.

A quick and dirty patch, as usual, just to play around with.  This
attempts to improve the reader side, because the reader is side
much more sensitive.  Tested only with zstd.  We probably can do
something for the writer side as well, but I'd prefer to postpone
that, until we actually have to do something.

A quick thinking-process dump:
Our shared dstrm-s are almost non-pCPU at this point (we have a
fall back bounce buffer in pCPU), so we can have any in-flight
number of those.   Doing something similar for exclusive dstrm-s
is more complicated, because those dctxes are beefy - zstd dctx
sits at ~100KB.  And this rules out the "pool of idle dctxes"
approach.  I decided to keep them pCPU, and implement exclusive
dstrm borrowing (from remote CPUs) instead.

A quick (and a bit extreme) synthetic fio test for Reader vs Reader
inversion on 24 CPUs (preempt=full, zstd, 48 low priority (nice 19)
bg readers, 24 normal priority (nice 0) CPU hogs and 24 high priority
(nice -19) fg readers).

fg reader results (average of 3 runs):

    Metric           Base               Patched
    ----------------------------------------------------------
    Read IOPS        396k               1,064k        (+2.7x)
    Read clat avg    48.32 us           9.66 us       (-5.0x)
    Read clat stdev  7,571.00 us        31.92 us      (-237x)
    Read clat p99.99 5,707.10 us        2,233.68 us   (-2.6x)
    Read clat max    3,555,300 us       6,287.57 us   (-565x)

A quick note (the last one) - happy Friday!  Time to logoff for me.

---
 drivers/block/zram/zcomp.c    | 75 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  5 ++-
 drivers/block/zram/zram_drv.c |  4 +-
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 81f21bad787e..af1aaa1f9e9b 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -190,38 +190,66 @@ bool zcomp_shared_decomp(struct zcomp *comp)
 	return !comp->ops->create_dctx;
 }
 
+static bool zcomp_dstrm_excl_trylock(struct zcomp_dstrm *zstrm)
+{
+	/* Cheap pre-check: don't touch a busy stream's cachelines */
+	if (mutex_is_locked(&zstrm->excl_lock))
+		return false;
+	/*
+	 * Pin the stream.  The write side of ->lock is only taken by
+	 * zcomp_cpu_dead(), which also sets ->local_copy to NULL.
+	 */
+	if (!down_read_trylock(&zstrm->lock))
+		return false;
+	if (zstrm->local_copy && mutex_trylock(&zstrm->excl_lock))
+		return true;
+	up_read(&zstrm->lock);
+	return false;
+}
+
+static struct zcomp_dstrm *zcomp_dstrm_excl_tryget(struct zcomp *comp)
+{
+	struct zcomp_dstrm *zstrm;
+	unsigned int cpu;
+
+	for_each_online_cpu_wrap(cpu, raw_smp_processor_id()) {
+		zstrm = per_cpu_ptr(comp->dstream, cpu);
+		if (zcomp_dstrm_excl_trylock(zstrm))
+			return zstrm;
+	}
+	return NULL;
+}
+
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode)
 {
-	for (;;) {
-		struct zcomp_dstrm *zstrm = raw_cpu_ptr(comp->dstream);
-
-		/*
-		 * Pin the stream.  The write side of ->lock is only taken
-		 * by zcomp_cpu_dead(), so this never contends with other
-		 * decompression requests, regardless of their mode.
-		 */
-		down_read(&zstrm->lock);
-		if (!zstrm->local_copy) {
-			/* The stream has been destroyed, re-try */
+	struct zcomp_dstrm *zstrm;
+
+	if (mode == ZCOMP_DSTRM_SHARED) {
+		for (;;) {
+			zstrm = raw_cpu_ptr(comp->dstream);
+			down_read(&zstrm->lock);
+			if (zstrm->local_copy)
+				return zstrm;
 			up_read(&zstrm->lock);
-			continue;
 		}
-
-		/*
-		 * Exclusive requests additionally own ->local_copy and
-		 * ->ctx and hence can only wait for each other.
-		 */
-		if (mode == ZCOMP_DSTRM_EXCLUSIVE)
-			mutex_lock(&zstrm->excl_lock);
-		return zstrm;
 	}
+
+	/* wait_event() checks the condition first before touching the waitq */
+	wait_event(comp->dstrm_waitq, (zstrm = zcomp_dstrm_excl_tryget(comp)));
+	return zstrm;
 }
 
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode)
+void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
+		     enum zcomp_dstrm_mode mode)
 {
-	if (mode == ZCOMP_DSTRM_EXCLUSIVE)
+	if (mode == ZCOMP_DSTRM_EXCLUSIVE) {
 		mutex_unlock(&zstrm->excl_lock);
+		up_read(&zstrm->lock);
+		if (wq_has_sleeper(&comp->dstrm_waitq))
+			wake_up(&comp->dstrm_waitq);
+		return;
+	}
 	up_read(&zstrm->lock);
 }
 
@@ -294,6 +322,8 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 	mutex_lock(&zstrm->excl_lock);
 	ret = zcomp_decompress_buf(comp, zstrm, sg, zstrm->local_copy, &req);
 	mutex_unlock(&zstrm->excl_lock);
+	if (wq_has_sleeper(&comp->dstrm_waitq))
+		wake_up(&comp->dstrm_waitq);
 	return ret;
 }
 
@@ -385,6 +415,7 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params,
 		ret = -ENOMEM;
 		goto cleanup;
 	}
+	init_waitqueue_head(&comp->dstrm_waitq);
 
 	for_each_possible_cpu(cpu) {
 		struct zcomp_dstrm *zstrm = per_cpu_ptr(comp->dstream, cpu);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 6764818d2a9f..39efefc43a13 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,6 +5,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
+#include <linux/wait.h>
 
 struct scatterlist;
 
@@ -96,6 +97,7 @@ struct zcomp_ops {
 /* dynamic per-device compression frontend */
 struct zcomp {
 	struct zcomp_dstrm __percpu *dstream;
+	wait_queue_head_t dstrm_waitq;
 	struct zcomp_cstrm __percpu *cstream;
 	struct zcomp_cstrm *recomp_cstream;
 	const struct zcomp_ops *ops;
@@ -118,7 +120,8 @@ void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
 bool zcomp_shared_decomp(struct zcomp *comp);
 struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp,
 				    enum zcomp_dstrm_mode mode);
-void zcomp_dstrm_put(struct zcomp_dstrm *zstrm, enum zcomp_dstrm_mode mode);
+void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
+		     enum zcomp_dstrm_mode mode);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
 		   const void *src, unsigned int *dst_len);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e608769bfad5..079f3723db31 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1382,7 +1382,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 		copy_page(dst, zstrm->local_copy);
 		kunmap_local(dst);
 	}
-	zcomp_dstrm_put(zstrm, ZCOMP_DSTRM_EXCLUSIVE);
+	zcomp_dstrm_put(zram->comps[prio], zstrm, ZCOMP_DSTRM_EXCLUSIVE);
 	slot_unlock(zram, index);
 
 	return ret;
@@ -2135,7 +2135,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst);
 	kunmap_local(dst);
-	zcomp_dstrm_put(zstrm, mode);
+	zcomp_dstrm_put(zram->comps[prio], zstrm, mode);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
 
 	return ret;
-- 
2.56.0.176.g3575e65682-goog

