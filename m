Return-Path: <SRS0=yHxa=2T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC23C2D0C8
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 02:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CBB21741
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 02:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTiaEzio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfL2Ccq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:32:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbfL2Ccq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Dec 2019 21:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577586764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ybn2C2h2DHgE+3vcixIRzlx8G6Ik5hcUJldK5GhD/5Q=;
        b=iTiaEzioR4NP+3762khxpCn6obVbLRLtneU5S1i+CvHAKP4tEmgTbv7jZxZl4ANRzIM2e8
        wPqSrjHcqe5ujq3bCURuh6hpV/7mTTaJ70FUJembwW/vHDrf6Ln7aDOVuT8Z+QWX/oPXAq
        Kh2bBbpGVFIQ2PLniTvl2XohlPhAFUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-QHoxB8zQP3G5L1ePekvJXQ-1; Sat, 28 Dec 2019 21:32:43 -0500
X-MC-Unique: QHoxB8zQP3G5L1ePekvJXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A5E2107ACC4;
        Sun, 29 Dec 2019 02:32:42 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7F5E77C82;
        Sun, 29 Dec 2019 02:32:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: fix splitting segments
Date:   Sun, 29 Dec 2019 10:32:30 +0800
Message-Id: <20191229023230.28940-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two issues in get_max_segment_size():

1) the default segment boudary mask is bypassed, and some devices still
require segment to not cross the default 4G boundary

2) the segment start address isn't taken into account when checking
segment boundary limit

Fixes the two issues.

Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-pag=
e bvec count")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d783bdc4559b..234377d8146b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -157,16 +157,14 @@ static inline unsigned get_max_io_size(struct reque=
st_queue *q,
 	return sectors & (lbs - 1);
 }
=20
-static unsigned get_max_segment_size(const struct request_queue *q,
-				     unsigned offset)
+static inline unsigned get_max_segment_size(const struct request_queue *=
q,
+					    const struct page *start_page,
+					    unsigned long offset)
 {
 	unsigned long mask =3D queue_segment_boundary(q);
=20
-	/* default segment boundary mask means no boundary limit */
-	if (mask =3D=3D BLK_SEG_BOUNDARY_MASK)
-		return queue_max_segment_size(q);
-
-	return min_t(unsigned long, mask - (mask & offset) + 1,
+	offset =3D mask & (page_to_phys(start_page) + offset);
+	return min_t(unsigned long, mask - offset + 1,
 		     queue_max_segment_size(q));
 }
=20
@@ -201,7 +199,8 @@ static bool bvec_split_segs(const struct request_queu=
e *q,
 	unsigned seg_size =3D 0;
=20
 	while (len && *nsegs < max_segs) {
-		seg_size =3D get_max_segment_size(q, bv->bv_offset + total_len);
+		seg_size =3D get_max_segment_size(q, bv->bv_page,
+						bv->bv_offset + total_len);
 		seg_size =3D min(seg_size, len);
=20
 		(*nsegs)++;
@@ -419,7 +418,8 @@ static unsigned blk_bvec_map_sg(struct request_queue =
*q,
=20
 	while (nbytes > 0) {
 		unsigned offset =3D bvec->bv_offset + total;
-		unsigned len =3D min(get_max_segment_size(q, offset), nbytes);
+		unsigned len =3D min(get_max_segment_size(q, bvec->bv_page,
+					offset), nbytes);
 		struct page *page =3D bvec->bv_page;
=20
 		/*
--=20
2.20.1

