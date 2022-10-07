Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2881C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJGTjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJGTin (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 15:38:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F4100BED
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 12:38:42 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297I3tHT011486
        for <linux-block@vger.kernel.org>; Fri, 7 Oct 2022 12:38:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=tNW7J3lts1U5Q6A3lcSNtjDwGy3R8xz/Y/If1JlIyLU=;
 b=fgqZ/rp7QL+oK1rmvyJYW5IkNig/29t9/PEgwZpSYuyMSNcBDj+BOBwW+dhNaEzjxRwF
 /x/mD1opSiFug2vhLIa+rb03mNy7ilsIwXEQscLtfijFsINY2MCBm2waLj4EX/9Do8lz
 NsDrxedneMYqlUdW+NF2pa0QvAxd+oZFd+5UNOY6WIRujKzxPGe/zSr+QwLL0GGQvDg0
 V4NpX+n4c1J8gQnOt/x6YwL4jut7BHGLEU7bhzafLH/7sFt6wmsWvIlUAW8dGdUOSO/J
 BVkprQYUSWKQjkpPcNpORlfL3aKBcFZVQK5XigiNOUVF0i1ymh2twjdMD90LR98cWhwR HQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k28c4pr4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 07 Oct 2022 12:38:41 -0700
Received: from twshared8247.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 12:38:40 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 99D9C984188C; Fri,  7 Oct 2022 12:38:32 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCHv2] block: fix leaking minors of hidden disks
Date:   Fri, 7 Oct 2022 12:38:25 -0700
Message-ID: <20221007193825.4058951-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wRO0ZeQMRdkuzsGi4--hECNIb_91kxQt
X-Proofpoint-GUID: wRO0ZeQMRdkuzsGi4--hECNIb_91kxQt
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
v1->v2:

  Actually check that the disk is hidden before assuming the minor needs
  to be freed.

 block/genhd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..0afcdbb7575c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1166,6 +1166,8 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
=20
+	if ((disk->flags & GENHD_FL_HIDDEN) && disk->major =3D=3D BLOCK_EXT_MAJ=
OR)
+		blk_free_ext_minor(disk->first_minor);
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
=20
--=20
2.30.2

