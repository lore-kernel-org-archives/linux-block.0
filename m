Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB6C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBE52147A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eGsbyJmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfBUEnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:43:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38404 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBUEnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724270; x=1582260270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=50FrjVtv4Yo0aiuQreK9umXTO0POZmS9w8hYB6GM6Eo=;
  b=eGsbyJmqW6LPiRmN5IhHt+lhmAMAEkWKAZ6Am3CNQF4GemQwRhoOARbP
   Hv7CZ9XRH5q6AgZnz2o5e7TAWSIC8nKoMXwZ0lrYkRGyi6IkHWwHUFkRW
   /GpqUXImFqInmQJhCU6QhGe4Vbb6w3szhXEyy1Mn+UVPcdo6L1o1BUBJs
   2LuTnKjY+O4HLQRLhghFcShx2Ph0h6LY7OtSou2r1YOGdLnrIcMv58IYh
   Xg+JRulq6Q/knzZSWSva60ikUL788UIGjZJv4bftkDkL8YWGzfkYQGKPs
   v3EE+0G8bO1bPsSjVdJWF4aoGA+n5iN56WgpnG73uYO+iTyexwj7H/FFN
   g==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133697"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:44:26 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:38 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:43:16 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 7/8] nvme/027: use consistent coding style
Date:   Wed, 20 Feb 2019 20:42:47 -0800
Message-Id: <20190221044248.11096-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
References: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/027     | 15 +++++----------
 tests/nvme/027.out |  1 -
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/027 b/tests/nvme/027
index 8d47f56..96107e2 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -38,11 +38,10 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme ns-rescan "/dev/${nvmedev}" > /dev/null 2>&1
-
-	rc=$?
-
-	nvme disconnect -n "${subsys_name}"
+	if ! nvme ns-rescan "/dev/${nvmedev}" > /dev/null 2>&1; then
+		echo "ERROR: ns-rescan failed"
+	fi
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -53,9 +52,5 @@ test() {
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
+	echo "Test complete"
 }
diff --git a/tests/nvme/027.out b/tests/nvme/027.out
index f114fcd..5c6ed26 100644
--- a/tests/nvme/027.out
+++ b/tests/nvme/027.out
@@ -1,5 +1,4 @@
 Running nvme/027
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
2.19.1

