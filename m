Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD3AC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 17:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBORSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBORSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 12:18:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD38694
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 09:18:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FH4imk014007;
        Wed, 15 Feb 2023 17:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=DzISjBPqwcT+DrKGr2x1FcScl1UWkBOb0rT1LG0Seco=;
 b=U3Omn/hwBE6CsRCfbxnpmr9DvuHfRY1YuGMZ/tDbIrjVMAkicCBG9WTXm3E+DE6vWzCS
 M1MoZtZwAQHGcy/hwaWYO9kznHTJ5cVzitSMBsnoSP3gYAHyKPeWOhjLVfU5B0sF0rFY
 tGICo/pSBQ7KsCcMBvO/8R9ObDTeIiDPLh0LwdWavkziaiq5W7Ogo1LBSqQxUhPLQydc
 dUEOig6blCNafqvkRE7qnv9QsYpbN24JqeU8WTNEtQFqSpR5RGQ5d1dSkuv0JB9BDmQd
 HLew24JHTu3GDHc8V/5ItqfSlZdrTByjw22GI3/YATBsKTvBl9jYfWYkTTEdRYMsQxzK mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m1110y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 17:18:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FGDFsO016754;
        Wed, 15 Feb 2023 17:18:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f7f0hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 17:18:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FHI2gw022138;
        Wed, 15 Feb 2023 17:18:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f7f0h8-1;
        Wed, 15 Feb 2023 17:18:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Saurav Kashyap <skashyap@marvell.com>
Subject: [PATCH] block: bio-integrity: Copy flags when bio_integrity_payload is cloned
Date:   Wed, 15 Feb 2023 12:18:01 -0500
Message-Id: <20230215171801.21062-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150155
X-Proofpoint-GUID: 5Gyn2MyZm4g1j6q3OyfmdO-_jNuRY68K
X-Proofpoint-ORIG-GUID: 5Gyn2MyZm4g1j6q3OyfmdO-_jNuRY68K
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure to copy the flags when a bio_integrity_payload is cloned.
Otherwise per-I/O properties such as IP checksum flag will not be
passed down to the HBA driver. Since the integrity buffer is owned by
the original bio, the BIP_BLOCK_INTEGRITY flag needs to be masked off
to avoid a double free in the completion path.

Fixes: aae7df50190a ("block: Integrity checksum flag")
Fixes: b1f01388574c ("block: Relocate bio integrity flags")
Reported-by: Saurav Kashyap <skashyap@marvell.com>
Tested-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3f5685c00e36..91ffee6fc8cb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -418,6 +418,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vcnt = bip_src->bip_vcnt;
 	bip->bip_iter = bip_src->bip_iter;
+	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
 
 	return 0;
 }
-- 
2.36.1

