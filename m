Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE1C43610
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A90822510
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A90822510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeKNBOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:14:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbeKNBOr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:14:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 336B6C04BD2F;
        Tue, 13 Nov 2018 15:16:13 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91C365D757;
        Tue, 13 Nov 2018 15:16:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 09/19] block: introduce bio_bvecs()
Date:   Tue, 13 Nov 2018 23:14:55 +0800
Message-Id: <20181113151505.15498-10-ming.lei@redhat.com>
In-Reply-To: <20181113151505.15498-1-ming.lei@redhat.com>
References: <20181113151505.15498-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 13 Nov 2018 15:16:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are still cases in which we need to use bio_bvecs() for get the
number of multi-page segment, so introduce it.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1f0dcf109841..3496c816946e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -196,7 +196,6 @@ static inline unsigned bio_segments(struct bio *bio)
 	 * We special case discard/write same/write zeroes, because they
 	 * interpret bi_size differently:
 	 */
-
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
@@ -205,13 +204,34 @@ static inline unsigned bio_segments(struct bio *bio)
 	case REQ_OP_WRITE_SAME:
 		return 1;
 	default:
-		break;
+		bio_for_each_segment(bv, bio, iter)
+			segs++;
+		return segs;
 	}
+}
 
-	bio_for_each_segment(bv, bio, iter)
-		segs++;
+static inline unsigned bio_bvecs(struct bio *bio)
+{
+	unsigned bvecs = 0;
+	struct bio_vec bv;
+	struct bvec_iter iter;
 
-	return segs;
+	/*
+	 * We special case discard/write same/write zeroes, because they
+	 * interpret bi_size differently:
+	 */
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
+		return 0;
+	case REQ_OP_WRITE_SAME:
+		return 1;
+	default:
+		bio_for_each_bvec(bv, bio, iter)
+			bvecs++;
+		return bvecs;
+	}
 }
 
 /*
-- 
2.9.5

