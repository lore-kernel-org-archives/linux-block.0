Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44416 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbeJVTIU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Oct 2018 15:08:20 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: linux-block@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests] common/rc: allow the loop driver to be built into the kernel
Date: Mon, 22 Oct 2018 06:50:04 -0400
Message-Id: <20181022105004.29324-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A number of kernel modules used by blktests must be compiled as
modules, since the module needs to be loaded with specific options, or
part of the test is to exercise what what happens when the kernel
module is loaded.  This is not true for the loop driver, so add a new
bash function, _have_kernel_module which works like _have_module but
will not fail if the driver is compiled directly into the kernel.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc      | 10 +++++++++-
 tests/nvme/002 |  4 ++--
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  4 ++--
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  5 +++--
 tests/nvme/008 |  5 +++--
 tests/nvme/010 |  2 +-
 tests/nvme/012 |  2 +-
 tests/nvme/014 |  5 +++--
 tests/nvme/015 |  4 ++--
 tests/nvme/019 |  5 +++--
 tests/nvme/021 |  5 +++--
 tests/nvme/022 |  5 +++--
 tests/nvme/023 |  5 +++--
 tests/nvme/024 |  5 +++--
 tests/nvme/025 |  5 +++--
 tests/nvme/026 |  5 +++--
 tests/nvme/027 |  5 +++--
 tests/nvme/028 |  5 +++--
 20 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/common/rc b/common/rc
index 8a892bc..be6133e 100644
--- a/common/rc
+++ b/common/rc
@@ -35,6 +35,14 @@ _have_module() {
 	return 1
 }
 
+_have_kernel_module() {
+	if modprobe -n -q "$1" || test -d "/sys/module/$1" ; then
+		return 0
+	fi
+	SKIP_REASON="$1 is not available as a module or built into the kernel"
+	return 1
+}
+
 _have_module_param() {
 	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
 		SKIP_REASON="$1 module does not have parameter $2"
@@ -60,7 +68,7 @@ _have_src_program() {
 }
 
 _have_loop() {
-	_have_module loop && _have_program losetup
+	_have_kernel_module loop && _have_program losetup
 }
 
 _have_blktrace() {
diff --git a/tests/nvme/002 b/tests/nvme/002
index 2b01534..0624cb1 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -10,8 +10,8 @@
 DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index 693ad8d..2a2dae2 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -11,8 +11,8 @@ DESCRIPTION="test if we're sending keep-alives to a discovery controller"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop \
-		&& _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index 55b5c67..14137e1 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -12,8 +12,8 @@ DESCRIPTION="test nvme and nvmet UUID NS descriptors"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index fa7a75d..4f638dd 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -11,9 +11,9 @@ DESCRIPTION="reset local loopback target"
 QUICK=1
 
 requires() {
-	_have_module nvme-loop && _have_module nvmet && _have_module loop && \
-		_have_configfs && _have_module nvme-core && \
-		_have_module_param nvme-core multipath
+	_have_module nvme-loop && _have_module nvmet && \
+	    _have_kernel_module loop && _have_configfs && \
+	    _have_module nvme-core && _have_module_param nvme-core multipath
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index a2693a2..ff04e34 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -10,8 +10,9 @@ DESCRIPTION="create an NVMeOF target with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index e5aa50b..4d4c626 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -10,8 +10,9 @@ DESCRIPTION="create an NVMeOF host with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index a76b176..11387f0 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -10,7 +10,7 @@ DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_fio && _have_module loop && \
+	_have_program nvme && _have_fio && _have_kernel_module loop && \
 		_have_configfs && _have_module nvme-loop && \
 		_have_module nvmet
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index a19dc36..a4503c2 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -11,7 +11,7 @@ TIMED=1
 
 requires() {
 	_have_program nvme && _have_program mkfs.xfs && _have_program fio && \
-		_have_module loop && _have_module nvmet && \
+		_have_kernel_module loop && _have_module nvmet && \
 		_have_module nvme-loop && _have_configfs
 }
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 08fef81..c2b1ecc 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -10,8 +10,9 @@ DESCRIPTION="flush a NVMeOF block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index 6b65c14..d59375b 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -10,8 +10,8 @@ DESCRIPTION="unit test for NVMe flush for file backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_configfs
+    _have_program nvme && _have_module nvme-loop && \
+	_have_kernel_module loop && _have_configfs
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 1547648..332694e 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe DSM Discard command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index 2c11d55..556b56b 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe list command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 2e7db71..cac098c 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe reset command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index b51124f..3ec6603 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 964df34..f30fff6 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 27c8fde..0877ae0 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe effects-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index 341b3b5..bd696f7 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 1f2018c..c8b7c35 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe ns-rescan command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index e6fb9e3..bf14dcc 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -10,8 +10,9 @@ DESCRIPTION="test NVMe list-subsys command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_module nvme-loop && _have_module loop && \
-		_have_module nvmet && _have_configfs
+	_have_program nvme && _have_module nvme-loop && \
+		_have_kernel_module loop && _have_module nvmet && \
+		_have_configfs
 }
 
 test() {
-- 
2.18.0.rc0
