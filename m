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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADCC433E6
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0888F64E2A
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhBAFLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 00:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBAFLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 00:11:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D95C061788
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n123so9966499pfn.10
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NtNlB9U7VtjwopCe74zxMMgND8EJvn8gcUKJfUwC+lg=;
        b=HnMgQ8zYgkG2K8y7RPLKKLGmzjEmtrez+tY3ZnHM4P56+ibUzfrDkmDsfOmdJxiEHC
         yPdXw36AUVxEb3VZvN1mqwOPJnVnuCEGaeqiauleNZdIMwSnex9NdQk5r714ZHirEGG5
         ydMlgXBXhxtwYpLBlhtIyyu+MfPd6vxQbknmhnq/KoTraDlBS0xP2T2p6EXCPENMbY5p
         1xfpFWVjdH3SgfSV8nTfPWWnJfqGYOkw0E9t+tugVCX3i3kyUXKicXEw/Zfri3Ad4BzB
         H/DHq5ZV97lpYRhW6888ayYmYI9uOHkt6m2H04BBSSkXM1cErTkCvA/xn20qp39d6QQZ
         yt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NtNlB9U7VtjwopCe74zxMMgND8EJvn8gcUKJfUwC+lg=;
        b=qWYK+Qna1aU/5Cmx9ecSZ5/F3NhwYOCnmSPRPJ3cw+GsecVbYX0N1GqfP6j8tNGVN8
         U3tUqXc6CGYtnHPAnkCx2h2uctAItnyUlunoYn56FisghVKZ4fr3qMOrZU0z5H0N6i4g
         Te4RP6kZxSmXeyKVl38asZVc08VuHRa/6SVz4lylE49/4/tNOc9+GEYZnxf7mg/R4JxM
         yMhijZoTi4cY/t1USgk+b6dBlytbVn3UiqZZ8L//jv9ma0R9TOBCqngN//j3zj1JGSZq
         +5RbN6L1ND9cNuYLvD/qQKefRVBo934TIeopU1hNxa4WdX6sToSY4OvuD0gh3Idio/D+
         1D2w==
X-Gm-Message-State: AOAM532J4kmjkKg8eH3TAfTep/TKwHzR+bq99QyyilNHlcribOrn/bfe
        gemXvXBNngBYSEo16GBhkZ1gOV7uFdSIWdjRIrX+rkXLzMILrcl67HDYgk/FEpJL2nY+1SsnYTh
        o0N09rBeCJwyCyjT+ds0BUfPtO1d+Q/kSOQuBt1eLdcYh1wrJOYZv4Z0gHZtRYjVDOMGi
X-Google-Smtp-Source: ABdhPJzxvkME3ikBqhi+gORlLVg6bi/eVzgjmLoiU5TdzRO9PKQxntzZ51tfnubHSQ/3i4ouCx93UQbCWS0=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:ee4b:b029:de:9cd1:35c8 with SMTP id
 11-20020a170902ee4bb02900de9cd135c8mr10516445plo.18.1612156231563; Sun, 31
 Jan 2021 21:10:31 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:16 +0000
In-Reply-To: <20210201051019.1174983-1-satyat@google.com>
Message-Id: <20210201051019.1174983-3-satyat@google.com>
Mime-Version: 1.0
References: <20210201051019.1174983-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 2/5] block: keyslot-manager: Introduce functions for device
 mapper support
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

Introduce blk_ksm_update_capabilities() to update the capabilities of
a keyslot manager (ksm) in-place. The pointer to a ksm in a device's
request queue may not be easily replaced, because upper layers like
the filesystem might access it (e.g. for programming keys/checking
capabilities) at the same time the device wants to replace that
request queue's ksm (and free the old ksm's memory). This function
allows the device to update the capabilities of the ksm in its request
queue directly. Devices can safely update the ksm this way without any
synchronization with upper layers *only* if the updated (new) ksm
continues to support all the crypto capabilities that the old ksm did
(see description below for blk_ksm_is_superset() for why this is so).

Also introduce blk_ksm_is_superset() which checks whether one ksm's
capabilities are a (not necessarily strict) superset of another ksm's.
The blk-crypto framework requires that crypto capabilities that were
advertised when a bio was created continue to be supported by the
device until that bio is ended - in practice this probably means that
a device's advertised crypto capabilities can *never* "shrink" (since
there's no synchronization between bio creation and when a device may
want to change its advertised capabilities) - so a previously
advertised crypto capability must always continue to be supported.
This function can be used to check that a new ksm is a valid
replacement for an old ksm.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 107 ++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |   9 +++
 2 files changed, 116 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index ac7ce83a76e8..9f9494b80148 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -424,6 +424,113 @@ void blk_ksm_unregister(struct request_queue *q)
 	q->ksm = NULL;
 }
 
+/**
+ * blk_ksm_intersect_modes() - restrict supported modes by child device
+ * @parent: The keyslot manager for parent device
+ * @child: The keyslot manager for child device, or NULL
+ *
+ * Clear any crypto mode support bits in @parent that aren't set in @child.
+ * If @child is NULL, then all parent bits are cleared.
+ *
+ * Only use this when setting up the keyslot manager for a layered device,
+ * before it's been exposed yet.
+ */
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child)
+{
+	if (child) {
+		unsigned int i;
+
+		parent->max_dun_bytes_supported =
+			min(parent->max_dun_bytes_supported,
+			    child->max_dun_bytes_supported);
+		for (i = 0; i < ARRAY_SIZE(child->crypto_modes_supported);
+		     i++) {
+			parent->crypto_modes_supported[i] &=
+				child->crypto_modes_supported[i];
+		}
+	} else {
+		parent->max_dun_bytes_supported = 0;
+		memset(parent->crypto_modes_supported, 0,
+		       sizeof(parent->crypto_modes_supported));
+	}
+}
+EXPORT_SYMBOL_GPL(blk_ksm_intersect_modes);
+
+/**
+ * blk_ksm_is_superset() - Check if a KSM supports a superset of crypto modes
+ *			   and DUN bytes that another KSM supports. Here,
+ *			   "superset" refers to the mathematical meaning of the
+ *			   word - i.e. if two KSMs have the *same* capabilities,
+ *			   they *are* considered supersets of each other.
+ * @ksm_superset: The KSM that we want to verify is a superset
+ * @ksm_subset: The KSM that we want to verify is a subset
+ *
+ * Return: True if @ksm_superset supports a superset of the crypto modes and DUN
+ *	   bytes that @ksm_subset supports.
+ */
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset)
+{
+	int i;
+
+	if (!ksm_subset)
+		return true;
+
+	if (!ksm_superset)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(ksm_superset->crypto_modes_supported); i++) {
+		if (ksm_subset->crypto_modes_supported[i] &
+		    (~ksm_superset->crypto_modes_supported[i])) {
+			return false;
+		}
+	}
+
+	if (ksm_subset->max_dun_bytes_supported >
+	    ksm_superset->max_dun_bytes_supported) {
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_superset);
+
+/**
+ * blk_ksm_update_capabilities() - Update the restrictions of a KSM to those of
+ *				   another KSM
+ * @target_ksm: The KSM whose restrictions to update.
+ * @reference_ksm: The KSM to whose restrictions this function will update
+ *		   @target_ksm's restrictions to.
+ *
+ * Blk-crypto requires that crypto capabilities that were
+ * advertised when a bio was created continue to be supported by the
+ * device until that bio is ended. This is turn means that a device cannot
+ * shrink its advertised crypto capabilities without any explicit
+ * synchronization with upper layers. So if there's no such explicit
+ * synchronization, @reference_ksm must support all the crypto capabilities that
+ * @target_ksm does
+ * (i.e. we need blk_ksm_is_superset(@reference_ksm, @target_ksm) == true).
+ *
+ * Note also that as long as the crypto capabilities are being expanded, the
+ * order of updates becoming visible is not important because it's alright
+ * for blk-crypto to see stale values - they only cause blk-crypto to
+ * believe that a crypto capability isn't supported when it actually is (which
+ * might result in blk-crypto-fallback being used if available, or the bio being
+ * failed).
+ */
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm)
+{
+	memcpy(target_ksm->crypto_modes_supported,
+	       reference_ksm->crypto_modes_supported,
+	       sizeof(target_ksm->crypto_modes_supported));
+
+	target_ksm->max_dun_bytes_supported =
+				reference_ksm->max_dun_bytes_supported;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_update_capabilities);
+
 /**
  * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
  * @ksm: The keyslot manager to init
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 323e15dd6fa7..164568f52be7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,6 +103,15 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child);
+
 void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
 
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset);
+
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.30.0.365.g02bc693789-goog

