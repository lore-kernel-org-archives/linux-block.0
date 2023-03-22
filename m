Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D77C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCVUpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCVUo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 16:44:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA910C
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 13:38:40 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MK2pS4022718
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 13:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=HvxeqQtgoUYOqveDqCCDVk0JtDl9H5KcrSA2JrvWmL0=;
 b=Qgc/JzE2R8HJEYBwruRRLpCl7oZD/nC+iKJ7fAy0yBhEuUuROJEa1bdIW1PBARObN+4S
 jNcb/0c5hSXsp9WGuUr7dW1XebRm2mwlb0dMou9pfwIVBvl2zIwCwQUlPo8Yf/p+RwNd
 OmLpZtahZy/O27RlfTveZFRqioJiFXbcL5v4YN4v/FFY7IYCXtQEPnevadod1HcUDKZS
 bfmW9f/6AOh3+S24y4lY04lJAGAyJFNneXSW/+FgqIOeStawJN4YOuWVhDRp1ALoiSXC
 ZgksGfa72VbFOWc+yNKTFAJ4TNTD4ig6qEyBvPsVIaIDIYbO5XxSIxfwdwrFZcuE3meD dA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pfn1gf08r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 13:38:39 -0700
Received: from twshared8612.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Mar 2023 13:38:36 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id CAC0F142B58C8; Wed, 22 Mar 2023 13:38:14 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: ensure polled hctx is valid
Date:   Wed, 22 Mar 2023 13:38:12 -0700
Message-ID: <20230322203812.674738-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _LZVDIf6jyL9RzvOY4NaBXiNVP64l6c9
X-Proofpoint-GUID: _LZVDIf6jyL9RzvOY4NaBXiNVP64l6c9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Imagine two threads polling the same queue while that queue is trying to
reallocate its hardware contexts. Both threads see their bios' valid
cookie value. The first polling thread completes all outstanding bios,
then the queue rebalances the hctx's. The 2nd polling thread attempts to
poll its now outdated cookie which may not have an hctx, or may not be a
polling type anymore. Check for both.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 932d2e95392e6..37d8a2f4d5da8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4721,6 +4721,9 @@ int blk_mq_poll(struct request_queue *q, blk_qc_t c=
ookie, struct io_comp_batch *
 	long state =3D get_current_state();
 	int ret;
=20
+	if (!hctx || hctx->type !=3D HCTX_TYPE_POLL)
+		return 0;
+
 	do {
 		ret =3D q->mq_ops->poll(hctx, iob);
 		if (ret > 0) {
--=20
2.34.1

