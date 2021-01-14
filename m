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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869AC433E9
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7C823B3E
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbhANPsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbhANPsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:21 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC2C061795
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:34 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k126so5093278qkf.8
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VXMYjn9O4XsIoXbGPi+u1w3+Oc2FJKcjd/08+b6WrBI=;
        b=dpUlfBP7ghRE0W1c/N+pxmSRl/ey4DQezPpbDZN0l+b8RG8CvlIPqIOxB+RvfmiswX
         sDi7LGLRi4EbbiVKyU0CjN8jKrFTsPgcYMgbxcuq3OqFoP8pqZXrV+1LgTVswuOCQvO4
         kNsH7JVDnYv/ZbpRhGecHxPO63rfSqtxAROm9xvp/P5Ra+G2TgNB5TU4rOud1n7g2utY
         EMAh23S6jSqWphe4ZoWFRzaVE9kkUy84pkEAXD1aeGinxhIV4fLxefiyk/ushanWTVdn
         xO6xhFXwKvW9gikMWbc9+PejtCtaq5TTKVuvYlS9qHqgweoRs7VhpqUu0jB3dgpfuZMi
         vhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VXMYjn9O4XsIoXbGPi+u1w3+Oc2FJKcjd/08+b6WrBI=;
        b=JtjbESY9RtIvH6mxV5faFZ6GnCHoRBP3n4nDKVvwgHa6O1HZGsUJLgtt2A+xsbKE1G
         cXZkexpujyvK7yzyUObu+pIoTIaruANL+J2hoKECPp/ZTLO4qRM3Efook9I1FXwN/Zhb
         CenR5FiVXN6YYXFxq/qUwAFAnPQQpa49tUhstT1luoaqi8eApycramcrneXlfcYS7TaE
         pA+1tsJHEV+pY96beXowXw4opgPsUmsk1D9OPKWv0g+luB4T9jEdfLrqvoFKmnfyKgNp
         o08MEkLc/5ePidCUkU0Ty9LnlgbyjaNRA73TZiUe1OgdJ6IdM/HNFH59nLqXZnl+g4Nu
         QT2w==
X-Gm-Message-State: AOAM532iDXvQe3P7B4uTEzW/eiEYLYLOZF+Judhon9qFtkqqW8b4WZw9
        Vh5Rp8m4B3BrfC6i3IFH48Tm7PREvhJJa2m7sudRobKbCH8lKZlWNJwbND0Z5MnY0+p9d/rtEzy
        YjL+OkMfq4NfWMzczAzYWFs/FM6E30lOdMYI9xAAc7c2l5QPiKk0tLfl4vJoaZj/fLFF1
X-Google-Smtp-Source: ABdhPJxB4L1wTGhRJSsrgLoO7tHuFYdrw8HNgPGtxULPSi0IZ0JS2biD0BYgq/c95/CXgcqzxvlrPWQSOJw=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:b328:: with SMTP id l40mr11010076ybj.15.1610639253503;
 Thu, 14 Jan 2021 07:47:33 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:18 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-3-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/7] block: blk-crypto: Introduce blk_crypto_bio_sectors_alignment()
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
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns
the required alignment in sectors. The number of sectors passed to
any call of bio_split() should be aligned to
blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..304e90ed99f5 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,19 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well.
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
@@ -93,6 +106,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
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
2.30.0.284.gd98b1dd5eaa7-goog

