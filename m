Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD3C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiGEU5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiGEU47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 16:56:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9321240
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 13:56:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265Jn628001452;
        Tue, 5 Jul 2022 20:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=iijkGBmaOhCvHOqvNj9HaRrH7raez5sN6TpD3EPHDVk=;
 b=N7BGy3xawmytxtzzDhLyygFxEKYpqeVg0MS8qfVB7sh3330z09Hhvls39wNKnmWC6dbE
 VEHJ7OEcK1mvid90EegXjKBpcwZ2vFWYnaQc+LUx2WIqv7k1m+PvACJoO41DoZSpcIg4
 IKjGXhPo219SsRdatwEKV3CA1UoMoWsowhOL+3YCZnI0DVsgTJXv4sXpNf819fg8lx1k
 mfnNcD/U59vqmaivEjKMeyBd+XU3vdSFZbYNYpWiLBC9xaj8aBj01yGrab6rKkNqEULb
 RpZhsq6BHG/MOP9NSpUFaxzIK1NCPl6quWtOxP/Ek/fpLuEgatCy8Bkib5H8mbVu+MSX JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyr6ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:56:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265KpFkU006618;
        Tue, 5 Jul 2022 20:56:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5hq3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:56:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 265KujJr018042;
        Tue, 5 Jul 2022 20:56:45 GMT
Received: from dhcp-10-159-234-206.vpn.oracle.com (dhcp-10-159-234-206.vpn.oracle.com [10.159.234.206])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5hq3e-1;
        Tue, 05 Jul 2022 20:56:45 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH] tests/nvme: Set clear_ids for passthru targets
Date:   Tue,  5 Jul 2022 13:56:31 -0700
Message-Id: <20220705205632.1720-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U4fo21Z7qDZSLbQ8NNhr63zNdIMFAXZZ
X-Proofpoint-GUID: U4fo21Z7qDZSLbQ8NNhr63zNdIMFAXZZ
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows to connect to passthru targets when the client and target
are on the same host.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4bebbc762cbb..5e50e69fb3f0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -303,6 +303,9 @@ _create_nvmet_passthru() {
 
 	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
 	echo 1 > "${passthru_path}/enable"
+	if [ -f "${passthru_path}/clear_ids" ]; then
+		echo 1 > "${passthru_path}/clear_ids"
+	fi
 }
 
 _remove_nvmet_passhtru() {
-- 
2.31.1

