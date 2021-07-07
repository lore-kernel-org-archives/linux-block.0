Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB6C11F66
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E4C61CC1
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGGFcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhGGFcg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:36 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86216C061574;
        Tue,  6 Jul 2021 22:29:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l21so2092311oig.3;
        Tue, 06 Jul 2021 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajJQQ1wMsYc4K5bCPNbQMhMwwTubupfzXXLYLgtflPY=;
        b=cHKOFmya97SUjVNq+yBAvvA85SDHvynbADkqZrv6lAmXPUO+kgTilVPYPiBeGkSYFt
         O18wQACj++qHCCG4qyoXphK/KQeK01zZ5UJfIteSBoRopwl3s8v//XW0z/nCa8g0o5zW
         Mwu0doASSFdYzulMORAGuuT3nL3jRGPdQFaSjxTGBiT/O++EYt4pkoWH5b9B8jnaB42U
         SxvqSCR6hSiwuUnlJnAq51DOWYwpXjGAgm2CyTUpvupuehVKPWK4p/qCF+mMadv9LsFo
         ro5M9bWsldHtkeiaRlHmxr+9rT3IK6pQkG/9T283o5l+Ag4uWjFwlM5FdP9haoUBPKo1
         7DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajJQQ1wMsYc4K5bCPNbQMhMwwTubupfzXXLYLgtflPY=;
        b=j6zhH1vUMWCb1V6zL8/fiSKrqfuvN3movQAUDT9/THZIxcMs2DMoBRZrBFilDi3bzg
         YsRpnAOM3loeuoxgdLWgRCH1qAKCNU85lGCq3pdClzKMZzApu+IOrbdwx15X2XIAhlnl
         IVyVR/pX02LyAkARd/GuZoc88t3P7tD7xbJpHbWDXUJ5fxnzJA0G296OEvny8kkYNVfk
         hDfxASLZaDDAhBV0VlK8YR90W+WdiFXPUrYv0vEjJS/d8rpbnMS117G6cZq4WqR/LeAX
         6Dethw9KGN2GQZZyaFgUDD0+5RTXfH0wM6TTjab1CXN/g/EnAbQX4Kay1rwyK2xZada1
         9LWA==
X-Gm-Message-State: AOAM530Hmw0iE89/4rVtwNfxv3QoHImQrBpNXuirWgNRiBz62lBeUwbA
        xJw7JB47S8US4/cIf4//MxQMuGmPKxA=
X-Google-Smtp-Source: ABdhPJwlmtO8K0u0EgvmFGour7UXe+e4StJ29DbHrk7RJ89X1ndz7QZlneDV3+CvDvm9stjACcGScQ==
X-Received: by 2002:a05:6808:d54:: with SMTP id w20mr3456898oik.175.1625635795767;
        Tue, 06 Jul 2021 22:29:55 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:55 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 4/9] block: keyslot-manager: introduce blk_ksm_restrict_dus_to_queue_limits()
Date:   Tue,  6 Jul 2021 22:29:38 -0700
Message-Id: <20210707052943.3960-5-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

Not all crypto data unit sizes might be supported by the block layer due to
certain queue limits. This new function checks the queue limits and
appropriately modifies the keyslot manager to reflect only the supported
crypto data unit sizes. blk_ksm_register() runs any given ksm through this
function before actually registering the ksm with a queue.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c | 89 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 4d0794506d43..01358df66e41 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -468,12 +468,101 @@ bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
 
+/*
+ * Restrict the supported data unit sizes of the ksm based on the request queue
+ * limits
+ */
+static unsigned long
+blk_ksm_largest_dus_for_queue_limits(struct blk_keyslot_manager *ksm,
+				     struct request_queue *q)
+{
+	/* The largest possible data unit size we support is PAGE_SIZE. */
+	unsigned long largest_dus = PAGE_SIZE;
+	struct queue_limits *limits = &q->limits;
+
+	/*
+	 * If the queue doesn't support SG gaps, then a bio may have to be split
+	 * between any two bio_vecs.  Since the size of each bio_vec is only
+	 * guaranteed to be a multiple of logical_block_size, logical_block_size
+	 * is also the maximum crypto data unit size that can be supported in
+	 * this case, as bios must not be split in the middle of a data unit.
+	 */
+	if (limits->virt_boundary_mask)
+		largest_dus = queue_logical_block_size(q);
+
+	/*
+	 * Similarly, if chunk_sectors is set and a bio is submitted that
+	 * crosses a chunk boundary, then that bio may have to be split at a
+	 * boundary that is only logical_block_size aligned.  So that limits the
+	 * crypto data unit size to logical_block_size as well.
+	 */
+	if (limits->chunk_sectors)
+		largest_dus = queue_logical_block_size(q);
+
+	/*
+	 * Each bio_vec can be as small as logical_block_size.  Therefore the
+	 * crypto data unit size can't be greater than 'max_segments *
+	 * logical_block_size', as otherwise in the worst case there would be no
+	 * way to process the first data unit without exceeding max_segments.
+	 */
+	largest_dus = min(largest_dus,
+			  rounddown_pow_of_two(limits->max_segments) *
+			  queue_logical_block_size(q));
+
+	return largest_dus;
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
+ * can support based on it's limits. Note that if @ksm won't support any
+ * crypto capabilities if its capabilities are restricted, the queue's ksm is
+ * set to NULL, instead of being set to a pointer to an "empty" @ksm, and @ksm
+ * is *not* modified.
+ *
+ * Return: true if @q's ksm is set to the provided @ksm, false otherwise
+ *	   (in which case @ksm will not have been modified)
+ */
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
+	unsigned long largest_dus_allowed;
+	unsigned int dus_allowed_mask;
+	bool dus_was_restricted = false;
+	int i;
+
 	if (blk_integrity_queue_supports_integrity(q)) {
 		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
 		return false;
 	}
+
+	largest_dus_allowed = blk_ksm_largest_dus_for_queue_limits(ksm, q);
+	dus_allowed_mask = (largest_dus_allowed << 1) - 1;
+
+	/*
+	 * Check if ksm will become empty if we clear disallowed data unit
+	 * sizes (in which case, don't modify the ksm)
+	 */
+	if (blk_ksm_is_empty_mask(ksm, dus_allowed_mask))
+		return false;
+
+	/* Clear all unsupported data unit sizes. */
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))
+			dus_was_restricted = true;
+		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
+	}
+
+	if (dus_was_restricted) {
+		pr_warn("Device: %s - Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits.\n",
+			q->backing_dev_info->dev_name, largest_dus_allowed);
+	}
+
 	q->ksm = ksm;
 	return true;
 }
-- 
2.25.1

