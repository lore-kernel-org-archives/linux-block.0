Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34565 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751810AbdF3JHt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 05:07:49 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests v2] tests: use nproc to get number of CPUs for fio jobs
Date: Fri, 30 Jun 2017 11:07:35 +0200
Message-Id: <20170630090735.11709-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use nproc to get number of CPUs for fio jobs and introduce
_run_fio_rand_io helper for parallel IO which we don't really care about
the details and just want some IO.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/fio      | 7 +++++++
 tests/block/005 | 4 +---
 tests/block/006 | 2 +-
 tests/block/008 | 4 +---
 tests/block/011 | 5 ++---
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/common/fio b/common/fio
index 86ed4b2b7180..2b0759d19f5d 100644
--- a/common/fio
+++ b/common/fio
@@ -166,6 +166,13 @@ _run_fio() {
 	fio "${args[@]}" "$@"
 }
 
+# Wrapper around _run_fio used if you need some I/O but don't really care much
+# about the details
+_run_fio_rand_io() {
+	_run_fio --bs=4k --rw=randread --norandommap --numjobs=$(nproc) \
+		--name=reads --direct=1
+}
+
 _fio_perf_report() {
 	# If there is more than one group, we don't know what to report.
 	if [[ $(wc -l < "$TMPDIR/fio_perf") -gt 1 ]]; then
diff --git a/tests/block/005 b/tests/block/005
index 8f8b7065404e..e59a3e35221b 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -36,9 +36,7 @@ test_device() {
 	fi
 
 	# start fio job
-	_run_fio --bs=4k --rw=randread --norandommap \
-		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 &
+	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" &
 
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
index 033fa0d5e7a5..03abf57241bd 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -36,9 +36,7 @@ test_device() {
 	fi
 
 	# start fio job
-	_run_fio --bs=4k --rw=randread --norandommap \
-		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 &
+	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" &
 
 	# while job is running, hotplug CPUs randomly
 	while kill -0 $! 2>/dev/null; do
diff --git a/tests/block/011 b/tests/block/011
index 65ed3dfa7092..920c58bb8ee4 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -40,9 +40,8 @@ test_device() {
 	fi
 
 	# start fio job
-	_run_fio --bs=4k --rw=randread --norandommap \
-		--name=reads --filename="$TEST_DEV" --size="$size" \
-		--numjobs=8 --direct=1 --ignore_error=EIO,ENXIO,ENODEV &
+	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
+			--ignore_error=EIO,ENXIO,ENODEV &
 
 	while kill -0 $! 2>/dev/null; do
 		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
-- 
2.12.3
