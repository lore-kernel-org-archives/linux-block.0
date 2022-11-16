Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D01EC43217
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiKPWkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKPWjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 17:39:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679558002
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:39:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLdK1i016874;
        Wed, 16 Nov 2022 22:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=l14U5Jkv9etIkJoKML6/3Kbi8x0GUvPi8CsuovaXEy0=;
 b=1c2QQK05HjJ3v5pykkDHLsQLIR1esPlfIKp35lYRPbONHrCbk/rbNUz3VKi596POazvo
 QVO7Y7DNvIQNowp+Mai6Itg8ILuJjNf534OjEUGJX9cm5NZn8W2GKGutQINzezR7SBN8
 bT9rECOPWXB5/Fwe47NOrmEiATeWexzc6DjIjlvzDrhCA+5aGfXXsLf2TbhU1ZdDjAzj
 CLw+Be1drGi2bJLtFYFBkxAwGTvk7O/yq4PnO7rwyO72wzDzMjuJDEWA9ssFM2c55GIA
 z4IJC86SJvrZ0BIGk1BVXk92LJ5/ZQm3Q794luH6e4vRY/G2fbImovXWAyTn/Mk041lE qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htxxnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 22:39:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGMQL0h034762;
        Wed, 16 Nov 2022 22:39:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2dcmwfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 22:39:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGMdkue020661;
        Wed, 16 Nov 2022 22:39:46 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kw2dcmwes-1;
        Wed, 16 Nov 2022 22:39:46 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH v2] tests/nvme/039: Remove passthrough command tests
Date:   Wed, 16 Nov 2022 14:39:45 -0800
Message-Id: <20221116223945.1043785-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160154
X-Proofpoint-GUID: KAhcvVkQ0BggpM-dSGZ1uDlRGDzB05B6
X-Proofpoint-ORIG-GUID: KAhcvVkQ0BggpM-dSGZ1uDlRGDzB05B6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
disabled error logging for passthrough commands so the associated
tests should be removed.

When an error logging opt-in mechanism for passthrough commands is
provided, the tests can be added back.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/039     | 3 ---
 tests/nvme/039.out | 2 --
 2 files changed, 5 deletions(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index e175055ddb06..11d6d24b6025 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -143,9 +143,6 @@ test_device() {
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
 
-	inject_access_denied_on_identify "${ctrl_dev}"
-	inject_invalid_admin_cmd "${ctrl_dev}"
-
 	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
 
 	echo "Test complete"
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
index 162935eb1d7b..139070d22240 100644
--- a/tests/nvme/039.out
+++ b/tests/nvme/039.out
@@ -2,6 +2,4 @@ Running nvme/039
  Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
  Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
  Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
- Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
- Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
 Test complete
-- 
2.31.1

