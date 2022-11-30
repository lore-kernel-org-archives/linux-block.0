Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD99C4167B
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 02:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiK3CkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 21:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiK3CkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 21:40:15 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256D6CA1D
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669776014; x=1701312014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6SGc4jysYRbl1xxj0WSk7vL1T0Jy9PPz2WaDTHaW384=;
  b=l84n22Ra07ag6grTjvGAvleA+nDHhdfpbJ5oEc6WIBNXCD62GHbbSX+/
   dsxpp6e8K6XoW8EsWadjuzNkVRQ1Ybuw0JoEWnh/7HE7YHHlW8g8vrQv1
   rXFh2YgAireDOSJ0KvO9X8rzcitND5R7S6OOOwcqIxNyKd+IVRNAcXL6S
   NC+Q+FNjG0l+0YsxQF6X41b2Ios3MeNnCZbhty5sDXKnCo3L8EZQO1lq2
   WbpLg3LBoYOmfPZVCKCtgFbdpUz3nyNkzPj5qwgU6C2qSQGMZ0LGwDwC/
   5F0SPxTQRwAbXMeUoFSqL6IFq997Ikrnz+jKrYl7pUZl05v0FNpvUuc0U
   w==;
X-IronPort-AV: E=Sophos;i="5.96,204,1665417600"; 
   d="scan'208";a="321860756"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 10:40:13 +0800
IronPort-SDR: iiSdk6fMEaAczIyvyUR+Y+01OuE/feaP5CjT5XV3zIqKKIc0foISSr2ZW+RYVrRqTqGBy/T/hS
 g4YAxcTXFmmFRNhYAR6KXqSvFFiC+eYOnP11hoaUHo8VSv0A1JdnhWpxKZtJeqS6t3AijDHyxM
 190KRCYbLciQuqT8rjaHMKzvwrlghHs5pS6WFyIRHVh6b9s3mr96/34FXg33o3af4Iio/1YqG0
 SU3f43hHRZwHJLeEonL/Jv/3UHeBZEurzX/pfiQHKz71YUc4ex4Oy6u1HfmtHYhIrGZK26bHgP
 nH4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 17:58:53 -0800
IronPort-SDR: x4cJlgKoP+dcCW7cyWLshr9cO4lrDZTc4P99ar5CqgfpGTypYPw8RNy04C1ks67Ad9j10l++h+
 rELurnQp8+vcrwE3CAyg2/jT/yWWn+T/ABIcoeR/pgZElVJZvlpJicAXENkxQq2DXLRHsKCGXF
 JYvKm2P8v1yKf27RpKa4Th64ySxQdM2bReHPhiGEw6ckVLhKZgkmMecQrbvtPiFr50Ao8C2NQn
 3LXbM+qyozPdWpHKwpaOIP6MnLc+J/t6HznPj4VvLw58G5UfvJQvmX5RHUYm8dSRGEunhgQurJ
 j2k=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2022 18:40:11 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/017: extend IO inflight duration
Date:   Wed, 30 Nov 2022 11:40:12 +0900
Message-Id: <20221130024012.2313090-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case block/017 often fails on slow test systems. When it runs
on QEMU and kernel with LOCKDEP, it fails around 50% by chance with
error message as follows:

block/017 (do I/O and check the inflight counter)            [failed]
    runtime  1.715s  ...  1.726s
    --- tests/block/017.out     2022-11-15 15:30:51.285717678 +0900
    +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/block/017.out.bad   2022-11-25 16:23:50.778747167 +0900
    @@ -6,7 +6,7 @@
     sysfs inflight reads 1
     sysfs inflight writes 1
     sysfs stat 2
    -diskstats 2
    +diskstats 1
     sysfs inflight reads 0
     sysfs inflight writes 0
    ...

The test case issues one read and one write to a null_blk device, and
checks that inflight counters reports correct numbers of inflight IOs.
To keep IOs inflight during test, it prepares null_blk device with
completion_nsec parameter 0.5 second. However, when test system is slow,
inflight counter check takes long time and the read completes before the
check. Hence the failure.

To avoid the failure, extend the inflight duration of IOs. Prepare a
null_blk device without completion_nsec parameter and measure time to
check the inflight counters. Prepare null_blk device again specifying
completion_nsec parameter 0.5 seconds plus the measured time of inflight
counter check.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/017 | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tests/block/017 b/tests/block/017
index 8596888..59429b0 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -24,11 +24,38 @@ show_inflight() {
 	awk '$3 == "nullb1" { print "diskstats " $12 }' /proc/diskstats
 }
 
+# Measure how long it takes for inflight counter check using time command.
+# Convert X.YYYs time format into integer in milliseconds.
+counter_check_duration_in_millis()
+{
+	local show_seconds sub_second seconds
+
+	show_seconds=$( { time show_inflight > /dev/null; } 2>&1 )
+	show_seconds=${show_seconds/s/}
+	sub_second=${show_seconds##*.}
+	sub_second=$((10#${sub_second}))
+	seconds=${show_seconds%%.*}
+	echo $(( seconds * 1000 + sub_second ))
+}
+
 test() {
+	local io_in_millis
+
 	echo "Running ${TEST_NAME}"
 
-	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=500000000 \
-			power=1; then
+	# Prepare null_blk to measure time to check inflight counters. IOs
+	# should be inflight long enough to cover counter checks twice.
+	if ! _configure_null_blk nullb1 irqmode=2 power=1; then
+		return 1
+	fi
+
+	io_in_millis=$(( 500 + $(counter_check_duration_in_millis) * 2 ))
+
+	_exit_null_blk
+
+	# Prepare null_blk again with desired IO inflight duration
+	if ! _configure_null_blk nullb1 irqmode=2 \
+	     completion_nsec=$((io_in_millis * 1000 * 1000)) power=1; then
 		return 1
 	fi
 
-- 
2.37.1

