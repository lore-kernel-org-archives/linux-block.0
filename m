Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E03822B1
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176482; cv=none; b=FXD1ABEch0mH1zM1hon2sFd8VuADYESTODgnWc8sQIUArA9NJVU+DpODkyOX2rrDVLwXJWmUwh3LmT9d4DHJGrrLsFDfYI3bQ3viYfTxOwcSWUcCfUyn11bRv6h6rlsKkIyR4OkIcwAmgbr6oN1FCe5jPgHwyDwB5x/FKgGLOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176482; c=relaxed/simple;
	bh=UOBQMDboe3FurNL1fwsoCR+UO+c0f/CLUXkhSYblSsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO4nGXYP8yA8KYJ89XsPgTpI8Al6cox0f87uNpvncr2zsc+guJKqOY8b/PLwg/Cs602BKiCE9OA7csyLvLvLKANkQEmHAyy0hPFT4o/GHNdCRQENtR8WAk/aW1qlJuW1Cqm+1d0VcwlgYh+/srTQAGp2BHH0Akfdik3ccXR72OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=NjMB13Mb; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="NjMB13Mb"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso337108eec.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792176480; x=1792781280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOUEWUnwnVxWxJH7C5xN/7NfB+Ebm1z7A2AX4Ywo4+s=;
        b=NjMB13MbBU5AXZkvZyw8S+By4qULTieuND5CzWSxcZ2wS7XIv55AmIPGEQo9wg5sSz
         ytJBXvtB40c7OQc2vT+ieC+LCr+SaAUHBMLLyRXbbr9E3vIb4Bz4TmK9KUSy4mJI3nG0
         FsMaOsUmU/8mazNlmyUtvH/qD1dFeWP2Ui2mSvHTraYs66FUNeblJCMPeKGbWiFcUgE8
         DQeqI4n2HrAr79UIjcnAse5pIRufx7WoZlhfoTY/RbAwmBwbKDAaR8LdHhdf9hvci7/D
         OY+BgMH3SOnnBRac7kvdrFdxfrOpO5mrl9tGS3Ig8pHjzT54UBNsLZKe2nvNgiwu4y+e
         Kx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176480; x=1792781280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOUEWUnwnVxWxJH7C5xN/7NfB+Ebm1z7A2AX4Ywo4+s=;
        b=IvsE0ASMBAEfVcVAUx6c2U2boU/J7zdWJE8c/mZFPtrXBK0YTBJjXhr01XKiuTi17w
         C0aIZR2MDv3DlmTNT0uqddjHMO2KIvLSxLUizcyQvI8Xq5oepgHOGWrDGpgJ7ALEwKa/
         EdsZThSuZWnigx1CCC8jW0MstEY9pBD3VX3JgubhyWZvAfkUc3MA0jRwDL/4wFd226Wr
         YP4UtZZStmbGjFyHBJ2Uz22qKKt17aWXZoE4rumGriLnqroWO2IquwAImnD9vMSc+M5a
         nEzL5cLRCMCVVLh4t07a2Tz/E9M3yCUeMl1zPjfe93sSee81qKQjmdaI+QHUuXdHaMQD
         surg==
X-Forwarded-Encrypted: i=1; AKwUvBw2RgPWoiCXrLlyC17mr1aKxnUuzx2YZkrY55o77nNe3gi3vsYvEvImP5cWiyeI5oxU8p0XxL5QBCgwig==@vger.kernel.org
X-Gm-Message-State: AFq9FYJB8WjJfY+/6H+SFwbRuWrxtjydBYv3kLYNbztnIckR+VwBrFwM
	zqMKnGYOBwcAWvFUlTLlYeWWeEfXZlMTGNAGZtsx/1qEeFg85Phgn72quQAqu4eTpCc=
X-Gm-Gg: AYBFou01pRIkZ6vsxm8odDoutxnPqspq88DqXKQ8/0qO6WhqF77UIDXqBVR7lnUiRi2
	porHhABzfG5wduPwJwduJCYvi2ChmsBOT+z96ngkvfIWADHWMk2uq7kcKrI1O3rDu4YDFBlca1g
	SvM4LxL3c2lGHg/g9TPd2GocToi94m/NDdjX9NboeXrGnxc1Uq4CDBqT9pfIygKafQU7HtWUsl1
	JumUhho61hfxCwAcfkT2Jsdd65PyxclNr1EDe4MNiCO8DoZ+1fK7txZZ9wR+veW/7YUVJWtZLUu
	u6rhdt76P4GFDMkvxlrpNXQ/SI+RuZ4IGPWKwND69EksoO/JXrl3gEF2G0g+nvy3Z7L4uvMcclG
	KqBdOH2ZajarNwXn/q0IB2lU1rtHgMClu3SwKzwdcmDzKFKvv1jKZpyJH4i5/Lhzfgp1K39xF7e
	4AjADBa793+WVSSnXG2r+K9cjid7dkKveWITuyapWBBFCGTdfn3S99XPfs9DwOOrebtynsxTfc6
	CR8A2HdGMpYqtEXj1tVLik7nwz7Mt2Dk+UiCUsTBTroqjZlsueJe02gRfFlxboug2UBMnI=
X-Received: by 2002:a05:7301:1f04:b0:351:2a18:c172 with SMTP id 5a478bee46e88-361a1660788mr1010366eec.15.1792176479682;
        Fri, 16 Oct 2026 11:47:59 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:85ee:eb9a:5637:424d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm8004502eec.22.2026.10.16.11.47.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 11:47:59 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] blk-mq: pop cached request if it is usable
Date: Fri, 16 Oct 2026 14:47:52 -0400
Message-ID: <20261016184753.27189-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016184753.27189-1-artem@trailofbits.com>
References: <20261016184753.27189-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit dc278e9bf2b9513a763353e6b9cc21e0f532954e ]

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug flushes and calls
blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
use-after-free bug. Fix this by popping the cached request before any
possible blocking calls if it is suitable for use.

Popping this request first holds a queue reference, so avoid any
serialization races with queue freezes and can safely proceed with
dispatching that request to the driver. This potentially increases a
timing window from when a driver wants to freeze its queue to when
requests stop being dispatched. That scenario is off the fast path
though, and drivers need to appropriately handle requests during a
freeze request anyway.

The downside is the popped element needs to be individually freed when
we performed a bio plug merge. The cached request would have had to be
freed later anyway, but this patch does it inline with building the plug
list instead of after flushing it.

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for bio_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using queue limits")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://patch.msgid.link/20260521190253.242065-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Assisted-by: LLM
[ Backport to 6.6.y: Pop a suitable request from the older cached_rq list
  before fallible preparation, then initialize it after preparation. The
  target has three preparation or merge exits; the following correction
  restores the request on each exit. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-64017 to 6.6.y.

The backport separates suitability and popping from initialization in the
older cached_rq implementation. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y).

Thanks,
Artem Dinaburg

 block/blk-mq.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c1c5a261d0cf002d9f87f0f1330182eb4158cfc..1ad77737b27d3233489b4d9f690c9e6ab77d2130 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2984,17 +2984,7 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
 		return false;
 
-	/*
-	 * If any qos ->throttle() end up blocking, we will have flushed the
-	 * plug and hence killed the cached_rq list as well. Pop this entry
-	 * before we throttle.
-	 */
 	plug->cached_rq = rq_list_next(rq);
-	rq_qos_throttle(rq->q, bio);
-
-	blk_mq_rq_time_init(rq, 0);
-	rq->cmd_flags = bio->bi_opf;
-	INIT_LIST_HEAD(&rq->queuelist);
 	return true;
 }
 
@@ -3027,20 +3017,30 @@ void blk_mq_submit_bio(struct bio *bio)
 		rq = rq_list_peek(&plug->cached_rq);
 		if (rq && rq->q != q)
 			rq = NULL;
+		if (rq && !blk_mq_can_use_cached_rq(rq, plug, bio))
+			rq = NULL;
 	}
 	if (rq) {
 		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-			if (!bio)
+			if (!bio) {
+				blk_mq_free_request(rq);
 				return;
+			}
 		}
-		if (!bio_integrity_prep(bio))
+		if (!bio_integrity_prep(bio)) {
+			blk_mq_free_request(rq);
 			return;
-		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+		}
+		if (blk_mq_attempt_bio_merge(q, bio, nr_segs)) {
+			blk_mq_free_request(rq);
 			return;
-		if (blk_mq_can_use_cached_rq(rq, plug, bio))
-			goto done;
-		percpu_ref_get(&q->q_usage_counter);
+		}
+		rq_qos_throttle(rq->q, bio);
+		blk_mq_rq_time_init(rq, 0);
+		rq->cmd_flags = bio->bi_opf;
+		INIT_LIST_HEAD(&rq->queuelist);
+		goto done;
 	} else {
 		if (unlikely(bio_queue_enter(bio)))
 			return;
