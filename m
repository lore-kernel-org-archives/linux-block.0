Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9C3B960D
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218617; cv=none; b=XW4KJRAlWPRBxA5cUjyySesW9CCtJR2+uOfmpkNEI6ObeSraCJqdv5DrEh2PCN1KSqu0djJNwiqzhGLQjwQGEZuWXh6jfYCRTgkQpFlfI9lAEkIFAXmNKvWlbs1Ved1bXCQjrNkBC6E1NrwnY5ou68l66BqamAyWOx8XkRm/4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218617; c=relaxed/simple;
	bh=8rX/6/v5ZGwUIV+PJgwOYMpTS/BX+olsi2efD19EG+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmCiVshaOP1A1bk3m5KtWWQn7R83gzOnr7wA5bi03bH8RPVQVC2IwecaTmOhAUcJiDDJ/3kBCgU/eCzXhpa0FnX1AtXcfm5rntF7pIfwWDYMMjaRn8iBa6Rd2KTcJKiznlS+DqnofKOiBxLHbKf3qjYjLcr3/Kn/FvsxZBbi73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CDR87WgC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDR87WgC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aae4816912so91237915ad.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218615; x=1773823415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBtB7XXOythHDvRMRushsmy5L46KSzcoEi5jZRX7GEc=;
        b=CDR87WgCcagG1bEU0UlxhWrlK8HhWGAbIMbds9lj0JNvhoSUuDQVUIKE+mKM+0Uw/U
         ODK4vlepmiPuhkIATrJXk2F5D7ETW5bQHT16rnUG+VOMD+PU9lQSa5h5ZOBtFesd5M7s
         VNd4Jkm/OrlpdLrpemAExTqj/1ddPyv/INlOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218615; x=1773823415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBtB7XXOythHDvRMRushsmy5L46KSzcoEi5jZRX7GEc=;
        b=Dh1grn/+aiVMoPD87zndeP4bV/7YCR8xnYsfGH+DppQTyYWsPq3bo+zDa3zwH/HeWD
         95sZwNlDstJn4L6SI011cfvWzyNln2cA6qjRsmEtdSK8xK4NZtnOB/ikBFlZWtyKIQzK
         8TC8DkKA3iReJyTxW6SsfAiP4bN79Hh+2q/iumu2Nh/Em4fQL0vFYvc1lpZDSz3DE40m
         xu2AJlBeiERN1IZLZgbUHPxV19q2iSF/hlMSp4AlifMnDkHkoKV9oNzr+xDl4KY5kJWK
         WLtU+2Wo6BpQkNNIgasChnGLZumTPeaipVQHgtYyC+zngltjQlPrFoQRx/BRd87U034y
         qsRw==
X-Forwarded-Encrypted: i=1; AJvYcCWT7ftiWwyk75a35owbBNUoxO1azsnYSoUZlkCkYxlwUCVcOAU3beyevVhMSpoUkBNVnvVqp6rFB1OHgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AoZhQtnwKjDcwkyyhPc1Dw4PfQHcAyhclS3He6IclZTBLX5n
	CGPIksQDtD2xvoOzJOuw0a4Gs4OWLK40ckJHkQRJMPUmEebNXCQO0/xiu+KuCDQ0AQ==
X-Gm-Gg: ATEYQzx6g3V2efw4zG/07gq9wl7Qb7nxUez0lvqWKvmHUZ32cogyxJ4bKqoRwHpVTak
	ge8FBbrJfWt9YKoUF5+FMBO2vqIgLj4Pn+yL0yzn3W8PfQTVdo7CMEV/5LgQ82P4P7eJJg7bB3a
	j8HM1e1HxvEYL+ZfTaG19erKWTwqQ5jstcofTo08CrG1tciO+x8FPz6W99yOp97Twhv/yGWmwwC
	GxgKIRPMfash7Vp1RWkKH2snxi7ukLiJn8ZI9zAYaCtZElw38pWS+xZXGX931aCNO340uReLUQW
	6AKH+SLJREXs7IWX8GxiDjGuL1sGN6L2SiZX6+bzE5iHhdZOpZgV9NGtcEp9kL53IQhNa5Wj95D
	VHGmVlCd++USiNEHOLQ1358YQyx72V6gEq5IyS9V0SO0bgDLeuA59tldmS2gz9UsmWPpNWmtcmR
	cbiFUGsk1liMiXUqAgPUnM15SxsRmX/E3MaBm7MPua/w+Q3zA46hjpNxKDUYvmX0xlpNERxtxhW
	EjT0mXsGWjoOA==
X-Received: by 2002:a17:903:18d:b0:2ae:3dd5:c69c with SMTP id d9443c01a7336-2aeae858e3fmr20712175ad.33.1773218615277;
        Wed, 11 Mar 2026 01:43:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:34 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 3/6] zram: drop ->num_active_comps
Date: Wed, 11 Mar 2026 17:42:46 +0900
Message-ID: <20260311084312.1766036-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not entirely correct to use ->num_active_comps for
max-prio limit, as ->num_active_comps just tells the
number of configured algorithms, not the max configured
priority.  For instance, in the following theoretical
example:

    [lz4] [nil] [nil] [deflate]

->num_active_comps is 2, while the actual max-prio is 3.

Drop ->num_active_comps and use ZRAM_MAX_COMPS instead.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 29 ++++++++++++++++-------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index add3291ff27f..0c3e83787d9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2335,6 +2335,18 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
+static bool highest_priority_algorithm(struct zram *zram, u32 prio)
+{
+	u32 p;
+
+	for (p = prio + 1; p < ZRAM_MAX_COMPS; p++) {
+		if (zram->comp_algs[p])
+			return false;
+	}
+
+	return true;
+}
+
 static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
@@ -2482,12 +2494,11 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		 * Secondary algorithms failed to re-compress the page
 		 * in a way that would save memory.
 		 *
-		 * Mark the object incompressible if the max-priority
-		 * algorithm couldn't re-compress it.
+		 * Mark the object incompressible if the max-priority (the
+		 * last configured one) algorithm couldn't re-compress it.
 		 */
-		if (prio < zram->num_active_comps)
-			return 0;
-		set_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		if (highest_priority_algorithm(zram, prio))
+			set_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
 
@@ -2619,12 +2630,6 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	prio_max = min(prio_max, (u32)zram->num_active_comps);
-	if (prio >= prio_max) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS) {
 		ret = -EINVAL;
 		goto out;
@@ -2837,7 +2842,6 @@ static void zram_destroy_comps(struct zram *zram)
 		if (!comp)
 			continue;
 		zcomp_destroy(comp);
-		zram->num_active_comps--;
 	}
 
 	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++)
@@ -2902,7 +2906,6 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 		}
 
 		zram->comps[prio] = comp;
-		zram->num_active_comps++;
 	}
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f0de8f8218f5..08d1774c15db 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -125,7 +125,6 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_COMPS];
-	s8 num_active_comps;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.53.0.473.g4a7958ca14-goog

