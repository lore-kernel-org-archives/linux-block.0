Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDCEC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C842C2146F
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hvxvQHIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfAIBgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997775; x=1578533775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+xnckddNMm49webjnZi2TS72ew50ly01dfQYJFtOps=;
  b=hvxvQHIOBD9WRFe+MnXI9x2EclgXeqUnzNXw76PV9I2FF10V23lpD/EX
   wNiZXVZXiMWgeWmt5JZR8EXzL9nFl1FQEho4NuPH1WnkZFlE6Mh5mT+8z
   gPJx5h7NYY3s+BOsqTnLSN/ovDjlI1L+6HCTSjyxMNF1WF8P4kNZfOFQU
   m+lf8uhKJY9eEe/ug4gMOadIFKjfnfHlrrifU1cjqPfk7uhvGdq24cDOd
   uPIuhP2DMf4LMEvIKX01yOd7GFLqV7d3u338APTLy5i2KTuFoEKODP2uJ
   dyiQmIEmnTUvqmyu1HNmyivlB8IeSLVXOK3Aa5+GnQjsWBw0TYGPmwUGm
   g==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:15 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:16 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:13 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 05/14] block/013: Skip for zoned block devices
Date:   Wed,  9 Jan 2019 10:35:33 +0900
Message-Id: <20190109013542.23686-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

block/013 runs mkfs.ext3 but ext3 file system does not support zoned
block devices. Add device_requires() implementation to automatically
skip the test if the target device is a zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/013 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/block/013 b/tests/block/013
index 35fc181..fe68cc1 100755
--- a/tests/block/013
+++ b/tests/block/013
@@ -19,6 +19,14 @@ requires() {
 	_have_program mkfs.ext3
 }
 
+device_requires() {
+	if _test_dev_is_zoned; then
+		SKIP_REASON="${TEST_DEV} is a zoned block device (not supported by ext3)"
+		return 1
+	fi
+	return 0
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-- 
2.20.1

