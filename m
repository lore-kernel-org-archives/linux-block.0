Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669BC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BE820738
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgDVHo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:44:58 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50430 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgDVHo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:44:58 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 2D14FBF5D9;
        Wed, 22 Apr 2020 07:44:55 +0000 (UTC)
From:   Klaus Jensen <its@irrelevant.dk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH blktests v3] Fix unintentional skipping of tests
Date:   Wed, 22 Apr 2020 09:44:36 +0200
Message-Id: <20200422074436.376476-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
good handful of tests.

For example, block/005 uses _test_dev_is_rotational to check if the
device is rotational and uses the result to size up the fio run. As a
side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
commit cd11d001fe86) causes the test to print out a "[not run]" even
through the test actually ran successfully.

Fix this by renaming the existing helpers to _require_foo (e.g. a
_require_test_dev_is_rotational) and add the non-_require variant where
needed.

Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---

Changes since v2
~~~~~~~~~~~~~~~~
* Fix missing _test_dev -> _require_test_dev in block/003 (Shinichiro)
* Revert change in block/004 (Shinichiro)

 check           | 10 ++++------
 common/iopoll   |  4 ++--
 common/rc       | 35 ++++++++++++++++++++++++++++-------
 new             | 12 ++++++------
 tests/block/003 |  2 +-
 tests/block/007 |  3 ++-
 tests/block/011 |  2 +-
 tests/block/019 |  2 +-
 tests/nvme/032  |  2 +-
 tests/nvme/rc   |  4 ++--
 tests/scsi/006  |  2 +-
 tests/scsi/rc   |  6 +++---
 tests/zbd/007   |  2 +-
 tests/zbd/rc    | 11 +++++++++--
 14 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/check b/check
index 398eca05e3a4..84ec086c408b 100755
--- a/check
+++ b/check
@@ -423,18 +423,16 @@ _call_test() {
 _test_dev_is_zoned() {
 	if [[ ! -f "${TEST_DEV_SYSFS}/queue/zoned" ]] ||
 	      grep -q none "${TEST_DEV_SYSFS}/queue/zoned"; then
-		SKIP_REASON="${TEST_DEV} is not a zoned block device"
 		return 1
 	fi
 	return 0
 }
 
-_test_dev_is_not_zoned() {
-	if _test_dev_is_zoned; then
-		SKIP_REASON="${TEST_DEV} is a zoned block device"
+_require_test_dev_is_zoned() {
+	if ! _test_dev_is_zoned; then
+		SKIP_REASON="${TEST_DEV} is not a zoned block device"
 		return 1
 	fi
-	unset SKIP_REASON
 	return 0
 }
 
@@ -497,7 +495,7 @@ _run_test() {
 			local unset_skip_reason=0
 			if [[ ! -v SKIP_REASON ]]; then
 				unset_skip_reason=1
-				if (( !CAN_BE_ZONED )) && ! _test_dev_is_not_zoned; then
+				if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
 					SKIP_REASON="${TEST_DEV} is a zoned block device"
 				elif declare -fF device_requires >/dev/null; then
 					device_requires
diff --git a/common/iopoll b/common/iopoll
index 80a5f99b08ca..dfdd2cf6f08f 100644
--- a/common/iopoll
+++ b/common/iopoll
@@ -17,7 +17,7 @@ _have_fio_with_poll() {
 	return 0
 }
 
-_test_dev_supports_io_poll() {
+_require_test_dev_supports_io_poll() {
 	local old_io_poll
 	if ! old_io_poll="$(cat "${TEST_DEV_SYSFS}/queue/io_poll" 2>/dev/null)"; then
 		SKIP_REASON="kernel does not support polling"
@@ -30,7 +30,7 @@ _test_dev_supports_io_poll() {
 	return 0
 }
 
-_test_dev_supports_io_poll_delay() {
+_require_test_dev_supports_io_poll_delay() {
 	local old_io_poll_delay
 	if ! old_io_poll_delay="$(cat "${TEST_DEV_SYSFS}/queue/io_poll_delay" 2>/dev/null)"; then
 		SKIP_REASON="kernel does not support hybrid polling"
diff --git a/common/rc b/common/rc
index 1893dda2b2f7..dfa7ac0e4ffc 100644
--- a/common/rc
+++ b/common/rc
@@ -181,22 +181,36 @@ _have_tracepoint() {
 	return 0
 }
 
-_test_dev_can_discard() {
-	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
-		SKIP_REASON="$TEST_DEV does not support discard"
+_test_dev_is_rotational() {
+	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
 		return 1
 	fi
 	return 0
 }
 
-_test_dev_is_rotational() {
-	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
+_require_test_dev_is_rotational() {
+	if ! _test_dev_is_rotational; then
 		SKIP_REASON="$TEST_DEV is not rotational"
 		return 1
 	fi
 	return 0
 }
 
+_test_dev_can_discard() {
+	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
+		return 1
+	fi
+	return 0
+}
+
+_require_test_dev_can_discard() {
+	if ! _test_dev_can_discard; then
+		SKIP_REASON="$TEST_DEV does not support discard"
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_queue_get() {
 	if [[ $1 = scheduler ]]; then
 		sed -e 's/.*\[//' -e 's/\].*//' "${TEST_DEV_SYSFS}/queue/scheduler"
@@ -214,7 +228,7 @@ _test_dev_queue_set() {
 	echo "$2" >"${TEST_DEV_SYSFS}/queue/$1"
 }
 
-_test_dev_is_pci() {
+_require_test_dev_is_pci() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q pci; then
 		# nvme needs some special casing
 		if readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
@@ -247,7 +261,7 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
-_test_dev_in_hotplug_slot() {
+_require_test_dev_in_hotplug_slot() {
 	local parent
 	parent="$(_get_pci_parent_from_blkdev)"
 
@@ -262,6 +276,13 @@ _test_dev_in_hotplug_slot() {
 
 _test_dev_is_partition() {
 	if [[ -z ${TEST_DEV_PART_SYSFS} ]]; then
+		return 1
+	fi
+	return 0
+}
+
+_require_test_dev_is_partition() {
+	if ! _test_dev_is_partition; then
 		SKIP_REASON="${TEST_DEV} is not a partition device"
 		return 1
 	fi
diff --git a/new b/new
index 31973ed1add2..73f0faa8fa96 100755
--- a/new
+++ b/new
@@ -85,10 +85,10 @@ group_requires() {
 #
 # Usually, group_device_requires() just needs to check that the test device is
 # the right type of hardware or supports any necessary features using the
-# _test_dev_foo helpers. If group_device_requires() sets \$SKIP_REASON, all
-# tests in this group will be skipped on that device.
+# _require_test_dev_foo helpers. If group_device_requires() sets \$SKIP_REASON,
+# all tests in this group will be skipped on that device.
 # group_device_requires() {
-# 	_test_dev_is_foo && _test_dev_supports_bar
+# 	_require_test_dev_is_foo && _require_test_dev_supports_bar
 # }
 
 # TODO: define any helpers that are specific to this group.
@@ -171,10 +171,10 @@ DESCRIPTION=""
 #
 # Usually, device_requires() just needs to check that the test device is the
 # right type of hardware or supports any necessary features using the
-# _test_dev_foo helpers. If device_requires() sets \$SKIP_REASON, the test will
-# be skipped on that device.
+# _require_test_dev_foo helpers. If device_requires() sets \$SKIP_REASON, the
+# test will be skipped on that device.
 # device_requires() {
-# 	_test_dev_is_foo && _test_dev_supports_bar
+# 	_require_test_dev_is_foo && _require_test_dev_supports_bar
 # }
 
 # TODO: define the test. The output of this function (stdout and stderr) will
diff --git a/tests/block/003 b/tests/block/003
index 6696d371d7e5..2af9b89ec3e5 100755
--- a/tests/block/003
+++ b/tests/block/003
@@ -14,7 +14,7 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_can_discard
+	_require_test_dev_can_discard
 }
 
 test_device() {
diff --git a/tests/block/007 b/tests/block/007
index f03935084ce6..b19a57024b42 100755
--- a/tests/block/007
+++ b/tests/block/007
@@ -15,7 +15,8 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_supports_io_poll && _test_dev_supports_io_poll_delay
+	_require_test_dev_supports_io_poll && \
+		_require_test_dev_supports_io_poll_delay
 }
 
 run_fio_job() {
diff --git a/tests/block/011 b/tests/block/011
index c3432a63e274..4f331b4a7522 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -15,7 +15,7 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_is_pci
+	_require_test_dev_is_pci
 }
 
 test_device() {
diff --git a/tests/block/019 b/tests/block/019
index 7cd26bd512bc..113a3d6e8986 100755
--- a/tests/block/019
+++ b/tests/block/019
@@ -14,7 +14,7 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_is_pci && _test_dev_in_hotplug_slot
+	_require_test_dev_is_pci && _require_test_dev_in_hotplug_slot
 }
 
 test_device() {
diff --git a/tests/nvme/032 b/tests/nvme/032
index a91a473ac5df..ce45657951a1 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -19,7 +19,7 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_is_nvme
+	_require_test_dev_is_nvme
 }
 
 test_device() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413d32d2..6ffa971b4308 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -11,12 +11,12 @@ group_requires() {
 }
 
 group_device_requires() {
-	_test_dev_is_nvme
+	_require_test_dev_is_nvme
 }
 
 NVMET_CFS="/sys/kernel/config/nvmet/"
 
-_test_dev_is_nvme() {
+_require_test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
 		SKIP_REASON="$TEST_DEV is not a NVMe device"
 		return 1
diff --git a/tests/scsi/006 b/tests/scsi/006
index f220f61e3c1e..05ed6520d600 100755
--- a/tests/scsi/006
+++ b/tests/scsi/006
@@ -12,7 +12,7 @@ DESCRIPTION="toggle SCSI cache type"
 QUICK=1
 
 device_requires() {
-	_test_dev_is_scsi_disk
+	_require_test_dev_is_scsi_disk
 }
 
 test_device() {
diff --git a/tests/scsi/rc b/tests/scsi/rc
index 2a192fd0f969..1477cecc5593 100644
--- a/tests/scsi/rc
+++ b/tests/scsi/rc
@@ -11,14 +11,14 @@ group_requires() {
 }
 
 group_device_requires() {
-	_test_dev_is_scsi
+	_require_test_dev_is_scsi
 }
 
 _have_scsi_generic() {
 	_have_modules sg
 }
 
-_test_dev_is_scsi() {
+_require_test_dev_is_scsi() {
 	if [[ ! -d ${TEST_DEV_SYSFS}/device/scsi_device ]]; then
 		SKIP_REASON="$TEST_DEV is not a SCSI device"
 		return 1
@@ -26,7 +26,7 @@ _test_dev_is_scsi() {
 	return 0
 }
 
-_test_dev_is_scsi_disk() {
+_require_test_dev_is_scsi_disk() {
 	if [[ ! -d ${TEST_DEV_SYSFS}/device/scsi_disk ]]; then
 		SKIP_REASON="$TEST_DEV is not a SCSI disk"
 		return 1
diff --git a/tests/zbd/007 b/tests/zbd/007
index b4dcbd89f179..2376b3aedaa0 100755
--- a/tests/zbd/007
+++ b/tests/zbd/007
@@ -18,7 +18,7 @@ requires() {
 }
 
 device_requires() {
-	_test_dev_is_logical
+	_require_test_dev_is_logical
 }
 
 # Select test target zones. Pick up the first sequential required zones. If
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 9c1dc5210b1a..a910a2425567 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -18,7 +18,7 @@ group_requires() {
 }
 
 group_device_requires() {
-	_test_dev_is_zoned
+	_require_test_dev_is_zoned
 }
 
 _fallback_null_blk_zoned() {
@@ -254,13 +254,20 @@ _find_two_contiguous_seq_zones() {
 
 _test_dev_is_dm() {
 	if [[ ! -r "${TEST_DEV_SYSFS}/dm/name" ]]; then
+		return 1
+	fi
+	return 0
+}
+
+_require_test_dev_is_dm() {
+	if ! _test_dev_is_dm; then
 		SKIP_REASON="$TEST_DEV is not device-mapper"
 		return 1
 	fi
 	return 0
 }
 
-_test_dev_is_logical() {
+_require_test_dev_is_logical() {
 	if ! _test_dev_is_partition && ! _test_dev_is_dm; then
 		SKIP_REASON="$TEST_DEV is not a logical device"
 		return 1
-- 
2.26.2

