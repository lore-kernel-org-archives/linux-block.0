Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E24C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA777214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHDj17Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfAJJiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25557 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113084; x=1578649084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyXgBxFofyFjmYAYzW1/Ngl99UpQOlz5CAC4EPQ/P1g=;
  b=eHDj17Qh1qb2y2mskIDYUpu2/bRoe3lZeoCSHFJ3NTf2xs2ZpWM/+YF4
   Iy0q+KaVMZuXC7Dbk5S/yb85w/PkyufdcEGYzNSzEEjZq2FmGECTOFUaZ
   mOrAeTsQLe71jTspwfw6HWR4QXpgNNqCpKgbTbMeWoAdOaPQ+QPe3p4qv
   ZHezu5MIoCQIVkn9R6TqZ7gtZDih9tkBaU8nRXK7jVkjNy27AWjDLqVBQ
   zUk6CRRjXXe8b8UjSuXIOc4yZlSkFAtEQ3NH1naeYySbdTmRrK/AeO6oW
   ZaO9RkVx2YH/ZMoWtG08oB/DHqENyuYh4aF1laSF9+XJ0pw7FlNzrOZUu
   g==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468980"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:32 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:21 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:47 -0800
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
Subject: [PATCH blktests v2 05/16] block/004: Adjust fio conditions for zoned block device
Date:   Thu, 10 Jan 2019 18:37:14 +0900
Message-Id: <20190110093725.32675-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/block/004 b/tests/block/004
index 4c14c4b..88cc083 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -16,10 +16,26 @@ requires() {
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
+		set_scheduler "$(basename "$(readlink -f "${TEST_DEV}")")" \
+			      deadline || return $?
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

