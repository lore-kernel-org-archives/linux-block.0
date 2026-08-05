Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B12E738F
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896359; cv=none; b=quNP80qQldkbgnP7GE3L4LpvoljdRk0DRSd7LUz+aDKSI5VFyi1d8K7jl0EZG1s9V9rYaSq88FWH91dqUwQ60F8yx1/8jWhHd8LvnDW9gpSY3jp0NIcZUvx1nGljvfydSsKpmtv+KfljY2Q/nQVLqtD1Sj0ZsZySnzHqqvR3NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896359; c=relaxed/simple;
	bh=nUuZ2skQfOzg/qCPaXxIP7ZQgcAg/Aar9NHePDlidY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRhTBJaxYSX1agM0sZY5bFgGPVmhbnqc/rSwmiPeT55yBlx6bYMn5qHzTm8n4dDAyhDx3PM3XD3EcCMdbIf4FTJP5Ypchw6QNg/SceiAji1xBuj7/WNkZcFAL0MIr0obOKsfz5YH69S1WLolnJMJJRd9EApoX6KolXyLq3KGwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aDNGcD5H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDNGcD5H"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so552747a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785896356; x=1786501156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=aDNGcD5HoyVE6TmgPFOr4MlJCpJRlb5Gg9QsTgUq2iJG3lN3Whe67iY3X9WbgBbp+e
         mutgoztQol7SuecW2F79J9FM7t29ab5dj0RhpG7jw6oHbs8I5HuIWqbRC67jSEtppL+N
         vDixLNEL/+wjMRb60CLa5qgae2yLENFUWCOQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896356; x=1786501156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=C4hpNng24Y5577pJU/p9pqRQ/eeHnUY8yseOuRfjTRzQU/RfABpVqiXdSwTuuRpUwr
         BFxpx+mKtfS9/Tk0XTOGLFPh15gPyNkUjYoKY63rEwim7HuvtCHvnBo/bDotAAnnaa4p
         +ebDam1rEOzi6SnLfgv4+o/Xz2shusAfeg5He75HYx4rDya0YteQHvDBYs8gEdoyvQc2
         lg71+im5DGfAdtIi69OWrngQ/2GSX3OoJAwMs+QI9foIvKAWheBfNmFqI3PBgQFpk2pS
         JoTbWVeQMTl/RYVAG5J89IgySQl3G1cRgZEffMl+EtmJL7PtaS9dUt9em1PcQzfDuXgS
         9Lew==
X-Forwarded-Encrypted: i=1; AHgh+RorJ4Wsa2Y/DXz+3V6k0uXhZsTkWfhxFW4JypFDz97xthF+A7so14RLfqTBcc/2S8thVLTeKlNhpqL22A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fdo50TCxa42pCblQ5e/yXVqX0hyRi1xbmZkbdnHtyORJcaL+
	nPzJ1d/2lR10JEFMBsF7mXWBBhH3JA6HpHrqQQlkk3fc4wEJngCCvSlQYAfj1GLKvQ==
X-Gm-Gg: AR+sD10Bu7wRpETxYk1E81NJGnnr/bffvtqNBvOVp4AdcJKzeXo7r0QRtm8ImH2Imm4
	mCxLz1HSRu4UdObKSpMPZscZVK7h1IUbCFy+LLEX97gVWf4KICC3O8u8BPG64TBBbdDwlpqI1p7
	VtQx0CqEIJB3DIAd0k6KXS8W9viMb0eKwtDNcWwfLxWt00pU3pVeapNSaMsJUssDDk3wzfGHFZs
	AG0S8YATg4gKOmaON9VsslTLBiPd4AiXh0Ed7mSuexGjamynOSdM7cfHdKCaQxHoxpkEuScY3WN
	whZ28IRALzFskUxjoqwOH8aSg89fvYj2tiFcFkx3Uym4KlGJw06n8Sh8fe92uls18Ddw5+0dYIo
	z30ot4bBCj+zgxzSBbXbaSgVxl2NsEB4WAxs6heNEL95aRirILWuYOCP52gRXmBHsuG0OU9IC1P
	IDu4RSm2V4x87Xd9OnZIh2200FRL/5jyVdFzYu9RC9F5HIy8k78EafNwmZNve98x9LMJSBjepdD
	i2MrYPRfA1qExujruUgPYeyJB+HxpWel0Fo2UDWVMguX5ziCPRh
X-Received: by 2002:a17:90b:4d91:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3903c53799cmr2986763a91.1.1785896356174;
        Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d1971besm543489a91.0.2026.08.04.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:19:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] zram: freeze device queue before device reset
Date: Wed,  5 Aug 2026 11:18:44 +0900
Message-ID: <20260805021854.1057715-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device reset does not take into account in-flight async IO
requests so we can free meta table and reset device concurrently
with those requests being executed. The block layer guidelines
indicate that queue state should be protected by blk_mq_freeze_queue()
during teardown.  Freeze zram queue before device reset.

Fixes: cd67e10ac699 ("zram: promote zram from staging")
Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56183c827e1b..3b9dfcae9317 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
@@ -2842,6 +2843,9 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
+	unsigned int memflags;
+
+	memflags = blk_mq_freeze_queue(zram->disk->queue);
 	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
@@ -2855,6 +2859,7 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+	blk_mq_unfreeze_queue(zram->disk->queue, memflags);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.55.0.571.g244d577d93-goog

