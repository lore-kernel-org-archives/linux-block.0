Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3692C43444
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAD8214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gjgiOQYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfAJJiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25557 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAJJiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113085; x=1578649085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OQcsi1yU0ByuSqzlqVyi/FGyGBLmv2+IEHJohsWTFI=;
  b=gjgiOQYhb572DxrAvNFFeswe8i1W8sdWnMtfNfuLS95Wu2A0U6sXG4/B
   FQAUgVRcAOgqGRuSAw81RG9ZRoptTQPoA3wTwcIKtSvJk5rkXnt5lomE9
   qhAszeq4UIr6oAQL2epohw67r7MkoQpqAXjC6UAjFknepf518pMR+kl9O
   BfXLuN4d31ORYs7/s20vEuhwOLBgWNHwznTefeLktMEqSPUAC2zZVVlfL
   BmkOe+/pTKQ+iBPBBYINOHAmrF01CiSjx4YGcCMkAUydze4F8WSQeIJE1
   s/ns7Kan1DZpeAhxatnRbNH2kUcC86fPl0Owww53cQbv4/r6weVlS12/x
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468981"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:38 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:25 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:51 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 06/16] block/013: Skip for zoned block devices
Date:   Thu, 10 Jan 2019 18:37:15 +0900
Message-Id: <20190110093725.32675-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/013 runs mkfs.ext3 but ext3 file system does not support zoned
block devices. Add device_requires() implementation to automatically
skip the test if the target device is a zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/013 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/block/013 b/tests/block/013
index 35fc181..35998c7 100755
--- a/tests/block/013
+++ b/tests/block/013
@@ -19,6 +19,15 @@ requires() {
 	_have_program mkfs.ext3
 }
 
+device_requires() {
+	if _test_dev_is_zoned; then
+		SKIP_REASON="${TEST_DEV} is a zoned block device "
+		SKIP_REASON+="(not supported by ext3)"
+		return 1
+	fi
+	return 0
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-- 
2.20.1

