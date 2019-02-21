Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8EDC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8FA2147A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E56bVCry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfBUEnD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:43:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38362 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBUEnD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724247; x=1582260247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoWFxH7/RaVaIjIa2jYOPopZ4mbNcHlMqa2P+Kmyasw=;
  b=E56bVCryuRAu6RGbbz/6F6m1crTtDYIt58ev/wAnL8wOxfzGJD6uVodY
   +l6OL7DwGoJoEJoxWu29JIaI6aJ+23eJfucmYaBw2yW9sfHu0bxvcaIO2
   Di6bBY7yEGl8vtTh9Ja51t9roG53i7K9NmAJysoLGkJm4CMUPiFWIr+7S
   Trd5IzEQLPLr8p2WtyLznUZFfMZ4BqtGKOKhrqMY1pNy72FA2OW34YZJh
   GkZGBJQ2MbLrdjW1s7o1K3ziDh4Fc2IS+YmBQvxnq7ufN4XdiqMuvhuie
   UiY8OoJNJoqa+rDbX7rcWSmUNazyx2DOQ0a+qGPeN28dQbFyBs0uQMa18
   w==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133605"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:44:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:25 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:43:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/8] nvme/022: use consistent coding style
Date:   Wed, 20 Feb 2019 20:42:42 -0800
Message-Id: <20190221044248.11096-3-chaitanya.kulkarni@wdc.com>
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
 tests/nvme/022     | 14 +++++---------
 tests/nvme/022.out |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/022 b/tests/nvme/022
index 8f89d03..35ab3e8 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -38,11 +38,11 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme reset "/dev/${nvmedev}" > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme reset "/dev/${nvmedev}" > /dev/null 2>&1; then
+		echo "ERROR: reset failed"
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
2.19.1

