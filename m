Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7702415B70
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924942; cv=none; b=TtnvlSIqSA0vid/imLTuLsSfhVW5lipYMngxI7g2EBOwnNIadplP4g7YtqJeH1tENi48ggaNCQaNIj+tXMVz8wgXthcfXVzyKlIOnMJUIpMCCH8gavIK8vMc75mDuCkeN5J804sehLfuTT5aZro+BgeDsLtwbVHS9BqTRWsSJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924942; c=relaxed/simple;
	bh=0wzyBwXBMDmvq/f85jWRP6REnUkDh1sBv3uYSm/sjWc=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=sqAvzCvzAeFGfcC/RlOowmOi0EqNBCSeweiGQCMeD24ktuVib8sEtLwjgFHnlKQistOL6yU5ks5WHKVrqG+DiCF7tx4cEujtYIQqnLLT8wbR1L1DUVqQ+rBv2RiAejEhGx2pXVmuK7B+fZ0yS2Mj9KvsEvxuY1jF0OhTXLmhE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bVXW0gCD; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bVXW0gCD"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261002070852epoutp015c49eaaff903ba6d907edcec96b2071b~apLy5Ve320530105301epoutp01x
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 07:08:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261002070852epoutp015c49eaaff903ba6d907edcec96b2071b~apLy5Ve320530105301epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790924932;
	bh=zurfcCFPjosiAu0u7Jh/RguCB+nxUdfOOVGTyFBuPAc=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=bVXW0gCDwmycgUeqg8Mrl8nruSNQgf5Hz/zRGaLunCn8hsgc1RACB66RXE6zoUPT+
	 RhjMJt/iSW4/V1AkwIONDua1Sy1GHDNCfA8J2ome59TMM2zNP03PXtLlD8rfD3RyO/
	 uGjyssp8WyOlN8zcap+MX7IjfVlR/yH3QlNp+OWY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20261002070852epcas2p4716e9b2127943a18d4d3262e93612257~apLyqtOMZ2608326083epcas2p4X;
	Fri,  2 Oct 2026 07:08:52 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.205]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hx0J34dHcz2SSKx; Fri,  2 Oct
	2026 07:08:51 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH blktests] nvme/071: test reservation preempt with multiple
 hosts
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
Date: Fri, 02 Oct 2026 16:08:51 +0900
X-CMS-MailID: 20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a
References: <CGME20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>

nvme/054 covers the reservation commands with a single host, so its
preempt step can only exercise a reservation holder preempting itself.

Add a test that connects three hosts to one namespace and sends the
Preempt and the Preempt and Abort actions of the Reservation Acquire
command from the reservation holder and from a non-holder registrant,
with PRKEY set to the key of another registrant, to the key of the
holder, and to 0h.  After each command the test checks the reservation
type and, for every registrant, its reservation key and whether it
holds the reservation, as reported by the Reservation Report command.

The steps in which the reservation holder preempts another registrant
or sends PRKEY 0h fail without the kernel patch "nvmet: fix preempt of
another registrant by the reservation holder".

The hosts connect to the same subsystem from one machine, so with
native multipath they share one namespace block device.  The test sends
the reservation commands to the controller character devices to pick
the host.  That goes through NVME_IOCTL_IO_CMD on the character device,
which the kernel reports as deprecated in its log for each command and
which only works while the controller has a single namespace.

The test needs the kernel soft target, because it adds the two extra
hosts through configfs.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 tests/nvme/071     | 253 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |   9 ++
 2 files changed, 262 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..435f797
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,253 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Samsung Electronics Co., Ltd.
+#
+# Test the Preempt and the Preempt and Abort actions of the Reservation Acquire
+# command with three hosts registered on one namespace. The action depends on
+# the PRKEY field regardless of which registrant sends the command (NVMe Base
+# Specification 2.1, section 8.1.22.7). The target used to handle every preempt
+# sent by the reservation holder as the holder preempting itself, which left
+# the registrants selected by PRKEY registered.
+#
+# Each command has to go to the controller of one specific host. The hosts
+# connect to the same subsystem from one machine, so with native multipath they
+# share a single namespace block device and only the controller character
+# devices tell them apart. An I/O command sent to a controller character device
+# uses NVME_IOCTL_IO_CMD, which works while the controller has one namespace
+# and makes the kernel log "using deprecated NVME_IOCTL_IO_CMD ioctl on the
+# char device!" for each command.
+#
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMe reservation preempt with multiple hosts"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_require_nvme_trtype_is_fabrics
+	_require_kernel_nvme_target
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# Host i registers with the reservation key i + 1.
+hostids=(
+	"${def_hostid}"
+	"1f01fb42-9f7f-4856-b0b3-51e60b8de349"
+	"2f01fb42-9f7f-4856-b0b3-51e60b8de349"
+)
+ctrls=()
+nsid=""
+report_arg="--cdw11=1"
+
+hostnqn_of() {
+	if [[ "${hostids[$1]}" == "${def_hostid}" ]]; then
+		echo "${def_hostnqn}"
+	else
+		echo "nqn.2014-08.org.nvmexpress:uuid:${hostids[$1]}"
+	fi
+}
+
+find_ctrl_by_hostid() {
+	local hostid=$1
+	local dev
+
+	for dev in /sys/class/nvme/nvme*; do
+		[[ -e "${dev}/hostid" ]] || continue
+		[[ "$(cat "${dev}/subsysnqn" 2>/dev/null)" == "${def_subsysnqn}" ]] || \
+			continue
+		if [[ "$(cat "${dev}/hostid" 2>/dev/null)" == "${hostid}" ]]; then
+			basename "${dev}"
+			return 0
+		fi
+	done
+	return 1
+}
+
+# Wait until the controller has set up its namespace.
+wait_ctrl_ns() {
+	local ctrl=$1
+	local i
+
+	for ((i = 0; i < 50; i++)); do
+		compgen -G "/sys/class/nvme/${ctrl}/nvme*n*" > /dev/null && \
+			return 0
+		sleep .1
+	done
+	return 1
+}
+
+# Send a reservation command as the host with the given index.
+resv_cmd() {
+	local cmd=$1
+	local host=$2
+
+	shift 2
+	_nvme_run "resv ${cmd}" "/dev/${ctrls[${host}]}" \
+		--namespace-id="${nsid}" "$@"
+}
+
+nvme_resv() {
+	if ! resv_cmd "$@" >> "${FULL}" 2>&1; then
+		echo "FAIL: nvme resv-$1 failed on host $2 with args: ${*:3}"
+		return 1
+	fi
+}
+
+nvme_resv_expect_invalid_field() {
+	local out
+
+	if out=$(resv_cmd "$@" 2>&1); then
+		echo "FAIL: nvme resv-$1 succeeded on host $2 with args: ${*:3}"
+		return 1
+	fi
+	echo "${out}" >> "${FULL}"
+	if ! echo "${out}" | grep -qi "invalid field"; then
+		echo "FAIL: nvme resv-$1 on host $2 did not fail with Invalid Field in Command"
+		return 1
+	fi
+}
+
+# Check the reservation type and the registrants. The registrants are given as
+# a sorted list of "<rkey>:<rcsts>", where rcsts is 1 for the reservation
+# holder.
+check_resv() {
+	local exp_rtype=$1
+	local exp_regs=$2
+	local report rtype regs
+
+	report=$(resv_cmd report 0 "${report_arg}")
+	rtype=$(echo "${report}" | \
+		sed -n -E "s/^rtype[[:space:]]*:[[:space:]]*//p" | head -1)
+	regs=$(echo "${report}" | awk '
+		function flush() { if (k != "") print k ":" r; k = ""; r = "" }
+		/^[^[:space:]].*\[[0-9]+\]/ { flush() }
+		/^[[:space:]]+rcsts[[:space:]]*:/ { r = $NF }
+		/^[[:space:]]+rkey[[:space:]]*:/ { k = $NF }
+		END { flush() }' | sort | xargs)
+
+	[[ "${rtype}" == "${exp_rtype}" ]] || \
+		echo "FAIL: expected rtype ${exp_rtype}, got '${rtype}'"
+	[[ "${regs}" == "${exp_regs}" ]] || \
+		echo "FAIL: expected registrants '${exp_regs}', got '${regs}'"
+}
+
+# Register all hosts and let host 0 acquire a reservation of the given type.
+resv_setup() {
+	local rtype=$1
+	local i
+
+	for i in "${!ctrls[@]}"; do
+		nvme_resv register "${i}" --nrkey="$((i + 1))" --rrega=0
+	done
+	nvme_resv acquire 0 --crkey=1 --rtype="${rtype}" --racqa=0
+}
+
+# Clear the reservation and all registrations. Host 2 is never unregistered by
+# this test.
+resv_clear() {
+	nvme_resv release 2 --crkey=3 --rrela=1
+	check_resv 0 ""
+}
+
+test_preempt() {
+	echo "Preempt another registrant by the holder"
+	resv_setup 4
+	check_resv 4 "1:1 2:0 3:0"
+	nvme_resv acquire 0 --crkey=1 --prkey=2 --rtype=3 --racqa=1
+	check_resv 4 "1:1 3:0"
+	resv_clear
+
+	echo "Preempt and abort another registrant by the holder"
+	resv_setup 4
+	nvme_resv acquire 0 --crkey=1 --prkey=2 --rtype=4 --racqa=2
+	check_resv 4 "1:1 3:0"
+	resv_clear
+
+	echo "Preempt another registrant by the holder of a write exclusive reservation"
+	resv_setup 1
+	nvme_resv acquire 0 --crkey=1 --prkey=2 --rtype=1 --racqa=1
+	check_resv 1 "1:1 3:0"
+	resv_clear
+
+	echo "Preempt with PRKEY 0 by the holder"
+	resv_setup 4
+	nvme_resv_expect_invalid_field acquire 0 --crkey=1 --prkey=0 --rtype=3 \
+		--racqa=1
+	check_resv 4 "1:1 2:0 3:0"
+	resv_clear
+
+	echo "Preempt the holder by itself"
+	resv_setup 4
+	nvme_resv acquire 0 --crkey=1 --prkey=1 --rtype=3 --racqa=1
+	check_resv 3 "1:1 2:0 3:0"
+	resv_clear
+
+	echo "Preempt another registrant by a non-holder"
+	resv_setup 4
+	nvme_resv acquire 2 --crkey=3 --prkey=2 --rtype=3 --racqa=1
+	check_resv 4 "1:1 3:0"
+	resv_clear
+
+	echo "Preempt the holder by a non-holder"
+	resv_setup 4
+	nvme_resv acquire 2 --crkey=3 --prkey=1 --rtype=3 --racqa=1
+	check_resv 3 "2:0 3:1"
+	resv_clear
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local ns i ctrl
+	local skipped=false
+	local ns_path
+
+	# test() runs once for each transport
+	ctrls=()
+
+	_nvmet_target_setup --blkdev file --resv_enable
+	for i in 1 2; do
+		_create_nvmet_host "${def_subsysnqn}" "$(hostnqn_of "${i}")"
+	done
+	for i in "${!hostids[@]}"; do
+		_nvme_connect_subsys --hostnqn "$(hostnqn_of "${i}")" \
+			--hostid "${hostids[${i}]}"
+		ctrl=$(find_ctrl_by_hostid "${hostids[${i}]}")
+		if [[ -z "${ctrl}" ]] || ! wait_ctrl_ns "${ctrl}"; then
+			echo "FAIL: no controller with a namespace for host ${i}"
+		fi
+		ctrls+=("${ctrl}")
+	done
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	nsid=$(cat "/sys/block/${ns}/nsid")
+	ns_path="${NVMET_CFS}/subsystems/${def_subsysnqn}/namespaces/${nsid}"
+
+	if _nvme_run "resv report" --help 2>&1 | grep -- '--eds' > /dev/null; then
+		report_arg="--eds"
+	fi
+
+	if [[ -f "${ns_path}/resv_enable" ]] ; then
+		test_preempt
+	else
+		SKIP_REASONS+=("missing reservation feature")
+		skipped=true
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	for i in 1 2; do
+		_remove_nvmet_host "$(hostnqn_of "${i}")"
+	done
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000..a0f54bf
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,9 @@
+Running nvme/071
+Preempt another registrant by the holder
+Preempt and abort another registrant by the holder
+Preempt another registrant by the holder of a write exclusive reservation
+Preempt with PRKEY 0 by the holder
+Preempt the holder by itself
+Preempt another registrant by a non-holder
+Preempt the holder by a non-holder
+Test complete
-- 
2.43.0

