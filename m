Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A4C43217
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381697AbiEMQO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381084AbiEMQOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 12:14:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB845FC9
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEHjP6030569
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kHCxhgTRVCZCY0wTUT+Ftx2hh6wYUIhaJ3MlJ1aPO9M=;
 b=fTOf+whYLk8GzChNP9msN4WbjgDeklvOTN+1p9RE0zOC1DXPgVFWmxbLaYouRDZRCyVc
 g2GWksVsoisNhLK71GAgSOOJlW8dO7ZvTOD16O+wNp6VyY7BcAzrj6hig+Z2MRykS6km
 lZYjzA3od9Jru4AusaKX54YcdIKkqFSRDmA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g12mtsfjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:05 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:14:05 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:14:04 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3CFF63E459A1; Fri, 13 May 2022 09:13:56 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] block: export dma_alignment attribute
Date:   Fri, 13 May 2022 09:13:37 -0700
Message-ID: <20220513161339.1580042-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Gt7Iqwr0WvKTePowi0QCKvxUlRFmQEZa
X-Proofpoint-ORIG-GUID: Gt7Iqwr0WvKTePowi0QCKvxUlRFmQEZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_08,2022-05-13_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

User space may want to know how to align their buffers to avoid
bouncing. Export the queue attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

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

