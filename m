Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8031C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 20:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiF3UnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiF3Um5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6911C24
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:56 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UJCLq4004575
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Un4NLPzCwa9kRECQYiM/bb2nQGDf07xC9htX3/5DtNA=;
 b=ek3A4jZu7HYu0B2lUbVx87zg1N2CK9KDJ7Vg5nwa6+xnHz8tqpDYALGsIleQ/ZLzQ72Z
 zMZh8d98Tk2VWQ9QzrkleZSsCwgArhgxnGQtJ9KZQgGy6MEZcYPF3GrYJtkVhtij7g9o
 4VhPhrVJIiMsiJmws3pssN82ePFS+sbnp8k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h195a4pwy-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id F00125932DC1; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 09/12] block: add partial sector parameter helper
Date:   Thu, 30 Jun 2022 13:42:09 -0700
Message-ID: <20220630204212.1265638-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y80jDp6hw7th8crxT9UxkZ4fpiYwNEUX
X-Proofpoint-ORIG-GUID: Y80jDp6hw7th8crxT9UxkZ4fpiYwNEUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Check if an iov is a read, and aligned to a partial sector access. If so
set the skipped and truncated bytes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4396fcf04bb8..e631cdd01df4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1362,6 +1362,27 @@ static inline bool blkdev_dio_unaligned(struct blo=
ck_device *bdev, loff_t p,
 		!bdev_iter_is_aligned(bdev, iter);
 }
=20
+static inline bool blkdev_bit_bucket(struct block_device *bdev, loff_t p=
os,
+				loff_t len, struct iov_iter *iter, u16 *skip,
+				u16 *trunc)
+{
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
+
+	if (iov_iter_rw(iter) !=3D READ ||
+	    !blk_queue_bb(bdev_get_queue(bdev)) ||
+	    iter->nr_segs > 1)
+		return false;
+
+	if (!iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
+				 bdev_dma_alignment(bdev)))
+	        return false;
+
+	*skip =3D pos & (blksz - 1);
+	*trunc =3D blksz - ((pos + len) & (blksz - 1));
+
+	return true;
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

