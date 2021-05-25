Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D976C47087
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A6E6138C
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEYV0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36441 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhEYV0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977915; x=1653513915;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qHj3M9XFL/tykUsf56Cg90qnsKbQHFHiajzEaN4c+7Y=;
  b=lb4WMvI45zpFU3Yis245VL5Bk2RTgx8BlVpwRorW+6oubXpFLxe20CQF
   iIik1kzEuUvvGUVGHH26EQzkLdmLN+PBoErh1KAW/0TwK+565YXTIa+lU
   DANixe3lgqPTwnvWddC3tXFTl6hAHZKmQJ850MyBDLoTeblFHjS+I+3fr
   bfIv9fZowbX66Mk3pubDV7lO8flU0FayUZd93AI9wLYG1JvKRtaFwYxmD
   6/KTVH2BmR7Ab4ISO8ywi1WapUZBLcWCp5VATc+zQXb1dYswL6Zsss+G4
   LRS07pLsDgKWjcxqmY6KBMGlkoO2UPN3UpveAb6mosQtxfswwo6QkQayy
   Q==;
IronPort-SDR: 4aqBaFOPxIWwtAQ2cMd1FST12Kkp1hTzLsycO/JQbKZGGPmJRugj2GUgRc+LMlbV1Ns9hw5pQw
 wCMMd5TyNjY/LIQI28hK3P741xeruFFKDsql6uDmEqBXbT2BMZr/QMkT5W9wvWAQ9LmY0hy/xc
 RStPvaLYPY4p0tRSYjtWYVsXrWnH8dk5KjvAVZ+PGWySnOQrPtYcswMAoORKKrAOqUUvesWhe+
 63wEXW4LbcTdXwSoRaMx7g8aGU5SgP7f9rQNqKK5cZ+kiov2SiAXUSAF/SkCia1+hRPiF8PB+r
 HDE=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717544"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:15 +0800
IronPort-SDR: rc+Pe9SwTQTrsvgorcjsPqao+Mx4cSXQ8fQD4WQN9yxBCsWw/MGDBGc0IoOkZ44UpoR8NS7ofV
 ZE6218DUkc0r8eI4GDVxjDW3hHO2dBo3cz3S5Ip8G+fsY2gbyBPzQzcPYCeFpAoKao4W9yqDlc
 QDfe39Co9/DwtMezXBd0yxxgatbe+eHsiHcgL0e9eHRy8pB6cbvvynGZ0KIf0Zs5057qzziuX2
 vb299YVpN+LaMByhb+rkz7iEUK1MM4fefYb3WD2nDHHNA1Mgqgj0whGKhftpHumBCBX+TrAmgf
 h4bv68Bvk4gCwYm64M35fiR8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:42 -0700
IronPort-SDR: xEuFmaKQgjMwJH+B41lM58oV43m0MVuK4NhI2z06SszfC0Lf2a6om3NjXE2LgFLumNV7I5x9Pc
 BZNUkf5C5s3Znc46xCyUH140EwnXtkLIv+zNItNDstCLg94ITt7pV7PgbIcMfbqc+K16mzxpgR
 hBuZ05VbsVJ3LNVdOuXY4uBqPDN3JDADN58NL9VaOKu0KQHjwGPajQ8xRKlnsn14MZnucoJk3A
 mVBqLniix6kaKbR1JstC0wEStQrpEbJzc4aHs+Yp/I7JWCkmJVGevbWuhavr8UxcT5zetSCOIe
 WRc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:14 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 09/11] dm: rearrange core declarations
Date:   Wed, 26 May 2021 06:24:59 +0900
Message-Id: <20210525212501.226888-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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
index ed8c5a8df2e5..c200658d8bcb 100644
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
@@ -1246,7 +1201,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->io_count);
+	dm_io_inc_pending(io);
 	sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1272,7 +1227,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_IOERR);
+		dm_io_dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1280,7 +1235,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 			up(&md->swap_bios_semaphore);
 		}
 		free_tio(tio);
-		dec_pending(io, BLK_STS_DM_REQUEUE);
+		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
 		DMWARN("unimplemented target map return value: %d", r);
@@ -1569,7 +1524,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		error = __send_empty_flush(&ci);
-		/* dec_pending submits any data associated with flush */
+		/* dm_io_dec_pending submits any data associated with flush */
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
 		ci.sector_count = 0;
@@ -1610,7 +1565,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 	}
 
 	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 	return ret;
 }
 
-- 
2.31.1

