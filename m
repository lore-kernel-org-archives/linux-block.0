Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F637C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1243F20645
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dB5wRpuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfBSX25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4297 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfBSX25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550618937; x=1582154937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1+QoXnegF54dAEsXRGbMvDFgTs5Z3KXA+rf0XmLa+UY=;
  b=dB5wRpuRa8kW17D8ESEmN/SNt80sGU45GGm5QsnnSD1E+MXe9Y2KbEoA
   8DAOq/D7uwVHzosP7T+qCwBc7R+3B2mW7nFMa1BuueIcN0NsEZwPjfgoi
   Zks6wHHzLVe2+b0enhkfaGOylQSf+r/oLriExrIvC/AsSO7YSljG3z8Al
   Nbm5ci0zkUv727onBjPOBEl5Df2nmDP+cULLWeOtJrEaij/jOnfp3GX75
   bn5aXNGmX6da9imQaAO41dskjsmKL2N+xr/NJkX7YYTOox96V5IhENAsK
   bZlkx8xepp97ujw2y4MgXp2JwTSGcoA5taHO+a/ZuKyNY1/m1ye5QFHGd
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="106651249"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:28:57 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:20 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:28:57 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/8] nvme/025: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:22 -0800
Message-Id: <1550618905-4112-6-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/025     | 16 ++++++----------
 tests/nvme/025.out |  1 -
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/025 b/tests/nvme/025
index 741d374..c2092d3 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -38,11 +38,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme effects-log "/dev/${nvmedev}" > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme effects-log "/dev/${nvmedev}" > /dev/null 2>&1; then
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
diff --git a/tests/nvme/025.out b/tests/nvme/025.out
index b700bc7..f15ff2f 100644
--- a/tests/nvme/025.out
+++ b/tests/nvme/025.out
@@ -1,5 +1,4 @@
 Running nvme/025
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

