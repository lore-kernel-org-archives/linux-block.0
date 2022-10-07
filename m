Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD8C433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 19:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJGTcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJGTcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 15:32:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA02B27E
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 12:32:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 297I3EjP010071
        for <linux-block@vger.kernel.org>; Fri, 7 Oct 2022 12:32:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=pTYQvH9eHiBVTo4+66G8d50saFJ+IrsqSBN7mKkiDlQ=;
 b=eGm8Hb2aYg6dcvgslcNGCQQ2JIyQjAN1dVSPvG7kPDXmSZrIgAOiDSJDsZmDJkKtzCwh
 qN+9mQtN0KCCsByhwU+Buko9t6PhLcAObA9jOSvkSEIvuA8pI7Ss4n+rFjA1gX+Pa2UR
 FYweV8kczKyGsDXnF6HUtpSKLJZ/Go8t0u6Cgl/7t+913zSu0Vx7Li+z/eG5/dqOC9Dk
 qWdLV0fbn3p69y5Eg9jF26X6AQbxzYQwiyzbFvTrjUMRTDnfhbQli6/xuPiX+hNBWmdG
 ZA8CblrwoiAtM1bA1jSV282BZqMyasrXHFNenUlN+p4BDOTaDzYkv0wX5zTRNvlJ6dWJ tQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3k244sgmxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 07 Oct 2022 12:32:41 -0700
Received: from twshared5112.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 12:32:40 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 7DB88984034A; Fri,  7 Oct 2022 12:32:34 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] block: fix leaking minors of hidden disks
Date:   Fri, 7 Oct 2022 12:32:34 -0700
Message-ID: <20221007193234.3958465-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rw5wby7298SGgQCCpxNMtW5wC1S3AELD
X-Proofpoint-ORIG-GUID: rw5wby7298SGgQCCpxNMtW5wC1S3AELD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The major/minor of a hidden gendisk is not propagated to the block
device. This is required to suppress it from being visible. For these
disks, we need to handle freeing the dynamic minor directly when it's
released since bdev_free_inode() won't be able to.

Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/genhd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..d46edf26320a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1166,6 +1166,8 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
=20
+	if (disk->major =3D=3D BLOCK_EXT_MAJOR)
+		blk_free_ext_minor(disk->first_minor);
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
=20
--=20
2.30.2

