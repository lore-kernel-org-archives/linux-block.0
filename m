Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hp7kN5eI"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE369129
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 17:36:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso1974635b3a.1
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 17:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700184962; x=1700789762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Ogejqs0EiJ3xA2QptK/5IeMxnM4VLXdfI939PQ67o=;
        b=hp7kN5eIf4PlMC8bcYe8nTivq2CtM1q+FCaTmhH9ILaOTjKxpYP2nFPgvS32ImLF7U
         jw3SnU5BX8eeJHWuY6Vw790MYS1XdQ0Z+w5RwSCEgSYap/0v2sPRPjm3fXOa7kfZTpwx
         dhJtDF1OAXPOghlbb8Jw2d7+QO/Z5RT7GFiao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184962; x=1700789762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1Ogejqs0EiJ3xA2QptK/5IeMxnM4VLXdfI939PQ67o=;
        b=pENM6OkUgw96iW/j1GJiiCttqtBZyGBu6ZqlieaSmbkub1rwYRx7g7N/17WPZELSbJ
         /Hxxf2LLZqb7fuyIueyFtUShVJ96ltfuE5l+a1NlhzWRegdf8ghPCNGbptg/MR3LOhzW
         lKZ1nIejs05ptDf0Wrw1+kQm/O+KzHqcqI/4TBX5+FXvugEr9yNHr1se+j4i4FVPKrak
         Zgyfj9r9ekUiYp5ZqoupAEJt1VO0qUHyzT1XYOyzeDIpVg/HQcmPhVjYvYX8n4nBQpPt
         uXd8njrzBivZyxU6/XOxCl+QzjTV6J2e4AUxFTJOMrW67cNGbHv43WX2trU+3YRV3sdv
         V1sA==
X-Gm-Message-State: AOJu0YztmMAEa7Ct4IV6E+T7lXqUS1HBKe6T004DE51G3DP8KmfBr/v4
	Q8y1bxjyGKKiliufx/uB22DSug==
X-Google-Smtp-Source: AGHT+IFutsPPJeCezg9ncaiWu7vmxMCIB1NH8QFjkhs2exGVXXIDsRE9zd5SWQLiWQqHytLDPOre1A==
X-Received: by 2002:a05:6a20:3d1b:b0:187:72e7:6d98 with SMTP id y27-20020a056a203d1b00b0018772e76d98mr5366964pzi.3.1700184962235;
        Thu, 16 Nov 2023 17:36:02 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:9bb8:f5e7:ec61:22c8])
        by smtp.gmail.com with ESMTPSA id fa42-20020a056a002d2a00b006933e71956dsm377190pfb.9.2023.11.16.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:36:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Dmytro Maluka <dmaluka@chromium.org>,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] zram: split memory-tracking and ac-time tracking
Date: Fri, 17 Nov 2023 10:35:20 +0900
Message-ID: <20231117013543.540280-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231115024223.4133148-1-senozhatsky@chromium.org>
References: <20231115024223.4133148-1-senozhatsky@chromium.org>
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
these days. Namely ac-time is used for fine grained writeback
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
+	  entry (page), which can be used for a more fine grained IDLE
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
index d77d3664ca08..f6b286e7f310 100644
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
+#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
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

