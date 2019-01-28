Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1025DC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED820880
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yz0wapKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfA1NPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31555 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681312; x=1580217312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0oktnb5c+ZxGU/792H6YJ1FgxEgeE8jHcYYjYH+9ZnY=;
  b=Yz0wapKjrbax2KKCuS8iPVIeNZrRozhXKSnDcWEF0hNW5W1WSBi2Vy7P
   MCcqwWzZpHjPkmpAGeQjAZaqguyZ7qQSfBcCEwO04p4YqHupcdYS+fOxO
   mRYUtOE4N0XrGrnat3zjxvgHVK5u7aXzb4t3gh1KL+oYMgIG0Sx1dRVBZ
   wzjHIeU2NFbzzVDrOssODwc2UlGv4nLW1nfY8BNLMK0Al5x5J4cOylkZ6
   RivR2YP+Cofs/+hHcRgDE/1CtBRHDMdvWR5fsPRVqJUArEGzXMRi1JnCv
   XBs3ZnkGeoesghQIa57G9PJsQNPgMmrt0TMM5OiCjmDKsQBQ0Z6spDMSo
   A==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="104898840"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:12 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jan 2019 04:54:15 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:09 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v4 03/12] block/004: Adjust fio conditions for zoned block devices
Date:   Mon, 28 Jan 2019 22:14:46 +0900
Message-Id: <20190128131455.31997-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
References: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
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
 tests/block/004 | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/block/004 b/tests/block/004
index 4c14c4b..d181725 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -8,18 +8,32 @@
 
 DESCRIPTION="run lots of flushes"
 TIMED=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_fio
 }
 
+device_requires() {
+	! _test_dev_is_zoned || _have_fio_zbd_zonemode
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
+	local directio=""
+	local zbdmode=""
+
+	if _test_dev_is_zoned; then
+		_test_dev_queue_set scheduler deadline
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

