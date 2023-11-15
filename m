Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC644
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IbResloZ"
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1DBCA
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:42:33 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b56b618217so3752697b6e.0
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700016153; x=1700620953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNxsGh7O8Qrwyxy3QycDFsbHOojSVaRxAmLFQTto2P4=;
        b=IbResloZCbM+GRpuzwbCVcvtPBqgJlz7XjeuiBwyt1BycPgKmpNGGk5c7Ftp0+EQd/
         gFN76gwNWeTvez/nv3NGzrHdNDROoVMyHzSdBPFHk81qPYQ6ASi3UE2c9k7HFMXdfyKx
         I+JlHXcmyZCKBi+C+zO4sCfNMTC3HU4Chq4rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700016153; x=1700620953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNxsGh7O8Qrwyxy3QycDFsbHOojSVaRxAmLFQTto2P4=;
        b=tSkCJb4eMBjmjstwC2kV0kaffYAC2Xfa6Ar7XemsfeDSnI468KkdkEfvxCxhBPHbt7
         KmvMNen9hXaOEFPF+m9d7g6XyEiM8bPo0bODxm37M4+4Lb+BR9SLxTCjjt65LGN9ViDL
         +yDKndOd1McIepvnw4/63lnL7RHlsDOmOrVleNm1zgLdJ1h+umexjM1NsQscPg51vP5l
         mJ1fNc2tvgcxGx5sKdhTPQEBCuqP8jH/cfALJYI4ZQjD94zg3p9a7p1HYHIttpQTS1V/
         r9Yu0w+/ck70Npp5EV6giNFTyu/nLCdqC7huFvMQCj542VIqzSYPmsd1u0nZhQlnLcDj
         FC+w==
X-Gm-Message-State: AOJu0YxiMwpcZ5A44T0cTup5EN5RmeS4wq9RPU7TS5MXM9NL8A7/m51x
	Ksiui2ErZWAGSyLWD/+5NUNhR4CfD5xtBQ0YhzY=
X-Google-Smtp-Source: AGHT+IFn97al+iQz35GaoiLcoDHRp1U4+X5Wc4pvZ38la847bt/RUgOnYLlhOsTW6uqOHxWr6PddnQ==
X-Received: by 2002:a05:6808:2f17:b0:3af:983a:8129 with SMTP id gu23-20020a0568082f1700b003af983a8129mr15857252oib.53.1700016153179;
        Tue, 14 Nov 2023 18:42:33 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dfe3:bfcd:e155:c392])
        by smtp.gmail.com with ESMTPSA id c15-20020a62e80f000000b0068ffd56f705sm1862016pfi.118.2023.11.14.18.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 18:42:32 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zram: split memory-tracking and ac-time tracking
Date: Wed, 15 Nov 2023 11:42:12 +0900
Message-ID: <20231115024223.4133148-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZRAM_MEMORY_TRACKING enables two features:
- per-entry ac-time tracking
- debugfs interface

The latter one is the reason why memory-tracking depends
on DEBUG_FS, while the former one is used far beyond debugging
these days. Namely ac-time is used for fine-grained writeback
of idle entries (pages).

Move ac-time tracking under its own config option so that
it can be enabled (along with writeback) on systems without
DEBUG_FS.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  2 +-
 drivers/block/zram/Kconfig                  | 11 ++++++++-
 drivers/block/zram/zram_drv.c               | 27 ++++++++++-----------
 drivers/block/zram/zram_drv.h               |  2 +-
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index e4551579cb12..ee2b0030d416 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -328,7 +328,7 @@ as idle::
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
-Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
+Additionally, when CONFIG_ZRAM_TRACK_ENTRY_ACTIME is enabled pages can be
 marked as idle based on how long (in seconds) it's been since they were
 last accessed::
 
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 0386b7da02aa..af201392ed52 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -69,9 +69,18 @@ config ZRAM_WRITEBACK
 
 	 See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+config ZRAM_TRACK_ENTRY_ACTIME
+	bool "Track access time of zram entries"
+	depends on ZRAM
+	help
+	  With this feature zram tracks access time of every stored
+	  entry (page), which can be used for a more fine-grained IDLE
+	  pages writeback.
+
 config ZRAM_MEMORY_TRACKING
 	bool "Track zRam block status"
 	depends on ZRAM && DEBUG_FS
+	select ZRAM_TRACK_ENTRY_ACTIME
 	help
 	  With this feature, admin can track the state of allocated blocks
 	  of zRAM. Admin could see the information via
@@ -86,4 +95,4 @@ config ZRAM_MULTI_COMP
 	  This will enable multi-compression streams, so that ZRAM can
 	  re-compress pages using a potentially slower but more effective
 	  compression algorithm. Note, that IDLE page recompression
-	  requires ZRAM_MEMORY_TRACKING.
+	  requires ZRAM_TRACK_ENTRY_ACTIME.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d77d3664ca08..68e0a8187783 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -174,6 +174,14 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
+	zram->table[index].ac_time = ktime_get_boottime();
+#endif
+}
+
 static inline void update_used_max(struct zram *zram,
 					const unsigned long pages)
 {
@@ -293,8 +301,9 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
 				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
-#ifdef CONFIG_ZRAM_MEMORY_TRACKING
-			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
+#ifdef ZRAM_TRACK_ENTRY_ACTIME
+			is_idle = !cutoff || ktime_after(cutoff,
+							 zram->table[index].ac_time);
 #endif
 			if (is_idle)
 				zram_set_flag(zram, index, ZRAM_IDLE);
@@ -317,7 +326,7 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		u64 age_sec;
 
-		if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING) && !kstrtoull(buf, 0, &age_sec))
+		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) && !kstrtoull(buf, 0, &age_sec))
 			cutoff_time = ktime_sub(ktime_get_boottime(),
 					ns_to_ktime(age_sec * NSEC_PER_SEC));
 		else
@@ -841,12 +850,6 @@ static void zram_debugfs_destroy(void)
 	debugfs_remove_recursive(zram_debugfs_root);
 }
 
-static void zram_accessed(struct zram *zram, u32 index)
-{
-	zram_clear_flag(zram, index, ZRAM_IDLE);
-	zram->table[index].ac_time = ktime_get_boottime();
-}
-
 static ssize_t read_block_state(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -930,10 +933,6 @@ static void zram_debugfs_unregister(struct zram *zram)
 #else
 static void zram_debugfs_create(void) {};
 static void zram_debugfs_destroy(void) {};
-static void zram_accessed(struct zram *zram, u32 index)
-{
-	zram_clear_flag(zram, index, ZRAM_IDLE);
-};
 static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
@@ -1254,7 +1253,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
-#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
 	if (zram_test_flag(zram, index, ZRAM_IDLE))
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d090753f97be..3b94d12f41b4 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -69,7 +69,7 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
-#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
 };
-- 
2.43.0.rc0.421.g78406f8d94-goog

