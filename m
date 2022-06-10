Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA4CC43334
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbiFJUEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiFJUEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 16:04:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FA28710
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:13 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIDr76028846
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=d8bkh7bfZZY5WjJ1g5p81fAjYDMdOKOPAhoGcAryaQs=;
 b=kH9v/ayu679VGaCZ+C4IvFjZt/07EaKj4vRvCHMau5dISJI6AY4GAnsiCwvwwY3NHgXy
 Tx8HdLP79eCJ3hsE/UMFk6wQmSrDWm28Txay4ArVEAeznAu/CMNKzJLc+OJDxAbmzXnR
 TQadrCvQLuqT1F0VBQ+GIShLSuoHGanKD6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb208m54-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:12 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:04:11 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 99F384E9D696; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 03/11] block: export dma_alignment attribute
Date:   Fri, 10 Jun 2022 12:58:22 -0700
Message-ID: <20220610195830.3574005-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bj3HofPq1eYezXSAinWTXD3xmO1yuJqb
X-Proofpoint-ORIG-GUID: bj3HofPq1eYezXSAinWTXD3xmO1yuJqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

User space may want to know how to align their buffers to avoid
bouncing. Export the queue attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 block/blk-sysfs.c                    | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index e8797cd09aff..cd14ecb3c9a5 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -260,6 +260,15 @@ Description:
 		for discards, and don't read this file.
=20
=20
+What:		/sys/block/<disk>/queue/dma_alignment
+Date:		May 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		Reports the alignment that user space addresses must have to be
+		used for raw block device access with O_DIRECT and other driver
+		specific passthrough mechanisms.
+
+
 What:		/sys/block/<disk>/queue/fua
 Date:		May 2018
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..14607565d781 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -274,6 +274,11 @@ static ssize_t queue_virt_boundary_mask_show(struct =
request_queue *q, char *page
 	return queue_var_show(q->limits.virt_boundary_mask, page);
 }
=20
+static ssize_t queue_dma_alignment_show(struct request_queue *q, char *p=
age)
+{
+	return queue_var_show(queue_dma_alignment(q), page);
+}
+
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
 queue_##name##_show(struct request_queue *q, char *page)		\
@@ -606,6 +611,7 @@ QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
=20
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
@@ -667,6 +673,7 @@ static struct attribute *queue_attrs[] =3D {
 	&blk_throtl_sample_time_entry.attr,
 #endif
 	&queue_virt_boundary_mask_entry.attr,
+	&queue_dma_alignment_entry.attr,
 	NULL,
 };
=20
--=20
2.30.2

