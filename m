Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4549C64E75
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C66020773
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 14:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsrEjARH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgKQOH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgKQOH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 09:07:27 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC965C061A51
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 06:07:22 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b191so14028390qkc.10
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VFLfomyHfS1rChguiUYux0VDzmO87K0fqGJKV/Zo06o=;
        b=lsrEjARHRfnK+GRKjAxdOdYK84058343x4ulP/2szJFkfRTORC2ldq4cnjAxiY8jFI
         VQLtam4zqFLuBEcfKLbMnYFBrc32LaXluaMUMRa9Q0lhpOiy17Y8e5FpWCYnvuxFlQcp
         +qgOqNxvhb7p7nbmzb3olVL/Wp9bYkkluw/hVMI8LRZExpX+23VEDIC4LLOSsmGyFkYJ
         uYKVQe833Zw5GqXv9aw6cVkP5qfvpcB7mibNUbGyOlTqiXHs2rELMbbwEkRA7ghwvovl
         8cJR9PNzWNaFeurdO8tvnYukki2HEdBkRu7gHibwFjZNw2DaBb8Sv8CWJWiewGjFMyKg
         o55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VFLfomyHfS1rChguiUYux0VDzmO87K0fqGJKV/Zo06o=;
        b=NB6cXtQ82ELQ9ylNoQbbBy/+xpU8AoIxWHY9WAbH6WJd9o91LsqL9MgnY6vo3ooQZO
         eYmmV7dGLKKSC4PHsHYqGkk5Z2DrgxHszblVaG1xx4KHGVSKINAvCCrkPq+jOsle9OsL
         wNR9A/L7eUmIfCnBccGa2JPjwKFYaSlmx+Y7zgdhof7/qOKvBZ6x2gbLcuwPvHrAYTKd
         MueW8Dn/fohni2RzT/ecs36oKDXmdPSMAFHg+hprHKNu6ULQCFj4lL2eVgNYMmBiMFaX
         2ZcFaPRSUIB1MiqpAPkNcDKVIDWe9Oqw4cd/xsGbMySmU3i0InvpO2v0s8mPvFk8iGno
         UKUg==
X-Gm-Message-State: AOAM532H9KDxK/W2NOZAsTw1FmCLyDxGetd9fh7iADQ7DIaLoDzJguN5
        PUhHmS6YN7DZc9zRi+SXjbrVt7yvLmA=
X-Google-Smtp-Source: ABdhPJziptkvCq37CzgbpEBQNKwt2yD7i4Pi8fsOTIWooGKOH1aD86wFQm0soQyhT2NOVUgerF6aSe6rQFQ=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:470d:: with SMTP id k13mr21059648qvz.40.1605622042064;
 Tue, 17 Nov 2020 06:07:22 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:07:05 +0000
In-Reply-To: <20201117140708.1068688-1-satyat@google.com>
Message-Id: <20201117140708.1068688-6-satyat@google.com>
Mime-Version: 1.0
References: <20201117140708.1068688-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v7 5/8] iomap: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required.
No DUN contiguity checks are done - callers are expected to set up the
iomap correctly to ensure that each bio submitted by iomap will not have
blocks with incontiguous DUNs by calling fscrypt_limit_io_blocks()
appropriately.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..b4240cc3c9f9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
@@ -185,11 +186,14 @@ static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 	bio->bi_private = dio;
@@ -272,6 +276,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.29.2.299.gdc1121823c-goog

