Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FCC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F90364DD7
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBKWzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBKWzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 17:55:14 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F6C06178C
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:53:55 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id r15so5766045qke.5
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nMk2rpCCOeT8dI5UTilvWQY64g/eZhRKWUUyT5Ql4No=;
        b=C8iBF1ueyOKFu2vl33L9zFcRuhPmqdByeBFr8XrUOKKYRy5p8LQjoVwgzqb7sfnMmO
         na8mDZX/jZ2S6pzYjdQkyI9mfjNAMk/PpaiJhrJTCn3VWpX+vxrSThxDjyLBwi8RYV+z
         jNbpjp62GHsgVR/bPjgBuhccwnwqBV0rJHn1+d6B3c5rz6w7V1QJ2NU0rmYe4468xmaC
         2JUSyS2zwc1xTd18HCCrun8Qp/nnEGIJrcPttdn9dYC2mqtXSFSYL8RKBJXi+h+Fs/SP
         /fDU614hXvW4xJygc/EpqElZg/o9YeMFb5mYKHpx8+NCQFC3cAveULBTzuFel76DcSba
         2vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nMk2rpCCOeT8dI5UTilvWQY64g/eZhRKWUUyT5Ql4No=;
        b=jEfmJTgGjZfn3RU+rJCJ51fKZ0KntXLsBwtpZ1LeGiWyMAGKqV2+y5ZpK2tj5I9k9W
         IcTQrRv2m/FpVfU+vwnWlV2rwWz3HGnihHGIEPEcoLZECmRCMKS/ypWeu8AeO6+rC2pZ
         iDhe9hI1AJWS8rBxrTYkQRtY88FH28sKMAvaPLyONJhnfcX8ggCgX8Jp8cMlfv+4A9aU
         SuuUzYVs/MiFn4bHCuc7M65UIm2qQaMrhaVAO8hPA2VFcp1+ufV1O9Lxgcncez34pZnY
         piXlykEN+Ercqru7x3Tvg4FqNFYgih5tT8TQEX+I7xYULx28JHhKj/lq6ekYDeXgabDW
         EYWw==
X-Gm-Message-State: AOAM533rXxgxcxLBtW5Hw00j7P2rsLLINDuKBnTMigwluC+DQqtBwwsP
        HQw9RqrHmQIsg2Z3fax3I41uKOTvcFDxs4eaHyB1pIjum/HTey0wJ44jkZtweUqpCRG/4kAuujf
        iuPXL6NEaQhOt+/Zz9dv73tdSCG/grfJ88NpLItRP3ZpJLMTzzWqLftl0djFTps81JXlD
X-Google-Smtp-Source: ABdhPJyG32mdUz4eBbKeGyy/PmmHbi/ttUKwroKRd3kbGS67NKnukMk6VMjhAKDuY6XFP1/8km2XyBVIT2o=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:574:: with SMTP id
 cj20mr185686qvb.37.1613084034268; Thu, 11 Feb 2021 14:53:54 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:41 +0000
In-Reply-To: <20210211225343.3145732-1-satyat@google.com>
Message-Id: <20210211225343.3145732-4-satyat@google.com>
Mime-Version: 1.0
References: <20210211225343.3145732-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 3/5] dm: add support for passing through inline crypto support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the device-mapper core to support exposing the inline crypto
support of the underlying device(s) through the device-mapper device.

This works by creating a "passthrough keyslot manager" for the dm
device, which declares support for encryption settings which all
underlying devices support.  When a supported setting is used, the bio
cloning code handles cloning the crypto context to the bios for all the
underlying devices.  When an unsupported setting is used, the blk-crypto
fallback is used as usual.

Crypto support on each underlying device is ignored unless the
corresponding dm target opts into exposing it.  This is needed because
for inline crypto to semantically operate on the original bio, the data
must not be transformed by the dm target.  Thus, targets like dm-linear
can expose crypto support of the underlying device, but targets like
dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)

A DM device's table can only be changed if the "new" inline encryption
capabilities are a (*not* necessarily strict) superset of the "old" inline
encryption capabilities.  Attempts to make changes to the table that result
in some inline encryption capability becoming no longer supported will be
rejected.

For the sake of clarity, key eviction from underlying devices will be
handled in a future patch.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 drivers/md/dm-core.h          |  12 +++
 drivers/md/dm-table.c         | 159 ++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  18 +++-
 include/linux/device-mapper.h |  12 +++
 4 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 086d293c2b03..f4196ecd6132 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -13,6 +13,7 @@
 #include <linux/ktime.h>
 #include <linux/genhd.h>
 #include <linux/blk-mq.h>
+#include <linux/keyslot-manager.h>
 
 #include <trace/events/block.h>
 
@@ -162,6 +163,17 @@ struct dm_table {
 	void *event_context;
 
 	struct dm_md_mempools *mempools;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	/*
+	 * Keyslot manager representing the crypto capabilities of this table.
+	 * This field is only set temporarily, while the table is loaded but
+	 * not swapped in. When the table is swapped in, this field is set to
+	 * NULL after the capabilities are transferred to the request queue of
+	 * the device.
+	 */
+	struct blk_keyslot_manager *ksm;
+#endif
 };
 
 static inline struct completion *dm_get_completion_from_kobject(struct kobject *kobj)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 4acf2342f7ad..fbaadfc6eed9 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -187,6 +187,8 @@ static void free_devices(struct list_head *devices, struct mapped_device *md)
 	}
 }
 
+static void dm_table_destroy_keyslot_manager(struct dm_table *t);
+
 void dm_table_destroy(struct dm_table *t)
 {
 	unsigned int i;
@@ -215,6 +217,8 @@ void dm_table_destroy(struct dm_table *t)
 
 	dm_free_md_mempools(t->mempools);
 
+	dm_table_destroy_keyslot_manager(t);
+
 	kfree(t);
 }
 
@@ -1203,6 +1207,154 @@ static int dm_table_register_integrity(struct dm_table *t)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+struct dm_keyslot_manager {
+	struct blk_keyslot_manager ksm;
+	struct mapped_device *md;
+};
+
+static int device_intersect_crypto_modes(struct dm_target *ti,
+					 struct dm_dev *dev, sector_t start,
+					 sector_t len, void *data)
+{
+	struct blk_keyslot_manager *parent = data;
+	struct blk_keyslot_manager *child = bdev_get_queue(dev->bdev)->ksm;
+
+	blk_ksm_intersect_modes(parent, child);
+	return 0;
+}
+
+void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
+{
+	struct dm_keyslot_manager *dksm = container_of(ksm,
+						       struct dm_keyslot_manager,
+						       ksm);
+
+	if (!ksm)
+		return;
+
+	blk_ksm_destroy(ksm);
+	kfree(dksm);
+}
+
+static void dm_table_destroy_keyslot_manager(struct dm_table *t)
+{
+	dm_destroy_keyslot_manager(t->ksm);
+	t->ksm = NULL;
+}
+
+/*
+ * Initializes t->ksm with a keyslot manager that represents the common set of
+ * crypto capabilities of the devices described by the dm_table. However, if the
+ * constructed keyslot manager does not support a superset of the crypto
+ * capabilities supported by the current keyslot manager of the mapped_device,
+ * it returns an error instead, since we don't support restricting crypto
+ * capabilities on table changes. Finally, if the constructed keyslot manager
+ * doesn't actually support any crypto modes at all, it set @t->ksm to NULL
+ * (since a NULL ksm represents support for no capabilities) and returns 0
+ * (representing success).
+ */
+static int
+dm_table_construct_keyslot_manager(struct dm_table *t)
+{
+	struct dm_keyslot_manager *dksm;
+	struct blk_keyslot_manager *ksm;
+	struct dm_target *ti;
+	unsigned int i;
+	bool ksm_is_empty = true;
+
+	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
+	if (!dksm)
+		return -ENOMEM;
+	dksm->md = t->md;
+
+	ksm = &dksm->ksm;
+	blk_ksm_init_passthrough(ksm);
+	ksm->max_dun_bytes_supported = UINT_MAX;
+	memset(ksm->crypto_modes_supported, 0xFF,
+	       sizeof(ksm->crypto_modes_supported));
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!dm_target_passes_crypto(ti->type)) {
+			blk_ksm_intersect_modes(ksm, NULL);
+			break;
+		}
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
+					  ksm);
+	}
+
+	if (t->md->queue && !blk_ksm_is_superset(ksm, t->md->queue->ksm)) {
+		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
+		dm_destroy_keyslot_manager(ksm);
+		return -EINVAL;
+	}
+
+	/*
+	 * If the new KSM doesn't actually support any crypto modes, we may as
+	 * well represent it with a NULL ksm.
+	 */
+	ksm_is_empty = true;
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i]) {
+			ksm_is_empty = false;
+			break;
+		}
+	}
+
+	if (ksm_is_empty) {
+		dm_destroy_keyslot_manager(ksm);
+		ksm = NULL;
+	}
+
+	t->ksm = ksm;
+
+	return 0;
+}
+
+static void dm_update_keyslot_manager(struct request_queue *q,
+				      struct dm_table *t)
+{
+	if (!t->ksm)
+		return;
+
+	/* Make the ksm less restrictive */
+	if (!q->ksm) {
+		blk_ksm_register(t->ksm, q);
+	} else {
+		blk_ksm_update_capabilities(q->ksm, t->ksm);
+		dm_destroy_keyslot_manager(t->ksm);
+	}
+	t->ksm = NULL;
+}
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static int
+dm_table_construct_keyslot_manager(struct dm_table *t)
+{
+	return 0;
+}
+
+void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
+{
+}
+
+static void dm_table_destroy_keyslot_manager(struct dm_table *t)
+{
+}
+
+static void dm_update_keyslot_manager(struct request_queue *q,
+				      struct dm_table *t)
+{
+}
+
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 /*
  * Prepares the table for use by building the indices,
  * setting the type, and allocating mempools.
@@ -1229,6 +1381,12 @@ int dm_table_complete(struct dm_table *t)
 		return r;
 	}
 
+	r = dm_table_construct_keyslot_manager(t);
+	if (r) {
+		DMERR("could not construct keyslot manager.");
+		return r;
+	}
+
 	r = dm_table_alloc_md_mempools(t, t->md);
 	if (r)
 		DMERR("unable to allocate mempools");
@@ -1891,6 +2049,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 #endif
 
+	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7bac564f3faa..ee0434764941 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -28,6 +28,7 @@
 #include <linux/refcount.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
 
 #define DM_MSG_PREFIX "core"
 
@@ -1718,6 +1719,19 @@ static const struct dax_operations dm_dax_ops;
 
 static void dm_wq_work(struct work_struct *work);
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+static void dm_queue_destroy_keyslot_manager(struct request_queue *q)
+{
+	dm_destroy_keyslot_manager(q->ksm);
+}
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline void dm_queue_destroy_keyslot_manager(struct request_queue *q)
+{
+}
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
@@ -1739,8 +1753,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		put_disk(md->disk);
 	}
 
-	if (md->queue)
+	if (md->queue) {
+		dm_queue_destroy_keyslot_manager(md->queue);
 		blk_cleanup_queue(md->queue);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..f7198b492fea 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -257,6 +257,13 @@ struct target_type {
 #define DM_TARGET_NOWAIT		0x00000080
 #define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
 
+/*
+ * The target supports exposing the underlying device's inline encryption
+ * capabilities
+ */
+#define DM_TARGET_PASSES_CRYPTO		0x00000100
+#define dm_target_passes_crypto(type) ((type)->features & DM_TARGET_PASSES_CRYPTO)
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
@@ -533,6 +540,11 @@ void dm_table_run_md_queue_async(struct dm_table *t);
 struct dm_table *dm_swap_table(struct mapped_device *md,
 			       struct dm_table *t);
 
+/*
+ * Table keyslot manager functions
+ */
+void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm);
+
 /*
  * A wrapper around vmalloc.
  */
-- 
2.30.0.478.g8a0d178c01-goog

