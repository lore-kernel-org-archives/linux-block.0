Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27979C433E9
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020E92226A
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgL2I4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL2I4m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD0C0617A0
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so22672710ybj.14
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AHsPHV5g9RiEHoBH6SgrbuZwM40nn1MQir4HViM7xto=;
        b=MCfJiSBd2EZKgC/S/1p8+aHytGwvZFZ6W+n4r13mqlO867CotMVZeChoW8nF1zidB7
         3bGVdI5YxcZXoWuEwqAYXwiDUB9s9kCK2pUeaoDCp0MbEwwsVuSPbCfwtkC0gUG/HguW
         bUb2Im9l+9h5S0QL09SGUEt+h0PgNSKrO6l6w5FuKvhFXR3VUYWPDPulpBt9MjhOEicH
         JTOt63xSY0iQ0S5pwmpYyWv2uMJxggz2xQ77Db4FmZ3vlR5RP/YU/IrRd0ikxslwhSXX
         KlKrN6jIRBX/rcH5HGL5Dut+rg9QciYjxsgYCMkB2H2c0jqanznebgyp1CUMm5goILoa
         Spaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AHsPHV5g9RiEHoBH6SgrbuZwM40nn1MQir4HViM7xto=;
        b=I+fvgdfgMHgzuethn9wTKqcIGNQ+Yv58ucxetBF2XuM8wgP2OIj8SlA8tFOgSTA6j7
         4Ldnfa8DWfZHmSYJ4GcqNWWApLlkWPmx9VMMMhLnGsegHGGw1+u6ZnmEs7TPXiPtB/cZ
         TLWFi0Sr+arDZRNv9w/5wIM1D88T+Fjg9+/gI0uyz/sW9FQ1mWRfn4oNyS59Dok+Xuc3
         X5yiWxOdBaAv9BtSBi84tlLRQ/Ln6FSywlWL1eHCz3GEG+/wZy5mGrcFsj8CJ35AsBZE
         14JaMrF/FHXeOLFeWaYTtjmdv/AANPZ/7rDFzWsvRVOYjPCckVZcVelG8VaPPvRpcYdc
         Dhgg==
X-Gm-Message-State: AOAM531w84J8iGFw0MFcF58uo2BLeXohwtwTKXRfbr64e7ngMlrG2bxT
        504CWKjCgojoDVrdpxIYLKzXCQEGQDi9G7qbubxgh/TQSyJiPKVqnBPqarfqGF06J/IpEXrEB7T
        XB6bsSKV9GyyCFRFU4pp5Pxnh97BLI9I/jYPGcRYMUa5gmBwd1mAHlR11ElVozu/+iUz2
X-Google-Smtp-Source: ABdhPJwIU2/+76JfZ0atQI7PL99ZSXBC19tXBqc2dV0+l4PnayNyqylFZ8JBldRK5exI+pBQZrNvkQdIREA=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:aea8:: with SMTP id b40mr71477368ybj.347.1609232134987;
 Tue, 29 Dec 2020 00:55:34 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:21 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-4-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 3/6] dm: add support for passing through inline crypto support
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
---
 drivers/md/dm.c                 | 164 +++++++++++++++++++++++++++++++-
 include/linux/device-mapper.h   |   6 ++
 include/linux/keyslot-manager.h |   8 ++
 3 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b3c3c8b4cb42..13b9c8e2e21b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -28,6 +28,7 @@
 #include <linux/refcount.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
 
 #define DM_MSG_PREFIX "core"
 
@@ -1718,6 +1719,8 @@ static const struct dax_operations dm_dax_ops;
 
 static void dm_wq_work(struct work_struct *work);
 
+static void dm_destroy_inline_encryption(struct request_queue *q);
+
 static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
@@ -1739,8 +1742,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		put_disk(md->disk);
 	}
 
-	if (md->queue)
+	if (md->queue) {
+		dm_destroy_inline_encryption(md->queue);
 		blk_cleanup_queue(md->queue);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
@@ -1937,6 +1942,150 @@ static void event_callback(void *context)
 	dm_issue_global_event();
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
+static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
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
+/*
+ * Constructs and returns a keyslot manager that represents the crypto
+ * capabilities of the devices described by the dm_table. However, if the
+ * constructed keyslot manager does not support a superset of the crypto
+ * capabilities supported by the current keyslot manager of the mapped_device,
+ * it returns an error instead, since we don't support restricting crypto
+ * capabilities on table changes. Finally, if the constructed keyslot manager
+ * doesn't actually support any crypto modes at all, it just returns NULL.
+ */
+static struct blk_keyslot_manager *
+dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
+{
+	struct dm_keyslot_manager *dksm;
+	struct blk_keyslot_manager *ksm;
+	struct dm_target *ti;
+	unsigned int i;
+	bool ksm_is_empty = true;
+
+	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
+	if (!dksm)
+		return ERR_PTR(-ENOMEM);
+	dksm->md = md;
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
+	if (!blk_ksm_is_superset(ksm, md->queue->ksm)) {
+		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
+		dm_destroy_keyslot_manager(ksm);
+		return ERR_PTR(-EINVAL);
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
+	return ksm;
+}
+
+static void dm_update_keyslot_manager(struct request_queue *q,
+				      struct blk_keyslot_manager *ksm)
+{
+	if (!ksm)
+		return;
+
+	/* Make the ksm less restrictive */
+	if (!q->ksm) {
+		blk_ksm_register(ksm, q);
+	} else {
+		blk_ksm_update_capabilities(q->ksm, ksm);
+		dm_destroy_keyslot_manager(ksm);
+	}
+}
+
+static void dm_destroy_inline_encryption(struct request_queue *q)
+{
+	if (!q->ksm)
+		return;
+	dm_destroy_keyslot_manager(q->ksm);
+}
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline struct blk_keyslot_manager *
+dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
+{
+	return NULL;
+}
+
+static void dm_update_keyslot_manager(struct request_queue *q,
+				      struct blk_keyslot_manager *ksm)
+{
+}
+
+static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
+{
+}
+
+static inline void dm_destroy_inline_encryption(struct request_queue *q)
+{
+}
+
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 /*
  * Returns old map, which caller must destroy.
  */
@@ -2332,6 +2481,7 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
 {
 	struct dm_table *live_map = NULL, *map = ERR_PTR(-EINVAL);
 	struct queue_limits limits;
+	struct blk_keyslot_manager *ksm;
 	int r;
 
 	mutex_lock(&md->suspend_lock);
@@ -2361,7 +2511,19 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
 		}
 	}
 
+	ksm = dm_construct_keyslot_manager(md, table);
+	if (IS_ERR(ksm)) {
+		map = ERR_CAST(ksm);
+		goto out;
+	}
+
 	map = __bind(md, table, &limits);
+
+	if (IS_ERR(map))
+		dm_destroy_keyslot_manager(ksm);
+	else
+		dm_update_keyslot_manager(md->queue, ksm);
+
 	dm_issue_global_event();
 
 out:
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..0d5794a0a89a 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -257,6 +257,12 @@ struct target_type {
 #define DM_TARGET_NOWAIT		0x00000080
 #define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
 
+/*
+ *
+ */
+#define DM_TARGET_PASSES_CRYPTO		0x00000100
+#define dm_target_passes_crypto(type) ((type)->features & DM_TARGET_PASSES_CRYPTO)
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 164568f52be7..9164c1c72288 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -11,6 +11,8 @@
 
 struct blk_keyslot_manager;
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
 /**
  * struct blk_ksm_ll_ops - functions to manage keyslots in hardware
  * @keyslot_program:	Program the specified key into the specified slot in the
@@ -114,4 +116,10 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
 void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
 				 struct blk_keyslot_manager *reference_ksm);
 
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline void blk_ksm_destroy(struct blk_keyslot_manager *ksm) { }
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.29.2.729.g45daf8777d-goog

