Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA1C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA88F2086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ake8uZMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfARJpM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34681 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfARJpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804713; x=1579340713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6YTkS4nlP5Xyy3NO2sMAr7LrBiJv+t0RuuBnTmmOSPY=;
  b=Ake8uZMv3hbRfMfv4Nh9WlumNHt4HXKFy6hn1ZLnDVE37Cf9erlEYeCO
   PjxRKD3SALyzv6akKbU5+CTZwNTVacG3i+m7/ZEeSGxPWUYuwNiZlcqri
   cLGv5H5As/eO+itC56iZAf5j6y1W1FGYjytQSXtE1GFSb7rhkuizMyMLO
   EoQsbKysverMybT9x7BlDp0KhZRR2eafWtmwWzuugt626h57EdRFRGXul
   VptGSLCAD+QRZ3CokIZn1xUqWMTJhzFmKzE9g9S04rDsbyf+TP1hhzE1u
   ecSPd/OXAUudrV+8ojj6yYWeAdslV+CDUnB+bHS0WxrK+/iALjphzUmqp
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100920267"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:28 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:06 -0800
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
Subject: [PATCH blktests v3 03/13] block/004: Adjust fio conditions for zoned block devices
Date:   Fri, 18 Jan 2019 18:44:43 +0900
Message-Id: <20190118094453.13773-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a random write pattern to a zoned block device, fio requires --direct=1
and --zonemode=zbd options as well as deadline I/O scheduler to be
specified. Specify these options and set the I/O scheduler if the target
device is a zoned block device. Before doing that, also make sure that the
deadline scheduler is available and that fio supports the zbd zone mode.
Set CAN_BE_ZONED flag to run this test case for zoned block devices.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/block/004 b/tests/block/004
index 4c14c4b..7340d33 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -8,6 +8,7 @@
 
 DESCRIPTION="run lots of flushes"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_fio
@@ -16,10 +17,25 @@ requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
+	local directio=""
+	local zbdmode=""
+
+	if _test_dev_is_zoned; then
+		if ! _have_fio_zbd_zonemode; then
+			echo "${SKIP_REASON}"
+			return 1
+		fi
+
+		_test_dev_queue_set scheduler deadline
+
+		directio="--direct=1"
+		zbdmode="--zonemode=zbd"
+	fi
+
 	FIO_PERF_FIELDS=("write iops")
 	_fio_perf --bs=4k --rw=randwrite --norandommap --fsync=1 \
 		--number_ios=256 --numjobs=64 --name=flushes \
-		--filename="$TEST_DEV"
+		${directio} ${zbdmode} --filename="$TEST_DEV"
 
 	echo "Test complete"
 }
-- 
2.20.1

