Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073111F3BA9;
	Sun, 27 Jul 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753615343; cv=none; b=uTf3IfLr57BdRnlTY60jxapSA0bF54/1KpyNKjc94jpBy1R4uQrDRtjGSzf7rEGPI59P1C8mU03Juo4j1ZuVYSs5E3w5nr6tszmi8DBoTX14qhkZzzsyRcSVR8WMg9737t9X7PLPddpnMgfO3eUW6YJ2bxHYMF6aEWg1vhFPL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753615343; c=relaxed/simple;
	bh=Eu3PYpC28BmMT+QkBwSkegffzP9hRv4/+jrjeQ3evbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ29nRxPbRk9sMbJFF43ZYGEU6kfTxGwVox0xwXDsV7c6qodNjbvxaT4nW+NMcxPnLJpPmyemU4Gblzeb2I+zqxEjk+YzMCsipfId38wMOgV4MEZYiIEEaivxQp7j2Y1lDloCE1qTi2KZBwRnwMg9yOHklNiwi1ZK4CLqw266ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTNRTbuB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTNRTbuB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3134c67a173so3665233a91.1;
        Sun, 27 Jul 2025 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753615341; x=1754220141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2732z/PdTW/6w8daVSCYHyrlREp6oUNb1legWNQWVg=;
        b=cTNRTbuBL1K/1K9r7q21uoQmEUd/95t1hAxYgvizHpcBBgmd2VWUPF6oPo8vgh0a5T
         0jCys4T1ba/Q7LYeNeRfUgXR1XTHaRZfbFRaz+d0YPh7SBHM450rE3IiVU/LPIG2fHoE
         CXA+zmQOS7fH3nOw5GbExhuEejnSSOO3qCE8X2njtJqj9aFVWgD/SOtKZ6mipoDPK/fZ
         mMeedYfmM4b1IkZki3RQfE6Hj77z5liJ3AmNiq1xEKdJrpr5Eqh/0vAb9deyCtiJTJ7h
         kOYU9zoE51zp4Be1ryp1fb15NxaYpM2LQEVHr0HnBhIDLfIO+HqgZcfLpgLIrk9rdzwt
         u2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753615341; x=1754220141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2732z/PdTW/6w8daVSCYHyrlREp6oUNb1legWNQWVg=;
        b=Avzxs4GZBkLY5k2U5cmfQWvrXDWs1yQyxU5T510v8H9nwmJFEB1Urt2PjjDIUdFYLU
         0BeiK+FiZX1pwegdhOuj8wTBYsDjdyTWMocMGaq7APijgrscYFjiY9IV8Qo2ysy7Eeud
         KQfZHUWraSOxiUy97thFsem0bfikvopDAf7QYRvSg+vSpYBWkn8iLZPEjlJGhHAKw7Sk
         8gno4onDq7dOufd2JfKiuR7GP1ABLgiLHMg4qViqCj+KlpTmbCcxeKg/2Wqciyyck+IO
         5P0iVvSxYogPUIJjvPoCE3ZWYW39zHLyDIBteBp6IbYYuPNutcduSYd9ssgsQVBUFM6h
         9xdg==
X-Forwarded-Encrypted: i=1; AJvYcCU3JtUs5NOyO8s4vEdZ61NcESt+P4f4MIZDAIp/BXtDpU2+xab5jfFQ4o5QfpLGiOhCAE0VtpGk3T7r/7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduP22Ro5Tg9Ac8QpGx7a64fqLNJ2b6LEvVNHC+EjCVefsVRaA
	3BYxlkklQ2pQqqiXSGzxhyiqwkNLR/+v/MGE5AbWTRvV38IrMWbCGB8GxuskTYs=
X-Gm-Gg: ASbGncv4cPP3J4KmUATOq7rhtoq2SCTZfqGNm0AkvdGG6E1fZm1B/+pZwF2NyqGWF88
	WTvURnF4JEDkAE9HubIe2FIToo5prk7Dm43OPUZGvGTu+1GXhzMhGjnhNaFfULR2fJXtpKypK09
	SxrZopNEhQJbco95G0FSfd3Dc0KbSpfHd9nxzvo4Y3G+PntFAD63eeD7/XoR8+caU0UqZw738Nc
	9uzPy70HtGmeSH/LBJ7KES8sOO8KU9FZgFY086tDZfv4tbjXivfxcO4NJO3+hS7cGYR2qnWwtDA
	FzRySKok+HiUdjonSJEM/uzrdxTEkqZh4ipRlbQMO4Xvb0CPtFTFkbBwu5pdy7Wp+p+vZq6V/cl
	4Ti93d/ZS3EE8IFT3GHwUSuWBQwVYyeu46u5mliaZpSaBnXVjQRrScEO9lTJcD7s+v552ti9i3U
	suDU3nbQc+j1+EMw==
X-Google-Smtp-Source: AGHT+IGV3+LXUMol7EzkJpmjuTwyORgp2uWN/5IhjnBlXxsMmmgjxQ49k8LQi+9dXdzzAohNlQEUgA==
X-Received: by 2002:a17:90b:5623:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-31e779fe9b7mr14552564a91.18.1753615341024;
        Sun, 27 Jul 2025 04:22:21 -0700 (PDT)
Received: from maxserver (2001-b011-e009-e772-79bd-fe51-8340-5cfc.dynamic-ip6.hinet.net. [2001:b011:e009:e772:79bd:fe51:8340:5cfc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm3462422a91.22.2025.07.27.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 04:22:20 -0700 (PDT)
From: Meng Shao Liu <sau525@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meng Shao Liu <sau525@gmail.com>
Subject: [PATCH] blk-wbt: use fast inverse square root to optimize window size calculation
Date: Sun, 27 Jul 2025 07:21:42 -0400
Message-ID: <20250727112142.604373-1-sau525@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the computation of cur_win_nsec = win_nsec / sqrt(scale_step + 1)
in blk-wbt by introducing a fast inverse square root algorithm.
This approach replaces the original use of int_sqrt and division with a
more efficient and accurate approximation method.

Signed-off-by: Meng Shao Liu <sau525@gmail.com>
---
Since this fast inverse square root algorithm now appears in three locations
(blk-wbt, sch_cake, codel), it might be worth considering refactoring
the implementation into a shared helper to reduce duplication and ensure consistency.
However, this patch focuses solely on introducing the optimization in blk-wbt.

 block/blk-wbt.c | 60 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55..1fd5af3ba 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -80,6 +80,8 @@ struct rq_wb {
 	u64 win_nsec;				/* default window size */
 	u64 cur_win_nsec;			/* current window size */
 
+	u32 rec_inv_sqrt;   /* reciprocal value of sqrt(scaling step + 1) */
 	struct blk_stat_callback *cb;
 
 	u64 sync_issue;
@@ -130,6 +132,11 @@ enum {
 	 */
 	RWB_WINDOW_NSEC		= 100 * 1000 * 1000ULL,
 
+	/*
+	 * Initial reciprocal value of sqrt(scaling step + 1)
+	 */
+	RWB_REC_INV_SQRT    = 0,
+
 	/*
 	 * Disregard stats, if we don't meet this minimum
 	 */
@@ -395,20 +402,55 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 	rwb_trace_step(rwb, tracepoint_string("scale down"));
 }
 
+#define REC_INV_SQRT_CACHE (16)
+static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
+		~0,         ~0, 3037000500, 2479700525,
+	2147483647, 1920767767, 1753413056, 1623345051,
+	1518500250, 1431655765, 1358187914, 1294981364,
+	1239850263, 1191209601, 1147878294, 1108955788
+};
+
+/* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
+ * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
+ *
+ * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0.32
+ */
+
+static void rwb_newton_step(struct rq_wb *rwb)
+{
+	struct rq_depth *rqd = &rwb->rq_depth;
+	u32 invsqrt, invsqrt2;
+	u64 val;
+
+	invsqrt = rwb->rec_inv_sqrt;
+	invsqrt2 = ((u64)invsqrt * invsqrt) >> 32;
+	val = (3LL << 32) - ((u64)(rqd->scale_step + 1) * invsqrt2);
+
+	val >>= 2; /* avoid overflow in following multiply */
+	val = (val * invsqrt) >> (32 - 2 + 1);
+
+	rwb->rec_inv_sqrt = val;
+}
+
+static void rwb_invsqrt(struct rq_wb *rwb)
+{
+	struct rq_depth *rqd = &rwb->rq_depth;
+
+	if (rqd->scale_step + 1 < REC_INV_SQRT_CACHE)
+		rwb->rec_inv_sqrt = inv_sqrt_cache[rqd->scale_step + 1];
+	else
+		rwb_newton_step(rwb);
+}
+
 static void rwb_arm_timer(struct rq_wb *rwb)
 {
 	struct rq_depth *rqd = &rwb->rq_depth;
 
 	if (rqd->scale_step > 0) {
-		/*
-		 * We should speed this up, using some variant of a fast
-		 * integer inverse square root calculation. Since we only do
-		 * this for every window expiration, it's not a huge deal,
-		 * though.
-		 */
-		rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
-					int_sqrt((rqd->scale_step + 1) << 8));
-	} else {
+		rwb_invsqrt(rwb);
+		rwb->cur_win_nsec = reciprocal_scale(rwb->win_nsec,
+					     rwb->rec_inv_sqrt);
+	} else {
 		/*
 		 * For step < 0, we don't want to increase/decrease the
 		 * window size.
@@ -911,6 +953,7 @@ int wbt_init(struct gendisk *disk)
 
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
+	rwb->rec_inv_sqrt = RWB_REC_INV_SQRT;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
-- 
2.50.1

