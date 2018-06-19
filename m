Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61047 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967197AbeFSUYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:24:16 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/9] Multiple tests: remove unused and undefined variables
Date: Tue, 19 Jun 2018 13:23:50 -0700
Message-Id: <20180619202353.23631-7-bart.vanassche@wdc.com>
In-Reply-To: <20180619202353.23631-1-bart.vanassche@wdc.com>
References: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/loop/003 | 3 ---
 tests/nvme/010 | 3 +--
 tests/nvme/011 | 3 +--
 tests/nvme/012 | 1 -
 tests/nvme/013 | 1 -
 5 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/loop/003 b/tests/loop/003
index 353d4fcfa33c..6f6fa8d18ebe 100755
--- a/tests/loop/003
+++ b/tests/loop/003
@@ -28,11 +28,8 @@ requires() {
 }
 
 test() {
-	local loop_dev
 	echo "Running ${TEST_NAME}"
 
-	loop_dev="$(losetup -f)"
-
 	# In a subshell so TIMEFORMAT doesn't get clobbered.
 	(
 	TIMEFORMAT="Test took %0R seconds"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 956c6597a374..b6849dbad375 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -38,7 +38,6 @@ test() {
 	modprobe nvme-loop
 
 	local port
-	local ret=0
 	local nvmedev
 	local loop_dev
 	local file_path="${TMPDIR}/img"
@@ -70,7 +69,7 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -f local*verify*state "${fio_out}"
+	rm -f local*verify*state
 
 	modprobe -r nvme_loop
 	modprobe -r nvmet
diff --git a/tests/nvme/011 b/tests/nvme/011
index 872a99af4f8c..f26eb155809c 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -37,7 +37,6 @@ test() {
 	modprobe nvme-loop
 
 	local port
-	local ret=0
 	local nvmedev
 	local file_path
 	local file_path="${TMPDIR}/img"
@@ -65,7 +64,7 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -f local-write-and-verify*state "${fio_out}"
+	rm -f local-write-and-verify*state
 
 	modprobe -r nvme_loop
 	modprobe -r nvmet
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8f632b30734d..e570793dd5db 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -38,7 +38,6 @@ test() {
 	modprobe nvme-loop
 
 	local port
-	local ret=0
 	local nvmedev
 	local loop_dev
 	local mount_dir="/mnt/blktests"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 0ccb083b175b..247fe9f252fa 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -38,7 +38,6 @@ test() {
 	modprobe nvme-loop
 
 	local port
-	local ret=0
 	local nvmedev
 	local mount_dir="/mnt/blktests/"
 	local file_path="${TMPDIR}/img"
-- 
2.17.1
