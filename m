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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D2C4743C
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2063F613F8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFDUBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhFDUBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:01:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD74C061767
        for <linux-block@vger.kernel.org>; Fri,  4 Jun 2021 12:59:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w130-20020a25df880000b02905327e5d7f43so13190329ybg.3
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R3HMBFHospGnC9Opd1R53FLCvcJarpfKxQXd852tZKY=;
        b=o/e7RzBLKivm9MR0djmqRPiA7UqgFavlq7CZ6C7ujUQ4xJW9sKCvusYV8Wjv7azcNF
         GSRJO+oc7exvTHwGRccUsla+3cH6Shf4/mQDAFh9WuieKusx6AvCPFT6Mkzfa7Dbeucr
         PQNp/k/I52NavAo4qdqzFqBlFvxbHC5pXqZYRWw+PNyReppr7DMFz7PiVFXbtiB2ypiI
         xb+/l9Ws5QmVb1kNKnTCCUcdGwMPTr+vsHmSDpmwIRr/45Dr4tzkwhKOlyDodWPZVGjW
         ROv294W4itIH06Hmj6Ky0PXe7RWcKIL20UnO75KjzvtIaj+KEWiaOhB8PBIMk4feF6a9
         dsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R3HMBFHospGnC9Opd1R53FLCvcJarpfKxQXd852tZKY=;
        b=l6uuVVEb18DgwD5Iif1zNlHU9P4se4x/MHRNxNc8Kfe6WrXv5lsGypyYUrV8saYnpa
         ARlAFfhjKQlspKC7qnyzX08v7EFsDzce6O570mtQgb2uMpl/+A6X36BCSd8WvAmA5aor
         a4L0tYVNhbVxcBEcbICRXnZ88dRh4e2+5No3VHwaqFOTXmCjVOHJfFq4akrl+WMer1sE
         PyhpTqPwtbPUBMiO2C+t2O1x3o8W+oC2j52S+mVy1J8mSMUMG4XddTQ7PILiGjSUwYgB
         oLczxvc+oXqIT1MZhWqsbNmsIbNeRRZWUYIIro8NuWBt7wEgoSz2uQbHSP9D1lesDPnT
         WPZA==
X-Gm-Message-State: AOAM5302d50L4LknNJxs8H1qmWjdPOH83OUmOPEUxdgRoxB2EPGvD7oD
        zPh4wdySAl13Cfhx3eqIaXzipGGt2al+mfhw6mYfIrRVtsBOY4jkBUFWaM9yXseLBzHUT9HQrPT
        3C7dtCx/HeX6WZyKhFfeUx44s7cnnOrMtED+QSsgEXge7mxG44ti8T4x7sFzcthWeLpKh
X-Google-Smtp-Source: ABdhPJzFZypqjRzJtlE+aOSTEjYGKn65clE50NBU5ELxH8iIHgXb/wJcszapXniKS65VqovIMY2D3B1Zvrs=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a5b:34a:: with SMTP id q10mr7679716ybp.224.1622836754233;
 Fri, 04 Jun 2021 12:59:14 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:53 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-4-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 03/10] block: introduce bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function returns the required alignment for the number of sectors in
a bio. In particular, the number of sectors passed to bio_split() must be
aligned to this value.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 8b3591aee0a5..c8dcad7dde81 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -262,6 +262,20 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * The required sector alignment for a bio. The number of sectors in any bio
+ * must be aligned to this value.
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
2.32.0.rc1.229.g3e70b5a671-goog

