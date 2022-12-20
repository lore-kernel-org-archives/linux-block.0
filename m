Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 23:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiLTXxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLTXxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 18:53:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84AF20192
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jNw8iiUsMPsgbrgrTgwPRbPQnlzZe+MeVurSoO0OT4M=; b=XsGklmQhp4t+KTHArrVgqG2MDq
        dQrEYGvqeg/cGa8BT+LDVg1CyNO7hgQXQ+LrJOWx2Z1ehbPw7gX10T7lZ2kRNzQLq/aiR6olvv6Qt
        jMh0qZPFQqECDldeO+7FPQiPU/82y5PjOgQDTxnCr2cIgzk+uxbwXi/mn8FzHNXVfpmDkrt+wa1Nh
        AqJQQzDL6tu7kPagbfjBXV2+fVbF2LHll5O/Ik3nkXHnWYEh6Fp0B/RI9KLe2cWJZKNPGuRyk++v8
        lkmDzd01M3XI3yvuuytxLY7yShm0+Ur1WLYyIVWJK0BdVFHxzsZenAmYspg8s/YW7lvkmxyxPpD69
        hyyT3NAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7mQK-00642k-7K; Tue, 20 Dec 2022 23:53:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, bvanassche@acm.org, mcgrof@kernel.org
Cc:     kch@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH v3 1/2] blktests: replace module removal with patient module removal
Date:   Tue, 20 Dec 2022 15:53:23 -0800
Message-Id: <20221220235324.1445248-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221220235324.1445248-1-mcgrof@kernel.org>
References: <20221220235324.1445248-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A long time ago, in a galaxy far, far away...

I ran into some odd scsi_debug false positives with fstests. This
prompted me to look into them given these false positives prevents
me from moving forward with establishing a test baseline with high
number of cycles. That is, this stupid issue was prevening creating
high confidence in testing.

I reported it [0] and exchanged some ideas with Doug. However, in
the end, despite efforts to help things with scsi_debug there were
still issues lingering which seemed to defy our expectations upstream.
One of the last hanging fruit issues is and always has been that
userspace expectations for proper module removal has been broken,
so in the end I have demonstrated this is a generic issue [1].

Long ago a WAIT option for module removal was added... that was then
removed as it was deemed not needed as folks couldn't figure out when
these races happened. The races are actually pretty easy to trigger, it
was just never properly documented. A simpe blkdev_open() will easily
bump a module refcnt, and these days many thing scan do that sort of
thing.

The proper solution is to implement then a patient module removal
on kmod and that has been merged now as modprobe --wait MSEC option.
We need a work around to open code a similar solution for users of
old versions of kmod. An open coded solution for fstests exists
there for over a year now. This now provides the respective blktests
implementation.

I've tested blktests with this on kdevops without finding any
regressions in testing. srp tests were run with and without
use_siw=1.

The results are actually *part* of kdevops now under the repository
itself carrying only failures [2]. Linux next tag next-20221207 was
used.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
[2] https://github.com/linux-kdevops/kdevops/blob/master/workflows/blktests/results/mcgrof/libvirt-qemu/20221220/6.1.0-rc8-next-20221207.xz

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 common/multipath-over-rdma |  11 +--
 common/null_blk            |   9 ++-
 common/rc                  | 134 +++++++++++++++++++++++++++++++++++++
 common/scsi_debug          |   9 +--
 tests/nvme/rc              |   8 +--
 tests/nvmeof-mp/rc         |  15 +++--
 tests/srp/rc               |   4 +-
 7 files changed, 160 insertions(+), 30 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index fb820d6f4e42..ea7b233486ee 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -4,6 +4,7 @@
 #
 # Functions and global variables used by both the srp and nvmeof-mp tests.
 
+. common/rc
 . common/shellcheck
 . common/null_blk
 
@@ -428,14 +429,8 @@ stop_soft_rdma() {
 		      echo "$i ..."
 		      rdma link del "${i}" || echo "Failed to remove ${i}"
 		done
-	if ! _unload_module rdma_rxe 10; then
-		echo "Unloading rdma_rxe failed"
-		return 1
-	fi
-	if ! _unload_module siw 10; then
-		echo "Unloading siw failed"
-		return 1
-	fi
+	_patient_rmmod rdma_rxe || return 1
+	_patient_rmmod siw  || return 1
 	} >>"$FULL"
 }
 
diff --git a/common/null_blk b/common/null_blk
index 52eb48659d8d..cee72d73b688 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -5,6 +5,7 @@
 # null_blk helper functions.
 
 . common/shellcheck
+. common/rc
 
 _have_null_blk() {
 	_have_driver null_blk
@@ -23,10 +24,8 @@ _init_null_blk() {
 	local zoned=""
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
 
-	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
-		SKIP_REASONS+=("requires modular null_blk")
-		return 1
-	fi
+	_patient_rmmod null_blk || return 1
+	modprobe null_blk "$@" "${zoned}" || return 1
 
 	udevadm settle
 	return 0
@@ -58,5 +57,5 @@ _configure_null_blk() {
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
-	modprobe -r -q null_blk
+	_patient_rmmod null_blk
 }
diff --git a/common/rc b/common/rc
index ef23ebee7704..b17fcbf70c6d 100644
--- a/common/rc
+++ b/common/rc
@@ -409,3 +409,137 @@ _have_writeable_kmsg() {
 	fi
 	return 0
 }
+
+_has_modprobe_patient()
+{
+	modprobe --help >& /dev/null || return 1
+	modprobe --help | grep -q "\-\-wait" || return 1
+	return 0
+}
+
+MODPROBE_REMOVE_PATIENT=""
+if ! _has_modprobe_patient; then
+	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		# We will open code our own implementation of patient module
+		# remover in blktests. Use a 50 second default.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+	fi
+else
+	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
+	if [[ -n "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+	else
+		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
+		# with environments without support for modprobe --wait, but we
+		# only really need it exported right now for environments which
+		# don't have support for modprobe --wait to implement our own
+		# patient module removal support within blktests.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+	fi
+	MODPROBE_REMOVE_PATIENT="modprobe -r $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
+fi
+export MODPROBE_REMOVE_PATIENT
+
+# checks the refcount and returns 0 if we can safely remove the module. rmmod
+# does this check for us, but we can use this to also iterate checking for this
+# refcount before we even try to remove the module. This is useful when using
+# debug test modules which take a while to quiesce.
+_patient_rmmod_check_refcnt()
+{
+	local refcnt=0
+
+	refcnt=$(cat "/sys/module/$module/refcnt" 2>/dev/null)
+	if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
+		return 0
+	fi
+	return 1
+}
+
+# Tries to wait patiently to remove a module by ensuring first
+# the refcnt is 0 and then trying to remove the module over and over
+# again within the time allowed. The timeout is configurable per test, just set
+# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
+# This applies to both cases where kmod supports the patient module remover
+# (modrobe --wait) and where it does not.
+#
+# If your version of kmod supports modprobe -p, we instead use that
+# instead. Otherwise we have to implement a patient module remover
+# ourselves.
+_patient_rmmod()
+{
+	local module=$1
+	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
+	local max_tries=0
+	local mod_ret=0
+	local refcnt_is_zero=0
+	# Since we are looking for a directory we must adopt the
+	# specific directory used by scripts/Makefile.lib for
+	# KBUILD_MODNAME
+	local module_sys=${module//-/_}
+
+	[ ! -e "/sys/module/$module_sys" ] && return 0
+
+	if [[ -n $MODPROBE_REMOVE_PATIENT ]]; then
+		$MODPROBE_REMOVE_PATIENT "$module"
+		mod_ret=$?
+		if [[ $mod_ret -ne 0 ]]; then
+			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
+		fi
+		return $mod_ret
+	fi
+
+	max_tries=$max_tries_max
+
+	while [[ "$max_tries" != "0" ]]; do
+		if _patient_rmmod_check_refcnt "$module_sys"; then
+			refcnt_is_zero=1
+			break
+		fi
+		sleep 1
+		((max_tries--))
+	done
+
+	if [[ $refcnt_is_zero -ne 1 ]]; then
+		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
+		return 1
+	fi
+
+	# If we ran out of time but our refcnt check confirms we had
+	# a refcnt of 0, just try to remove the module once.
+	if [[ "$max_tries" == "0" ]]; then
+		modprobe -r "$module"
+		return $?
+	fi
+
+	# If we have extra time left. Use the time left to now try to
+	# persistently remove the module. We do this because although through
+	# the above we found refcnt to be 0, removal can still fail since
+	# userspace can always race to bump the refcnt. An example is any
+	# blkdev_open() calls against a block device. These issues have been
+	# tracked and documented in the following bug reports, which justifies
+	# our need to do this in userspace:
+	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
+	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
+	while [[ $max_tries != 0 ]]; do
+		if [[ -d /sys/module/$module ]]; then
+			modprobe -r "$module" 2> /dev/null
+			mod_ret=$?
+			if [[ $mod_ret == 0 ]]; then
+				break;
+			fi
+			sleep 1
+			((max_tries--))
+		else
+			break
+		fi
+	done
+
+	if [[ $mod_ret -ne 0 ]]; then
+		echo "custom patient module removal for $module timed out trying to remove $module using timeout of $max_tries_max last try returned $mod_ret"
+	fi
+
+	return $mod_ret
+}
diff --git a/common/scsi_debug b/common/scsi_debug
index ae13bb624b3d..889116e8b46b 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,6 +4,8 @@
 #
 # scsi_debug helper functions.
 
+. common/rc
+
 _have_scsi_debug() {
 	_have_module scsi_debug
 }
@@ -18,9 +20,8 @@ _init_scsi_debug() {
 		args+=(zbc=host-managed zone_nr_conv=0)
 	fi
 
-	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; then
-		return 1
-	fi
+	_patient_rmmod scsi_debug || return 1
+	modprobe scsi_debug "${args[@]}" || return 1
 
 	udevadm settle
 
@@ -60,5 +61,5 @@ _exit_scsi_debug() {
 	unset SCSI_DEBUG_TARGETS
 	unset SCSI_DEBUG_DEVICES
 	udevadm settle
-	modprobe -r scsi_debug
+	_patient_rmmod scsi_debug
 }
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ff13ea257cab..df78ed4bc6ea 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -162,11 +162,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
+	_patient_rmmod nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
-	fi
-	modprobe -rq nvmet 2>/dev/null
+                _patient_rmmod nvmet-"${nvme_trtype}"
+        fi
+	_patient_rmmod nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 4238a4cd663e..27e835a158ae 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -162,12 +162,13 @@ start_nvme_client() {
 }
 
 stop_nvme_client() {
-	_unload_module nvme-rdma || return $?
-	_unload_module nvme-fabrics || return $?
+	_patient_rmmod nvme-rdma || return 1
+	_patient_rmmod nvme-fabrics || return 1
 	# Ignore nvme and nvme-core unload errors - this test may be run on a
 	# system equipped with one or more NVMe SSDs.
-	_unload_module nvme >&/dev/null
-	_unload_module nvme-core >&/dev/null
+	export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS=5
+	_patient_rmmod nvme
+	_patient_rmmod nvme-core
 	return 0
 }
 
@@ -267,9 +268,9 @@ stop_nvme_target() {
 				rmdir "$d"
 			done
 	)
-	_unload_module nvmet_rdma &&
-		_unload_module nvmet &&
-		_exit_null_blk
+	_patient_rmmod nvmet_rdma || return 1
+	_patient_rmmod nvmet || return 1
+	_exit_null_blk
 }
 
 start_target() {
diff --git a/tests/srp/rc b/tests/srp/rc
index 55b535aea619..4d504f7bd0cc 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -491,7 +491,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	_unload_module ib_srpt
+	_patient_rmmod ib_srpt
 	modprobe ib_srpt "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
@@ -553,7 +553,7 @@ stop_lio_srpt() {
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-		_unload_module $m 10 || return $?
+		_patient_rmmod $m || return $?
 	done
 }
 
-- 
2.35.1

