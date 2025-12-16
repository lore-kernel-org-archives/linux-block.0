Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DF2ED843
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866163; cv=none; b=MAGyBMqtg9n84dAKEblU6v/sRa1OyOZMUpFiUaADF1oz+1IxY2hk/ovc4X950L4NuIKy32nDDatg/apS4eVR5ZV2hUexCHlNGqjkFYKJhy4VXpCHmV/RoSHC9aqqeOc6Lcf9tME9D5YJIrTkfVW3xm5jaEJ45mGe2PQtmwLXNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866163; c=relaxed/simple;
	bh=qmw9ImX/YTRWXCWXUJbm1ljcraMbyNZu371+0OyW1eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9s1oSMOTox4i2M/v5/d78quTDaJBGwF16rbTWZB/M+CYYFcUfKhKwmLyarCIKuNnISOTNHKRModJKsDPyRZqe57x+/wUcj1o4/bytpBiCjSwHJSVtyn6OLpN9b1SsgS9hErfqvIofpsPR0AtO79LQQwmu3pPI9ugsxLcUwBa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=fail smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2n6Yk6o; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2n6Yk6o"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c708702dfso2129248a91.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 22:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765866157; x=1766470957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zu/aPcKxXc3G/+SG7emrL7RZpvxEzm7psqqNr+dNYaY=;
        b=G2n6Yk6oxfCa8gVCQpp9vKS9A5TCgl7RNdD9VYW7xf5Cs2sAHYzKHpVoZ9vGTdXIIJ
         oYfuPLiuJwG6ZLlZLYyjqIl47INnwxUI4DyAKu5Fwf8TvywURcUffMa3qf9kpzWK0Idk
         W6JDkF+vFwLhZAevaloPJAmZIfwubSL0Luq5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866157; x=1766470957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu/aPcKxXc3G/+SG7emrL7RZpvxEzm7psqqNr+dNYaY=;
        b=wfFy3fhg4JtMv2T79CDphXb85+hQlmM2nmr8yCRArsd4iv+37PBJ6z6wXl2vd0oqkc
         VRj+FC88P224Zq23d2sDDyr9LkF9IZ+pD+9yIpIhvpkk2XqmoJnDhUj9WqxXSHm7Dw4w
         wAoshhxB7yM6+1/ru8JwP8ISoCf8G/EzEbrrFtwfXkB20C4hJ24KEErmp1sqXl3LdsZT
         KJhJPsnYbuGeag5+01SrWIdiqSHKiG6DydrRwaMVHgx2dxIixVVsr+2hckprW+Hb6SiN
         iDs/mcsyCXnm8vM2tTglyeWSR+G9ycsn/dvYPskc52vXAs50i+zP541tFB7IHJKYqa2m
         CDCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTWwNwWybaQk9ghKi8bUq5176i2z8qaW9W5Rm7ogZIY6x5igamxB25jAkXdS+DIX/CyMa8ZQAEY970Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyadlMRoQgW8IX98ExCDoo3Ve+pFm5GbRn9nIOj99n7Fp589EkM
	JdG5Udj4dDj2IpEzsDD+yVshDvVv/LTEbPxx8cAGoX0UZFvmOKIlOLsRQ7VMpf/nwQ==
X-Gm-Gg: AY/fxX5l0bANrPsPs5q8AGlu8Jh/qcZ2rSmnyULe/raS6MPy7TwA0ANfDNTwBGGxphJ
	ECSUb8t1O2KVEcrT9MitmF0A//Vcqq/FSDio+upKHQR1Egr45k6PfaTw8gN1UButzPNYB7zKLsg
	FTxLMEyGmHaaBHG/5GvCtokjqneQqFNeSQEIsUrB5d8SZxDk/pkg7LriSQDeYM/TtsjeE/VZ7NM
	EPnBS8CGtjvZCZIZ1KMHR666zh/e4XCiiJXvwqCLUhu3FTCFT5sgrEEeMgOksfhGw+gp0/K45HG
	zFh88oAEhzjV/mP+YTLZbK7aStASCsA07V0stA9zcCHu3N/HA9ZosfQ/9esDeeftF00T9MstWi4
	fyXxx9vIrqdMMa8EQgQVOYmLD4xMfSeYQ/8XIINirqf0YqFHxqtdPFIf3KJLwK7Yux+yzWTgwZa
	4o6drZpPf2OZHi5tns+jlHJqMCmf4jr4TjXnjF9DmFR2Eorg94ojcFLtUElTIUNeXX55E8lPY27
	w==
X-Google-Smtp-Source: AGHT+IGJrR7OtPtBhGm+9cDWg3KKBC6FnmouGC8vC5VDtsqiXV8EEGO4Aj1PKtsQ0CNxkvAqtSYZ9g==
X-Received: by 2002:a17:90b:180c:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-34abd6c0312mr9010865a91.2.1765866157264;
        Mon, 15 Dec 2025 22:22:37 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a48f:6b66:399d:86cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3dea94sm11038126a91.11.2025.12.15.22.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:22:36 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] zram: drop pp_in_progress
Date: Tue, 16 Dec 2025 15:22:23 +0900
Message-ID: <20251216062223.647520-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pp_in_progress makes sure that only one post-processing
(writeback or recomrpession) is active at any given time.
Functionality wise it, basically, shadows zram init_lock,
when init_lock is acquired in writer mode.

Switch recompress_store() and writeback_store() to take
zram init_lock in writer mode, like all store() sysfs
handlers should do, so that we can drop pp_in_progress.
Recompression and writeback can be somewhat slow, so
holding init_lock in writer mode can block zram attrs
reads, but in reality the only zram attrs reads that
take place are mm_stat reads, and usually it's the same
process that reads mm_stat and does recompression or
writeback.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 28 ++++++----------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 634848f45e9b..47826d8ed376 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1264,24 +1264,16 @@ static ssize_t writeback_store(struct device *dev,
 	ssize_t ret = len;
 	int err, mode = 0;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1))
-		return -EAGAIN;
-
-	if (!zram->backing_dev) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!zram->backing_dev)
+		return -ENODEV;
 
 	pp_ctl = init_pp_ctl();
-	if (!pp_ctl) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!pp_ctl)
+		return -ENOMEM;
 
 	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
@@ -1358,7 +1350,6 @@ static ssize_t writeback_store(struct device *dev,
 out:
 	release_pp_ctl(zram, pp_ctl);
 	release_wb_ctl(wb_ctl);
-	atomic_set(&zram->pp_in_progress, 0);
 
 	return ret;
 }
@@ -2622,14 +2613,10 @@ static ssize_t recompress_store(struct device *dev,
 	if (threshold >= huge_class_size)
 		return -EINVAL;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1))
-		return -EAGAIN;
-
 	if (algo) {
 		bool found = false;
 
@@ -2700,7 +2687,6 @@ static ssize_t recompress_store(struct device *dev,
 	if (page)
 		__free_page(page);
 	release_pp_ctl(zram, ctl);
-	atomic_set(&zram->pp_in_progress, 0);
 	return ret;
 }
 #endif
@@ -2891,7 +2877,6 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	atomic_set(&zram->pp_in_progress, 0);
 	reset_bdev(zram);
 
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
@@ -3127,7 +3112,6 @@ static int zram_add(void)
 	zram->disk->fops = &zram_devops;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
-	atomic_set(&zram->pp_in_progress, 0);
 	zram_comp_params_reset(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 48d6861c6647..469a3dab44ad 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -143,6 +143,5 @@ struct zram {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
 #endif
-	atomic_t pp_in_progress;
 };
 #endif
-- 
2.52.0.239.gd5f0c6e74e-goog

