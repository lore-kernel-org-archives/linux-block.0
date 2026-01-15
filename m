Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C034572F
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468267; cv=none; b=sqRDoK43yaBTA4hAm58zXXekLUZSVhOTYFGXpPPcGiMxny1mMZlCeki58kR6d2OLmA1lf++d+fAHZznmytwL1ALLtO7ArySZ21UUDRxsdK9heUcs/wnzPLTj0Nx6aY2qNonQmRLAwOmwM7mu6X4BJyEOMdSyuKfYJP/SpInIwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468267; c=relaxed/simple;
	bh=48IdRLAhK6gOD15GayrDiX2BL0iX7Qaw0dR5zbuRlok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJouhfAZp4xy7wE75QE1dFuDWZwc85jhr8jrdLebGFeozqXd6lMmtuxSgjUnz+lYDub6tJv/ZEzsZiAycSsOwpmCjcfUzNrSTp+SlHEviYVYiu0l16UsxvY21tpBe/KPzL987MlbjMvcRPfx0e0I1cmIImKQG0Pn7fvuCruDBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EIorI9XM; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIorI9XM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768468265; x=1800004265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48IdRLAhK6gOD15GayrDiX2BL0iX7Qaw0dR5zbuRlok=;
  b=EIorI9XMnaFJuXkk146KPMkq1Csl4UhgthYD+b30hff7CZYVQg+euTKN
   sxq/30bvR+uiiOy1C3kKVgC0RANjaNfT/Rq07m6swDDbDKdv9KnBDxOd6
   qHGVHs4pafd6hftKCh2L9LyxcQP/YQ0xLEz1z5vtVJHNMuKBpoY203qu1
   ESDOtgCAv47ZgfTMpbjAl+x3asvHNZ/1Ejf4SMHQ61mnLNVQeoEZquzSf
   HqoEVhcyvuyoe4FQxaouZxrOgOWdqCNM0SuQJn8wqDKfwHto7nD7a43OG
   gsWy2HHYcfhpZ8FLfOj+JSyVFfa9cwAotq0KMUc5WuiwIROQ8oevoooPN
   Q==;
X-CSE-ConnectionGUID: BM/l2fZdSnipd++9wI8fJQ==
X-CSE-MsgGUID: /x3cvi5GRyWHhtq9Na42ng==
X-IronPort-AV: E=Sophos;i="6.21,226,1763395200"; 
   d="scan'208";a="138836173"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2026 17:11:05 +0800
IronPort-SDR: 6968af29_Vw+sVe3AmJflGS/cSkB167NRMvTNRUp0ZtSAIVQSslHeY7S
 Ljauemujjo71zOnCCwGmWERU5l6kc3rfdk9Cj7w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2026 01:11:05 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2026 01:11:05 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v7 1/3] check,common,srp/rc: replace module removal with patient module removal
Date: Thu, 15 Jan 2026 18:10:59 +0900
Message-ID: <20260115091101.70464-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

A long time ago, in a galaxy far, far away...

I ran into some odd scsi_debug false positives with fstests. This
prompted me to look into them given these false positives prevents
me from moving forward with establishing a test baseline with high
number of cycles. That is, this stupid issue was prevening creating
high confidence in testing.

I reported it in 2021 [0] and exchanged some ideas with Doug. However,
in the end, despite efforts to help things with scsi_debug there were
still issues lingering which seemed to defy our expectations upstream.
One of the last hanging fruit issues is and always has been that
userspace expectations for proper module removal has been broken,
so in the end I have demonstrated this is a generic issue [1]. The same
problem was reported by Swarna in 2025 [2].

Long ago a WAIT option for module removal was added... that was then
removed as it was deemed not needed as folks couldn't figure out when
these races happened. The races are actually pretty easy to trigger, it
was just never properly documented. A simpe blkdev_open() will easily
bump a module refcnt, and these days many thing scan do that sort of
thing.

The proper solution is to implement then a patient module removal
on kmod and that has been merged now as modprobe --wait=MSEC option.
We need a work around to open code a similar solution for users of
old versions of kmod. An open coded solution for fstests exists
there for over a year now. This now provides the respective blktests
implementation.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
[2] https://lore.kernel.org/linux-block/aUmJtfPM7A26swxN@deb-101020-bm01.eng.stellus.in/

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
[Shin'ichiro: moved new function to 'check' to not source common/rc]
[Shin'ichiro: reflected comments by Bart for v4 series]
[Shin'ichiro: replaced modprobe -r option with --remove option]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check                      | 118 +++++++++++++++++++++++++++++++++++++
 common/multipath-over-rdma |  10 +---
 common/null_blk            |   5 +-
 common/nvme                |   8 +--
 common/scsi_debug          |  12 +---
 tests/srp/rc               |   4 +-
 6 files changed, 132 insertions(+), 25 deletions(-)

diff --git a/check b/check
index 6d77d8e..6a156b3 100755
--- a/check
+++ b/check
@@ -463,6 +463,124 @@ _test_dev_is_zoned() {
 	   $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
 }
 
+_has_modprobe_wait()
+{
+	modprobe --help |& grep --quiet -- --wait
+}
+
+# Check whether modprobe --wait is supported and set up the patient module
+# removal command. This is evaluated at source time, so we need to handle
+# the timeout dynamically in _patient_rmmod() for cases where tests want
+# to override it.
+MODPROBE_HAS_WAIT=""
+if _has_modprobe_wait; then
+	MODPROBE_HAS_WAIT="yes"
+fi
+
+if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+	export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+fi
+
+# checks the refcount and returns 0 if we can safely remove the module. rmmod
+# does this check for us, but we can use this to also iterate checking for this
+# refcount before we even try to remove the module. This is useful when using
+# debug test modules which take a while to quiesce.
+_patient_rmmod_check_refcnt()
+{
+	local module=$1
+	local refcnt
+
+	refcnt=$(cat "/sys/module/$module/refcnt" 2>/dev/null)
+	[[ $? -ne 0 || $refcnt -eq 0 ]]
+}
+
+# Tries to wait patiently to remove a module by ensuring first
+# the refcnt is 0 and then trying to remove the module over and over
+# again within the time allowed. The timeout is configurable per test, just set
+# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to calling this function.
+# This applies to both cases where kmod supports the patient module remover
+# (modprobe --wait) and where it does not.
+#
+# If your version of kmod supports modprobe --wait, we use that instead.
+# Otherwise we have to implement a patient module remover ourselves.
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
+	# Check if module is built-in or not loaded
+	if [[ ! -d "/sys/module/$module_sys" ]]; then
+		return 0
+	fi
+
+	# Check if this is a built-in module (no refcnt file means built-in)
+	if [[ ! -f "/sys/module/$module_sys/refcnt" ]]; then
+		return 0
+	fi
+
+	if [[ -n $MODPROBE_HAS_WAIT ]]; then
+		local timeout_ms=$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))
+		modprobe --remove --wait="${timeout_ms}" "$module"
+		mod_ret=$?
+		if [[ $mod_ret -ne 0 ]]; then
+			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
+		fi
+		return $mod_ret
+	fi
+
+	for ((max_tries=max_tries_max; max_tries != 0; max_tries--)); do
+		if _patient_rmmod_check_refcnt "$module_sys"; then
+			refcnt_is_zero=1
+			break
+		fi
+		sleep 1
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
+		modprobe --remove "$module"
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
+	while [[ $max_tries != 0 ]] && [[ -d /sys/module/$module_sys ]]; do
+		modprobe --remove "$module" 2> /dev/null
+		mod_ret=$?
+		if [[ $mod_ret == 0 ]]; then
+			break;
+		fi
+		sleep 1
+		((max_tries--))
+	done
+
+	if [[ $mod_ret -ne 0 ]]; then
+		echo "custom patient module removal for $module timed out trying to remove using timeout of $max_tries_max last try returned $mod_ret"
+	fi
+
+	return $mod_ret
+}
+
 # Arguments: module to unload ($1) and retry count ($2).
 _unload_module() {
 	local i m=$1 rc=${2:-1} reason
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 1084f80..9b72d26 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -427,14 +427,8 @@ stop_soft_rdma() {
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
index bbb6f78..c7d6a56 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -38,7 +38,8 @@ _init_null_blk() {
 	local args=("$@")
 	if (( RUN_FOR_ZONED )); then args+=("zoned=1"); fi
 
-	if ! modprobe -r null_blk || ! modprobe null_blk "${args[@]}" ; then
+	_patient_rmmod null_blk || return 1
+	if ! modprobe null_blk "${args[@]}"; then
 		SKIP_REASONS+=("requires modular null_blk")
 		return 1
 	fi
@@ -79,5 +80,5 @@ _configure_null_blk() {
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
-	modprobe -r -q null_blk
+	_patient_rmmod null_blk
 }
diff --git a/common/nvme b/common/nvme
index eed5db0..f752f56 100644
--- a/common/nvme
+++ b/common/nvme
@@ -213,13 +213,13 @@ _cleanup_nvmet() {
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_nvme_fcloop_del_lport "${def_local_wwnn}" "${def_local_wwpn}"
-		modprobe -rq nvme-fcloop 2>/dev/null
+		_patient_rmmod nvme-fcloop
 	fi
-	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
+	_patient_rmmod nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
+		_patient_rmmod nvmet-"${nvme_trtype}"
 	fi
-	modprobe -rq nvmet 2>/dev/null
+	_patient_rmmod nvmet
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
diff --git a/common/scsi_debug b/common/scsi_debug
index 89c4801..8964558 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -98,14 +98,8 @@ _init_scsi_debug() {
 		args+=(zbc=host-managed zone_nr_conv=0)
 	fi
 
-	if ! _unload_module scsi_debug 10; then
-		echo "Unloading scsi_debug failed" >&2
-		return 1
-	fi
-	if ! modprobe scsi_debug "${args[@]}"; then
-		echo "Loading scsi_debug ${args[*]} failed" >&2
-		return 1
-	fi
+	_patient_rmmod scsi_debug || return 1
+	modprobe scsi_debug "${args[@]}" || return 1
 
 	udevadm settle
 
@@ -180,7 +174,7 @@ _exit_scsi_debug() {
 	udevadm settle
 
 	if _module_file_exists scsi_debug; then
-		_unload_module scsi_debug 10
+		_patient_rmmod scsi_debug
 		return
 	fi
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 47b9546..8585272 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -502,7 +502,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	_unload_module ib_srpt
+	_patient_rmmod ib_srpt
 	modprobe ib_srpt "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
@@ -564,7 +564,7 @@ stop_lio_srpt() {
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-		_unload_module $m 10 || return $?
+		_patient_rmmod $m || return $?
 	done
 }
 
-- 
2.52.0

