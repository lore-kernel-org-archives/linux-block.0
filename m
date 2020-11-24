Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07EC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1266B206D5
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy/pnL6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbgKXSB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390842AbgKXSB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 13:01:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90BAC0613D6
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p8so23277107wrx.5
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UeSxtr8F5MKjjgRzkdBiAIGeYvef1JkimaFWN5LzuM=;
        b=Hy/pnL6MgrnpG01xX/KfSrrnJv0CKyFAUCJzV5xgh7iVP6PPdzLI1Rk/I0bvxlgXfs
         DHuBu+hWsFov0AdPn4sY83VHHuHjBWLXy3PYvVoO4Cu+a0MT2RGpu15jZZttoojj+KL0
         NcBlS9AUxoNc4YInW9JN+DzVW0JnRj/jKnfw50xBW0SE+UnJ7YzSD9zsbUpe/6rhzEqa
         mQH9DlB/lhTOGCm174aaH7MoBy+lqYvikq9BpPQQTFVVfa0db+sHmM6bkyHxpQewKBou
         HdaSpKqqoQSPqAqPaANoQheQeHhQ4hTFC7sdXqufqRRSfoYEDvXgR4omCCuYFSv2uqcX
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UeSxtr8F5MKjjgRzkdBiAIGeYvef1JkimaFWN5LzuM=;
        b=ZYxUNf8qSPlbyxjA79yjFwE1l6xt+LrzffGmyM3Tf8sb4v+RfuiFVWaWvSPysFP9Fl
         birjeCo1mTuCY6ccIUjWMxjg9nSpcCcRzittPK6GgXYDU2Ff5nn4okD191/N+7wUfH6v
         VXPY83oJ/ziJYXJPbLs2EhkKgUomSb5Os3NLkyQSUhUawiEg8u/xJYekX+42MGE6Dt1a
         VQfS3bD/KbyQGIGhoe6F2OlHrBOIL3g1IkInX4OWVSt5APEI9AlaV1G4uEwuRYZXOKzO
         6wzkH7vIa52AP9vJDEwfjB4MWYLKkDQ5oZnXe8wyIIf3Bg+yUG+hXO0dZ8ij9udU7YIf
         hIWw==
X-Gm-Message-State: AOAM530YnirpWVEH02AW4i8q+TU8SlyhSzX9gOpPNV+obYS6dUQ1ECYu
        xsVHmk2WnpI2Gczxm2wnefg=
X-Google-Smtp-Source: ABdhPJzpMyQdO2xkf3pOxKT5kSF9qcXbAUrJ+RwOSeI7IcKlVg+jj/SnDcnG/Y1NJ8XSlk5PS2/LxQ==
X-Received: by 2002:adf:e449:: with SMTP id t9mr6659789wrm.257.1606240916660;
        Tue, 24 Nov 2020 10:01:56 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id x4sm12246403wrv.81.2020.11.24.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:01:55 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/2] bio: optimise bvec iteration
Date:   Tue, 24 Nov 2020 17:58:13 +0000
Message-Id: <e1acd31d91a1e9501a5420d6ac1488a4412a0353.1606240077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606240077.git.asml.silence@gmail.com>
References: <cover.1606240077.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__bio_for_each_bvec(), __bio_for_each_segment() and bio_copy_data_iter()
fall under conditions of bvec_iter_advance_single(), which is a faster
and slimmer version of bvec_iter_advance(). Add
bio_advance_iter_single() and convert them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c         |  4 ++--
 include/linux/bio.h | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..8e718920457a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1212,8 +1212,8 @@ void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 
 		flush_dcache_page(dst_bv.bv_page);
 
-		bio_advance_iter(src, src_iter, bytes);
-		bio_advance_iter(dst, dst_iter, bytes);
+		bio_advance_iter_single(src, src_iter, bytes);
+		bio_advance_iter_single(dst, dst_iter, bytes);
 	}
 }
 EXPORT_SYMBOL(bio_copy_data_iter);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..d55d53c49ae4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -148,11 +148,24 @@ static inline void bio_advance_iter(const struct bio *bio,
 		/* TODO: It is reasonable to complete bio with error here. */
 }
 
+/* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
+static inline void bio_advance_iter_single(const struct bio *bio,
+					   struct bvec_iter *iter,
+					   unsigned int bytes)
+{
+	iter->bi_sector += bytes >> 9;
+
+	if (bio_no_advance_iter(bio))
+		iter->bi_size -= bytes;
+	else
+		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+}
+
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
-	     bio_advance_iter((bio), &(iter), (bvl).bv_len))
+	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
@@ -161,7 +174,7 @@ static inline void bio_advance_iter(const struct bio *bio,
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
 		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
-	     bio_advance_iter((bio), &(iter), (bvl).bv_len))
+	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
 /* iterate over multi-page bvec */
 #define bio_for_each_bvec(bvl, bio, iter)			\
-- 
2.24.0

