Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D15397685
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851639; cv=none; b=BCiOcDoKN5p1CyTW6x2BbyN+FJgTHolGJY3Hm2bVDBxdDcDh3z54kuM+ibTJO28tWm127q17quQJ5QRyJYMKGG/XAdJZy31VNGhjKYiKkV2/pZ5IdTqCEAhldJJiE8ndrW7cu9OGYWVn32cEQfMtfObbvHIup+GYqfr8YVv/VXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851639; c=relaxed/simple;
	bh=feadXaVbDpt09d0IHhCtU9IhpkUdkNyxiJB78Gzd9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlAvyyfnotQODsE1L160cv69EmMdthxzLR39Ho6PAfS1S3j4tfn6HRucJB23mQp5DG8fCJ2jhqkK4c8DPzZPN1+7C70QxMM/i1w+tiybJ6m2+buWGa/RavhdvvnomSk+8TagDbcjxnZS6rSWQRX8CMGSHcph/3uxIbT/KKQGQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ5eef/g; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ5eef/g"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so20373a12.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851637; x=1774456437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx2bMmg0TFOhekmjlMiH/uxb0wN03CxoN0qCye5m4u0=;
        b=RJ5eef/gE/eQVu++kkzNfOQT4T2TWDfvt45j4Jwv6A95LGKBPe+8GIP9ywyu2096dq
         RsDzoXeFV5SQB1TIfbOcOV60JlLve3PswD2IOOuFRysQOA38LGlmyZpAMik37YK8is2z
         dEGUijS91W4A+oe+WHCQhyBWfC2noz8kxVTO3S71Jq4cS0TUB0mDskkMkTUZTUxYdst6
         rTH2I3nwYfB5bTaBESxNc/vsXCS4PbZrutcVIZFm1DiZFIP/w2awnkQHkHRriSE5xrku
         NEfLzj7NrD+hUPAJMb9DTA/G/vMdhOSL2mGzz5UsT9s2Sdb+wpLw1Cwiwv32PGMXO5o4
         AKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851637; x=1774456437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx2bMmg0TFOhekmjlMiH/uxb0wN03CxoN0qCye5m4u0=;
        b=NY5ONu7w4TBchwVNcmsOD0nLXArJ4Szb29ylUnKcOWFfxX/NELXwVGDoUMNlcdaUfn
         AIJtX9urT+GXCELGNgJQIusYiXgj7EJdQJLoxostIYeNOjpetd4qfzdTxkBZ6lJmq/9S
         deqJuaCMk8jfiwKHQ6icMms6AGzNv+Hl513tTGsQVtswFP4sgHpHsDedLLPtIcBkStrp
         yiWyctteK1wT2xt+2pbh17epMCeZmGYhtZW+edYr1Xash1EPNGdIdnca0xtH8EZ2DBkE
         346ETEJ8wRSUMlYd3mBoRL8kgQeLXhcrLsAn9UVezZ1nzWR9HFs422C88ZWW4p9gHtJE
         Fw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUogZkRKeV5MKHw5wUOaQ14LnBhd1qZNa/0yXvDOiWwrjlEnMiGc0avUCrw/j9rzymFnzSAIvk7MIGoVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRekJYE3gZ6ecIv6slYol4v8OCaEaMfDxVSjCfIZphQ87UivR
	BAYUu+x7rvmHq1wnSiC2obAYdcJPqGRsm5nQssFvdv78iX7uqKr456JcJjOQxCw1xnq09g==
X-Gm-Gg: ATEYQzyLYHeYZE9qEvZnxcalx0zng4OcsRSKnAyaU3G/697twqSNtvWeGf+Y1Dpbnn6
	OZZESOirlUb2keMjRwlxXYU2+nzs1qjzQuzLruU40jy+5AbaQvx0Jihjfsg6d5LVAU9uguqtK+z
	5/kUvYzsvVJT/4gcmW0fp5ZhcPYpM2v/uLE+rRSMZERhZ4zLJDUpBcX+TRCxyRC7H5I6zFXNLxI
	EOCXHz9WDZ/TDUivqOveUTvuRWSqJbTFDCaS7ys9dvckFP2xN+3TrpNUDpmFZYN+1XyvLAyl1Qy
	m/EoOm3N2m3LAfXj/32AOrtoCVfx+rkUge1b5z8JRgjJumz3mGlxUD/k7zoIK7VeJmy0A0EnMiI
	7x3OxOjoOWV/VnXMSCEUkbpruP0RiVYPqNyr46x5XMLdXG++7JFouxLGunmPGZ8ABNKA8t7iudn
	/kY3Wu6a3cin6Vh7272wEubDhKMkwfyGmMsg==
X-Received: by 2002:a05:6a21:1505:b0:398:8026:4811 with SMTP id adf61e73a8af0-39b99f71c99mr3647999637.35.1773851636506;
        Wed, 18 Mar 2026 09:33:56 -0700 (PDT)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51b3sm3797678b3a.39.2026.03.18.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:33:56 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fnnas.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wjl.linux@gmail.com
Subject: [PATCH] blk-iocost: do not lower busy_level when no IOs are completed
Date: Wed, 18 Mar 2026 16:33:51 +0000
Message-ID: <20260318163351.394528-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ioc_timer_fn(), iocost evaluates the device latency to adjust the
vrate. However, a logic error exists when no IOs are completed during
a timer period.

In such cases, ioc_lat_stat() returns missed_ppm and rq_wait_pct as zero.
The iocost incorrectly treats these zeros as a sign that the device
is meeting its QoS targets. As a result, busy_level is reset to 0. This
prevents busy_level from reaching the threshold needed to reduce vrate,
making iocost ineffective even when the device is severely overloaded.

This issue was observed while testing iocost on cloud disks. In normal
conditions, a 1MB IO has an average latency of ~6.5ms. After iocost
subtracts the size-based cost (size_nsec), the remaining latency is
~1.5ms. Based on this, rlat and wlat were set to 3000us. However, when
using fio with iodepth=128 to hit the cloud provider's BPS/IOPS limits,
the latency spiked to ~800ms as observed via iostat. Under this pressure,
it was common for some periods to record zero IO completions. This caused
busy_level to stay near zero, and vrate failed to scale down for over
10 seconds at a time.

Fix this by tracking the number of completed IOs (nr_done). The logic to
lower busy_level now requires nr_done > 0. If no IOs were completed, we
maintain the current busy_level because the latency is unknown.

Due to limited resources, I have only tested this patch on Azure
cloud disks. I am unsure of its impact on other types of hardware.
Testing on different storage devices would be highly appreciated.

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 block/blk-iocost.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..8b3bec6ea27e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1596,7 +1596,8 @@ static enum hrtimer_restart iocg_waitq_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p)
+static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p,
+			 u32 *nr_done)
 {
 	u32 nr_met[2] = { };
 	u32 nr_missed[2] = { };
@@ -1633,6 +1634,8 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
 
 	*rq_wait_pct_p = div64_u64(rq_wait_ns * 100,
 				   ioc->period_us * NSEC_PER_USEC);
+
+	*nr_done = nr_met[READ] + nr_met[WRITE] + nr_missed[READ] + nr_missed[WRITE];
 }
 
 /* was iocg idle this period? */
@@ -2250,12 +2253,12 @@ static void ioc_timer_fn(struct timer_list *timer)
 	u64 usage_us_sum = 0;
 	u32 ppm_rthr;
 	u32 ppm_wthr;
-	u32 missed_ppm[2], rq_wait_pct;
+	u32 missed_ppm[2], rq_wait_pct, nr_done;
 	u64 period_vtime;
 	int prev_busy_level;
 
 	/* how were the latencies during the period? */
-	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
+	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct, &nr_done);
 
 	/* take care of active iocgs */
 	spin_lock_irq(&ioc->lock);
@@ -2403,7 +2406,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 		/* clearly missing QoS targets, slow down vrate */
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
-	} else if (rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
+	} else if (nr_done &&
+		   rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[READ] <= ppm_rthr * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[WRITE] <= ppm_wthr * UNBUSY_THR_PCT / 100) {
 		/* QoS targets are being met with >25% margin */
@@ -2429,7 +2433,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			 */
 			ioc->busy_level = 0;
 		}
-	} else {
+	} else if (nr_done) {
 		/* inside the hysterisis margin, we're good */
 		ioc->busy_level = 0;
 	}
-- 
2.53.0

