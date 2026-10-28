Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205901;
	b=T5zhdc09H3KRNGWRzJ5Xp/iI1kSgvw9mLQCFTEvgBmau5BNPZzOZKaX5tiUeBzwoHbeJ
	 PuS+FLF+utc8717yvhT6rKUyTJl6+LJDA4ZItlUAEM9FQzN3X0hjjliE0JO3753+9kL4u
	 Rbq8aEqSrEv24hAMQvyeAJtyXMysjVxUklzwbwIgFxlWWiK004wxeOikkHRf3sjxoTImX
	 w7NeX4ff28iMwK0xnNlVfZEz9zd5jWHiayhDbbHiEdgss3xxi5CsmwV0yy4Y7FS3yi9xq
	 QsgNIdqI8e2dncVnCwxFj6fZmKsY31J8a+FLbzT/Mm494jI104NKQx4GrVlzEc0FBMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PUxAas9xBNxD7Kmn6oWG+Bu02h/tdJSLbILrhQp1lyg=;
	b=FKNMWzAAFxq+B/fBJsiUUnB4YucVLj0u25hQxL6QdO24tEYpQSEASCw7vY3eN3SSqX25
	 vhi1aDsTAtKzMbsxHebO+lBy7Ykq5WH1Jxv64sTgUPHv6SkrBygbSvvIDsZaWXB/rrUvP
	 ESFkgtT8MFag6QmFdSNk6euzGPDL5Sz9OJCoOVvAmhnKegXETik3FQWRjajBMlp4bvwwm
	 G4+kljYMkJ7lz2hd4yx9t2nkG8i2qRgDZmiR8qd0pwld3lo+jlDk6KPdjqZpr3PYC/h5m
	 0LIwBU7XmqipmCsSCG4Q+rpnvwsD19gTO3b2AcrV9ruvxHrEHroSXPypahe2h/DqHbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k6uLA0dv;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41F606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC41F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k6uLA0dv
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8470d7d430fso575807a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205900; x=1793810700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUxAas9xBNxD7Kmn6oWG+Bu02h/tdJSLbILrhQp1lyg=;
        b=k6uLA0dvoWxmJd8LUnRWBj9tzEXqdDoIDV48ryUS02YlxmLzd86nZvjmtmUu9mDnpV
         glkiATD9GIBQfZry2jcrjczPJKTVMzbxX5s+RTgTw7Bndp21bGIAAIFE94W/QdTVuSuf
         MFq/O3DHB0CpSBeEPXRKSNmys7uPjNrWFx3EPuMsTZJ/euE4QzW+58RYddd4xnytjjjk
         7iaO4cDpcyJHcZ2tyqj8PZcM78PF07A+I8W9KxeV+DfHwZPCs7pWAFi0D7itfY+r9cP4
         OOI7faaypdn9CrUS1ne29RBg4Zh25XEL2hVM1zfrJV8cyk6xBC0owSVIfbVrvRwJqOxS
         +oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205900; x=1793810700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUxAas9xBNxD7Kmn6oWG+Bu02h/tdJSLbILrhQp1lyg=;
        b=CWmcf6OQYlCFbU+1iLkIOG70+77Rub4TTrisI0BXwE7jtSOg7/IK82KOiurO6zvZzX
         myqGZBfYWnWhXzK5iFTbU4UKTSvQTivPV0BcKLvx54OSkHblQEpOgqRxbeAUi7tpFPEY
         uNXsRraPImk/Jdo3srHVakkHxgQy93Y2ILeo3UCXvIXPmGnyvNORmqWeceZmhz9+5pds
         5oWgMCNpglGi1XtHWylY1bievFHzSz4CiUOL/6pk5dvDQSyazd99wCs2off5qNDFO5Aj
         wYfpc/7M+exBalozkLZx78dL+NfBZJ4Um/7/FOKNPAqBTD9MwKVVjatIsLDwHtIqGyeq
         oG3w==
X-Gm-Message-State: AFq9FYIuGhE/jchcpFrearHLthwR1SAuAHJJwziqLDZSpAEjcsMZsNOI
	4jhwW8xiu93NbNoFpFEuroShfah5muYn/OuHxRbLbHx0MgUuz/JP4068lBmoqtqQUDvbGxMxXT2
	EcJjS/vg=
X-Gm-Gg: AYBFou2BV1ZbxJSwVuirRhSjmKF67GeOuQrTyAV11W1qkK1Q+OYuHGaL/PXWny51XyV
	Yw/qW7FjXETOflF6BSfb3mcZHSLQ3W8YNvgNSTTJi32dw0m2OOfMJ9R96EkM0hb7ZSTwvOn0ZLw
	rXGbaUr4LorxONli13tLPxrJI/vMtlzxRptOhXs7INgieNJwHNQKd9kVmggvPjrcYRCnkay1Yxj
	4PVrnDgPkGXFqFL07/G6MS5NQM2r1fGeuBYOiD0fcFebn02RCGs2l2WwBkB9OzzvZHWY55fiExC
	h5feS8ILk0NbIQZHFUvMZ+jb3HDFdxEsZAgooU6FcK8ercq7mFNsHCPkabcbeQxN/Outug9JTKD
	Er/quLQ6WUv8pqnxsGpsMjO0gZriLvrxkLsMW41PiYZkw+4A3c6kDw1fna+6aMecuowQxvuVQjQ
	D4Eka+kF0Fu4LitUQwlk7HZ1fxAI8u52N8dB2NhcpdmTvFjPFAmvxaZLoZBoABubBV2DqCKRBH1
	IqoAXEo/aHRyxBDAo0g3s3Wyot82kJ/f3RToetZSFxky4PnCy6SKBoFs18eSw0LoopYwAnBXv8T
	F1mubIVgc8ndGotH/DsgVsn05xWN3LRhHHZKuUQerA2hsSPPgPGV1Hm/5RUuxA3tx9Z5WZ9jgQ=
	=
X-Received: by 2002:a05:6830:7190:b0:81f:2b74:7fc2 with SMTP id 46e09a7af769-85ab9873afamr2762282a34.8.1793205899862;
        Wed, 28 Oct 2026 09:44:59 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 34/98] block: don't enter reclaim under rq_qos_mutex
Date: Wed, 28 Oct 2026 10:41:37 -0600
Message-ID: <20261028164415.1262013-35-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

ioc_qos_write() and the wbt_lat_usec writers take rq_qos_mutex with the
queue frozen, blkcg_deactivate_policy() does the same with blkcg_mutex,
so nothing holding either may wait for IO. blkg_conf_prep() got
GFP_NOIO for the blkg in commit 5d726c4dbeed, but the
radix_tree_preload() right after it, the policy init functions and the
GFP_KERNEL fallback in blkcg_activate_policy() can still enter reclaim
there. lockdep reports the cycle on the first write to io.max.

Use GFP_NOIO for all of them.

Fixes: 9730763f4756 ("block: correct locking order for protecting blk-wbt parameters")
Fixes: 5d726c4dbeed ("blk-cgroup: fix possible deadlock while configuring policy")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c    | 13 +++++++++----
 block/blk-iocost.c    |  5 +++--
 block/blk-iolatency.c |  3 ++-
 block/blk-throttle.c  |  3 ++-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 00da55c6ec43..5b7a32293dc6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -884,7 +884,11 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			parent = blkcg_parent(parent);
 		}
 
-		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
+		/*
+		 * Drop the spinlock to allocate the new blkg. rq_qos_mutex and
+		 * blkcg_mutex stay held, and both are taken with the queue
+		 * frozen elsewhere: GFP_NOIO.
+		 */
 		spin_unlock_irq(&q->queue_lock);
 
 		new_blkg = blkg_alloc(pos, disk, GFP_NOIO);
@@ -893,7 +897,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail_exit;
 		}
 
-		if (radix_tree_preload(GFP_KERNEL)) {
+		if (radix_tree_preload(GFP_NOIO)) {
 			blkg_free(new_blkg);
 			ret = -ENOMEM;
 			goto fail_exit;
@@ -1648,7 +1652,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		if (!pd) {
 			/*
 			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
+			 * prealloc for @blkg w/ GFP_NOIO: blkcg_mutex is held,
+			 * and a bio based queue has not been frozen above.
 			 */
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
@@ -1660,7 +1665,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			if (pd_prealloc)
 				pol->pd_free_fn(pd_prealloc);
 			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
+						       GFP_NOIO);
 			if (pd_prealloc)
 				goto retry;
 			else
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bfb0dd320c4a..99fe89f687ae 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2938,11 +2938,12 @@ static int blk_iocost_init(struct gendisk *disk)
 	struct ioc *ioc;
 	int i, cpu, ret;
 
-	ioc = kzalloc_obj(*ioc);
+	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
+	ioc = kzalloc_obj(*ioc, GFP_NOIO);
 	if (!ioc)
 		return -ENOMEM;
 
-	ioc->pcpu_stat = alloc_percpu(struct ioc_pcpu_stat);
+	ioc->pcpu_stat = alloc_percpu_gfp(struct ioc_pcpu_stat, GFP_NOIO);
 	if (!ioc->pcpu_stat) {
 		kfree(ioc);
 		return -ENOMEM;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c15b1aba606c..a3bd153c67be 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -761,7 +761,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 	struct blk_iolatency *blkiolat;
 	int ret;
 
-	blkiolat = kzalloc_obj(*blkiolat);
+	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
+	blkiolat = kzalloc_obj(*blkiolat, GFP_NOIO);
 	if (!blkiolat)
 		return -ENOMEM;
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c46807a0faab..c5e26551956a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1322,7 +1322,8 @@ static int blk_throtl_init(struct gendisk *disk)
 	unsigned int memflags;
 	int ret;
 
-	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
+	/* The caller holds rq_qos_mutex, which is taken with the queue frozen */
+	td = kzalloc_node(sizeof(*td), GFP_NOIO, q->node);
 	if (!td)
 		return -ENOMEM;
 
-- 
2.56.0

