Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1CBC43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 15:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiGEPrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGEPqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 11:46:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A41C10B
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 08:46:08 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265FDkhp013675
        for <linux-block@vger.kernel.org>; Tue, 5 Jul 2022 08:46:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=xFgG8Xc6eIABxXYm/O+u+rzOX/O2jGRK+u7+j6UP5fA=;
 b=N1oQETHku8zOM6DPcOmWmGdOLL8ChDBXFKdPJuwrYDUE0cjPmCl0wbo/i2QPucaMtHI3
 DcZYfFkSl9V/SxvqYAw3MK6yCpMUoHRfwtw66LujtT+TyhbctSVOvKpQLK2d8QjDejpn
 +UjaQIHyKnqBrBHUTi6MmI26wtdb1AklnUs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h2hbqrwe6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 08:46:08 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 08:46:01 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 08:45:33 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 407A55C1F910; Tue,  5 Jul 2022 08:45:10 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Keith Busch" <kbusch@kernel.org>
Subject: [PATCH 1/3] block: ensure iov_iter advances for added pages
Date:   Tue, 5 Jul 2022 08:45:04 -0700
Message-ID: <20220705154506.2993693-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QqOayhV1a9PZ2y1G69FPZNNgOvTgPpWM
X-Proofpoint-ORIG-GUID: QqOayhV1a9PZ2y1G69FPZNNgOvTgPpWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_12,2022-06-28_01,2022-06-22_01
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

