Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9CDC433E9
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D3E64E55
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBKWyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBKWyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 17:54:31 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A91C0613D6
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:53:51 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id i5so5704927qkk.22
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7AM0u1xvi8rWerhtus0gkgsr+ctRsqYSopY+7YCNCuU=;
        b=YHXMLWoRrs5Tga9v4ug8VhkgXuFjpIarwAkKXOSGVN9CpUwPnymZN47mdVImCVFMzS
         EFxeY/39D+pMo2q0iXB5AodSVZNHFA2+OVhVxnEmm0bD71USTcZ6rq5j8ZrLK68t88Om
         tqtRnH5mgB+O8IF/uXdak4RfijjKXjfShaCyTj9hg830vJDVRDB4mAnbG9RVLAypglLz
         MZ1Q5dDZff3hsRiERW+8pETHyiqbi7yxHOWhPTy/aPdKTfu3Aea3iLm6JCd6UXaJRDBf
         LJxqb27hVA9csvmQ7nWtvLM2nGxTLPtzjI3AvT0l+Kxrb9pehbLghCxR73b1kz1rslEa
         Zf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7AM0u1xvi8rWerhtus0gkgsr+ctRsqYSopY+7YCNCuU=;
        b=g+nLaBmCv2URSAaylTKRc5QlFq0AUfmRwJHSeRAjA60MmDyNnIOyAz5oy4I96wT0YT
         8Ma6m3A305IvlG9ZjIpZ9kmrjplaSIXx3LqcHAgF6lGlcZlUNwJ+/Xj8O0GuJMOCI9Lg
         n/ojrihClzIr88DNiYgpbl2ntMNxGQu6CAgcbKZq6IM3nw0SJ2/4ldLOYj9YF2qyTjSf
         ol1M5pOOPRfqZYSR+qTeE5g2iVLDhqzc75KIU1zX92vEFuHfo6VDQfQ0ZnPokrKXhrZ6
         I7H2/Qbujqc1aj1vFyFUXpmR+th2HrnUkzGp5FguoBs0ayIS21YhZzTzmWBv9dhseyDp
         aA2Q==
X-Gm-Message-State: AOAM5318ZGQVD6zmSKyoi0qabKLOwQhxq1f7IITDi5RUgeUhgV8vE6Iz
        8vB2nn55lx6j7e1dieaczNo5uEPfEh3mIQtv4ri2acSK826AipJ0c3prDQs8kNr6ewMTofKAk/d
        VTuG9YK05Fdj7ztZGnua9tGVortMTuXVqJY+szc4dpRcoMJSLbUJH9EVVgD2yoNjE9AYQ
X-Google-Smtp-Source: ABdhPJwtQFk7Sp4imxBMUoJh2UPtarEaoN31R7oWcM+JFisbkGFAI60SrSiHOXgLIFdEnZappBCaiKruEHM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:fd47:: with SMTP id j7mr73482qvs.22.1613084030680;
 Thu, 11 Feb 2021 14:53:50 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:39 +0000
In-Reply-To: <20210211225343.3145732-1-satyat@google.com>
Message-Id: <20210211225343.3145732-2-satyat@google.com>
Mime-Version: 1.0
References: <20210211225343.3145732-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 1/5] block: keyslot-manager: Introduce passthrough keyslot manager
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

The device mapper may map over devices that have inline encryption
capabilities, and to make use of those capabilities, the DM device must
itself advertise those inline encryption capabilities. One way to do this
would be to have the DM device set up a keyslot manager with a
"sufficiently large" number of keyslots, but that would use a lot of
memory. Also, the DM device itself has no "keyslots", and it doesn't make
much sense to talk about "programming a key into a DM device's keyslot
manager", so all that extra memory used to represent those keyslots is just
wasted. All a DM device really needs to be able to do is advertise the
crypto capabilities of the underlying devices in a coherent manner and
expose a way to evict keys from the underlying devices.

There are also devices with inline encryption hardware that do not
have a limited number of keyslots. One can send a raw encryption key along
with a bio to these devices (as opposed to typical inline encryption
hardware that require users to first program a raw encryption key into a
keyslot, and send the index of that keyslot along with the bio). These
devices also only need the same things from the keyslot manager that DM
devices need - a way to advertise crypto capabilities and potentially a way
to expose a function to evict keys from hardware.

So we introduce a "passthrough" keyslot manager that provides a way to
represent a keyslot manager that doesn't have just a limited number of
keyslots, and for which do not require keys to be programmed into keyslots.
DM devices can set up a passthrough keyslot manager in their request
queues, and advertise appropriate crypto capabilities based on those of the
underlying devices. Blk-crypto does not attempt to program keys into any
keyslots in the passthrough keyslot manager. Instead, if/when the bio is
resubmitted to the underlying device, blk-crypto will try to program the
key into the underlying device's keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 block/keyslot-manager.c         | 39 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 86f8195d8039..ac7ce83a76e8 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -62,6 +62,11 @@ static inline void blk_ksm_hw_exit(struct blk_keyslot_manager *ksm)
 		pm_runtime_put_sync(ksm->dev);
 }
 
+static inline bool blk_ksm_is_passthrough(struct blk_keyslot_manager *ksm)
+{
+	return ksm->num_slots == 0;
+}
+
 /**
  * blk_ksm_init() - Initialize a keyslot manager
  * @ksm: The keyslot_manager to initialize.
@@ -205,6 +210,10 @@ blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
 	int err;
 
 	*slot_ptr = NULL;
+
+	if (blk_ksm_is_passthrough(ksm))
+		return BLK_STS_OK;
+
 	down_read(&ksm->lock);
 	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
 	up_read(&ksm->lock);
@@ -325,6 +334,16 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 	struct blk_ksm_keyslot *slot;
 	int err = 0;
 
+	if (blk_ksm_is_passthrough(ksm)) {
+		if (ksm->ksm_ll_ops.keyslot_evict) {
+			blk_ksm_hw_enter(ksm);
+			err = ksm->ksm_ll_ops.keyslot_evict(ksm, key, -1);
+			blk_ksm_hw_exit(ksm);
+			return err;
+		}
+		return 0;
+	}
+
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
 	if (!slot)
@@ -360,6 +379,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
 {
 	unsigned int slot;
 
+	if (blk_ksm_is_passthrough(ksm))
+		return;
+
 	/* This is for device initialization, so don't resume the device */
 	down_write(&ksm->lock);
 	for (slot = 0; slot < ksm->num_slots; slot++) {
@@ -401,3 +423,20 @@ void blk_ksm_unregister(struct request_queue *q)
 {
 	q->ksm = NULL;
 }
+
+/**
+ * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
+ * @ksm: The keyslot manager to init
+ *
+ * Initialize a passthrough keyslot manager.
+ * Called by e.g. storage drivers to set up a keyslot manager in their
+ * request_queue, when the storage driver wants to manage its keys by itself.
+ * This is useful for inline encryption hardware that doesn't have the concept
+ * of keyslots, and for layered devices.
+ */
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm)
+{
+	memset(ksm, 0, sizeof(*ksm));
+	init_rwsem(&ksm->lock);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_init_passthrough);
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 18f3f5346843..323e15dd6fa7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,4 +103,6 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.30.0.478.g8a0d178c01-goog

