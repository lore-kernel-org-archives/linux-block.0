Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24064C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF82147A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GqEF/EFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfBUEnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:43:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38404 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBUEnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724267; x=1582260267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ku+jq0dVyjIM5dKH2/mW0ifuisJYDNlGOya+gmn3ATU=;
  b=GqEF/EFO7FsBWYLxxnZSQzgqTGx3n4ZC0E3q0XP6R5iQKN/0WdHFk42S
   s2DEoxxzaT6bQRkGWxcrwAjkVsc06EIPoaHomRcuvZRrQ1yWRxsrojvtC
   eYHUnIz+84Nd6mW5Ig0v4k15wk4WdayvOIEDjOBOjPc238sUKfs1tj4xk
   UfYjn95S2W0Nuw6OKQN7TS4ezq3GvLTGmo7FYgkUf9e0fhr3M9pq30w4r
   7MdnVu3hcb+BTBZik88q0/uY5RtZwdWAnTKU03J+MybusT54PzAvirBV7
   0WfG+yj4xEO983AYKaq3TvbCy4s6uBM7v5ypCVjQcH+TexEzSPRMrbqUX
   g==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133683"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:44:23 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:36 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:43:14 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 6/8] nvme/026: use consistent coding style
Date:   Wed, 20 Feb 2019 20:42:46 -0800
Message-Id: <20190221044248.11096-7-chaitanya.kulkarni@wdc.com>
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
 tests/nvme/026     | 14 +++++---------
 tests/nvme/026.out |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/026 b/tests/nvme/026
index f915579..ae37aa7 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -38,11 +38,11 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme ns-descs "/dev/${nvmedev}" -n 1 > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme ns-descs "/dev/${nvmedev}" -n 1 > /dev/null 2>&1; then
+		echo "ERROR: ns-desc failed"
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
2.19.1

