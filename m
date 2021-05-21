Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D8C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161A66108D
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhEUDC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhEUDC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566093; x=1653102093;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mVWcuA33S1kgvwU9lvMHZjHYjL3rbxOlZv0XJKT/oqg=;
  b=oOojov0t+gUKW62xVaL67urGKYMMZeFQG3ORx3s2Mf/JPrx+6gdyJA/x
   faYdUufCMYJL0U5rS0Nil+ZAcd6nh+RoMV9ZH9KpcmY7iVEMB5O8FmKAu
   h/7cGuJobLoqypfMnkgWfuctyRhurQkcf1H4JrZn/AmCOQ+Um8mS1deoR
   Z1D4yo32nkOg65fh75uQrgd9nGOUAkjV+HYZwfaitNpRhNC2OWCdUjI6D
   nHcbRnBka7R5vXC7+t+1j5p7RuKx2PeoYJwMZiD5M+qDYRSIJaZyo3cpw
   FnN/alZeo6uBw1MKndFpj66/sVB+BNbv8jfxxs4qPTtkhFh4X7WBQsR4U
   g==;
IronPort-SDR: nfUV1uNcbpG+8Rf3PziMblEgDN3xa2YQ3jGRW13w6jx5RPdDw8qlTtoeR21bUOc98LTaG4k1zA
 99JakX6c5jl28m9A8bpFfyDGyCI8SL9mge3g2DcLl43dtTB2a2V1DwAle4h2S3ZKoPwZpTrF0i
 Wcc+lWjQ/sNR/c0cvD5IGJ34qsSBs3ZvyirfeUYRmwjCSgxuQJ/DAvf+3QpD2UG61DUQi/wZzi
 nFxmSSF74TqHFBveRAgBemGnpGNdwbwRyFXPRIYT93T2tumKDsKlaT6Uo6XobbQd9cvroLNdaV
 Hkk=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943890"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:33 +0800
IronPort-SDR: sey2g+GqGOxwE86IkB+QWoEgWnmVV4jVowRbXu7kCAaIYsxMolp/wpBs3/xng1XqfmOVwYSfpo
 0tCNbzRUDZvL83+NuP3xyBTlhs1mnIpz5PuHd4BIlm+74LLKGfljwpv0vE22gFdl0fP3YDfMDp
 qz8BkfZ2ArSOMvugBR9PnV3Pio/P0xvniiLAb8WS6cW8NsoYbyb5GSzKq+cO3KPirf4CI6m27L
 kuR1ekjSSVerAfX05KcbwKc6SVNq/adJme63q3GKuGhoncdIP2f+QWTS51TaQUHIOo8UYJ7uAv
 ymfrhePuq5AtCw5DQgby4vYq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:09 -0700
IronPort-SDR: vZc1obVH3qSWD/jUq9mfK4iY9tPm1e1SZ0Chfeq038Lw7l/fnCY+XCoeWwTI4FnGz6H47hcMY4
 aNi+e5zcoVZBkI3gB/1JPb8Mf+VSEyJzfcEKt8Wkv5MUfqUZfHn2HYSp5ZxNPBerinfGMmzaU7
 7VaYuCw4NBxBAQ40GJSCN9HjYtStao4hO+1ioiU+juK/1+5RfHxuiwKl5biCeqflhKdkn+mLfQ
 V/xBaQuk3VCKi5tts9PF937jbBzGsLjYDKJxRJ53WY05cBkPa+a0JDjhzSwjeaP6lbagrfom+q
 714=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 09/11] dm: rearrange core declarations
Date:   Fri, 21 May 2021 12:01:17 +0900
Message-Id: <20210521030119.1209035-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the definitions of struct dm_target_io, struct dm_io and of the
bits of the flags field of struct mapped_device from dm.c to dm-core.h
to make them usable from dm-zone.c.
For the same reason, declare dec_pending() in dm-core.h after renaming
it to dm_io_dec_pending(). And for symmetry of the function names,
introduce the inline helper dm_io_inc_pending() instead of directly
using atomic_inc() calls.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c      | 59 ++++++--------------------------------------
 2 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5953ff2bd260..cfabc1c91f9f 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -116,6 +116,19 @@ struct mapped_device {
 	struct srcu_struct io_barrier;
 };
 
+/*
+ * Bits for the flags field of struct mapped_device.
+ */
+#define DMF_BLOCK_IO_FOR_SUSPEND 0
+#define DMF_SUSPENDED 1
+#define DMF_FROZEN 2
+#define DMF_FREEING 3
+#define DMF_DELETING 4
+#define DMF_NOFLUSH_SUSPENDING 5
+#define DMF_DEFERRED_REMOVE 6
+#define DMF_SUSPENDED_INTERNALLY 7
+#define DMF_POST_SUSPENDING 8
+
 void disable_discard(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
@@ -173,6 +186,45 @@ struct dm_table {
 #endif
 };
 
+/*
+ * One of these is allocated per clone bio.
+ */
+#define DM_TIO_MAGIC 7282014
+struct dm_target_io {
+	unsigned int magic;
+	struct dm_io *io;
+	struct dm_target *ti;
+	unsigned int target_bio_nr;
+	unsigned int *len_ptr;
+	bool inside_dm_io;
+	struct bio clone;
+};
+
+/*
+ * One of these is allocated per original bio.
+ * It contains the first clone used for that original.
+ */
+#define DM_IO_MAGIC 5191977
+struct dm_io {
+	unsigned int magic;
+	struct mapped_device *md;
+	blk_status_t status;
+	atomic_t io_count;
+	struct bio *orig_bio;
+	unsigned long start_time;
+	spinlock_t endio_lock;
+	struct dm_stats_aux stats_aux;
+	/* last member of dm_target_io is 'struct bio' */
+	struct dm_target_io tio;
+};
+
+static inline void dm_io_inc_pending(struct dm_io *io)
+{
+	atomic_inc(&io->io_count);
+}
+
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error);
+
 static inline struct completion *dm_get_completion_from_kobject(struct kobject *kobj)
 {
 	return &container_of(kobj, struct dm_kobject_holder, kobj)->completion;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4426019a89cc..563504163b74 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -74,38 +74,6 @@ struct clone_info {
 	unsigned sector_count;
 };
 
-/*
- * One of these is allocated per clone bio.
- */
-#define DM_TIO_MAGIC 7282014
-struct dm_target_io {
-	unsigned magic;
-	struct dm_io *io;
-	struct dm_target *ti;
-	unsigned target_bio_nr;
-	unsigned *len_ptr;
-	bool inside_dm_io;
-	struct bio clone;
-};
-
-/*
- * One of these is allocated per original bio.
- * It contains the first clone used for that original.
- */
-#define DM_IO_MAGIC 5191977
-struct dm_io {
-	unsigned magic;
-	struct mapped_device *md;
-	blk_status_t status;
-	atomic_t io_count;
-	struct bio *orig_bio;
-	unsigned long start_time;
-	spinlock_t endio_lock;
-	struct dm_stats_aux stats_aux;
-	/* last member of dm_target_io is 'struct bio' */
-	struct dm_target_io tio;
-};
-
 #define DM_TARGET_IO_BIO_OFFSET (offsetof(struct dm_target_io, clone))
 #define DM_IO_BIO_OFFSET \
 	(offsetof(struct dm_target_io, clone) + offsetof(struct dm_io, tio))
@@ -137,19 +105,6 @@ EXPORT_SYMBOL_GPL(dm_bio_get_target_bio_nr);
 
 #define MINOR_ALLOCED ((void *)-1)
 
-/*
- * Bits for the md->flags field.
- */
-#define DMF_BLOCK_IO_FOR_SUSPEND 0
-#define DMF_SUSPENDED 1
-#define DMF_FROZEN 2
-#define DMF_FREEING 3
-#define DMF_DELETING 4
-#define DMF_NOFLUSH_SUSPENDING 5
-#define DMF_DEFERRED_REMOVE 6
-#define DMF_SUSPENDED_INTERNALLY 7
-#define DMF_POST_SUSPENDING 8
-
 #define DM_NUMA_NODE NUMA_NO_NODE
 static int dm_numa_node = DM_NUMA_NODE;
 
@@ -825,7 +780,7 @@ static int __noflush_suspending(struct mapped_device *md)
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
  */
-static void dec_pending(struct dm_io *io, blk_status_t error)
+void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 {
 	unsigned long flags;
 	blk_status_t io_error;
@@ -978,7 +933,7 @@ static void clone_endio(struct bio *bio)
 	}
 
 	free_tio(tio);
-	dec_pending(io, error);
+	dm_io_dec_pending(io, error);
 }
 
 /*
@@ -1247,7 +1202,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->io_count);
+	dm_io_inc_pending(io);
 	sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1273,7 +1228,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_IOERR);
+		dm_io_dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1281,7 +1236,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_DM_REQUEUE);
+		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
 		DMWARN("unimplemented target map return value: %d", r);
@@ -1570,7 +1525,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		error = __send_empty_flush(&ci);
-		/* dec_pending submits any data associated with flush */
+		/* dm_io_dec_pending submits any data associated with flush */
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
 		ci.sector_count = 0;
@@ -1611,7 +1566,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 	}
 
 	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 	return ret;
 }
 
-- 
2.31.1

