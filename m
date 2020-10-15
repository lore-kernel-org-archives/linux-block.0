Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F34C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D412076E
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erKXgeEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgJOVqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbgJOVqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FAEC0613D3
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:41 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j17so173848pgj.10
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ch6nvSub6LPLhqFDO+1Ngo8vwhJFQ7f44Mxixhhd0C0=;
        b=erKXgeEJdd65aOt7EvfIQrxEVMZDG6HulO74oHjfoANkWKvJnE49mXrq+Hsptz3+Ga
         FxTzPcfQyOceq3aIFKmQSMq5SSM0AgEtQ7K34yAU/dBuPTorhKqCxpI2iO9EWwXi/Bt/
         +uRsCiu8JT9QqCuMPIxooBMbVg2Ufs/lmX9nFS1zqJpr81ZwA8hQrgcB6V2+T4JbUYEi
         SrH4a1yeX+iE3V11cxOaHeaLHrNQtRZ52oCRqKocsGHY+9GZnJJZwy2Sg0f2Bfygwev+
         yfKVoSDTZARjHUj2javmg2ADI3z8nFeVKPtCDc1lJ6Qi6t382sWcsB2cBKiL4+77SqOV
         AfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ch6nvSub6LPLhqFDO+1Ngo8vwhJFQ7f44Mxixhhd0C0=;
        b=armpjGbLM/nKrzlJbcF10JTARhxZQhQmig0LtXiX9Ls+WYL/Q745NCRUPPOUTOKFXg
         jwDwFb20tjTHQzTeeRr+x8a0KGg/zC59PiZrEVmzQBgGBEdKCduhG/SkFgzEhCpUWhwS
         p9g1vn0D6A3OJDlIpSqg4RX3ZKnTkyJHKXl7BuoUAp6p4Gt7/lJYWkogjlzxVtal78an
         iCHsIYN0if0pL4EfaybvaxWa10FWk3cgdrOXmIezEQME2tpbdEo/8Z5N4KJjiWtjs+GF
         c/ddThtYnfZdOH0clafKqPuzCldhZb7W7/uzkkHZ/EmSpWX5eDUTOljB3Fj2nlu+m7Ag
         UEDw==
X-Gm-Message-State: AOAM530YL7S+JAa2IUqtBilN/UjMXWNCZ39EnOkc9h58OBPdmc8imgrl
        aplVZbq2CFGqdISAPUsDmPSq3GozdWIKDF0cGi04NbNJydP4Y1blknsam2PGTdLN9DjHQTdOGYA
        EtAogkbw7+plw2c5xpMUbWFH+BYwZMVf8maB+1KsI51J3toVghFI7ttl3rW8l7CKwEeaG
X-Google-Smtp-Source: ABdhPJwhx2toIgFmDseGxQzGpK/2t4Kas5iEEhvkp2rHiVYQV9LBIlyMLStzdPkzAQOknVMMz1/GU/4rMHk=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90a:940c:: with SMTP id
 r12mr78628pjo.1.1602798400036; Thu, 15 Oct 2020 14:46:40 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:29 +0000
In-Reply-To: <20201015214632.41951-1-satyat@google.com>
Message-Id: <20201015214632.41951-2-satyat@google.com>
Mime-Version: 1.0
References: <20201015214632.41951-1-satyat@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough keyslot manager
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
---
 block/keyslot-manager.c         | 41 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 35abcb1ec051..5ad476dafeab 100644
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
@@ -198,6 +203,10 @@ blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
 	int err;
 
 	*slot_ptr = NULL;
+
+	if (blk_ksm_is_passthrough(ksm))
+		return BLK_STS_OK;
+
 	down_read(&ksm->lock);
 	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
 	up_read(&ksm->lock);
@@ -318,6 +327,16 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
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
@@ -353,6 +372,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
 {
 	unsigned int slot;
 
+	if (blk_ksm_is_passthrough(ksm))
+		return;
+
 	/* This is for device initialization, so don't resume the device */
 	down_write(&ksm->lock);
 	for (slot = 0; slot < ksm->num_slots; slot++) {
@@ -394,3 +416,22 @@ void blk_ksm_unregister(struct request_queue *q)
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
+ *
+ * See blk_ksm_init() for more details about the parameters.
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
2.29.0.rc1.297.gfa9743e501-goog

