Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiC3BeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiC3BeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE11717AD
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603937; x=1680139937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9tmb9UXT4IOr7YYICgArWiPg5ZIuz5QuTvT/5WNXGM=;
  b=WTPme7B6oTaTx5zNVZYgmuZP422if2cryROQz/d1ebL7V8LMHjeYeLVH
   SHGdVI+Bi/fdJp1kySTeMB/Y7J7f2sSSuZ5bNsMIHA1lK8zidQk0JE8W3
   j7JJ0GVjeXG3XZGiavqUKTh6IzTknsKr1EtTIhm6h1a4E+k+vqfMtLz0h
   DKfmRQ+zm3OtZJO4nHKem+PzQmM0pzmMhSslq5aZUfP8UmWQqvLB45b45
   LrjCN72qAqhMM1jT0gbI/j9SNtvHbM3aKzLY6OenqTJn0myrnjSqrmlfe
   pfgAdML2SqYxJASvirg/O8nX+hG20u278Y2hfn1n5mln7COpD9ZaysXZV
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439143"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:17 +0800
IronPort-SDR: hgS8ASoHLj62Z8j/WmRnB5y+I5K9J46Qf/nIFf7BJZMGPoeNX6eVe4B0vfmkS8rg1A1sfGi/Q8
 KrTKIuc3YvIp5Fodn+U7YftOKqsJoyf6EXvS0C39U3sLArtBAeTjWztmT0UvlYAdTRU642lC6o
 BeyHXzyggcKPVaz8niqNE3azRovnkelWgB24sZCeIJXLpLrprtxYaQkTB1biHF5Si5RK9yI9DV
 /q4bJJB1+uukryoqA/xOUXa5mBKcuGyFHd6qBKKDPRUHgplWuNOgkAJgcvARU9PzbjBhFIXyLW
 xaqTm2698xDexsiBLbBRR4dK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:09 -0700
IronPort-SDR: sKt3vFkzn15HSLa6NiB6+fRgGCAfj+UfrS/cLTpboPO0O2CgjKeyxOwOEaAZjLPNlUrHLg4LAB
 YG+qXPWq5qIwbLo2hdcDawXREFpz4Oma1F4pvU+taR4JLnSjdqzrMIhUmEcSajURyE5tQz+7WX
 5pzOiwULJq29nVUHsX3KsJpLo2m2UbrlzMWLFU6ZRd5XT5ulYWP0IGI0QDKzF18E+7IaDr1gF4
 rhXsk7g3JbAAiD3XQpBnzR0kvKN92sPUoW8xADXmh9PtrSnEoJYDTopNNNZXujPCYYX4HVxXYE
 Ht8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:17 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/6] zbd/008: check no stale page cache after BLKRESETZONE ioctl
Date:   Wed, 30 Mar 2022 10:32:10 +0900
Message-Id: <20220330013215.463555-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Run two processes which repeat data read and BLKRESETZONE ioctl, and
check that the race does not leave stale page cache. This allows to
catch the bug fixed with the commit e5113505904e ("block: Discard page
cache of # zone reset target range").

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/008     | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/008.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/zbd/008
 create mode 100644 tests/zbd/008.out

diff --git a/tests/zbd/008 b/tests/zbd/008
new file mode 100755
index 0000000..c625bad
--- /dev/null
+++ b/tests/zbd/008
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Western Digital Corporation or its affiliates.
+#
+# Check stale page cache is not left after race between BLKZONERESET and data
+# read. Regression test for commit e5113505904e ("block: Discard page cache of
+# zone reset target range").
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="check no stale page cache after BLKZONERESET and data read race"
+TIMED=1
+
+requires() {
+	_have_scsi_debug && _have_module_param scsi_debug zbc &&
+		_have_program xfs_io
+}
+
+test() {
+	local dev dump
+	echo "Running ${TEST_NAME}"
+
+	rm -f "$FULL"
+
+	# Create virtual device with zones
+	if ! _init_scsi_debug dev_size_mb=32 \
+	     zbc=host-managed zone_nr_conv=0; then
+		return 1
+	fi
+	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+
+	# Run read workload
+	: "${TIMEOUT:=10}"
+	_run_fio --filename="$dev" --size="32M" --rw=randread \
+		 --norandommap --name=reads --time_based &
+
+	while kill -0 $! 2>/dev/null; do
+		# Fill the device with known pattern
+		xfs_io -c "pwrite -S 0xaa -b 2M 0 32M" -d "$dev" >> "$FULL"
+
+		# Data read should return zero data pattern after zone reset
+		blkzone reset "$dev"
+		dump=$(dd if="$dev" bs=4k 2>> "$FULL" | hexdump -e '"%x"')
+		if [[ $dump != "0*" ]]; then
+			echo "$dump"
+			break
+		fi
+	done
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/008.out b/tests/zbd/008.out
new file mode 100644
index 0000000..08575bd
--- /dev/null
+++ b/tests/zbd/008.out
@@ -0,0 +1,2 @@
+Running zbd/008
+Test complete
-- 
2.34.1

