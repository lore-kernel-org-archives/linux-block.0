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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B98C4743E
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD8613F8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDUBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhFDUBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:01:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727BC061767
        for <linux-block@vger.kernel.org>; Fri,  4 Jun 2021 12:59:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 22-20020a250d160000b0290532b914c9f4so13154341ybn.9
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=08ngW/6ouUjDi/wpMdVaPAEKWapsl3xNTLfVKkU+m5Y=;
        b=JDRTNf9J3ToOzwgDWEPGtKVPxO+kW3G7lO/Ja39i6iJVtmjdTC6z7d4SG0Nk34X17w
         Uw6MyFloGKyph4f73tQ88uuoVLDriLqHxKZJFNgWvRoLVOe7pkFv0xbugv+Y54ulivvF
         oZ2LTT+KwbktGUmNj8H3DGivs/PFnvronFpDpFHPCKdD94HrBZB63hP3V1YUeuqrlxw5
         VYGnxk+HH1++nT9zCh06Epc8xwbafe+8z5LV+5IKPfxX4XgOwUw9mdneMs/OPiMOqh2f
         mp/X0H0zkSjdfyWIfyFpV71FW39Rx0gLE1lzDE3RLp8AoDURCdiK3ZLZqLzNC8HLOJxE
         NF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=08ngW/6ouUjDi/wpMdVaPAEKWapsl3xNTLfVKkU+m5Y=;
        b=WJtpQXCu9eMNMBaOtExhSfaQ1PGqiXYTk85acc3woaKibo/LlhhJgVAKj0wSJTmLMc
         9ZmACCdeByzPXFDk86QLwyUHipqznb6uyttKjGBqglYpb3QSTd8Tfr+xCvGxch5YL3Ob
         wPtkRZWmfoqg/ZXLNSmcYc5vHjUJOVNXUQApa9z0k5zfJJZKLiIhQZvptt5A4uGyn0hf
         pg1iekWKMy/w+VaCIGU/gAePG0RXz5PFZ3C77TuYsG+B+kBRHdDx20XJROoN/Lcr9aj3
         SmhjbvXt6T9uCGBI7SamQhoERO+05vA7qtEPTGiZeD/f8wOerQpVLr6ZAYDYgROZ9Obb
         sHQg==
X-Gm-Message-State: AOAM532+sxf2OsSr1Mcf1Lj887heNk/ZsTESzF2DDferYeQRzhdylL/Z
        jbcoA/Mn/SmafP0EDYq4MWhAB41KmfRMP+n8aul/qWLBy6EWgl7sZ1gqgN2df5yVrwDAoc8AVHd
        OdQe6x5eIygPO7PnVGbKyhwlQEcAiS4TMeIt4VMvrrB/OYWZl518H+OHc9qQjjKtuo054
X-Google-Smtp-Source: ABdhPJySrTkm2ZZQhHIET6BVacdS/IIJwe+EXCFPY8X8aCXyuEC7h3HWa6Hi7G41FKirusQld9i5BZkyqos=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:6b42:: with SMTP id o2mr7686789ybm.244.1622836752705;
 Fri, 04 Jun 2021 12:59:12 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:52 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-3-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 02/10] block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The size of any bio must be aligned to the data unit size of the bio crypt
context (if it exists) of that bio. This must also be ensured whenever a
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns the
required alignment in sectors. The number of sectors passed to any call of
bio_split() must be aligned to blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..7f1535cc7e7c 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,21 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well. Note that a bio must contain a whole number of
+ * crypto data units (which is selected by the submitter of bio), since
+ * encryption/decryption can only be performed on a complete crypto data unit.
+ */
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	if (!bio_has_crypt_ctx(bio))
+		return 1;
+	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
+								SECTOR_SHIFT;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +108,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	return 1;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

