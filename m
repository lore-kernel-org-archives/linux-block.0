Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18438D40D
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292629; cv=none; b=CVvJQITVAfGfwE1bR8jBCiGtz+gTy+jvAkynQMrRjp3H1+ymJtfGZIY/TOZ9Qq5Yq4UgW8sdysxSBBHLDtBy05UK4iGXutJ+twgG8k403A8Ps7l3aOMqxRb6oozaIBhfG9VmAeZ/mpz14CRANdSCVyVq6LxsdwL59fN6QVvS7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292629; c=relaxed/simple;
	bh=yHpHCxNOC5MlsnpDgYnYkeYbWsX6snYvQjK/qKOfYz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INyAP/fA8Lfo98Xrkx9BD3rHokrxCd6HUF6J4Hf05l3GqGM2FhcvHv6W4PbIZr4NLek/8VFuys/jI9iyH0qa3uMAQJ9aK7MQiWdGAELdw1itnZdVPtylCJW0kvSPB++Uc+TL+WaMpXyvhqKeaTp9k5ljmm1QZ4kacSbdk3oU9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=NhrYqFgX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="NhrYqFgX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so5628341a12.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1784292628; x=1784897428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts6ItQRv/aSdCv0Y+lKO30HlVCBc9sllq/rXrxpJ0EM=;
        b=NhrYqFgXCgSL/0L1mTny9IynK1wzTBI1/cRMXwa6PyhtKFcrru+zvKUcobjefJDm3o
         xitmv7fs3kvkSj7KbijDlwyCX+OrarJcreXbT4PgYH1n7CfZV/pwOqQiFWgR+U/ENNXB
         FnY7ZfAccK6I7RzT63s1CdNAm7bWKHx/R2fB27VWzvuD1Haf/Ok0JizusW2H2s4h8fX+
         ELAzAel7hdw+o5FS2atLFjgP/uwJfWDFrtD1WUgcWjKI2PPzgfmXvFx+3UsoASuiGnQd
         zwrISvkmdelWGGnrr/ollACPRurRnXFO0fJvwxqbJ+XFkBW4OfjWK+SY5+hrf6ZFxm01
         Ungw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292628; x=1784897428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts6ItQRv/aSdCv0Y+lKO30HlVCBc9sllq/rXrxpJ0EM=;
        b=XHZXDH62A5Ucd3SL+JegNcKVAJ+HK7cPOQSQXXVcA5QTs2X4DX2CXhcy5X+RIUnkt9
         mQ8irOtt8fUQ/3r4XHIf8NzqbEUASOdziz+PzVNcx9OBpAbaW7jn7AQBpoUmRF+Q2ynw
         v6b7yROu+j4k3Tn4SH3n8dDCgZuyF/8qv7ne8lBYpDXlyC13comlt3VW/qi+1jQEQ92n
         9HMhlMkPx9zg74boAXGVyp8W0ydBukWYAT/Wirrg3JzKPJ9HYzgkyGfHOjqgUqW2c4rb
         ffhGpD9HMqKxwD66yRiIA+ZcxKGsKz0TGfpbj7fq131x7q5XyC7IAR//K3WIvMGrEgc+
         ofSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQIcu4Slzsa2DOuYFkf0wd6bGt5hIzWVZ/meFYNTViQx6Qp+oaMt67G8Hb20hduYmQ71JMuf8LbNC9LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysfdVpnWitbvKVPVnAvlmPIBHvhm17PrxvlyEQpy1FbcgEantS
	aO+LRlp47IOnUOJiSoNJTZXbjTfYqVl6XzB+a+nDTCknXs0+r6GWs4wiDwm1w2wVHHg=
X-Gm-Gg: AfdE7cmOKWiUcsiNrg4uhF4CgIqu0Az1fNFmGGd+5v9yC5qjU992ImwsTIEEP5Md6vq
	w0rK7RXr9AP9zdBIElmtJMJJbtEUuk6MtwpHUWqnuhnDuaaPk5z4D0swll0HZOBmVdzYSzElIb9
	O/Q6ctWpm6hFCaiOig58un1C6Y8Te2ZiEDu7nG+4mxeX/aEz9PWMeOKGVhTuT36/d6GlN9Gk98y
	IZsi+2Q+U9x0dXKbHomEJgsPJcv36gzal0BjKS7SLdKLAp+H+cuwSUEwwM5ls5bckd5z5K9ZqH3
	t83j1FcSeT+CVYJtE+n0fP0AoJwAgYylPFPPUGkYLnRzgskH45t/tIyoB0zrRkZFB9C5r+pMP0T
	neHu4kwTV3RX/6ddcFMTUncAI7EW6H45Kknv6/Jns6HvOKjEG6KV3nPj7ldskWhpej0op69TaLg
	==
X-Received: by 2002:a05:6300:48:b0:3c3:994f:b4f5 with SMTP id adf61e73a8af0-3c3ad67a262mr2799204637.28.1784292627902;
        Fri, 17 Jul 2026 05:50:27 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517aad72csm808235a12.1.2026.07.17.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:50:27 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	guzebing1612@gmail.com
Cc: yukuai@fygo.io,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-wbt: Always change enable_state to MANUAL when setting latency
Date: Fri, 17 Jul 2026 20:50:21 +0800
Message-ID: <20260717125021.88825-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
state") compares only the boolean enabled state in the no-op check.
Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
is therefore still skipped, and enable_state is not changed to
WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
WBT through wbt_disable_default(), silently discarding the explicit
sysfs setting:

  # enable_state = WBT_STATE_ON_DEFAULT, min_lat_nsec = 2000000
  echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
  echo bfq > /sys/block/nullb0/queue/scheduler
  cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled

Skip the update only if the stored latency matches and enable_state
already equals the exact target state: WBT_STATE_ON_MANUAL for a
non-zero value, WBT_STATE_OFF_MANUAL for zero.

A write that passes the check then reaches wbt_set_min_lat(), which
performs the actual transition to the MANUAL state.

Rename the helper to wbt_lat_changed() to improve readability.

Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 953d400fd013..4f12a064286e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -813,7 +813,14 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
 	wbt_update_limits(RQWB(rqos));
 }
 
-static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
+/*
+ * Return true if writing @val would change the WBT state:
+ * 1) @val differs from the stored min_lat_nsec, or
+ * 2) @val matches, but enable_state is not the corresponding manual state
+ *    (WBT_STATE_ON_MANUAL for non-zero @val, WBT_STATE_OFF_MANUAL for 0),
+ *    so the write still has to update enable_state.
+ */
+static bool wbt_lat_changed(struct request_queue *q, u64 val)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	struct rq_wb *rwb;
@@ -825,7 +832,8 @@ static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
 	if (rwb->min_lat_nsec != val)
 		return true;
 
-	return rwb_enabled(rwb) != !!val;
+	return rwb->enable_state !=
+	       (val ? WBT_STATE_ON_MANUAL : WBT_STATE_OFF_MANUAL);
 }
 
 static void wbt_exit(struct rq_qos *rqos)
@@ -1021,7 +1029,7 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 		val *= 1000ULL;
 
 	mutex_lock(&disk->rqos_state_mutex);
-	if (!wbt_set_lat_changed(q, val)) {
+	if (!wbt_lat_changed(q, val)) {
 		mutex_unlock(&disk->rqos_state_mutex);
 		goto out;
 	}
-- 
2.43.0

