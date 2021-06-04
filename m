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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F99C4743C
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C4613F8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFDUCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:02:15 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42840 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhFDUCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:02:04 -0400
Received: by mail-yb1-f202.google.com with SMTP id 22-20020a250d160000b0290532b914c9f4so13154626ybn.9
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wJJSAHsgrNVobsA6v1QNlZBTtRzVhTXm7J8/hbunSiM=;
        b=s/9Q7No1v6Rq6WtoRwX3CpJFU8g8xp+FzjfQ9jgfe08+uLbq5ptD0+orOP8d4+DTH2
         EIHIhsd3aLBlX5u7+FC9U3Zt8PhgKwvqRLeK9GZ2O7tabix7hYUZ01hRJaKfZ1cPN9eR
         d9fq52P4+I5QQpJGtNQhRJwF6VRYAKB6a3L2HSBPMZM3N9qbZNCqwLClIO7hUHwBRP59
         77OQrv/ctBX9liw3F1TEV1IZGuLVrk0i0Uimbo4O8Bybsy2Brrd8MONws0MIwjDnD/2v
         pZeZC6j4h34HjAZ4sNBrRkWIQfnJKhtSi3xoHZ3ieYnkF8nTDzXLELE3h1Yw0Uw9ydPG
         cOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wJJSAHsgrNVobsA6v1QNlZBTtRzVhTXm7J8/hbunSiM=;
        b=pvzdHuO0Sljr3Nl2ziMlnEwOwsvyWJHvGIqbolzTrHfr9lNBnGzMa86omUJD0EhuNq
         ppWFg2cZXbZypKUPCIOzjwOY8dGYRb8sZCddVMwU8B2yRQ1T2iJN/hWb1A1pXXEcDIlE
         MfujFIrNKONLUeFOp18Gql3OWXE4/fXUGHIKifNxBZ4XlaoEUjkWfX0+3WiSltLPnPj0
         Uie5ylRlX8+zNtP80wpDtt/8md0deNahOZcJk+AqozZU5lqUSEg7/EOXVqZyxkfNKOzZ
         +sbkve8SxB6V9nTxmNYCAoJgl45CU4TqrZ5LlK+sm48TzVzc9y0hTnyNbezwI5lNkFK2
         weZA==
X-Gm-Message-State: AOAM5337Zbj74mRSqXJ+ACW+otGUXBqJ4YUYb+Zfmx34kYkHmVkx6SEP
        43vrHg0csJtmI+ZD+VjUnTaPMnP54qIbckTh1+hadTjV0GB10ToDV0hLAqbhbUEkaHCLbz6EeWc
        7u9SpRWROIkTvhInjJ1jiFCtwvGgt3BbGuvEBpbdj7U+RO28n0uHwWRk68ikZJE6c7oVN
X-Google-Smtp-Source: ABdhPJy1fd7m8zrrg5pm8rmkbKphbHnv06LKzft+zyB6KJv2i8ydmxtr0oBXWXUy2thxIc8ZE+zR1SP9dYA=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:b009:: with SMTP id q9mr7530652ybf.506.1622836757710;
 Fri, 04 Jun 2021 12:59:17 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:55 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-6-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 05/10] block: keyslot-manager: introduce blk_ksm_restrict_dus_to_queue_limits()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not all crypto data unit sizes might be supported by the block layer due to
certain queue limits. This new function checks the queue limits and
appropriately modifies the keyslot manager to reflect only the supported
crypto data unit sizes. blk_ksm_register() runs any given ksm through this
function before actually registering the ksm with a queue.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c | 91 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 88211581141a..6a355867be59 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -458,12 +458,103 @@ bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
 
+/*
+ * Restrict the supported data unit sizes of the ksm based on the request queue
+ * limits
+ */
+static void
+blk_ksm_restrict_dus_to_queue_limits(struct blk_keyslot_manager *ksm,
+				     struct request_queue *q)
+{
+	/* The largest possible data unit size we support is PAGE_SIZE. */
+	unsigned long largest_dus = PAGE_SIZE;
+	unsigned int dus_allowed_mask;
+	int i;
+	bool dus_was_restricted = false;
+	struct queue_limits *limits = &q->limits;
+
+	/*
+	 * If the queue doesn't support SG gaps, a bio might get split in the
+	 * middle of a data unit. So require SG gap support for inline
+	 * encryption for any data unit size larger than a single sector.
+	 *
+	 * A crypto data unit might straddle an SG gap, and only a single sector
+	 * of that data unit might be before the gap - the block layer will need
+	 * to split that bio at the gap, which will result in an incomplete
+	 * crypto data unit unless the crypto data unit size is a single sector.
+	 */
+	if (limits->virt_boundary_mask)
+		largest_dus = SECTOR_SIZE;
+
+	/*
+	 * If the queue has chunk_sectors, the bio might be split within a data
+	 * unit if the data unit size is larger than a single sector. So only
+	 * support a single sector data unit size in this case.
+	 *
+	 * Just like the SG gap case above, a crypto data unit might straddle a
+	 * chunk sector boundary, and in the worst case, only a single sector of
+	 * the data unit might be before/after the boundary.
+	 */
+	if (limits->chunk_sectors)
+		largest_dus = SECTOR_SIZE;
+
+	/*
+	 * Any bio sent to the queue must be allowed to contain at least a
+	 * data_unit_size worth of data. Since each segment in a bio contains
+	 * at least a SECTOR_SIZE worth of data, it's sufficient that
+	 * queue_max_segments(q) * SECTOR_SIZE >= data_unit_size. So disable
+	 * all data_unit_sizes not satisfiable.
+	 *
+	 * We assume the worst case of only SECTOR_SIZE bytes of data in each
+	 * segment since users of the block layer are free to construct bios
+	 * with such segments.
+	 */
+	largest_dus = min(largest_dus,
+			1UL << (fls(limits->max_segments) - 1 + SECTOR_SHIFT));
+
+	/* Clear all unsupported data unit sizes. */
+	dus_allowed_mask = (largest_dus << 1) - 1;
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))
+			dus_was_restricted = true;
+		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
+	}
+
+	if (dus_was_restricted) {
+		pr_warn("Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits on device %s.\n",
+			largest_dus, q->backing_dev_info->dev_name);
+	}
+}
+
+/**
+ * blk_ksm_register() - Sets the queue's keyslot manager to the provided ksm, if
+ *			compatible
+ * @ksm: The ksm to register
+ * @q: The request_queue to register the ksm to
+ *
+ * Checks if the keyslot manager provided is compatible with the request queue
+ * (i.e. the queue shouldn't also support integrity). After that, the crypto
+ * capabilities of the given keyslot manager are restricted to what the queue
+ * can support based on it's limits. Note that if @ksm doesn't support any
+ * crypto capabilities after the capability restriction, the queue's ksm is
+ * set to NULL, instead of being set to a pointer to the now "empty" @ksm.
+ *
+ * Return: true if @q's ksm is set to the provided @ksm, false otherwise
+ *	   (including the case when @ksm becomes "empty" due to crypto
+ *	    capability restrictions)
+ */
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
 	if (blk_integrity_queue_supports_integrity(q)) {
 		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
 		return false;
 	}
+
+	blk_ksm_restrict_dus_to_queue_limits(ksm, q);
+
+	if (blk_ksm_is_empty(ksm))
+		return false;
+
 	q->ksm = ksm;
 	return true;
 }
-- 
2.32.0.rc1.229.g3e70b5a671-goog

