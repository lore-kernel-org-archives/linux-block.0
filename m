Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815441DE3A4
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510824; cv=none; b=bQVs1I3HdRjNFnHWnhrHxEb75buY475GyGktgLn0P9mEt4mzSlzkSjuqzN9Im4dy7ZPPw1eZH5EoT7BpAzVz+92Hg/+5wboiMD4pIHSAWUvEB6uJpLqVNkKAbyS4pxoqouM/UyQ6lBJYGwZUDEfZoLN3rlHKXZ6kgTwPsDPPpI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510824; c=relaxed/simple;
	bh=sCDkI7ENHQnXmpAh3KuSLSxg0XzvGEd48fbJO0pMl7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aERB0JYOTSVItHZftYPu5Q8MKmdSGjEebLBkVBEnZCm4qDEktulv+HALYk3h3lAtGzTtFij5NZcBvwP7AcI4WkU+rinB2WPZM6jXXGHmfVqJbVhsHpzBakyJC36c1EN88oyNUPkkTXtcKZmB+Uu+0ThkQcvF7LOgynpNMzML2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=wyO1xh1b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="wyO1xh1b"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436309f1ad7so757853f8f.3
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771510821; x=1772115621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WPV5zc+4pTYNW/WHh9z0i95W/Lb1GJgH88opLKR1Gc=;
        b=wyO1xh1bbqeqBY+KIqukgTEM6kchR+ZVBd/FALdRv5m7+YXXQnkMDM5o2cHAZTgKCC
         RDmAgDO4zOSW/QxhgW4GxHF1J7TCG2aFQRm0/+0DRwrtagY52KqtNcteEk8ypTy4clb+
         X3/b9tNZk754jVwBMRsna3iB7+s4XgZRD2pZW4yilyNDkCC5uAAx1xro1ownVuXoNMJo
         BtQAeYCQk94NeA0pjzsCuLXuGw5q/TJ+HQhCJQIZbmcKUd0H1iTcrZoF+GgGU6AzuYYx
         qPBD9cqZ0LSbsnIljmVLJpdTWocjKKz9HWqcqeHfF9TbyEnfCxxUchmp+PvLWP3B4Ot3
         xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771510821; x=1772115621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WPV5zc+4pTYNW/WHh9z0i95W/Lb1GJgH88opLKR1Gc=;
        b=QlLNypt3mvWhL2cilTu43Pkw56m8XMw0ILQ/QtFQ1lgec8S92RN1yBpjCUdxp0Yjk8
         mJdpgtFScEC5ltl6x/eVlPSKfbw0epnwciEZ5P+SvxnX3wDMT8NjwDp5lnI0wq1ZB1sL
         1pr4trJ9Fb9f4MdFdaHkRA5Nf/RNlsJAhOOh4FEvA+PIG1hvIQLgJHuRCTS3Eog7bvUb
         Q1dPOWCDTLVMabnQqGNoLot0G7btJ7okziY2Vjo22FBcsduejZQ3ZP/QoDLUzOsDYceb
         kxMnynftpqNJv254ObeOmkwSrcT83DBWtH10Q+QNpF5lbNEDUw7wuR9maGYAz2FP9PTi
         qXew==
X-Forwarded-Encrypted: i=1; AJvYcCVQk9zmR+AMPxALin6Q9Hto/cygHTWFok20/d4Q/VlmcJPhK3m7ny4S50kVofWlnea4D+uoaUVw0Y7kCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJg8ev6PDT79KnF49hOYfkaohXjL2FhSPLA/1LmtxvxiOV9Tzg
	crtzuC5mclvpByHyKuC7UxPL2fHyR4RZvpuGQoRyaTyVCRw/lZ1UngVeqzIuobRk1cE=
X-Gm-Gg: AZuq6aLlDWR8TKRQCpNuSUM+NZyj6emGXseRbnrt8qhPJ9g6xp/4FAESNZxnLW6805m
	4aazE1fmReFJykERs68cZNvHsomNrRDR0tS8bdY8WhNzoEl8U/I+U6tZLDdCw7Z2D3lywIJB/0n
	6IshhvPZ/XeWMHlC/hM9ebyXi+oXfFiKZxv+T1jLeOd2tbZ+JGWXBfudIwZqS2t1YMn1+uBVl7x
	s/KdOyMXD3wKPrns6heKOEUETH4OdK4/zlIkRZDBqzOWiG5foTH8q9frtXodrN6ucD3kJK6g5Ya
	/AcYrSIejLwSGI+LvONwDzsWw3Zy8TpavvXpEsLFsf4eN/WItD00dN78zwVrfEQrYGo0JI2kBk5
	vQ4D0orfQ9Je1khtIx8ClR2eUhCo3Vskmyk2NKiOzPybJK+xMuz0g4EBoze6IVB3MrlO/W3g5eY
	pA7A4GlwoyxSPM59GBvLcI9Outp6jned2Zv6RFwooSyPTxoM1pwWqd0gmTDWJcPSYOFv3wAooVm
	ebFvjJinB1rYVH39MWkvLzcTzk66TORV7k=
X-Received: by 2002:a5d:5d83:0:b0:437:6b6e:d114 with SMTP id ffacd0b85a97d-4379db9800dmr29808717f8f.30.1771510820603;
        Thu, 19 Feb 2026 06:20:20 -0800 (PST)
Received: from localhost.localdomain.com (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm47122906f8f.7.2026.02.19.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:20:20 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
Date: Thu, 19 Feb 2026 15:20:12 +0100
Message-ID: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Even though we check that we "should" be able to do lc_get_cumulative()
while holding the device->al_lock spinlock, it may still fail,
if some other code path decided to do lc_try_lock() with bad timing.

If that happened, we logged "LOGIC BUG for enr=...",
but still did not return an error.

The rest of the code now assumed that this request has references
for the relevant activity log extents.

The implcations are that during an active resync, mutual exclusivity of
resync versus application IO is not guaranteed. And a potential crash
at this point may not realizs that these extents could have been target
of in-flight IO and would need to be resynced just in case.

Also, once the request completes, it will give up activity log references it
does not even hold, which will trigger a BUG_ON(refcnt == 0) in lc_put().

Fix:

Do not crash the kernel for a condition that is harmless during normal
operation: also catch "e->refcnt == 0", not only "e == NULL"
when being noisy about "al_complete_io() called on inactive extent %u\n".

And do not try to be smart and "guess" whether something will work, then
be surprised when it does not.
Deal with the fact that it may or may not work.  If it does not, remember a
possible "partially in activity log" state (only possible for requests that
cross extent boundaries), and return an error code from
drbd_al_begin_io_nonblock().

A latter call for the same request will then resume from where we left off.

Cc: stable@vger.kernel.org
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   | 53 +++++++++++++-----------------
 drivers/block/drbd/drbd_interval.h |  5 ++-
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 742b2908ff68..b3dbf6c76e98 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -483,38 +483,20 @@ void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *i)
 
 int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *i)
 {
-	struct lru_cache *al = device->act_log;
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
 	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last = i->size == 0 ? first : (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
-	unsigned nr_al_extents;
-	unsigned available_update_slots;
 	unsigned enr;
 
-	D_ASSERT(device, first <= last);
-
-	nr_al_extents = 1 + last - first; /* worst case: all touched extends are cold. */
-	available_update_slots = min(al->nr_elements - al->used,
-				al->max_pending_changes - al->pending_changes);
-
-	/* We want all necessary updates for a given request within the same transaction
-	 * We could first check how many updates are *actually* needed,
-	 * and use that instead of the worst-case nr_al_extents */
-	if (available_update_slots < nr_al_extents) {
-		/* Too many activity log extents are currently "hot".
-		 *
-		 * If we have accumulated pending changes already,
-		 * we made progress.
-		 *
-		 * If we cannot get even a single pending change through,
-		 * stop the fast path until we made some progress,
-		 * or requests to "cold" extents could be starved. */
-		if (!al->pending_changes)
-			__set_bit(__LC_STARVING, &device->act_log->flags);
-		return -ENOBUFS;
+	if (i->partially_in_al_next_enr) {
+		D_ASSERT(device, first < i->partially_in_al_next_enr);
+		D_ASSERT(device, last >= i->partially_in_al_next_enr);
+		first = i->partially_in_al_next_enr;
 	}
 
+	D_ASSERT(device, first <= last);
+
 	/* Is resync active in this area? */
 	for (enr = first; enr <= last; enr++) {
 		struct lc_element *tmp;
@@ -529,14 +511,21 @@ int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *
 		}
 	}
 
-	/* Checkout the refcounts.
-	 * Given that we checked for available elements and update slots above,
-	 * this has to be successful. */
+	/* Try to checkout the refcounts. */
 	for (enr = first; enr <= last; enr++) {
 		struct lc_element *al_ext;
 		al_ext = lc_get_cumulative(device->act_log, enr);
-		if (!al_ext)
-			drbd_info(device, "LOGIC BUG for enr=%u\n", enr);
+
+		if (!al_ext) {
+			/* Did not work. We may have exhausted the possible
+			 * changes per transaction. Or raced with someone
+			 * "locking" it against changes.
+			 * Remember where to continue from.
+			 */
+			if (enr > first)
+				i->partially_in_al_next_enr = enr;
+			return -ENOBUFS;
+		}
 	}
 	return 0;
 }
@@ -556,7 +545,11 @@ void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i)
 
 	for (enr = first; enr <= last; enr++) {
 		extent = lc_find(device->act_log, enr);
-		if (!extent) {
+		/* Yes, this masks a bug elsewhere.  However, during normal
+		 * operation this is harmless, so no need to crash the kernel
+		 * by the BUG_ON(refcount == 0) in lc_put().
+		 */
+		if (!extent || extent->refcnt == 0) {
 			drbd_err(device, "al_complete_io() called on inactive extent %u\n", enr);
 			continue;
 		}
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index 366489b72fe9..5d3213b81eed 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -8,12 +8,15 @@
 struct drbd_interval {
 	struct rb_node rb;
 	sector_t sector;		/* start sector of the interval */
-	unsigned int size;		/* size in bytes */
 	sector_t end;			/* highest interval end in subtree */
+	unsigned int size;		/* size in bytes */
 	unsigned int local:1		/* local or remote request? */;
 	unsigned int waiting:1;		/* someone is waiting for completion */
 	unsigned int completed:1;	/* this has been completed already;
 					 * ignore for conflict detection */
+
+	/* to resume a partially successful drbd_al_begin_io_nonblock(); */
+	unsigned int partially_in_al_next_enr;
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.52.0

