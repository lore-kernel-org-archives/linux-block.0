Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21980C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjC0UOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjC0UOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:19 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FAE1FD0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:29 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id bz27so9824350qtb.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PKqdJFHlMUFZNUEvpL9gBzLYs3G0zKQPB+NnAYo5GY=;
        b=LNhGbnQ872T6kfvd8On5BE3swsvg6RPnCAsE2Cxsk20+d8Fv/S8cKRHP0n7319K436
         CDBGd6AmWvjb4cbXM1f6HtnTTG2Ize3oXs5AdZCeS2NnqbIKFhnhgu2ZoRqUjdHyaSVh
         SPXMPtI7lJtn32PFtyJuA84LXoAQ81C9+VtD5rnI0HotZPbm/vL90EYitFPNMdjUHhaX
         HesIw/sGsVrdWTG5vlI1vF+CHCEb1q2R++tccDUGKHBrYo26lOWVT3pF2SAI6C38RQHr
         RNndI93i4b+5IO643GTlgP9GmbZQtkcf4gfLjiwUCUgMwQvTIzR7knwKRHv4tSRSOkjU
         VwPA==
X-Gm-Message-State: AO0yUKX63OkLZkX1EWy96u6LmkUvGB3k9IyhQ1Sk/CsMZUnvzlJQRIZO
        VU3ouB7wAAfQpRYpepRvAY9Y
X-Google-Smtp-Source: AK7set8CW+cpPq4Pp9FJfsBjh5ZA7tWZLyqOfAoMlX+sA6HGXom7lYbcNpi3u7woOx27vLDKG9NLYA==
X-Received: by 2002:a05:622a:1a98:b0:3d8:9b45:d362 with SMTP id s24-20020a05622a1a9800b003d89b45d362mr21296148qtc.28.1679948008860;
        Mon, 27 Mar 2023 13:13:28 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id m64-20020a375843000000b0073b8512d2dbsm16899758qkb.72.2023.03.27.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:28 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 13/20] dm: split discards further if target sets max_discard_granularity
Date:   Mon, 27 Mar 2023 16:11:36 -0400
Message-Id: <20230327201143.51026-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
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

