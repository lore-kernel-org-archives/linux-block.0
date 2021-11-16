Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE012C433EF
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E161A62
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhKPRcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 12:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhKPRc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 12:32:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82FC061746
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=937KWT+XLBHB1U9hhNKWb65T060x+Vs6/Qwte6jJh90=; b=yLL7jFuzSNv/5Bhz4ZZgHz4tl8
        yY/t5DHJZD7gTWAtYZUnk+KPdqRMdX9oN99kZEqeBlCBkzyjI9lQoTtkcLnHlvIfE97SpkQrhImqy
        4/OPF/14GujAODTXNLvgXzpyfUI4FtTJGB74c1c3nXUGPa2HC70l7d26lE31LJl8T681l9RvxL8aV
        nT5O7T3GnavmAIcaXbykq3b+09Xmlqy4l+B/bZJQ3l3YFi5H+nsuj3Em8BxyIwkzks+0P2IxktzsL
        rJvLEmMvKbeMrVj8oow90a4BDDczk6Zw2JsxqCq5zRMOde/yflrSa/5Qxmo/HVyy1h2AHroN9b9Od
        CkbMWRnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mn2Gt-002Sja-G6; Tue, 16 Nov 2021 17:29:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dwagner@suse.de, osandov@fb.com, mcgrof@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] blktests: replace module removal with patient module removal
Date:   Tue, 16 Nov 2021 09:29:26 -0800
Message-Id: <20211116172926.587062-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
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
on kmod and patches have been sent for that and those patches are
under review. In the meantime we need a work around to open code a
similar solution for users of old versions of kmod. I sent an open
coded solution for fstests about since August 19th and has been used
there for a few months now. Now that that stuff is merged and tested
in fstests with more exposure, its time to match parity on blktests.

I've tested blktests with this for things which I can run virtually
for a while now. More wider testig is welcomed.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/multipath-over-rdma |  11 +--
 common/null_blk            |   9 ++-
 common/rc                  | 148 ++++++++++++++++++++++++++++++++++---
 common/scsi_debug          |   9 ++-
 tests/nvme/rc              |   6 +-
 tests/nvmeof-mp/rc         |  15 ++--
 tests/srp/rc               |  17 +----
 7 files changed, 166 insertions(+), 49 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index cef05ec..c2af372 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -4,6 +4,7 @@
 #
 # Functions and global variables used by both the srp and nvmeof-mp tests.
 
+. common/rc
 . common/shellcheck
 . common/null_blk
 
@@ -427,14 +428,8 @@ stop_soft_rdma() {
 		      echo "$i ..."
 		      rdma link del "${i}" || echo "Failed to remove ${i}"
 		done
-	if ! unload_module rdma_rxe 10; then
-		echo "Unloading rdma_rxe failed"
-		return 1
-	fi
-	if ! unload_module siw 10; then
-		echo "Unloading siw failed"
-		return 1
-	fi
+	_patient_rmmod rdma_rxe || return 1
+	_patient_rmmod 1siw  || return 1
 	} >>"$FULL"
 }
 
diff --git a/common/null_blk b/common/null_blk
index 6611db0..6c81657 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -4,6 +4,8 @@
 #
 # null_blk helper functions.
 
+. common/rc
+
 _have_null_blk() {
 	_have_modules null_blk
 }
@@ -21,9 +23,8 @@ _init_null_blk() {
 	local zoned=""
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
 
-	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
-		return 1
-	fi
+	_patient_rmmod null_blk || return 1
+	modprobe null_blk "$@" "${zoned}" || 1
 
 	udevadm settle
 	return 0
@@ -46,5 +47,5 @@ _configure_null_blk() {
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
-	modprobe -r null_blk
+	_patient_rmmod null_blk
 }
diff --git a/common/rc b/common/rc
index 85e6314..2b551bf 100644
--- a/common/rc
+++ b/common/rc
@@ -321,15 +321,143 @@ _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
+# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
+# modprobe removal to run forever trying to remove a module.
+MODPROBE_REMOVE_PATIENT=""
+modprobe --help | grep -q -1 "remove-patiently"
+if [[ $? -ne 0 ]]; then
+	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		# We will open code our own implementation of patient module
+		# remover in blktests. Use a 50 second default.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+	fi
+else
+	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
+	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
+			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+		fi
+	else
+		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
+		# with environments without support for modprobe -p, but we
+		# only really need it exported right now for environments which
+		# don't have support for modprobe -p to implement our own
+		# patient module removal support within fstests.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+	fi
+	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_TIMEOUT_ARGS"
+fi
+export MODPROBE_REMOVE_PATIENT
+
+# checks the refcount and returns 0 if we can safely remove the module. rmmod
+# does this check for us, but we can use this to also iterate checking for this
+# refcount before we even try to remove the module. This is useful when using
+# debug test modules which take a while to quiesce.
+_patient_rmmod_check_refcnt()
+{
+	local module=$1
+	local refcnt=0
+
+	if [[ -f /sys/module/$module/refcnt ]]; then
+		refcnt=$(cat /sys/module/$module/refcnt 2>/dev/null)
+		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
+			return 0
+		fi
+		return 1
+	fi
+	return 0
+}
+
+# Patiently tries to wait to remove a module by ensuring first
+# the refcnt is 0 and then trying to persistently remove the module within
+# the time allowed. The timeout is configurable per test, just set
+# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
+# If you want this to try forever just set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
+# to the special value of "forever". This applies to both cases where kmod
+# supports the patient module remover (modrobe -p) and where it does not.
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
+
+	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
+		$MODPROBE_REMOVE_PATIENT $module
+		mod_ret=$?
+		if [[ $mod_ret -ne 0 ]]; then
+			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
+		fi
+		return $mod_ret
+	fi
+
+	max_tries=$max_tries_max
+
+	# We must use a string check as otherwise if max_tries is set to
+	# "forever" and we don't use a string check we can end up skipping
+	# entering this loop.
+	while [[ "$max_tries" != "0" ]]; do
+		_patient_rmmod_check_refcnt $module
+		if [[ $? -eq 0 ]]; then
+			refcnt_is_zero=1
+			break
+		fi
+		sleep 1
+		if [[ "$max_tries" == "forever" ]]; then
+			continue
+		fi
+		let max_tries=$max_tries-1
 	done
-	return 1
+
+	if [[ $refcnt_is_zero -ne 1 ]]; then
+		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
+		return -1
+	fi
+
+	# If we ran out of time but our refcnt check confirms we had
+	# a refcnt of 0, just try to remove the module once.
+	if [[ "$max_tries" == "0" ]]; then
+		modprobe -r $module
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
+			modprobe -r $module 2> /dev/null
+			mod_ret=$?
+			if [[ $mod_ret == 0 ]]; then
+				break;
+			fi
+			sleep 1
+			if [[ "$max_tries" == "forever" ]]; then
+				continue
+			fi
+			let max_tries=$max_tries-1
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
 }
diff --git a/common/scsi_debug b/common/scsi_debug
index b48cdc9..9987286 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -4,14 +4,15 @@
 #
 # scsi_debug helper functions.
 
+. common/rc
+
 _have_scsi_debug() {
 	_have_modules scsi_debug
 }
 
 _init_scsi_debug() {
-	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "$@"; then
-		return 1
-	fi
+	_patient_rmmod scsi_debug || return 1
+	modprobe scsi_debug "$@" || return 1
 
 	udevadm settle
 
@@ -51,5 +52,5 @@ _exit_scsi_debug() {
 	unset SCSI_DEBUG_TARGETS
 	unset SCSI_DEBUG_DEVICES
 	udevadm settle
-	modprobe -r scsi_debug
+	_patient_rmmod scsi_debug
 }
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c27cde..2fb3c0d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -125,11 +125,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
+	_patient_rmmod nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
+		_patient_rmmod nvmet-"${nvme_trtype}" 2>/dev/null
 	fi
-	modprobe -r nvmet 2>/dev/null
+	_patient_rmmod nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index dcb2e3c..54d8c95 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -164,12 +164,13 @@ start_nvme_client() {
 }
 
 stop_nvme_client() {
-	unload_module nvme-rdma || return $?
-	unload_module nvme-fabrics || return $?
+	_patient_rmmod nvme-rdma || return 1
+	_patient_rmmod nvme-fabrics || return 1
 	# Ignore nvme and nvme-core unload errors - this test may be run on a
 	# system equipped with one or more NVMe SSDs.
-	unload_module nvme >&/dev/null
-	unload_module nvme-core >&/dev/null
+	export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS=5
+	_patient_rmmod nvme
+	_patient_rmmod nvme-core
 	return 0
 }
 
@@ -269,9 +270,9 @@ stop_nvme_target() {
 				rmdir "$d"
 			done
 	)
-	unload_module nvmet_rdma &&
-		unload_module nvmet &&
-		_exit_null_blk
+	_patient_rmmod nvmet_rdma || return 1
+	_patient_rmmod nvmet || return 1
+	_exit_null_blk
 }
 
 start_target() {
diff --git a/tests/srp/rc b/tests/srp/rc
index 586f007..c3bba24 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -326,16 +326,9 @@ stop_srp_ini() {
 	local i
 
 	log_out
-	for ((i=40;i>=0;i--)); do
-		remove_mpath_devs || return $?
-		unload_module ib_srp >/dev/null 2>&1 && break
-		sleep 1
-	done
-	if [ -e /sys/module/ib_srp ]; then
-		echo "Error: unloading kernel module ib_srp failed"
-		return 1
-	fi
-	unload_module scsi_transport_srp || return $?
+	remove_mpath_devs || return $?
+	_patient_rmmod ib_srp || return 1
+	_patient_rmmod scsi_transport_srp || return $1
 }
 
 # Associate the LIO device with name $1/$2 with file $3 and SCSI serial $4.
@@ -554,9 +547,7 @@ stop_lio_srpt() {
 	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
-	do
-		unload_module $m 10 || return $?
-	done
+	_patient_rmmod $m || return $1
 }
 
 # Load and configure the SRP target driver
-- 
2.33.0

