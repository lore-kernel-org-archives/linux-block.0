Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC507C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbiEaTWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiEaTWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:22:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7861753728
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:52 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiJSD020530
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IPGZEoZLlJcqR4y6vi40ehjfP/MqoJW85cjDrHKckc4=;
 b=QYEcrZNf+hVe4oJ1zvfngKNwQmhfUUVb4niGahxQrJ6zIiWxYkwB5rOZfLS8Zc2hOEj8
 s0KHBRvWUMRKh6iNfg+VZnx7GDBbyteXjq9xeY6G3cxuAq68RHkAe7xOdlMIZOY7WIFe
 TwKTbssPNx164WOZL8vwcapD7KsDOW70wxY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbguqqxhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:52 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:22:51 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id F18AD4924B0C; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv5 02/11] block/bio: remove duplicate append pages code
Date:   Tue, 31 May 2022 12:11:28 -0700
Message-ID: <20220531191137.2291467-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fCrl5TQx5WGjPFBS9oTHPQ5IPLBZkRvn
X-Proofpoint-ORIG-GUID: fCrl5TQx5WGjPFBS9oTHPQ5IPLBZkRvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The getting pages setup for zone append and normal IO are identical. Use
common code for each.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 102 ++++++++++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e249f6414fd5..55d2a9c4e312 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1158,6 +1158,37 @@ static void bio_put_pages(struct page **pages, siz=
e_t size, size_t off)
 		put_page(pages[i]);
 }
=20
+static int bio_iov_add_page(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	bool same_page =3D false;
+
+	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (WARN_ON_ONCE(bio_full(bio, len)))
+			return -EINVAL;
+		__bio_add_page(bio, page, len, offset);
+		return 0;
+	}
+
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
+static int bio_iov_add_zone_append_page(struct bio *bio, struct page *pa=
ge,
+		unsigned int len, unsigned int offset)
+{
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
+	bool same_page =3D false;
+
+	if (bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_zone_append_sectors(q), &same_page) !=3D len)
+		return -EINVAL;
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))
=20
 /**
@@ -1176,7 +1207,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	bool same_page =3D false;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1185,7 +1215,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
 	 * possible so that we can start filling biovecs from the beginning
 	 * without overwriting the temporary page array.
-	*/
+	 */
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
@@ -1195,18 +1225,18 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
+		int ret;
=20
 		len =3D min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
+			ret =3D bio_iov_add_zone_append_page(bio, page, len,
+					offset);
+		else
+			ret =3D bio_iov_add_page(bio, page, len, offset);
=20
-		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-			if (same_page)
-				put_page(page);
-		} else {
-			if (WARN_ON_ONCE(bio_full(bio, len))) {
-				bio_put_pages(pages + i, left, offset);
-				return -EINVAL;
-			}
-			__bio_add_page(bio, page, len, offset);
+		if (ret) {
+			bio_put_pages(pages + i, left, offset);
+			return ret;
 		}
 		offset =3D 0;
 	}
@@ -1215,51 +1245,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	return 0;
 }
=20
-static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *=
iter)
-{
-	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
-	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
-	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);
-	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
-	struct page **pages =3D (struct page **)bv;
-	ssize_t size, left;
-	unsigned len, i;
-	size_t offset;
-	int ret =3D 0;
-
-	/*
-	 * Move page array up in the allocated memory for the bio vecs as far a=
s
-	 * possible so that we can start filling biovecs from the beginning
-	 * without overwriting the temporary page array.
-	 */
-	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
-	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
-
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (unlikely(size <=3D 0))
-		return size ? size : -EFAULT;
-
-	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
-		struct page *page =3D pages[i];
-		bool same_page =3D false;
-
-		len =3D min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_add_hw_page(q, bio, page, len, offset,
-				max_append_sectors, &same_page) !=3D len) {
-			bio_put_pages(pages + i, left, offset);
-			ret =3D -EINVAL;
-			break;
-		}
-		if (same_page)
-			put_page(page);
-		offset =3D 0;
-	}
-
-	iov_iter_advance(iter, size - left);
-	return ret;
-}
-
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1294,10 +1279,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
 iov_iter *iter)
 	}
=20
 	do {
-		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
-			ret =3D __bio_iov_append_get_pages(bio, iter);
-		else
-			ret =3D __bio_iov_iter_get_pages(bio, iter);
+		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
 	/* don't account direct I/O as memory stall */
--=20
2.30.2

