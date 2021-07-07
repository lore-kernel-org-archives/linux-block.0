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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86782C07E9E
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696AB61CBA
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhGGFcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhGGFcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8EC061574;
        Tue,  6 Jul 2021 22:29:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so1141398otk.7;
        Tue, 06 Jul 2021 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RxYTCKcZkVHS+OeXSYpWZPM6l33cLGgmxCxzTKdJGg=;
        b=lVKq2Nn+YBMFZPkkyIrnSnegcFvQ4xPyd3sCfD8nCTRpjVugPC3CuZroVztcKeAy1O
         gzCg7m/rm2mzt5xKLgEclpAHrUKcdHBgXLnkaw0YU9K0RdWDHdcQ8Uvp8+nRF17+RbqK
         /xanRDAGLimCc61ANlkdXDQIdigWAf1SYc6CuIqlNM2dRh+9uhFnQkyQS59VVrjD2r9A
         u6GpU1Nqevps+7YIfBfx3P2TbHIE+Fqt8hyUIaGKr4NLErsfU++RJobjY7JrXigM/dIS
         3sXncDKdaK2J1H38DyVhkhxLWNaOQaRfXVwh1VYe/BB4669nvlrP3zFBvoMPPLoK/UZJ
         JIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RxYTCKcZkVHS+OeXSYpWZPM6l33cLGgmxCxzTKdJGg=;
        b=UxVDhpl0NRKA3lGhTYUS6kEEOgd+r8Z/d8/1rjJBUR9nWzieYyTAhQyZdSCEQKKrp5
         alsHQCycProRRyMsiBYVoqf/ZT8DLZL75hCQa8/SB7t6Ll+OHmxltgTwl73sEDw+7ZYp
         B3nu4p1EiMeOBeN5WGUc4dVxigYQ6ToyvujHYRfC5gqZmDpfWK7tjZVPdqO7b5e6FSkC
         +7urQtXkgpqM69ngT8L3vK7ZzN50YtNAr2pkn4Qij6wAfEWFGoXVuSmUsDzguyGezSar
         4FoD/1if0JxxvzeUA4R/6edb53KZfWhFESmt3hLNuapOr8Gih30Qkc74a6qT1rb+rZeU
         Bcrw==
X-Gm-Message-State: AOAM531vF32f2NKP7yT4HFsFk/kX7d1OOdOAbbRB9dkwVYRHBztIh4f4
        WHFaNIOHiSz/NLJkWzgcua2P0hHcIJo=
X-Google-Smtp-Source: ABdhPJybxnYkYobbpAVo3IbhOvQylVK1ckUFFvL1FhiQWkgtvfNfBzWqJ/OgRzxtZQ99y5LGTPgkkg==
X-Received: by 2002:a9d:7f0b:: with SMTP id j11mr17627649otq.369.1625635793935;
        Tue, 06 Jul 2021 22:29:53 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:53 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 2/9] block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
Date:   Tue,  6 Jul 2021 22:29:36 -0700
Message-Id: <20210707052943.3960-3-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

The size of any bio must be aligned to the data unit size of the bio crypt
context (if it exists) of that bio. This must also be ensured whenever a
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns the
required alignment in sectors. The number of sectors passed to any call of
bio_split() must be aligned to blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..81d10cf950ce 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,18 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Return the number of sectors to which the size of this bio (and any bios
+ * split from it) must be aligned based on its encryption context.
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
@@ -93,6 +105,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
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
2.25.1

