Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F7CCA47F
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGEPqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiGEPpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 11:45:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D5175B6
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 08:45:39 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265FDUAH028428
        for <linux-block@vger.kernel.org>; Tue, 5 Jul 2022 08:45:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6VyZ7VWwddmwfYb64IxFJS52WLjceaQUMCQwIfSXDSI=;
 b=Q/fvZOo5KrbOzHxHf30rQlv5tKwloAoBMyoJOGFVDDuv6mRSemVgVH7gCC+FwO0+BX4d
 c9CC2WpvOaXjdPWLsCJK7+V+ruxOxoWDA0xnYABiL60OYeZjLY0of3CUYZtWx/gVsZAY
 aV//GnXKE1fkx1Ex1vyWenBl3Hr7aX5vQn8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4apvvbp9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 08:45:38 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 08:45:35 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D2C8F5C1F914; Tue,  5 Jul 2022 08:45:10 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] block: fix leaking page ref on truncated direct io
Date:   Tue, 5 Jul 2022 08:45:06 -0700
Message-ID: <20220705154506.2993693-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705154506.2993693-1-kbusch@fb.com>
References: <20220705154506.2993693-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9o66aThGotj0c2DzMvZq-mnP9e291a2s
X-Proofpoint-GUID: 9o66aThGotj0c2DzMvZq-mnP9e291a2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_12,2022-06-28_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The size being added to a bio from an iov is aligned to a block size
after the pages were gotten. If the new aligned size truncates the last
page, its reference was being leaked. Ensure all pages that were not
added to the bio have their reference released.

Since this essentially requires doing the same that bio_put_pages(), and
there was only one caller for that function, this patch makes the
put_page() loop common for everyone.

Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 01223f8086ed..082436736d69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1151,14 +1151,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_=
iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
=20
-static void bio_put_pages(struct page **pages, size_t size, size_t off)
-{
-	size_t i, nr =3D DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
-
-	for (i =3D 0; i < nr; i++)
-		put_page(pages[i]);
-}
-
 static int bio_iov_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int offset)
 {
@@ -1228,10 +1220,16 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
 	 */
 	size =3D iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_siz=
e,
 				  nr_pages, &offset);
-	if (size > 0)
+	if (size > 0) {
+		nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
 		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
-	if (unlikely(size <=3D 0))
-		return size ? size : -EFAULT;
+	} else
+		nr_pages =3D 0;
+
+	if (unlikely(size <=3D 0)) {
+		ret =3D size ? size : -EFAULT;
+		goto out;
+	}
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
@@ -1240,10 +1238,8 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 			ret =3D bio_iov_add_zone_append_page(bio, page, len,
 					offset);
-			if (ret) {
-				bio_put_pages(pages + i, left, offset);
+			if (ret)
 				break;
-			}
 		} else
 			bio_iov_add_page(bio, page, len, offset);
=20
@@ -1251,6 +1247,10 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	}
=20
 	iov_iter_advance(iter, size - left);
+out:
+	while (i < nr_pages)
+		put_page(pages[i++]);
+
 	return ret;
 }
=20
--=20
2.30.2

