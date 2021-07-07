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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173CAC07E95
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E438661CB2
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGGFcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGGFcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86718C06175F;
        Tue,  6 Jul 2021 22:29:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so1174134otp.1;
        Tue, 06 Jul 2021 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKLA0+FCBowVgG4E9RkNcEjEHS5yJYVCiaDWXv1pfIY=;
        b=oyNGkcJ6XnPGYVoJaxg1HQWuHn7uBt5y7r/Ix1cqwQkbbuUTaWpJP0TuYBr1d2ubdh
         se7hhIxQDEj0iZumZmjuQbDV8xgSJPlT3o3AVterATy6hAB9ZtiCBSmLL5gIPQ9qOON7
         Oo6YKmZrkSzsqL60BHJGLXBMHWZViAPekcszR+WP6BRQP7IxyhpFsEe3kY3toIEgK8PZ
         IJ8cGwkB+n69G3KpjL+Ul4mSQvJx1zNsLziUyRk69nBh0MYfWKySd0cb0fwA9Xlt8y6c
         q6DszTMFclIC6CD8vhrKWLLvd6Ls3RCg5nHpHY65uHSQlSb7UJAT9bN32sAKR7I/Y8fr
         kxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKLA0+FCBowVgG4E9RkNcEjEHS5yJYVCiaDWXv1pfIY=;
        b=TXVOZ+KG0c1jesD6yur6vvIBV52/KTg8oHxZUTAFKzPMzUNRru+w9t67p/qdEaMPpR
         Jhp/uk0DS1sr5E2o3oqb3EkP4ENQR4MtOQNqq9EA61A/Xqd0ogaWQUQk5IXbprcqJJvq
         u779tMj065d79bTiD+NxaXz2fu5WHLqV/pKAvzb6leU7ODyyqzV2FZDNEjtjrzc3LZIa
         geSo0pb8x3Kx2l8u9LubGjmuVh0SjivM2ZKgNrau6o4Uiuewm23zyr6r+nAQUxjYeT+m
         UDrLeuhaKm6znBekTXqPW7YfEnm/hv//ecunOBWQqFKVsUgjbfee9FbIA2TlHOjwQ00Q
         zw3Q==
X-Gm-Message-State: AOAM530nXbs/TQDSKwooAKxtllVw3t8HqeHQgEecJWu5NgJJSNzT8IJY
        kXGouWn2hAA1wKImUGpwA9eS4z9nZ9Q=
X-Google-Smtp-Source: ABdhPJwwPNc307kT3uft+V/0e81pT9M5PI/vcOzJY/NrFGAr9Xv4KyvBSIqwigsALCTahPWhkaZOjQ==
X-Received: by 2002:a05:6830:99:: with SMTP id a25mr17281218oto.19.1625635794835;
        Tue, 06 Jul 2021 22:29:54 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:54 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 3/9] block: introduce bio_required_sector_alignment()
Date:   Tue,  6 Jul 2021 22:29:37 -0700
Message-Id: <20210707052943.3960-4-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

This function returns the required alignment for the number of sectors in
a bio. In particular, the number of sectors passed to bio_split() must be
aligned to this value.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 4b885c0f6708..047d2c2411f2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -261,6 +261,23 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * Return the number of sectors to which the size of the given bio (and any bios
+ * split from it) must be aligned.
+ *
+ * Normally this is just the disk's logical block size in sectors, but it may be
+ * greater if the bio has an encryption context.
+ */
+static inline unsigned int bio_required_sector_alignment(struct bio *bio)
+{
+	unsigned int alignmask =
+		(bdev_logical_block_size(bio->bi_bdev) >> SECTOR_SHIFT) - 1;
+
+	alignmask |= blk_crypto_bio_sectors_alignment(bio) - 1;
+
+	return alignmask + 1;
+}
+
 /*
  * The max bio size which is aligned to q->limits.discard_granularity. This
  * is a hint to split large discard bio in generic block layer, then if device
-- 
2.25.1

