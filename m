Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311419;
	b=lfn+wMcVwu1Tq1bLm0WxDWFaL/WbW5KlRR+Y03U948zRhd27cGVPQZ9fJZMSJnNqpzUF
	 yaDukuii0AH7zHYje1LdM2OEd4urPDpT9aW3AI5HkpGwAFvbYqElOfMs+DhdE0/UFO+Xj
	 hvCjCbyTeOCoQ6nxQ1t0Pri5aHN+SFzz0iQuHEVD3pZLeWiKANWVFTklBbi+fDHA1W67G
	 FeLaP8FSDjClJK+9z9MM1PxfQfz595q8EEcT7VDaVkh73gxUrjPhcXuJBAJZ1iRF4cc67
	 mrtszlYHPZZsfivwwS90Ch0LcZyyeto1tnvy9xTDtz9ZMb8nK7qd744E+AL2RALor3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=;
	b=Nozt9xx0L9OtcIQMVjLMHsy6/NsAuH+PkmHib6rq9hTIBV3ZFW4rw86n8Q1vK4Tk0O89
	 rvSJEa8G9VCjR2RgIBrIddVL8hmiO8JUjuSAnfrDvAYwMFrFv6wBS+mqegxNi8uQDppPL
	 bL7PVA6ScXnwi0ER8uFy0mfmO7JyF8FHFprzb+IM5S+ghRJDHHAXUUXYU0Hs0xhrC0vOB
	 /mI5/M+5M6XAEj4UTO5SvgebymINNrr8R9CrUint/9dK/oFOQntRC2O9nInHdkPxaeOLu
	 WW8L096aOmtK7mQ86eddL/bMnoWSV3yI9rRUM0eg2G6UM1R51MLlSZOaoO5FTCQO/FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crusoe.ai;
	spf=pass smtp.mailfrom=crusoe.ai;
	dkim=pass header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=UmTrv8EZ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66C606C63C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 11:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C66C606C63C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=UmTrv8EZ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dee593f18so1260586f8f.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 03:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794311418; x=1794916218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=;
        b=UmTrv8EZlwb2Y9jmjZp74Mndnz2i2BLjVQIPogm/GDzGOg4JsVe+lEbhMwsoN4iK1e
         tHQZ2WNyRPXOfbsgUHPNdlxL/DCyOzc/ba+cYzP4iWLmSMc0qtkT73Lmlm37UDE2dmZ9
         aLw8OkCVY9dLUzmLntt1pFtSWSMIUPqVQ7tbv08K+AJWLmQ2QntW9HPyr2ZAP6wN61qM
         VRUI/0LNOoed7WyHUojqWOFBUyNCGH2QmqTpg+XkFiggljdcOad14wTcq0V66yTnCJ7u
         nRFPGVpfvQDhJdtuj7zSug2Hjx5px5YmKO811pnUN1v2YQBvlif28TM9FgQXfiVvnRoX
         NIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311418; x=1794916218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=If/vmK3q8FUAhPl8Kockqza3omsYZYUwMRxSxvwQVjs=;
        b=xwCYef8292rcIg4ymS+AoqDI8BBTkZPrXEhU8LY9hdZWxfQDxfohypNbk+EqlUeWIU
         BW3jbLc9gQFJtKz01fKupcvAu2gUmc/rqtxOY7WJc5rhjetdp0gwfIE+RnZMvyPyjvoB
         zFOQLakmKeaiX0oFkUlP8MLNIhdMOs/9HJysqErcPWmXe890WwtzaWSqQIiClqzyrl1u
         0G9AfaLcILjWhROS/TfHzprH+Qn64uXO3FCfTfq+pqDOnDXHpbGzyv8cFV1KSIVzfcaL
         JCMdesunFmx6j3Q8Yj8L3l3A8r+hyI6qttQSjkj+EaZrr5NSvfTJaC4gFo2K53oqoofZ
         4MPA==
X-Gm-Message-State: APuU4Z/aU+d/K3tPE9diUHHmrFUrzzmp1UHAfvmerM0xRGqSr9Hf5j8C
	j6U8/pIJPrZzTBQIG+ANt2LPWIyd49OZz52PBi2MzxC0OV1+Eh4qlekBJTK1ATvL+a961yoHFyy
	g47QG5cUsTQ==
X-Gm-Gg: AYBFou1WK04BU5PWqsfYbpxaA2PPMttqUd3nSpmHX7wN6Rw4S3WTHBxnnJ01EBHIe2u
	I9k8pOUtfh6wW2e6wnFGN9dv9kSlW+z3/8ajqif4TkxDC0sCUJc/3n5A7qLfMPxVG0uLnM+jf7I
	qzREJjcdgOoOK6uIYYkGtGjsrA7Qj4lu6566zHkXwwOmJUriDIZ79+iEHnFWqVLwezj4BTElNK2
	aJ3C5qw0eKQEHwnxPnChQ7d3uToNXX0E1jcqD4loAwPMh/Icb2HULPkjhVBVkWEr+dRIvTIdnaH
	lxF1gG1OOz7E/GVIQCnqYOIRWh7kiS/VyRRpjvlAlmcDdAXbD3S4Eciy+fzQYepe+XX1rGpjEVF
	Z24HGmOFwPQOw0CuKztQAeTlfNmtg08N31zaU5d6N9k0qeDj5pyC83llr057ndjW7QrTuiyEtyL
	Uy+CnyZeBJfnLdJ32CG0h2kb+Fy8S/pMR8JrdKv3ijAls3/DrpEnaUBalZPS5hQgwPEJw3VbDdm
	45cI5bohVhLBCS2OieXGvBFF/tWKmDFEUX/gyeB0iZxlS0UYRRAiOcpQCKAtet91ixZriTda19Y
	xW6S3S7zsESy1ugli3mHr8slgaE7AzLGoIV3Pkh5CzyWeSiVCcMywLIUJnMcr/JZ0C9IY7OM9NP
	tfj0ADWDsX937iDK+
X-Received: by 2002:a05:6000:29cb:b0:493:c7aa:7cef with SMTP id ffacd0b85a97d-49830b98240mr2765311f8f.52.1794311417769;
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284cce7sm4839689f8f.8.2026.11.10.03.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-block@vger.kernel.org
Cc: nilay@linux.ibm.com,
	shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: [PATCH blktests v2] nvme/081: test the per-queue io_cpu sysfs attribute
Date: Tue, 10 Nov 2026 11:50:05 +0000
Message-ID: <20261110115005.47367-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
References: <cover.1794015622.git.saravanand@crusoe.ai> <20261107095350.98072-1-saravanand@crusoe.ai> <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme-tcp exposes /sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
so a control plane can choose the CPU that runs each I/O queue's socket
work [1]. Test that

  - io_cpu reads back a written CPU and rejects invalid values
  - managed is read only and turns 0 once io_cpu is written
  - an assignment and the queue directories survive a controller reset
  - the queue directories follow the queue count as attr_qid_max
    shrinks and grows it
  - removing the controller while io_cpu is written completes

The test skips when the kernel does not have the queues/ directory or
the io_cpu attribute.

[1] https://lore.kernel.org/linux-nvme/cover.1794015622.git.saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
Changes since v1 [2]:
- Connect with --nr-io-queues 2 and expect exactly two queue
  directories (Nilay).
- Skip with separate reasons when the queues directory or the io_cpu
  attribute is missing (Nilay).
- Check that queue_count is unchanged across a controller reset and
  that the queue directories match it (Nilay).

[2] https://lore.kernel.org/all/20261107095350.98072-1-saravanand@crusoe.ai/

 tests/nvme/081     | 208 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/081.out |   2 +
 2 files changed, 210 insertions(+)
 create mode 100755 tests/nvme/081
 create mode 100644 tests/nvme/081.out

diff --git a/tests/nvme/081 b/tests/nvme/081
new file mode 100755
index 0000000..0bda988
--- /dev/null
+++ b/tests/nvme/081
@@ -0,0 +1,208 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Saravanan D <saravanand@crusoe.ai>
+#
+# Test the per-queue io_cpu sysfs attribute of nvme-tcp
+
+. tests/nvme/rc
+
+DESCRIPTION="test the per-queue io_cpu sysfs attribute"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype tcp
+	_require_min_cpus 2
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# last CPU in the online list, and the first CPU id past the possible ones
+last_online_cpu() {
+	awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online
+}
+
+first_impossible_cpu() {
+	echo $(( $(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/possible) + 1 ))
+}
+
+nr_queue_dirs() {
+	local nvmedev="$1"
+
+	find "/sys/class/nvme/${nvmedev}/queues" -mindepth 1 -maxdepth 1 \
+		-type d 2>/dev/null | wc -l
+}
+
+# queue_count includes the admin queue
+queue_count() {
+	cat "/sys/class/nvme-fabrics/ctl/$1/queue_count"
+}
+
+expect_queue_dirs() {
+	local nvmedev="$1"
+	local expected="$2"
+	local nr
+
+	nr=$(nr_queue_dirs "${nvmedev}")
+	if [[ "${nr}" -ne "${expected}" ]]; then
+		echo "${nr} queue directories, expected ${expected}"
+		return 1
+	fi
+	return 0
+}
+
+expect_attr() {
+	local file="$1"
+	local expected="$2"
+	local value
+
+	value=$(cat "${file}")
+	if [[ "${value}" != "${expected}" ]]; then
+		echo "${file}: read ${value}, expected ${expected}"
+		return 1
+	fi
+	return 0
+}
+
+test_read_write() {
+	local qdir="$1"
+	local cpu="$2"
+	local bad
+
+	expect_attr "${qdir}/1/managed" 1
+
+	echo "${cpu}" > "${qdir}/1/io_cpu"
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+
+	for bad in "$(first_impossible_cpu)" -2 abc 0x1; do
+		if { echo "${bad}" > "${qdir}/1/io_cpu"; } 2>/dev/null; then
+			echo "io_cpu accepted ${bad}"
+		fi
+	done
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+
+	if { echo 1 > "${qdir}/1/managed"; } 2>/dev/null; then
+		echo "managed is writable"
+	fi
+
+	echo unbound > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	echo -1 > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+test_reset() {
+	local nvmedev="$1"
+	local qdir="$2"
+	local cpu="$3"
+	local count
+
+	count=$(queue_count "${nvmedev}")
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	if [[ "$(queue_count "${nvmedev}")" -ne "${count}" ]]; then
+		echo "queue count $(queue_count "${nvmedev}") after reset," \
+			"expected ${count}"
+	fi
+	expect_queue_dirs "${nvmedev}" $((count - 1))
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+set_qid_max() {
+	local nvmedev="$1"
+	local qid_max="$2"
+	local retries=10
+
+	echo "${qid_max}" > \
+		"${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_qid_max"
+	while [[ "$(queue_count "${nvmedev}")" -ne $((qid_max + 1)) ]]; do
+		if (( retries-- == 0 )); then
+			echo "queue count did not change to $((qid_max + 1))"
+			return 1
+		fi
+		sleep 1
+	done
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	expect_queue_dirs "${nvmedev}" "${qid_max}"
+}
+
+io_cpu_writer() {
+	local qdir="$1"
+	local cpu="$2"
+	local file
+
+	while true; do
+		for file in "${qdir}"/*/io_cpu; do
+			{ echo "${cpu}" > "${file}"; } 2>/dev/null
+			{ echo unbound > "${file}"; } 2>/dev/null
+		done
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local skipped=false
+	local nvmedev qdir cpu writer
+
+	_nvmet_target_setup --blkdev file
+
+	# fabrics caps nr_io_queues at the online CPU count, hence the
+	# _require_min_cpus 2
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2 \
+		--nr-io-queues 2
+	_nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	qdir="/sys/class/nvme/${nvmedev}/queues"
+	cpu=$(last_online_cpu)
+
+	if [[ ! -d "${qdir}" ]]; then
+		SKIP_REASONS+=("missing per-queue sysfs directories")
+		skipped=true
+	elif [[ ! -f "${qdir}/1/io_cpu" ]]; then
+		SKIP_REASONS+=("missing per-queue io_cpu attribute")
+		skipped=true
+	else
+		expect_queue_dirs "${nvmedev}" 2
+		test_read_write "${qdir}" "${cpu}"
+		test_reset "${nvmedev}" "${qdir}" "${cpu}"
+
+		if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+			set_qid_max "${nvmedev}" 1
+			expect_attr "${qdir}/1/io_cpu" "${cpu}"
+			set_qid_max "${nvmedev}" 2
+		fi
+
+		# remove the controller while its queue directories are written
+		io_cpu_writer "${qdir}" "${cpu}" &
+		writer=$!
+		sleep 1
+	fi
+
+	_nvme_disconnect_subsys
+
+	if [[ -n "${writer}" ]]; then
+		kill "${writer}"
+		wait "${writer}" 2>/dev/null
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/081.out b/tests/nvme/081.out
new file mode 100644
index 0000000..5deb638
--- /dev/null
+++ b/tests/nvme/081.out
@@ -0,0 +1,2 @@
+Running nvme/081
+Test complete
-- 
2.56.0

