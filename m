Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 15:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiGLPdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGLPdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 11:33:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9399FE14
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 08:33:13 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C9iCsv006700
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 08:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=xFgG8Xc6eIABxXYm/O+u+rzOX/O2jGRK+u7+j6UP5fA=;
 b=ZyNu+P0u3K9TTVLqZdsUtUWuCgObU0K/RRtN7NzUdIOq0mywF/RTlm1QukURWBjIRFka
 7E+FID5rWCS2ZqaWxshULTYj8Y1JOX4WwagS33mqxNSFY3t0lhzm4yKk1HxZZw/qoSAc
 zCE6vkG70IRJoynec8YbEGte1nExtTtzXbs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h8pgny49f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 08:33:12 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 08:33:10 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 7BF5F60739D8; Tue, 12 Jul 2022 08:32:58 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/3] block: ensure iov_iter advances for added pages
Date:   Tue, 12 Jul 2022 08:32:54 -0700
Message-ID: <20220712153256.2202024-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KBG2jZHy6TOL0VlITJX0nTOCkCzJkt2H
X-Proofpoint-GUID: KBG2jZHy6TOL0VlITJX0nTOCkCzJkt2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

There are cases where a bio may not accept additional pages, and the iov
needs to advance to the last data length that was accepted. The zone
append used to handle this correctly, but was inadvertently broken when
the setup was made common with the normal r/w case.

Fixes: 576ed9135489c ("block: use bio_add_page in bio_iov_iter_get_pages"=
)
Fixes: c58c0074c54c2 ("block/bio: remove duplicate append pages code")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..fdd58461b78f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1211,6 +1211,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
+	int ret =3D 0;
=20
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
@@ -1235,7 +1236,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
-		int ret;
=20
 		len =3D min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
@@ -1246,13 +1246,13 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
=20
 		if (ret) {
 			bio_put_pages(pages + i, left, offset);
-			return ret;
+			break;
 		}
 		offset =3D 0;
 	}
=20
-	iov_iter_advance(iter, size);
-	return 0;
+	iov_iter_advance(iter, size - left);
+	return ret;
 }
=20
 /**
--=20
2.30.2

