Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC7C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 17:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCXR7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCXR7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:23 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B801CBF6
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:01 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id r5so2210908qtp.4
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PKqdJFHlMUFZNUEvpL9gBzLYs3G0zKQPB+NnAYo5GY=;
        b=6q01wNZghiu5vTIOY50dkjlSGuef4DKnCR+NpCJuCjUY2FyqXE0dLsdGYs1v8J5iBM
         phGfnkutbv9hF/frVuZdgxSULfB826uoM7rrlq4Mb+lq1/CrDRExf/haK5rKJj42BIu/
         JBVj0KGJvcMmoLjTk9Cv+u0netVzDoE3aN7Swe4p9mCUsTuVBOBInZ2IIXdO4iJRFm11
         Eil0TtuA35WZ76ehGzEPRzKynfeESmp/5lr+mp+mw68WWzD7PAyP26tqJx5VrrTvWmkZ
         VBWfY37Co9FeHzEx1oHq6Tfaw68RLXNde767gPr0fZwZx5bQJdcgmow0RkGwahYFlK1v
         oXFw==
X-Gm-Message-State: AO0yUKVYhyY+LChUNzB5q+bREegg/DK3h/bBP7aJSSl63hQBr6dX8gM+
        0Q51iAR1LMoEh3rx27YibZjc
X-Google-Smtp-Source: AK7set9Pa75MSe7qmMCQ3y5qWv/TuU6NoOI8MAEdwIhKnMW5+8A7tzWu6CW0B4S958q2mr3a15g4Ww==
X-Received: by 2002:a05:622a:4:b0:3e3:8e11:ca56 with SMTP id x4-20020a05622a000400b003e38e11ca56mr7064409qtw.37.1679680632164;
        Fri, 24 Mar 2023 10:57:12 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a228a00b00745b3e62006sm14396384qkh.23.2023.03.24.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:11 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 8/9] dm: split discards further if target sets max_discard_granularity
Date:   Fri, 24 Mar 2023 13:56:55 -0400
Message-Id: <20230324175656.85082-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block core (bio_split_discard) will already split discards based
on the 'discard_granularity' and 'max_discard_sectors' queue_limits.
But the DM thin target also needs to ensure that it doesn't receive a
discard that spans a 'max_discard_sectors' boundary.

Introduce a dm_target 'max_discard_granularity' flag that if set will
cause DM core to split discard bios relative to 'max_discard_sectors'.
This treats 'discard_granularity' as a "min_discard_granularity" and
'max_discard_sectors' as a "max_discard_granularity".

Requested-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.c               | 25 +++++++++++++++++++------
 include/linux/device-mapper.h |  6 ++++++
 include/uapi/linux/dm-ioctl.h |  4 ++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b6ace995b9ca..6eb0748a3bb2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1162,7 +1162,8 @@ static inline sector_t max_io_len_target_boundary(struct dm_target *ti,
 	return ti->len - target_offset;
 }
 
-static sector_t max_io_len(struct dm_target *ti, sector_t sector)
+static sector_t __max_io_len(struct dm_target *ti, sector_t sector,
+			     unsigned int max_granularity)
 {
 	sector_t target_offset = dm_target_offset(ti, sector);
 	sector_t len = max_io_len_target_boundary(ti, target_offset);
@@ -1173,11 +1174,16 @@ static sector_t max_io_len(struct dm_target *ti, sector_t sector)
 	 *   explains why stacked chunk_sectors based splitting via
 	 *   bio_split_to_limits() isn't possible here.
 	 */
-	if (!ti->max_io_len)
+	if (!max_granularity)
 		return len;
 	return min_t(sector_t, len,
 		min(queue_max_sectors(ti->table->md->queue),
-		    blk_chunk_sectors_left(target_offset, ti->max_io_len)));
+		    blk_chunk_sectors_left(target_offset, max_granularity)));
+}
+
+static inline sector_t max_io_len(struct dm_target *ti, sector_t sector)
+{
+	return __max_io_len(ti, sector, ti->max_io_len);
 }
 
 int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
@@ -1562,12 +1568,13 @@ static void __send_empty_flush(struct clone_info *ci)
 }
 
 static void __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
-					unsigned int num_bios)
+					unsigned int num_bios,
+					unsigned int max_granularity)
 {
 	unsigned int len, bios;
 
 	len = min_t(sector_t, ci->sector_count,
-		    max_io_len_target_boundary(ti, dm_target_offset(ti, ci->sector)));
+		    __max_io_len(ti, ci->sector, max_granularity));
 
 	atomic_add(num_bios, &ci->io->io_count);
 	bios = __send_duplicate_bios(ci, ti, num_bios, &len);
@@ -1603,10 +1610,16 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 					  struct dm_target *ti)
 {
 	unsigned int num_bios = 0;
+	unsigned int max_granularity = 0;
 
 	switch (bio_op(ci->bio)) {
 	case REQ_OP_DISCARD:
 		num_bios = ti->num_discard_bios;
+		if (ti->max_discard_granularity) {
+			struct queue_limits *limits =
+				dm_get_queue_limits(ti->table->md);
+			max_granularity = limits->max_discard_sectors;
+		}
 		break;
 	case REQ_OP_SECURE_ERASE:
 		num_bios = ti->num_secure_erase_bios;
@@ -1627,7 +1640,7 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 	if (unlikely(!num_bios))
 		return BLK_STS_NOTSUPP;
 
-	__send_changing_extent_only(ci, ti, num_bios);
+	__send_changing_extent_only(ci, ti, num_bios, max_granularity);
 	return BLK_STS_OK;
 }
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 7975483816e4..8aa6b3ea91fa 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -358,6 +358,12 @@ struct dm_target {
 	 */
 	bool discards_supported:1;
 
+	/*
+	 * Set if this target requires that discards be split on both
+	 * 'discard_granularity' and 'max_discard_sectors' boundaries.
+	 */
+	bool max_discard_granularity:1;
+
 	/*
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 7edf335778ba..1990b5700f69 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -286,9 +286,9 @@ enum {
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	47
+#define DM_VERSION_MINOR	48
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2022-07-28)"
+#define DM_VERSION_EXTRA	"-ioctl (2023-03-01)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
-- 
2.40.0

