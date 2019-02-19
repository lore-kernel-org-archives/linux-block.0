Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC583C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DED21479
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ONpFAtS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfBSXum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:50:42 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8491 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSXum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550620242; x=1582156242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MH+sTvHYTMCmskS4oty+uhPaY+GAlN6DhFcjpPhRpBY=;
  b=ONpFAtS8+T1aMGpN57QlQMQkxaXCJ3hBN8amSAi6MPfdsjV70PIPkDV3
   1kLakIxl4FUZSJW5l9fXRnc9GPpiksuY7HX0/NvuAyWVgOn1csGI91ZW/
   6xpsl+nHD0Qc8MtSHBHBghTczFmObrM5CnK0/2V4xjq7HR3A0mYTWfMde
   sMKNLnkd31zq9NzONJBMuvC8TJOSLbAvLZAnN6zoudjhXaECj4FoN23lT
   j04CDkTaFTvrnb9mZYCOCz5dgUd+xGXm6L71wTBvs5bp7xygO9/mKcAAY
   aGp9DHE4soJIS9rIePJkg+DVOmMumBJN8qXIom8EAKPSL9ALGcZHabsu4
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="206871419"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:28:38 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:02 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:28:39 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/8] nvme/021: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:18 -0800
Message-Id: <1550618905-4112-2-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/021     | 15 ++++++---------
 tests/nvme/021.out |  1 -
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/021 b/tests/nvme/021
index 8e9512a..f204a2f 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -38,11 +38,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme list > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme list | grep -q "${nvmedev}n1" > /dev/null 2>&1; then
+		echo "Test Failed"
+	else
+		echo "Test complete"
+	fi
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -53,9 +55,4 @@ test() {
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
 }
diff --git a/tests/nvme/021.out b/tests/nvme/021.out
index 5fb0601..b6b1a7c 100644
--- a/tests/nvme/021.out
+++ b/tests/nvme/021.out
@@ -1,5 +1,4 @@
 Running nvme/021
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

