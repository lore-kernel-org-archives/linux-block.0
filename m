Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E249C4360F
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654521738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MBgxbh42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfBSXun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:50:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8491 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550620242; x=1582156242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+6X97aczkrGshsRxSR1g3ojcMEm+vul9i8haM7p7vp4=;
  b=MBgxbh42Bgh2VAbMN9p4Hm6VxPUcb1gl0oOwhHDdCM6PFRGrwzyLjKzb
   2WeOvF2qQ2mxgUdmund+w/Nw+MZnn/gjYo6swhrpCul3npDGwfFLGMF0l
   yQojoVwe8a5LDvClQuLhxbfXXGa4nUt1gw1JjrC2e8tXMSb/m1qNkEcLs
   Svf2wda69SxkXfpvCT9abSzkgofiugGNwz6j/82LhVQNixH5WsJWLKbNl
   6wRlio6ky9w3gVBHqkpIOQaEC6WHp7EXs6ULXfdAQM2eD1YzU2hImyUFf
   DEioqk4WBUs0yRbRPmSTEnjQ+QvYkAEBe5r5c2XAnsD/KQ7V1f5cbbhqT
   g==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="206871423"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:28:42 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:06 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:28:43 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/8] nvme/022: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:19 -0800
Message-Id: <1550618905-4112-3-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/022     | 16 ++++++----------
 tests/nvme/022.out |  1 -
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/022 b/tests/nvme/022
index 8f89d03..3b5a101 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -38,11 +38,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme reset "/dev/${nvmedev}" > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme reset "/dev/${nvmedev}" > /dev/null 2>&1; then
+		echo "Test Failed"
+	else
+		echo "Test complete"
+	fi
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -52,10 +54,4 @@ test() {
 
 	modprobe -r nvme-loop
 	modprobe -r nvmet
-
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
 }
diff --git a/tests/nvme/022.out b/tests/nvme/022.out
index 173158a..1d393db 100644
--- a/tests/nvme/022.out
+++ b/tests/nvme/022.out
@@ -1,5 +1,4 @@
 Running nvme/022
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

