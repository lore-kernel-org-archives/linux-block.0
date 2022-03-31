Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF6C433FE
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiCaVsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiCaVr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 17:47:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338F1D9140
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 14:46:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VITFXF029851;
        Thu, 31 Mar 2022 21:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=6R5lYuuup8VZtWBfEtQA2UbsBf1NFiXrWcDZS5J3ZWY=;
 b=nu7pS04JeWsb3fzg0+eoe1nba11aaWeOZlHk88a3zaFgYLMmKDL35lGIg7Jnz9Uhs2ot
 Z4IvERQxKJQ0EfK4UooMuQ3hfhWKzPpSdKvy8SgRTbA3fzrFWmZHr/ofxemMDa+I3OI7
 fZIO5mL6f+CFEL1XWMnEHHsjRveZ7wfo5s4VUxDEgwi4xQdAjPxqEDJ2k8CV28RBR3WR
 oqEWADuXJm+1I9kQEJxQ+FWEkGtfc1YYgikeICy9rrqEcEPgzEXGRGAwhFW3k64az4m1
 nGSOd7rBZ5b67PLkm8ecsdth10+782z7c+hf0o5T5s14D6x7Hq+d8qcDK329PoUfQEGB Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbdb90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:45:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VLfL5w013723;
        Thu, 31 Mar 2022 21:45:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95cuxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:45:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VLjvTk025801;
        Thu, 31 Mar 2022 21:45:58 GMT
Received: from dhcp-10-65-129-122.vpn.oracle.com (dhcp-10-65-129-122.vpn.oracle.com [10.65.129.122])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95cuwy-2;
        Thu, 31 Mar 2022 21:45:58 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH blktests] nvme tests should use nvme_trtype when setting up passthru target
Date:   Thu, 31 Mar 2022 14:45:26 -0700
Message-Id: <20220331214526.95529-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220331214526.95529-1-alan.adamson@oracle.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FNBtg7jMc_d7N23fEAGceCrUnmJ_byHw
X-Proofpoint-ORIG-GUID: FNBtg7jMc_d7N23fEAGceCrUnmJ_byHw
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No matter what was passed in with nvme_trtype, the target was being
set up with trtype as "loop".  This caused several passthru tests
to fail when testing tcp or rdma.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c27cdee1b5f..3c38408a0bfe 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -335,7 +335,7 @@ _nvmet_passthru_target_setup() {
 	local subsys_name=$1
 
 	_create_nvmet_passthru "${subsys_name}"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	echo "$port"
-- 
2.27.0

