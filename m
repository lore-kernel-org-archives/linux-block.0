Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096F455606
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024426; cv=none; b=F09UfppjYdIyVHAi/gDd2OU/CGqMp4M2ooHdqNQGKtx4+plDKYpHmXPjESxIYVGlGmZ58sGrZsZ9THMp8q/tTLCDyHzKQylMBWZ4mdVOX/ajByZmUt/hLwh+Fsm0zwBXRFqpFVuVsvSzXgCcdbk7TlxiEaAC9dYWyI/THvpcnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024426; c=relaxed/simple;
	bh=GjAxKLy+axJVTeCuJLWowsU0JOzvm/1d2H/T4YCZwdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQrdi+SDZjPV9mK0NPpl4PD3HqWA+1FFJ1+yWEDirFGKBtGEOMkwOzqpA0EltFpuxeOyLGwFq+DYiaDSdf3uuN19TjaTVYUV6/JbxRYVmsufv0xJeU1KJopjJRXg9xt/qMxE6Af+f9OyM1RxgDdYXNZiMiyWNEAqczdt+Mnli4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VDKpBXyc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VDKpBXyc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so18684745e9.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790024422; x=1790629222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SxiX7ykUuzFoB5u8OW7JZMlOwhEiuup8UcQvf/vvFTw=;
        b=VDKpBXyc2dCflVzt1nTXu5ZU5Bcip5oV6+/JawYVXNV4I8VqQJEFQISLNEkpvo54Nv
         wuI43mNAMtOethChFJVxotaKEwnZYg7lSifBSpzc8UFWmLLIe2YD+r4R8YpuV4PdT3t9
         fR8Cjd7/cCvPp2XlRZLtusaREUaenA4LdP8yuv9K5HRb3Tse7oflAuP31Hg035oQ9zUC
         bjTvQZHbS9fOhXVAIjt0/7KfyAKsdXux+QFvHY/aRAxXavbUQ+gdNVTy2X+e1SjDRT/D
         80jutbUK5aCr+evYM/7Td+PJbWLGB/vb9wkkBYN+W1/7yALxLgYr/gJxxygj4fDZUD16
         ZvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024422; x=1790629222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxiX7ykUuzFoB5u8OW7JZMlOwhEiuup8UcQvf/vvFTw=;
        b=1TeGVHuUtsGyCdwzo40uT7NyX5oZpP+AyNFRb5hzrKwuoiTVetA/n1q+b2qB+ZQO7G
         z32dg7IpD4CMpouK2OZ28HNG4FLsBBxiSboP7r69rm6ieA8mmGdlLeVb4KOD8OLedgsB
         yKMI9tLz+eq4EAAofL0N6YKIWjsDBngIi30LmVaHoAs8v9kEi0sAVn2uFUBttaCW4GlT
         PdzeWLpHY+Vbb53vlHWzYdlK4jUCeSIoYesNyk5elE8QKomd7gdJ5ZjskD9DcXo+2052
         yIMwxAXGkg/XwJAnykYaSdIIOMQbA0o4dpZtyat8Yp3Zyu8L1B5hHIloZ9tGF9t3RsSf
         ng6Q==
X-Gm-Message-State: AFuF++mK/Bk8HkLuzAhAIxGSKhrXZi7IAJb716VtyuU5RL0sPCA0mkLu
	kwdLYrlcbQO8A6GF+gMVafo5P/qmasVD8wxZbSb8CLNK2nmkXq/REzuQVY/7qkFFAJ4+wlpTG7Z
	tXM4p/wbqfVG6KEaImKQ5+982D2hG5aL7NC3HbJICCmdEbt/b1G4p+WuimZgauTGLfxEnaTK4hZ
	ZCFyKokbObwYzVQj4Q9+NCZ7vrq4f0Sv79EaVrC7ckWSZq5wJa/p0N57c=
X-Gm-Gg: AYBFou36b8IfJSKC1Q0If8NaxteddtHgYVsvCLnnmuKY/FPGMv3mQ1Ya8d1upkpy/M/
	RupJSDLt+k9Mixjm5B4vMIjWM55bVE22zEhsUJObskzLy25CJma5FrdMBKpmNOzgQwR6wRVvv4m
	evGO83fVuJmRuLzNvUP1fUgNSq7RoRo2pQ6doiF6Xqg1oyR3MxJbY40O6sAjcq+pjj969s3RIYT
	gFlGQofq/s/IpLBLfknZRRFJZ0n2eEBxC+MsUHe9+rLFZPw3E3MbJ9VR2P4L7kZj1CKORRqc7M1
	49L+CrBQPcCAImMr2b/i0YU9F4KIL60wk7sLSZrcOJqhnmxd9Tlw1mwWbQ1Q8FRUUFYmaC+mPKM
	oSYC/eKIpta6ZGF+T9VZA8P3DymSfGfmmvZzcBcvF5YO40bt+izsIkj/XA6YcxbJf1VhDoROn8s
	IZjw+OvBp7IkD9Cx/0eXtMxMkHXTs/GkNklU+fZAYKao0c37TLpSGtE1pHs/g9XhR60+16YLSgX
	QkF7iXPTZQ+wmn8c9eqF+jN1bsXmHDWoTeMLU0=
X-Received: by 2002:a05:600c:1993:b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49fc56dbc54mr169802245e9.3.1790024421579;
        Mon, 21 Sep 2026 14:00:21 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fda089577sm3345565e9.1.2026.09.21.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:00:20 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests] nvme/071: test CCR and CQT recovery on a multipath fabrics namespace
Date: Mon, 21 Sep 2026 14:59:51 -0600
Message-ID: <20260921205951.3023714-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme/070 demonstrated the ABA ghost write window. The kernel closes it
by fencing a controller before retrying timed-out writes on another
path, but nvme/070 does not functionally exercise CCR or CQT
themselves.

Add a functional test that drives both cross-controller reset (CCR)
and command quiesce time (CQT) recovery. The setup is the same as
nvme/070: a ublk loop device backs an nvmet namespace that is exported
through two ports, the host connects to both paths, and io_timeout on
the subsystem drops to 2 seconds. In addition, the target subsystem's
CQT is set to 30 seconds, since it is disabled by default.

The first scenario holds one write in the backstore for 4 seconds. The
host times the write out, starts fencing, and the CCR issued on the
other path completes within its budget. The second scenario holds a
write for 10 seconds, longer than CCR can wait, so the host gives up
on CCR and switches to time-based recovery, waiting out the remaining
CQT window before releasing the retry.

Each scenario runs nvme-ghost-write-detector while recovery is in flight
to check that no stale data surfaces, and confirms the recovery took the
expected route by watching dmesg after a marker written to /dev/kmsg.

The test requires nvme_core.multipath=Y and is limited to tcp, rdma
and fc, the transports that implement controller fencing.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 tests/nvme/071     | 184 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  67 +++++++++++++++++
 2 files changed, 251 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..d700416
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,184 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Mohamed Khalfella
+
+. tests/nvme/rc
+. common/ublk
+
+DESCRIPTION="CCR/CQT functional test"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_ublk
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype tcp rdma fc
+	_have_src_program nvme-ghost-write-detector
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+count_paths_to_subsystem() {
+	local subsysnqn="$1"
+	local dev count
+
+	count=0
+	for dev in /sys/class/nvme/nvme*; do
+		[[ -e "${dev}/subsysnqn" ]] || continue
+		[[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
+		count=$(( count + 1 ))
+	done
+	echo "${count}"
+}
+
+set_io_timeout_of_subsystem() {
+	local subsysnqn="$1"
+	local timeout="$2"
+	local dev
+
+	for dev in /sys/class/nvme/nvme*; do
+		[[ -e "${dev}/subsysnqn" ]] || continue
+		[[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
+		if ! echo "${timeout}" > "${dev}/io_timeout" 2> /dev/null; then
+			echo "FAIL: can not set io_timeout on ${dev##*/}"
+			return 1
+		fi
+	done
+}
+
+dmesg_mark() {
+	local marker="blktests ${TEST_NAME} $1"
+
+	echo "${marker}" >> /dev/kmsg
+	echo "${marker}"
+}
+
+dmesg_since_mark() {
+	dmesg | awk -v m="$1" 'index($0, m) { found = 1; next } found'
+}
+
+wait_for_dmesg_after_mark() {
+	local mark="$1"
+	local pattern="$2"
+	local timeout="$3"
+	local i
+
+	for ((i = 0; i < timeout * 2; i++)); do
+		if dmesg_since_mark "${mark}" | grep -q -e "${pattern}"; then
+			return 0
+		fi
+		sleep 0.5
+	done
+	return 1
+}
+
+test_injecting_delay_ccr_recovery() {
+	local mark ns
+
+	mark=$(dmesg_mark "ccr_recovery_started")
+
+	if ! ${UBLK_PROG} inject -n 0 -o write -d 4 -c 1 >> "$FULL" 2>&1; then
+		echo "FAIL: can not inject write delay"
+	fi
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	"$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"
+
+	# The injected delay is within the limits that CCR can handle.
+	# Expect fencing to start and CCR to succeed.
+	if ! wait_for_dmesg_after_mark "${mark}" "starting controller fencing" 30; then
+		echo "FAIL: controller fencing did not start"
+	fi
+
+	if ! wait_for_dmesg_after_mark "${mark}" "CCR succeeded using nvme" 30; then
+		echo "FAIL: cross controller reset did not succeed"
+	fi
+}
+
+test_injecting_delay_cqt_recovery() {
+	local mark ns
+
+	mark=$(dmesg_mark "cqt_recovery_started")
+
+	if ! ${UBLK_PROG} inject -n 0 -o write -d 10 -c 1 >> "$FULL" 2>&1; then
+		echo "FAIL: can not inject write delay"
+	fi
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	"$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"
+
+	# The injected delay is outside the limit that CCR can handle.
+	# Expect CCR to fail and CQT to save the day.
+	if ! wait_for_dmesg_after_mark "${mark}" "starting controller fencing" 30; then
+		echo "FAIL: controller fencing did not start"
+	fi
+
+	if ! wait_for_dmesg_after_mark "${mark}" "attempting CCR" 30; then
+		echo "FAIL: cross controller reset was not attempted"
+	fi
+
+	if ! wait_for_dmesg_after_mark "${mark}" "CCR failed, switch to time-based recovery" 30; then
+		echo "FAIL: cross controller did not fail as expected"
+	fi
+
+	if ! wait_for_dmesg_after_mark "${mark}" "Time-based recovery finished" 30; then
+		echo "FAIL: expected to see time-based recovery ends"
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local port nr_paths
+	local attr_cqt
+	local -a ports
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	truncate -s "${NVME_IMG_SIZE}" "${TMPDIR}/ublk-img"
+	if ! ${UBLK_PROG} add -t loop -f "${TMPDIR}/ublk-img" -n 0 > "$FULL" 2>&1; then
+		echo "fail to add ublk device"
+		_exit_ublk
+		return 1
+	fi
+	udevadm settle
+
+	_setup_nvmet
+	_nvmet_target_setup --ports 2 --blkdev none
+	_create_nvmet_ns --blkdev /dev/ublkb0 \
+		--uuid "${def_subsys_uuid}" > /dev/null
+
+	# CQT is disabled by default, enable it for 30s
+	attr_cqt="${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_cqt"
+	if [[ -f "${attr_cqt}" ]]; then
+		echo 30000 > "${attr_cqt}"
+	else
+		echo "FAIL: failed to find attr_cqt: ${attr_cqt}"
+	fi
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	echo "Target ports: ${#ports[@]}"
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}"
+	done
+
+	nr_paths=$(count_paths_to_subsystem "${def_subsysnqn}")
+	if ((  nr_paths != 2 )); then
+		echo "FAIL: expected 2 paths, found ${nr_paths}"
+	fi
+
+	set_io_timeout_of_subsystem "${def_subsysnqn}" 2000
+
+	test_injecting_delay_ccr_recovery
+
+	test_injecting_delay_cqt_recovery
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	_exit_ublk
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000..f55eefb
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,67 @@
+Running nvme/071
+Target ports: 2
+starting nvme-ghost-write-detector test program
+iteration number 0, writing data
+validating written data
+successfully validated
+iteration number 1, writing data
+validating written data
+successfully validated
+iteration number 2, writing data
+validating written data
+successfully validated
+iteration number 3, writing data
+validating written data
+successfully validated
+iteration number 4, writing data
+validating written data
+successfully validated
+iteration number 5, writing data
+validating written data
+successfully validated
+iteration number 6, writing data
+validating written data
+successfully validated
+iteration number 7, writing data
+validating written data
+successfully validated
+iteration number 8, writing data
+validating written data
+successfully validated
+iteration number 9, writing data
+validating written data
+successfully validated
+finished nvme-ghost-write-detector test program
+starting nvme-ghost-write-detector test program
+iteration number 0, writing data
+validating written data
+successfully validated
+iteration number 1, writing data
+validating written data
+successfully validated
+iteration number 2, writing data
+validating written data
+successfully validated
+iteration number 3, writing data
+validating written data
+successfully validated
+iteration number 4, writing data
+validating written data
+successfully validated
+iteration number 5, writing data
+validating written data
+successfully validated
+iteration number 6, writing data
+validating written data
+successfully validated
+iteration number 7, writing data
+validating written data
+successfully validated
+iteration number 8, writing data
+validating written data
+successfully validated
+iteration number 9, writing data
+validating written data
+successfully validated
+finished nvme-ghost-write-detector test program
+Test complete
-- 
2.55.0

