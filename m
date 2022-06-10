Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE0C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 20:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiFJUKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347094AbiFJUKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 16:10:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654FC666A5
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:10:10 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIB3ol031875
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dywOri+/cY1xPB0YNJx6g470GDKJiIgQUSlE0U+ycFg=;
 b=FN15DiGAcxYLaVcAAl0WunUuMNYlPCsVNqnyh1Apm38KQVujBdl9cP5dj7LskcHJE4mc
 uAs7i+kyiPu5FiGP1mbAvtbCAZQSFu3uSgwDaAeLO8GsKCR3UeaDJ39sdJomscE2UVLv
 l7VbT41oOvLtzJDzXvxQ1sRh9hyiHfMYRbs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb0s8pq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:10:10 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:10:09 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 2C2244E9D6A9; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 09/11] block: introduce bdev_iter_is_aligned helper
Date:   Fri, 10 Jun 2022 12:58:28 -0700
Message-ID: <20220610195830.3574005-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v9pXwPqdYCqWf_xb0MaAP1gfpWsh6G5A
X-Proofpoint-ORIG-GUID: v9pXwPqdYCqWf_xb0MaAP1gfpWsh6G5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Provide a convenient function for this repeatable coding pattern.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab7e6aa17954..fb5c177708d5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1371,6 +1371,13 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
+static inline bool bdev_iter_is_aligned(struct block_device *bdev,
+					struct iov_iter *iter)
+{
+	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
+				   bdev_logical_block_size(bdev) - 1);
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

