Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EFC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3043620821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A90d5th4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfAIBgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAIBgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997772; x=1578533772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y2UIcQFZV2VSO5LWLyFpXLVsByLyTKQT6N4J5lGA0pk=;
  b=A90d5th4b8TkMHDbRZrEdU1YsrQ0VG2FhcAURTDngTUzLodgQlWxhHIe
   qyu+vGJ6JyGNZFk3aCN1MQtF4WwyQ8Z2chTu3WCIIfChSdDDmBmSzzp9q
   mmfftcXImpDVCnhkewYjjp8gD5rid8hEi2nzPbgxtaededwu9cxEgVDx3
   bVWslL25sn4sLohzXa1wOLx5Zi7/mDzwvm521pzSJSpEzbNp8gXSp5hsw
   CNhp4fxIGYbnnL2iswBhR2DnzEqscqam3ateqdqVv8D6RR4cVIMI9xgOT
   Kd3NmDG2ZeLNCO5FkQal//JtM9eip3494GKAEn1lLSMUJ24ICXTei674h
   w==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169159"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:11 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:12 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:09 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 04/14] block/004: Adjust fio conditions for zoned block device
Date:   Wed,  9 Jan 2019 10:35:32 +0900
Message-Id: <20190109013542.23686-5-damien.lemoal@wdc.com>
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

For a random write pattern to a zoned block device, fio requires --direct=1
and --zonemode=zbd options as well as deadline I/O scheduler to be
specified. Specify these options and set the I/O scheduler if the target
device is a zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/block/004 b/tests/block/004
index 4c14c4b..d9b8209 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -16,10 +16,20 @@ requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
+	local directio=""
+	local zbdmode=""
+
+	if _test_dev_is_zoned; then
+		directio="--direct=1"
+		zbdmode="--zonemode=zbd"
+		set_scheduler "$(basename "$(readlink -f "${TEST_DEV}")")" \
+			      deadline
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

