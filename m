Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D6C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53E214AF
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WA2CVOk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfBUEnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:43:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38362 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBUEnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724257; x=1582260257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnY0nacdNyOZr+E2dOsdfu1j2zW8pn1G+0mPyKJTa/Q=;
  b=WA2CVOk00yA4EHlQpZ+/t94U+3OKfhV+wXe5TOfBWfCDX09KaE3cILo8
   cgRt38Wq0MZ4uxobfAOuR/+1WMhnegcnox4xdRduupwJQ7pw42MfjDoaT
   u3m8f8JkIKrAOYNoBdk9dWhXYr/GmYLGvKNJSDodRTMIPNfQVAWBXLOgE
   0hp3ORfe+nlWh0FAnILu9TlFHOxy9rMK3OsJCwM84jkzO1Ioq7jWdvRfJ
   VX03oi3TT24UqGekJ3BF7FI/fi26KgjFY8AMjzhdzVt49SHTjD3HnVzSm
   QfWL9EupzhvPNPWFIqjWD0zVazzJ9LaLdfBp+mogp7aUz2U+s0bM+w325
   w==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133651"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:44:15 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:31 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:43:09 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 4/8] nvme/024: use consistent coding style
Date:   Wed, 20 Feb 2019 20:42:44 -0800
Message-Id: <20190221044248.11096-5-chaitanya.kulkarni@wdc.com>
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
 tests/nvme/024     | 15 +++++----------
 tests/nvme/024.out |  1 -
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/024 b/tests/nvme/024
index 313f778..09191c7 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -38,11 +38,10 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme smart-log "/dev/${nvmedev}" -n 1 > /dev/null 2>&1
-
-	rc=$?
-
-	nvme disconnect -n "${subsys_name}"
+	if ! nvme smart-log "/dev/${nvmedev}" -n 1 > /dev/null 2>&1; then
+		echo "ERROR: smart-log file-ns failed"
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
diff --git a/tests/nvme/024.out b/tests/nvme/024.out
index 737d22f..0b1a350 100644
--- a/tests/nvme/024.out
+++ b/tests/nvme/024.out
@@ -1,5 +1,4 @@
 Running nvme/024
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
2.19.1

