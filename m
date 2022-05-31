Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbiEaTQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiEaTQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:16:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEE9FEE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:55 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFii1j007242
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2rItl/F1NMKgVGyD79/zU2Yaz+xj0L1y7TsYse4R1IE=;
 b=Y35NhUmzuImRzok8zRj01WmrxFeE40NiIWGBZ2L9BoUQae6h0UdcTqiuUsflBFgtrFYK
 8ZOJBEUMGqmdc2cNb3dx1hNQdnmjfg0+cRSGb0R2mUXVCCaBLNEUwrl/fS6usvKRlYWY
 n7Wt569rco0qj1WFm2WrRGr/zBIMEVmy3qI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gcu788jha-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:55 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:54 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 0BAF34924B19; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 09/11] block: introduce bdev_iter_is_aligned helper
Date:   Tue, 31 May 2022 12:11:35 -0700
Message-ID: <20220531191137.2291467-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UtmAEEgD-We16bbzy7S-dCdDAv8ZKfKk
X-Proofpoint-ORIG-GUID: UtmAEEgD-We16bbzy7S-dCdDAv8ZKfKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Provide a convenient function for this repeatable coding pattern.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 834b981ef01b..583cdeb8895d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
+static inline bool bvev_iter_is_aligned(struct block_device *bdev,
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

