Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49865C4332F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AF660F70
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhJQBkC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbhJQBkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E722EC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z69so9063202iof.9
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zk+VFUyTHswlZhVazEfOgbMJknuQJMVW20A7FDAdBoY=;
        b=1NiYVEuR3i7KT6Jj6x5n12kjrMNcvRwLttA0275gZExQUfb7VWn2/iVeb6E72aY7DL
         /RsUyyp+5GVTVO63uFz3ZhCRgn5c1CmOKPPJGBpQTyaMlVznN69Zu9GDT3BHerltZ9o8
         UGzo1wwyFhay9NxLYIukwIHXI6sM3aqLfVNF9w2S+Fx0rZdTYZ03Rsxhb5LdeAMZzv/q
         wqk0ybvAtm0T0TjG213C6TDLHO1lzriKsXcoPwxsPoocCjq8zoYHimRdyOhAq53gdKCm
         7oy1ilQq/TH8kQTWz9NU1GYyBaJJ5A5Wxiv38YWqKWj6ZHzcQbivhfqfD0kUe2aAIIiC
         h8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zk+VFUyTHswlZhVazEfOgbMJknuQJMVW20A7FDAdBoY=;
        b=3Ac8cluVfUwQJKPsg5ZaG2TO49F3CMlBsPjoNgzNu9sWtcoZd/geTX5PBE+ovFd8YQ
         x0hJ2gomRzhsy7uCzmbNpehyWt8BnLoDFTJUJg2451yLOBWSGE5T6VwdWv6lCsJstDgL
         Lcycf0DVNZVcOvwbIef7SFZOEOq2n2lMiOPEgPv+ShOZ3x8poRtTnl6MGxA4asGweEMo
         wkOu9qHgow/qBTRo3tEIEsmpyePuOA/Usz4LaqbUraDp3vKdy1jfjbTydx6c7RO3RTaO
         46FB21t5gpSWOTmuHz0M72fF2KSwYUw7sHsYqfPJ/gvFBgMyTA+Ve3q1hKFmF9nErvwt
         zXWg==
X-Gm-Message-State: AOAM532PU+s7dVk3PgvBkk96Rj7y9/+32ZLocgLm8KOBbiCgFvYgEL3y
        SfVArPJpz/nl7PQ1ot94ZPyJYajNBbE17A==
X-Google-Smtp-Source: ABdhPJzJno1cEt4Cd8Ntf+ikpFg7p9YdPTGDS260+dzXRvlwYJWjj8mJfrg57kmgcRtyp6vM4J5eYg==
X-Received: by 2002:a05:6602:2f06:: with SMTP id q6mr9409170iow.39.1634434673157;
        Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/14] block: don't bother iter advancing a fully done bio
Date:   Sat, 16 Oct 2021 19:37:36 -0600
Message-Id: <20211017013748.76461-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're completing nbytes and nbytes is the size of the bio, don't bother
with calling into the iterator increment helpers. Just clear the bio
size and we're done.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         | 15 ++-------------
 include/linux/bio.h | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3c9ff23a036..2427e6fca942 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1278,18 +1278,7 @@ int submit_bio_wait(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_wait);
 
-/**
- * bio_advance - increment/complete a bio by some number of bytes
- * @bio:	bio to advance
- * @bytes:	number of bytes to complete
- *
- * This updates bi_sector, bi_size and bi_idx; if the number of bytes to
- * complete doesn't align with a bvec boundary, then bv_len and bv_offset will
- * be updated on the last bvec as well.
- *
- * @bio will then represent the remaining, uncompleted portion of the io.
- */
-void bio_advance(struct bio *bio, unsigned bytes)
+void __bio_advance(struct bio *bio, unsigned bytes)
 {
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
@@ -1297,7 +1286,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
-EXPORT_SYMBOL(bio_advance);
+EXPORT_SYMBOL(__bio_advance);
 
 void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			struct bio *src, struct bvec_iter *src_iter)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 62d684b7dd4c..9538f20ffaa5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -119,6 +119,28 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
 }
 
+void __bio_advance(struct bio *, unsigned bytes);
+
+/**
+ * bio_advance - increment/complete a bio by some number of bytes
+ * @bio:	bio to advance
+ * @bytes:	number of bytes to complete
+ *
+ * This updates bi_sector, bi_size and bi_idx; if the number of bytes to
+ * complete doesn't align with a bvec boundary, then bv_len and bv_offset will
+ * be updated on the last bvec as well.
+ *
+ * @bio will then represent the remaining, uncompleted portion of the io.
+ */
+static inline void bio_advance(struct bio *bio, unsigned int nbytes)
+{
+	if (nbytes == bio->bi_iter.bi_size) {
+		bio->bi_iter.bi_size = 0;
+		return;
+	}
+	__bio_advance(bio, nbytes);
+}
+
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
@@ -381,8 +403,6 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 struct request_queue;
 
 extern int submit_bio_wait(struct bio *bio);
-extern void bio_advance(struct bio *, unsigned);
-
 extern void bio_init(struct bio *bio, struct bio_vec *table,
 		     unsigned short max_vecs);
 extern void bio_uninit(struct bio *);
-- 
2.33.1

