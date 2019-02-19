Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B8C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32CA2147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TWY90dhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBSX3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:29:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47715 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfBSX3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550618942; x=1582154942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ORKYHTG15w1z30wTTdCblPsfjNAfqAuv1I1jj9/edBU=;
  b=TWY90dhm++iuTV/ra7c/2iFvNJ+nJReNhCl8UvzgAgnjGkHgKbLem56j
   LaKubqcaaLB9I3S7TFt2epMy9fcuxZaTJSiyrQZZybrHgBshJE/l47bvG
   Ekj7LH8qLTPWPbJkfPt/2nWb37lmfNU9ri5zqGiSO0axrx3ymZsrf94vL
   bTrZkmR5saZ0heaJJYtn/BeRhWsCgo1iVaZV2JAaJHJzzPpfAHTn0Mjtr
   72z1k8wMm5EI3VX1lbmhznzFlVlz+/JH8Zljhpi+Q0PMA+dfYBjzkEypr
   2mgE4lmpM2X6AQbG+I2ke55ehLeqW4wYGMEfitpk5MsPsCYDUn43ZVETd
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="101666813"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:29:02 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:26 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:29:03 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/8] nvme/026: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:23 -0800
Message-Id: <1550618905-4112-7-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/026     | 16 ++++++----------
 tests/nvme/026.out |  1 -
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/026 b/tests/nvme/026
index f915579..cdb196d 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -38,11 +38,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme ns-descs "/dev/${nvmedev}" -n 1 > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme ns-descs "/dev/${nvmedev}" -n 1 > /dev/null 2>&1; then
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
diff --git a/tests/nvme/026.out b/tests/nvme/026.out
index dcee481..c934cac 100644
--- a/tests/nvme/026.out
+++ b/tests/nvme/026.out
@@ -1,5 +1,4 @@
 Running nvme/026
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

