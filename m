Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751729AbdF2Lk6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 07:40:58 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] tests: use nproc to get number of CPUs for fio jobs
Date: Thu, 29 Jun 2017 13:40:50 +0200
Message-Id: <20170629114050.11733-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/block/004 | 2 +-
 tests/block/005 | 2 +-
 tests/block/006 | 2 +-
 tests/block/008 | 2 +-
 tests/block/011 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/block/004 b/tests/block/004
index 754d30260d63..2dc0f25b27cc 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -29,7 +29,7 @@ test_device() {
 
 	FIO_PERF_FIELDS=("write iops")
 	_fio_perf --bs=4k --rw=randwrite --norandommap --fsync=1 \
-		--number_ios=256 --numjobs=64 --name=flushes \
+		--number_ios=256 --numjobs=$(nproc) --name=flushes \
 		--filename="$TEST_DEV"
 
 	echo "Test complete"
diff --git a/tests/block/005 b/tests/block/005
index 8f8b7065404e..4d4d536324ab 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -38,7 +38,7 @@ test_device() {
 	# start fio job
 	_run_fio --bs=4k --rw=randread --norandommap \
 		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 &
+		--numjobs=$(nproc) --direct=1 &
 
 	# while job is running, switch between schedulers
 	while kill -0 $! 2>/dev/null; do
diff --git a/tests/block/006 b/tests/block/006
index 18e31cbf3809..2b8450104e46 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -43,7 +43,7 @@ test() {
 		--filename=/dev/nullb0 --size=5g --direct=1
 
 	# run async test
-	_fio_perf --bs=4k --ioengine=libaio --iodepth=8 --numjobs=4 \
+	_fio_perf --bs=4k --ioengine=libaio --iodepth=8 --numjobs=$(nproc) \
 		--rw=randread --norandommap --name=async \
 		--filename=/dev/nullb0 --size=5g --direct=1
 
diff --git a/tests/block/008 b/tests/block/008
index 033fa0d5e7a5..db8fecc54676 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -38,7 +38,7 @@ test_device() {
 	# start fio job
 	_run_fio --bs=4k --rw=randread --norandommap \
 		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 &
+		--numjobs=$(nproc) --direct=1 &
 
 	# while job is running, hotplug CPUs randomly
 	while kill -0 $! 2>/dev/null; do
diff --git a/tests/block/011 b/tests/block/011
index 65ed3dfa7092..53ed7e037d21 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -42,7 +42,7 @@ test_device() {
 	# start fio job
 	_run_fio --bs=4k --rw=randread --norandommap \
 		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 --ignore_error=EIO,ENXIO,ENODEV &
+		--numjobs=$(nproc) --direct=1 --ignore_error=EIO,ENXIO,ENODEV &
 
 	while kill -0 $! 2>/dev/null; do
 		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
-- 
2.12.3
