Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EFAC001DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCS0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCS0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 14:26:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62576DC
        for <linux-block@vger.kernel.org>; Mon,  3 Jul 2023 11:26:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82oI025221;
        Mon, 3 Jul 2023 18:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=S3goOZqeuYoc0I9eekS0pLYTxfPF9T/RelhGiV7wzY8=;
 b=mNiJusU2lahRoPDyVnjeOiv6DgU9MtMz3ZUvBNrmwn1qhuEuXnvZqRkw5fOivPslCfRo
 k0VUsvyUw9CdtMdic0E+UtoTpVA5lWzH7qRBFWd2xvGT9K23ofwbzRvTJDEM5/hZmANt
 TF9qecVrzhNiHnXEL4ZORFaiMz748dcnLnUEJp36f4docJ0tDUyObzqeuDHsPS/YaB9q
 fy2dxcAE2Mnzo3bLo6LNIowE5ls44ckPB8AH4FlDje82jlpzIC9OkspltB4Di+hxvlld
 /DbnCf5BD0KTHq4k6FH+gjTDGcSpPzz1GRFEQwVOO+lTjSynRIaGFfuhJ02eZivBg3gY lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ck8cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:25:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363HARxB009061;
        Mon, 3 Jul 2023 18:25:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak9ddgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:25:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363IPoQ7009914;
        Mon, 3 Jul 2023 18:25:50 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rjak9ddgd-1;
        Mon, 03 Jul 2023 18:25:50 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] nvme/43: use a valid hostkey
Date:   Mon,  3 Jul 2023 11:25:49 -0700
Message-Id: <20230703182549.971324-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030167
X-Proofpoint-GUID: RHqyIHjbvUVgadGBoUeLuKFB4qvb-R3V
X-Proofpoint-ORIG-GUID: RHqyIHjbvUVgadGBoUeLuKFB4qvb-R3V
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test does not generate a hostkey and uses a NULL when setting
up and connecting to a target. The test passes, but a valid hotkey
should be used. This patch generates a valid hostkey and uses it
when setting up the target.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/043 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index a030884aa4ed..d498fd7ae885 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -39,6 +39,11 @@ test() {
 		return 1
 	fi
 	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		return 1
+	fi
 
 	_setup_nvmet
 
-- 
2.31.1

