Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF7C10F02
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7321738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UTJeqG7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBSXun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:50:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8493 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfBSXun (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550620242; x=1582156242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iprgYqVvnBtgtvoOf+A59oNWqKkaJ5m2PGfv3PYB+Iw=;
  b=UTJeqG7OStb8O9c52/Wo66umypJ9cl7ktALwLmZLIz+SLUj6Dz0caWbm
   j3qUk0qjITDfThky7WpUieTWUdk61mGWVx+SYPGlhGePRw7QmuNQp/evm
   w6S5hMhLs/LKkBQa6U0O7xXNSheRjBPUfRX7vtb8p+5PnVQm9sckLIQZS
   FLUWGJ3KP20nkZ0Al1mUiIkP2vTiEmgQ9S/mMmi1IXdPzYaSl0e8+gVEu
   zqzAkk0HL7wNufHaAvB/VXJqCCi3+jYzUQOLtX5XJw8sYyTyqkZwtqdsU
   8BjkPiR/zJ4sCT/FHOLGgb5HJoFgqbwqHSWJTu/nz2DKlW+65N0DAu1Wu
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="206871429"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:28:46 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:07:10 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:28:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/8] nvme/023: use consistent coding style
Date:   Tue, 19 Feb 2019 15:28:20 -0800
Message-Id: <1550618905-4112-4-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

---
 tests/nvme/023     | 16 ++++++----------
 tests/nvme/023.out |  1 -
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/023 b/tests/nvme/023
index 3475104..c220c50 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -41,11 +41,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme smart-log "/dev/${nvmedev}" -n 1 > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme smart-log "/dev/${nvmedev}" -n 1 > /dev/null 2>&1; then
+		echo "Test Failed"
+	else
+		echo "Test complete"
+	fi
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -57,10 +59,4 @@ test() {
 
 	modprobe -r nvme-loop
 	modprobe -r nvmet
-
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
 }
diff --git a/tests/nvme/023.out b/tests/nvme/023.out
index aeb3ea7..47c99ca 100644
--- a/tests/nvme/023.out
+++ b/tests/nvme/023.out
@@ -1,5 +1,4 @@
 Running nvme/023
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
1.8.3.1

