Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC59C433FE
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbiEaTQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiEaTQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:16:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09A6455
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiCF8027281
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kBTJzpfwkjUsUlRGiDqeDPclwObqIgkDJOxJq79advA=;
 b=PvBwoi0w5oNjL4Fj9Knn6R0qDKcz+kIS1ZrPPwfXBECHj6LmXKGffLFTHITkC4xoVMq/
 2KssXH3gIz8YHRp8/MyMYHgW7/SFJ3N0jLXrfkv4H+/mYImENPABeT5y6JRISp9iS2qD
 8r0C/vMFhyr4MECLawTX+agOjYpUQ7Avfyw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdj4su43k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:54 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D93414924B16; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 06/11] block/merge: count bytes instead of sectors
Date:   Tue, 31 May 2022 12:11:32 -0700
Message-ID: <20220531191137.2291467-7-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: duwaPcKurhd29sb_e3lx-q9FxQHr1tYY
X-Proofpoint-ORIG-GUID: duwaPcKurhd29sb_e3lx-q9FxQHr1tYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Individual bv_len's may not be a sector size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4->v5:

  Updated comment (Christoph)

 block/blk-merge.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..21fb4d14ca3e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -201,11 +201,11 @@ static inline unsigned get_max_segment_size(const s=
truct request_queue *q,
  * @nsegs:    [in,out] Number of segments in the bio being built. Increm=
ented
  *            by the number of segments from @bv that may be appended to=
 that
  *            bio without exceeding @max_segs
- * @sectors:  [in,out] Number of sectors in the bio being built. Increme=
nted
- *            by the number of sectors from @bv that may be appended to =
that
- *            bio without exceeding @max_sectors
+ * @bytes:    [in,out] Number of bytes in the bio being built. Increment=
ed
+ *            by the number of bytes from @bv that may be appended to th=
at
+ *            bio without exceeding @max_bytes
  * @max_segs: [in] upper bound for *@nsegs
- * @max_sectors: [in] upper bound for *@sectors
+ * @max_bytes: [in] upper bound for *@bytes
  *
  * When splitting a bio, it can happen that a bvec is encountered that i=
s too
  * big to fit in a single segment and hence that it has to be split in t=
he
@@ -216,10 +216,10 @@ static inline unsigned get_max_segment_size(const s=
truct request_queue *q,
  */
 static bool bvec_split_segs(const struct request_queue *q,
 			    const struct bio_vec *bv, unsigned *nsegs,
-			    unsigned *sectors, unsigned max_segs,
-			    unsigned max_sectors)
+			    unsigned *bytes, unsigned max_segs,
+			    unsigned max_bytes)
 {
-	unsigned max_len =3D (min(max_sectors, UINT_MAX >> 9) - *sectors) << 9;
+	unsigned max_len =3D min(max_bytes, UINT_MAX) - *bytes;
 	unsigned len =3D min(bv->bv_len, max_len);
 	unsigned total_len =3D 0;
 	unsigned seg_size =3D 0;
@@ -237,7 +237,7 @@ static bool bvec_split_segs(const struct request_queu=
e *q,
 			break;
 	}
=20
-	*sectors +=3D total_len >> 9;
+	*bytes +=3D total_len;
=20
 	/* tell the caller to split the bvec if it is too big to fit */
 	return len > 0 || bv->bv_len > max_len;
@@ -269,8 +269,8 @@ static struct bio *blk_bio_segment_split(struct reque=
st_queue *q,
 {
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, sectors =3D 0;
-	const unsigned max_sectors =3D get_max_io_size(q, bio);
+	unsigned nsegs =3D 0, bytes =3D 0;
+	const unsigned max_bytes =3D get_max_io_size(q, bio) << 9;
 	const unsigned max_segs =3D queue_max_segments(q);
=20
 	bio_for_each_bvec(bv, bio, iter) {
@@ -282,12 +282,12 @@ static struct bio *blk_bio_segment_split(struct req=
uest_queue *q,
 			goto split;
=20
 		if (nsegs < max_segs &&
-		    sectors + (bv.bv_len >> 9) <=3D max_sectors &&
+		    bytes + bv.bv_len <=3D max_bytes &&
 		    bv.bv_offset + bv.bv_len <=3D PAGE_SIZE) {
 			nsegs++;
-			sectors +=3D bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
-					 max_sectors)) {
+			bytes +=3D bv.bv_len;
+		} else if (bvec_split_segs(q, &bv, &nsegs, &bytes, max_segs,
+					   max_bytes)) {
 			goto split;
 		}
=20
@@ -300,13 +300,20 @@ static struct bio *blk_bio_segment_split(struct req=
uest_queue *q,
 split:
 	*segs =3D nsegs;
=20
+	/*
+	 * Individual bvecs may not be logical block aligned. Round down the
+	 * split size so that each bio is properly sector size aligned, even if
+	 * we do not use the full hardware limits.
+	 */
+	bytes =3D ALIGN_DOWN(bytes, queue_logical_block_size(q));
+
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
-	return bio_split(bio, sectors, GFP_NOIO, bs);
+	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
 }
=20
 /**
@@ -375,7 +382,7 @@ EXPORT_SYMBOL(blk_queue_split);
 unsigned int blk_recalc_rq_segments(struct request *rq)
 {
 	unsigned int nr_phys_segs =3D 0;
-	unsigned int nr_sectors =3D 0;
+	unsigned int bytes =3D 0;
 	struct req_iterator iter;
 	struct bio_vec bv;
=20
@@ -398,7 +405,7 @@ unsigned int blk_recalc_rq_segments(struct request *r=
q)
 	}
=20
 	rq_for_each_bvec(bv, rq, iter)
-		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
+		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &bytes,
 				UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
--=20
2.30.2

