Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECAC4360F
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BA2177E
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rmA3T4bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfBRSxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:53:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25291 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfBRSxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 13:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550516027; x=1582052027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WRCdYSJCtC6LqCn86WtJ7Qxn2bsJdGp9x9KIqDmwh5I=;
  b=rmA3T4bcohgjVQpe4gTAaSzg4oQoD9p6MS+auADoc6ZTDUrdrtJnckDm
   ipVUZUJCZY7A1MmE43O5kJN7i0R7GY2YaQa2CXAMfCVQXfUY08ZM/S7Y6
   Ingxl7dyVXG3RziWFugyITbn/MLl1tszt3keyXZ0bzA5EMTuMatCdIBYZ
   XCs2sOrn6xugFCqnnrYFkqqUDtwMJo9X8Ove0RxPDizKrTGiKZmMZ8KZb
   7uhQEq6yyL6Mb+mNEnpkkdfzHZHLnGme1qQN18uyAGPbt8LSJdKRX4Yma
   x0npUomdwF19ppYIBHBbVCVvZqXrr9KklSU1xzwqUKbhlwq/YFGiPMfoF
   A==;
X-IronPort-AV: E=Sophos;i="5.58,385,1544457600"; 
   d="scan'208";a="103321457"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2019 02:53:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Feb 2019 10:32:12 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2019 10:53:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH BLKTESTS 3/3] nvme/017: fix output format
Date:   Mon, 18 Feb 2019 10:53:42 -0800
Message-Id: <1550516022-16374-4-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/017     |  5 ++++-
 tests/nvme/017.out | 11 -----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/nvme/017 b/tests/nvme/017
index 0b86bec..db87759 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -37,7 +37,10 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | grep -q "${subsys_nqn}"
+	if [ $? -ne 0 ]; then
+		echo "nvme discover command failed"
+	fi
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 4b0877a..6ce9a80 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,13 +1,2 @@
 Running nvme/017
-
-Discovery Log Number of Records 1, Generation counter 1
-=====Discovery Log Entry 0======
-trtype:  loop
-adrfam:  pci
-subtype: nvme subsystem
-treq:    not specified
-portid:  X
-trsvcid: 
-subnqn:  blktests-subsystem-1
-traddr:  
 Test complete
-- 
1.8.3.1

