Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502DC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F972147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eJOYpCnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfBSX3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:29:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47715 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfBSX3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550618950; x=1582154950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QO44zIbPm8yUv11en4aP0hHOSIqa7BOCkxU9ZjY5Koo=;
  b=eJOYpCnxo9wIJyeTMVbNVQrrR/QwMfVfcwQ1evOx+f0o3l4nWGYKL8EV
   LUVwAGHvXI/+0PS8wsr0vrmgHV6Ukyf71d/76uRUzhuWq3o8KtY54GL7L
   6DLNav10HRhSZFB9YwwZufBJNZVvvKcRIStMkt6/Q1jO60dpO16XGGiOz
   6C0JAFFO8kXlPaATDTZnux/FxmluDNfo8qDiqPzS6+K07Vb+u0yRIq5E1
   2uzWf0O0nHsqDuZk112wnXQIBPfetuz+AuJc4aLGVx/hZi1qKq9/rUcSW
   f4ydf0XO4Kmrm9iYFQvJHuIgElp9knqgF9t4Xf/zFp46rjjBa2I4+k8eN
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="101666825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:29:10 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:34 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:29:10 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 8/8] nvme/028: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:25 -0800
Message-Id: <1550618905-4112-9-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/028     | 17 ++++++-----------
 tests/nvme/028.out |  1 -
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/tests/nvme/028 b/tests/nvme/028
index 3478acc..ad8e89b 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -38,11 +38,12 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme list-subsys | grep -q loop
-
-	rc=$?
-
-	nvme disconnect -n "${subsys_name}"
+	if ! nvme list-subsys | grep -q loop; then
+		echo "Test Failed"
+	else
+		echo "Test complete"
+	fi
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -52,10 +53,4 @@ test() {
 
 	modprobe -r nvme-loop
 	modprobe -r nvmet
-
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
 }
diff --git a/tests/nvme/028.out b/tests/nvme/028.out
index c92b82d..536067f 100644
--- a/tests/nvme/028.out
+++ b/tests/nvme/028.out
@@ -1,5 +1,4 @@
 Running nvme/028
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

