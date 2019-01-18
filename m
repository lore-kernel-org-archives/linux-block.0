Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865FC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672432086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l83bDM7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfARJpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34681 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfARJpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804715; x=1579340715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IzZu3HYUWRKzTUWViQ/t9rs1bLmUlw8NNEuIXkqUbeM=;
  b=l83bDM7NVF/zLbe+4s8aL1wLGPsCUEoWO03NXgH2b96z2HUVLWzzGBsn
   zxsNWVO6I/MKbX4gzukBPbNvcHrYcewxmZJrIxm/VwfyKAZi/cFbtBStP
   X3Pa6Gph9oyMAHqqLinIGU9PWDDVOvIZx8sum+X5nIwgBBLSBdrCPzo6s
   s3wzIRwkZ+DYHFSmEFFGP4+NfMQSXPz0rcyK3KCx5mHK2SqohAXzjJFRy
   d+qxyXbbzKW/HlfTxsEg3bvyYr/IAZf35HBW4gz/z6lrUTR2jWcYHrFvV
   sAN0i9RbU1gbwiLZosqro3yyr+Md3YOyVkr6lOVnsmagkm37IoVq/DONw
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100920274"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:15 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:32 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:11 -0800
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
Subject: [PATCH blktests v3 04/13] block: Whitelist tests supporting zoned block devices
Date:   Fri, 18 Jan 2019 18:44:44 +0900
Message-Id: <20190118094453.13773-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define CAN_BE_ZONED=1 in block/005, block/006, block/010, block/011,
block/016, block/017, block/020, block/021 and block/023 as all these
tests should execute without any problem against null_blk with zoned
mode enabled or zoned block devices specified in TEST_DEVS.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/005 | 1 +
 tests/block/006 | 1 +
 tests/block/010 | 1 +
 tests/block/011 | 1 +
 tests/block/016 | 1 +
 tests/block/017 | 1 +
 tests/block/020 | 1 +
 tests/block/021 | 1 +
 tests/block/023 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/block/005 b/tests/block/005
index 65eba22..8ab6791 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -8,6 +8,7 @@
 
 DESCRIPTION="switch schedulers while doing IO"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_fio
diff --git a/tests/block/006 b/tests/block/006
index 630d478..0b8a3c0 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -12,6 +12,7 @@
 
 DESCRIPTION="run null-blk in blocking mode"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk && _have_module_param null_blk blocking && _have_fio
diff --git a/tests/block/010 b/tests/block/010
index 76b301f..b81208e 100644
--- a/tests/block/010
+++ b/tests/block/010
@@ -12,6 +12,7 @@
 
 DESCRIPTION="run I/O on null_blk with shared and non-shared tags"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk && _have_module_param null_blk shared_tags && _have_fio
diff --git a/tests/block/011 b/tests/block/011
index 8e10900..c3432a6 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -8,6 +8,7 @@
 
 DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_fio && _have_program setpci
diff --git a/tests/block/016 b/tests/block/016
index 10ec4ba..c70b7d0 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -11,6 +11,7 @@
 
 DESCRIPTION="send a signal to a process waiting on a frozen queue"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk
diff --git a/tests/block/017 b/tests/block/017
index cea29be..e4a9259 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -11,6 +11,7 @@
 
 DESCRIPTION="do I/O and check the inflight counter"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk
diff --git a/tests/block/020 b/tests/block/020
index a377ea2..39dde66 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -11,6 +11,7 @@
 
 DESCRIPTION="run null-blk on different schedulers with only one hardware tag"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk && _have_fio
diff --git a/tests/block/021 b/tests/block/021
index 0ca5a17..a1bbf45 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -11,6 +11,7 @@
 
 DESCRIPTION="read/write nr_requests on null-blk with different schedulers"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk
diff --git a/tests/block/023 b/tests/block/023
index b0739f7..0f20f4a 100755
--- a/tests/block/023
+++ b/tests/block/023
@@ -10,6 +10,7 @@
 
 DESCRIPTION="do I/O on all null_blk queue modes"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_null_blk
-- 
2.20.1

