Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiEWVBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiEWVBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:01:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A628C2DD7C
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:45 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGuO5004133
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rpqiacMuHcLTR1z/gIeHmy8f8+SjLNa8B9Hyy5ZqGjA=;
 b=Gi5Gtl6DJeSWYv1HUMlz0Z7ucTB1fH3oSKewPIPjrGpQXngir3LJM7Z5XCcyXIQTjl+N
 hQ3UE/1+uChnQOa2Gs/oGrQCpXa3oPOZtAIQ5vutR5rX8+vpuSQLmTRRAeVVqtzty8rW
 8OqLaXmcNMsv3QAZfCtLfL5NpvPRAasfX7s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6v4k44xr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:01:45 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:44 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id A4FA44464155; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/6] block: introduce bdev_dma_alignment helper
Date:   Mon, 23 May 2022 14:01:16 -0700
Message-ID: <20220523210119.2500150-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210119.2500150-1-kbusch@fb.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xepnxYYl-L8_QCgQMVmLV3XlfDJTjvwp
X-Proofpoint-GUID: xepnxYYl-L8_QCgQMVmLV3XlfDJTjvwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_09,2022-05-23_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Preparing for upcoming dma_alignment users that have a block_device, but
don't need the request_queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bdf2ac9142c..834b981ef01b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1365,6 +1365,11 @@ static inline int queue_dma_alignment(const struct=
 request_queue *q)
 	return q ? q->dma_alignment : 511;
 }
=20
+static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
+{
+	return queue_dma_alignment(bdev_get_queue(bdev));
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

