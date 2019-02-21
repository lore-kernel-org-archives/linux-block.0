Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3841C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990782147A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K63/WnJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfBUEnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:43:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38362 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBUEnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724260; x=1582260260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2NTcZx2CK6XUkjb2q/frGckCeFZc0zwvjfH8FqMKAUc=;
  b=K63/WnJZMNCOg1f8xrDznEXj2aNru/UZSOGbHb5BwZuyS5tInJe94T2v
   ceKoj6SR1iJpaeotFNiqNtRqDKrQeVBUMjNMCwAg6A1fI1HBJTQuUNN4x
   OSBPkgMDw5y37dIe65L7xJhtG2d88vw1DrJSroLIRJNAsccXXY404DNoa
   T5ScX+3LS0wfWJtyUcOxjQ1+kn+cxUCsSH/hEdEdhzqN1r2OV9Dy6uQ+l
   6KjX662rTauBbmXeWKu8U3VGDagmvfz6IFGYaLfHTHFZ5QOwitOOzqRQ1
   Muu6NDANElrrjjehCENhWskeF3GTk96+BSnsfTLgPmhJnk5NlKD4D3nel
   g==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133653"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:44:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:34 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:43:12 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 5/8] nvme/025: use consistent coding style
Date:   Wed, 20 Feb 2019 20:42:45 -0800
Message-Id: <20190221044248.11096-6-chaitanya.kulkarni@wdc.com>
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
 tests/nvme/025     | 14 +++++---------
 tests/nvme/025.out |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/025 b/tests/nvme/025
index 741d374..68b8ed7 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -38,11 +38,11 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme effects-log "/dev/${nvmedev}" > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme effects-log "/dev/${nvmedev}" > /dev/null 2>&1; then
+		echo "ERROR: effects-log failed"
+	fi
 
-	nvme disconnect -n "${subsys_name}"
+	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
@@ -53,9 +53,5 @@ test() {
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
+	echo "Test complete"
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
2.19.1

