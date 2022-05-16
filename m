Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF8C433FE
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 22:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348904AbiEPW4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiEPW4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 18:56:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05152B1D7
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 15:56:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKZMdJ009873;
        Mon, 16 May 2022 22:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=vk+vYcFgYaMuHaN1Ay8ZIYUInEjwExAWGZLWGGeAfzE=;
 b=fjQIeAdxNONb9SvV9sYa4iTsxihrSjo7Y0/TsXtnwNsmjwUqn9Xmj+NsuFH1y7dxF/Bg
 PjxWLXCxsYMR9FYX/UAWL4k+LpP2D90Gi4r6LFMrgDsZZKDK7WA30JecB49PhmvBvxHP
 t21w8lGNVuScThELFLWzGTMqBvnjRQ+hc1T4TpELhubxRJDzjQT4Q3H7B0zf3TVp97kY
 G5tneI2ynWNFfXJKcizVOeaTfoRoUll60Il0v8UhQrau0/44FxF+DvdLU9/uqP0IYD1e
 n1Oqf/Hx0zNhdJ1XTq8F+vtHuepz52DGCgxzdXxuHkv2710CsMk+N08c8jfht2EBunZO +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310mqhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GMtt1E013363;
        Mon, 16 May 2022 22:55:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xv3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24GMtul5013443;
        Mon, 16 May 2022 22:55:57 GMT
Received: from dhcp-10-65-131-124.vpn.oracle.com (dhcp-10-65-131-124.vpn.oracle.com [10.65.131.124])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xuyu-2;
        Mon, 16 May 2022 22:55:57 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH v4 blktests 1/2] tests/nvme: add helper routine to use error injector
Date:   Mon, 16 May 2022 15:55:38 -0700
Message-Id: <20220516225539.81588-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220516225539.81588-1-alan.adamson@oracle.com>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NL8rodNwD--bg7ztOqwn6oNIzOnhOD-I
X-Proofpoint-GUID: NL8rodNwD--bg7ztOqwn6oNIzOnhOD-I
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme tests can use these helper routines to setup and use
the nvme error injector.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3c38408a0bfe..6412d5aca818 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -375,3 +375,47 @@ _discovery_genctr() {
 	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
+
+declare -A NS_DEV_FAULT_INJECT_SAVE
+declare -A CTRL_DEV_FAULT_INJECT_SAVE
+
+_nvme_err_inject_setup()
+{
+        local a
+
+        for a in /sys/kernel/debug/"$1"/fault_inject/*; do
+                NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+        done
+
+        for a in /sys/kernel/debug/"$2"/fault_inject/*; do
+                CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+        done
+}
+
+_nvme_err_inject_cleanup()
+{
+        local a
+
+        for a in /sys/kernel/debug/"$1"/fault_inject/*; do
+                echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+        done
+
+        for a in /sys/kernel/debug/"$2"/fault_inject/*; do
+                echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+        done
+}
+
+_nvme_enable_err_inject()
+{
+        echo "$2" > /sys/kernel/debug/"$1"/fault_inject/verbose
+        echo "$3" > /sys/kernel/debug/"$1"/fault_inject/probability
+        echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
+        echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
+        echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
+}
+
+_nvme_disable_err_inject()
+{
+        echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
+        echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
+}
-- 
2.27.0

