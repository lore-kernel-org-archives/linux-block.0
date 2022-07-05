Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1165C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiGEPqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiGEPpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 11:45:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4118378
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 08:45:36 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265FDUAD028428
        for <linux-block@vger.kernel.org>; Tue, 5 Jul 2022 08:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e76lo8txgOrdQXHNY5JneNADPoSOMcRa9MkJbZK28GY=;
 b=cqJJMIy5L2UcyhUCgQMDDU7wtNM0yzXmJse+Vl81/7zUtpGB0B6FoiX2VCHhuwW0daY4
 9mW57wgPLoKFz6Jp2qIt4ewJrYPBvRKKSsbz56pp+6TUO9BvxpiMvH4jGWpE0ijXV+JM
 A47WsBSYUQTj5srOw6NfCMU9qyC2W/PAm6M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4apvvbp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 08:45:36 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 08:45:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 527EB5C1F913; Tue,  5 Jul 2022 08:45:10 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] block: ensure bio_iov_add_page can't fail
Date:   Tue, 5 Jul 2022 08:45:05 -0700
Message-ID: <20220705154506.2993693-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705154506.2993693-1-kbusch@fb.com>
References: <20220705154506.2993693-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: icILdWDP3K2WXZgYnSQSckaBpaa5Y8kh
X-Proofpoint-GUID: icILdWDP3K2WXZgYnSQSckaBpaa5Y8kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_12,2022-06-28_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Adding the page could fail on the bio_full() condition, which checks for
either exceeding the bio's max segments or total size exceeding
UINT_MAX. We already ensure the max segments can't be exceeded, so just
ensure the total size won't reach the limit. This simplifies error
handling and removes unnecessary repeated bio_full() checks.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fdd58461b78f..01223f8086ed 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1165,8 +1165,6 @@ static int bio_iov_add_page(struct bio *bio, struct=
 page *page,
 	bool same_page =3D false;
=20
 	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-		if (WARN_ON_ONCE(bio_full(bio, len)))
-			return -EINVAL;
 		__bio_add_page(bio, page, len, offset);
 		return 0;
 	}
@@ -1228,7 +1226,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size =3D iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_siz=
e,
+				  nr_pages, &offset);
 	if (size > 0)
 		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	if (unlikely(size <=3D 0))
@@ -1238,16 +1237,16 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
 		struct page *page =3D pages[i];
=20
 		len =3D min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
+		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 			ret =3D bio_iov_add_zone_append_page(bio, page, len,
 					offset);
-		else
-			ret =3D bio_iov_add_page(bio, page, len, offset);
+			if (ret) {
+				bio_put_pages(pages + i, left, offset);
+				break;
+			}
+		} else
+			bio_iov_add_page(bio, page, len, offset);
=20
-		if (ret) {
-			bio_put_pages(pages + i, left, offset);
-			break;
-		}
 		offset =3D 0;
 	}
=20
--=20
2.30.2

