Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C22BC433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290A961A05
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCXMWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232783AbhCXMWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8+DQME16jUyvekhNEe/o2OTn7M0+U6k+OHPme+ONW0=;
        b=emJ0154rmnLyTT/n75eP4BurTMiaX/lrt0rKNnB3Sm64mP1IPxQsx+Ap1vP1lTCdB3SaYn
        EDxgEqJ4NYi6A76r/8uPVBEK073khRADeJs5lHgnh5pSImPdAuHnfD51z2/NcxJ+2NY9Jc
        5iMaHKKliVaMOfKf4csISChpXTiv1aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-mVd1XucmM6qjrtCSskaDZQ-1; Wed, 24 Mar 2021 08:21:59 -0400
X-MC-Unique: mVd1XucmM6qjrtCSskaDZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE348C3F39;
        Wed, 24 Mar 2021 12:21:34 +0000 (UTC)
Received: from localhost (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 577436A90C;
        Wed, 24 Mar 2021 12:20:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/13] block: prepare for supporting bio_list via other link
Date:   Wed, 24 Mar 2021 20:19:22 +0800
Message-Id: <20210324121927.362525-9-ming.lei@redhat.com>
In-Reply-To: <20210324121927.362525-1-ming.lei@redhat.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far bio list helpers always use .bi_next to traverse the list, we
will support to link bios by other bio field.

Prepare for such support by adding a macro so that users can define
another helpers for linking bios by other bio field.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 132 +++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0246c92a6e8..619edd26a6c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -608,75 +608,11 @@ static inline unsigned bio_list_size(const struct bio_list *bl)
 	return sz;
 }
 
-static inline void bio_list_add(struct bio_list *bl, struct bio *bio)
-{
-	bio->bi_next = NULL;
-
-	if (bl->tail)
-		bl->tail->bi_next = bio;
-	else
-		bl->head = bio;
-
-	bl->tail = bio;
-}
-
-static inline void bio_list_add_head(struct bio_list *bl, struct bio *bio)
-{
-	bio->bi_next = bl->head;
-
-	bl->head = bio;
-
-	if (!bl->tail)
-		bl->tail = bio;
-}
-
-static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
-{
-	if (!bl2->head)
-		return;
-
-	if (bl->tail)
-		bl->tail->bi_next = bl2->head;
-	else
-		bl->head = bl2->head;
-
-	bl->tail = bl2->tail;
-}
-
-static inline void bio_list_merge_head(struct bio_list *bl,
-				       struct bio_list *bl2)
-{
-	if (!bl2->head)
-		return;
-
-	if (bl->head)
-		bl2->tail->bi_next = bl->head;
-	else
-		bl->tail = bl2->tail;
-
-	bl->head = bl2->head;
-}
-
 static inline struct bio *bio_list_peek(struct bio_list *bl)
 {
 	return bl->head;
 }
 
-static inline struct bio *bio_list_pop(struct bio_list *bl)
-{
-	struct bio *bio = bl->head;
-
-	if (bio) {
-		bl->head = bl->head->bi_next;
-		if (!bl->head)
-			bl->tail = NULL;
-
-		bio->bi_next = NULL;
-	}
-
-	return bio;
-}
-
 static inline struct bio *bio_list_get(struct bio_list *bl)
 {
 	struct bio *bio = bl->head;
@@ -686,6 +622,74 @@ static inline struct bio *bio_list_get(struct bio_list *bl)
 	return bio;
 }
 
+#define BIO_LIST_HELPERS(_pre, link)					\
+									\
+static inline void _pre##_add(struct bio_list *bl, struct bio *bio)	\
+{									\
+	bio->bi_##link = NULL;						\
+									\
+	if (bl->tail)							\
+		bl->tail->bi_##link = bio;				\
+	else								\
+		bl->head = bio;						\
+									\
+	bl->tail = bio;							\
+}									\
+									\
+static inline void _pre##_add_head(struct bio_list *bl, struct bio *bio) \
+{									\
+	bio->bi_##link = bl->head;					\
+									\
+	bl->head = bio;							\
+									\
+	if (!bl->tail)							\
+		bl->tail = bio;						\
+}									\
+									\
+static inline void _pre##_merge(struct bio_list *bl, struct bio_list *bl2) \
+{									\
+	if (!bl2->head)							\
+		return;							\
+									\
+	if (bl->tail)							\
+		bl->tail->bi_##link = bl2->head;			\
+	else								\
+		bl->head = bl2->head;					\
+									\
+	bl->tail = bl2->tail;						\
+}									\
+									\
+static inline void _pre##_merge_head(struct bio_list *bl,		\
+				       struct bio_list *bl2)		\
+{									\
+	if (!bl2->head)							\
+		return;							\
+									\
+	if (bl->head)							\
+		bl2->tail->bi_##link = bl->head;			\
+	else								\
+		bl->tail = bl2->tail;					\
+									\
+	bl->head = bl2->head;						\
+}									\
+									\
+static inline struct bio *_pre##_pop(struct bio_list *bl)		\
+{									\
+	struct bio *bio = bl->head;					\
+									\
+	if (bio) {							\
+		bl->head = bl->head->bi_##link;				\
+		if (!bl->head)						\
+			bl->tail = NULL;				\
+									\
+		bio->bi_##link = NULL;					\
+	}								\
+									\
+	return bio;							\
+}									\
+
+BIO_LIST_HELPERS(bio_list, next);
+
 /*
  * Increment chain count for the bio. Make sure the CHAIN flag update
  * is visible before the raised count.
-- 
2.29.2

