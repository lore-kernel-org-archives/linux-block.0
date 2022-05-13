Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E6C433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 16:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381327AbiEMQO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379689AbiEMQOF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 12:14:05 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5653DDEA
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFAmr6013679
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MIWeVQr0AeMqvbFOFL6kqzObRQGshHG578oRNvU8WpE=;
 b=XUTinstr+ANDgzYKfddJ2VkV7wZ1feDsYS98/ItPa9yzWJo/LKaCpOJkNKMOoX54R6BH
 iDkdO6OqQIp7vsoH5p6KnofKLYupEh22FXNxm7Geyau933uU0gI9sdV+WWS6ALcxNcBK
 17zIBaXnHHJ5W0R6lQR2QWgCED4zdVdC/ro= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g19w9wrhm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:02 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:14:01 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id AD6E33E459A4; Fri, 13 May 2022 09:13:56 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] block: ensure direct io is a block size
Date:   Fri, 13 May 2022 09:13:39 -0700
Message-ID: <20220513161339.1580042-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513161339.1580042-1-kbusch@fb.com>
References: <20220513161339.1580042-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ueOvbh9N39U8PgGy3WYKkIdOKYgfOgcw
X-Proofpoint-GUID: ueOvbh9N39U8PgGy3WYKkIdOKYgfOgcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_08,2022-05-13_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

If the iterator has an offset, filling a bio to the max bvecs may result
in a size that isn't aligned to the block size. Mask off bytes for the
bio being constructed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 4259125e16ab..b42a9e3ff068 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1144,6 +1144,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 {
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
 	bool same_page =3D false;
@@ -1160,6 +1161,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size =3D size & ~(queue_logical_block_size(q) - 1);
+
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
--=20
2.30.2

