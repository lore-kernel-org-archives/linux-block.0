Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796897;
	b=Eakt5gYO3Nqz1QwwlfS2cxQb9B+olyVi6sGKXbHSK4dywCE7necJg5IXiaVQjXbx6P9z
	 UdhOF26/tdTCiRbD1lnF3gVLcxvEULPbXMt7f4tth88XlZ3I81SQIsP1R9BUALXoalwZo
	 h2aXJvESKXOXtIKqKoYQmKdQQQGVY8/PufeATafRMvalO/+gfCaQvKadZFLF+EExYSV4T
	 yYIC76sbOJm631lQoijN9tKYmBYA6mMzoF86dXmyHbw787/Pq+X7XTjzelF2ZGaxlJ8FR
	 onjHnUMFg1zH5O4pi+QPvETnarPGBHHb834/YpisEVhm7rmd6/cL+PGh84z/gk9S93A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=;
	b=RwlhsZYiazTSLB0aJDy/StLfDp50nGFSqZI/VoJq6VxBr+uAhBlkjaf0jiIa6NRN0A+K
	 0DTCZQr8UuOvtkzsoRwPf5FSNIPtheLDOhb7UmMZN8AffPdEhH8+PrZtj8vDSlRibVUOY
	 fjpG2015M5ZNAmUSDfWLkafHtsxa98lrdmFtKS6c9yGcTK/OnJ8QxFganQ43drEo7sGev
	 OhqjjUWVL9dp/bK/PvQ4wbM8idHvdSE84Hp2b0dYgDKpkeLBEQ2dcl4m5YiGfKeyLztGe
	 xXaPNzIAzcY8tjZt19K3+K3X6slXGll/OY9IONwlRY3yKHt47xOA5+/OzSBl3LgnMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crusoe.ai;
	spf=pass smtp.mailfrom=crusoe.ai;
	dkim=pass header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=bYCVpUYG;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F80606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 23:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=bYCVpUYG
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so3136436eec.0
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792796896; x=1793401696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=;
        b=bYCVpUYG0L79yuD9/zd7o2hmLFxR5N711zd+mDlVnTAkZaYtFQnhmWqBK/LCUuRlfp
         eiU2hVVzCd5OwgkWQ3GQko5JgmeiqgDMLSE+KcJG/zpq9YwLA5eSrfyCinlB4d0NRYQY
         Do+wm2VN+bhc15SGixUMC6K5z0bRsOeiC/6VF5vArniV4JFfIbCLMXX3g5gizP4XOtaJ
         qOgaUa9ZCCVzca9sPR0VPNhdwwTdIA14cJeu7aw/APK9LgjsyB+wxGBsIU/cJSL/vpU8
         6KY9NtOl2Ji+0MZxIdR40z2dlQjWq6HSxW9F2K9AiloTpyD/CYC2fEot02j6ULt76u+J
         YLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796896; x=1793401696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9L1Mat+6X086VUXklbKnyMh21SlSOD3u0b/WuUZumAQ=;
        b=fG1EZWX12v9Mb/jq/srlpai78tkOYbVYbapGNVJYsCGb65Bv6PrzNSBjp9vYIHVgLw
         WG6+OeOJ2Oub+iu3QKwrKVI6YZ6nUA8H44prvkiM22NuGpR3VsiEEKfV0nqgktJV/JMX
         MH56oH6KpTvoF5VFC6nHC1GlsQ0Qek0F0jI2sNpKL7cxmxbEEWn+XI0ycd4kuj/o4cKo
         sLbZImjfONagqQ4+B6FEEM7KCpECRUAO9aXQk9VknjwAHO+IxW3/D59ckGVBCJxMD98O
         jFORbtqA3pWWExL8wrdgE/3FAoklbVyzAuTALcFSGCf0t3alU9hLdRu03eHjveihj4gY
         Gtfw==
X-Gm-Message-State: AFq9FYITAb8sFUTEMyJ6ANqp0q7Du7YrxCFaWKoJ90YxRP2AL+KlWizt
	NDSG+/6bljsK6zYvJqn05nKKen17crboKu0heRdXh6i/naNbCxPhht65ltmCK2OWDVzViUN7t6O
	KG3foiaM=
X-Gm-Gg: AYBFou2rmZr3cIajG749GSWzhBYz4PXbbjj8Q18yw0kH76LXGK3Q1H9dgawvLoFchev
	4OiYCv8ksebMZ043GbCCrvS5XI2XrB33DH6ryDZbT6eKrB+qWntcKPrzZb0xZx/mfzxu2lxwZxp
	/n2Cr87Ya7rOk0f8k8XGEmqVf1HwlIrCitcDCAq+7WQkRUWTFm8BArCzfyUe1iMrlknXQBI6LxR
	8JTFm6a0Z0As7Cas/UWOUo1EhpB0K7H97TyVdgq39bM2GhJjzQfE9YaMHLLXfmjAsMzwSSC8JOv
	JtDTWvQeW3xzdjANw2hHhhpMWFrEOm2NBQajGeiUHI9J2IJqJR5A/qGaQSuD3C2QAlR6xaKjw4E
	81MZ0L0BJnve0eZhTNwYoU5ysqXxmzJcj3jxvgv8QEUGqJHtWRdjMvwwYRorP0t8QAcDhXk1RFh
	MbbZ2EZYisfsdOuxlUSi+uDMBurusmGQ6h+XporA8NO0Lr8Dsk1y8NQZW4TvLvWMvruFanGA9mc
	F0ECCEQ6BHs3o+DdCZt4wsjZr/Of6i19rlitOcRoR4EEkj5BWMB6IZqP+u6gZDnjs9KO1dGnqKB
	Jv2RV0JckWZAM7pqY25PA39mYw==
X-Received: by 2002:a05:693c:415a:10b0:35a:7020:c08a with SMTP id 5a478bee46e88-369e846b175mr1112370eec.19.1792796895656;
        Fri, 23 Oct 2026 16:08:15 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d578casm1357561eec.6.2026.10.23.16.08.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 16:08:15 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	nilay@linux.ibm.com,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH blktests] nvme/075: test the per-queue io_cpu sysfs attribute
Date: Fri, 23 Oct 2026 16:08:09 -0700
Message-ID: <20261023230809.7869-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023230426.6425-1-saravanand@crusoe.ai>
References: <20261023230426.6425-1-saravanand@crusoe.ai>
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
  - an assignment survives a controller reset
  - the queue directories follow the queue count as attr_qid_max
    shrinks and grows it
  - removing the controller while io_cpu is written completes

The test skips when the kernel does not have the attribute.

[1] https://lore.kernel.org/linux-nvme/20261018010059.83120-1-saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
This tests the kernel series in the parent thread, which is under
review on linux-nvme.

 tests/nvme/075     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/075.out |   2 +
 2 files changed, 187 insertions(+)
 create mode 100755 tests/nvme/075
 create mode 100644 tests/nvme/075.out

diff --git a/tests/nvme/075 b/tests/nvme/075
new file mode 100755
index 0000000..0b4bce5
--- /dev/null
+++ b/tests/nvme/075
@@ -0,0 +1,185 @@
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
+
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+set_qid_max() {
+	local nvmedev="$1"
+	local qid_max="$2"
+	local queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+	local retries=10
+
+	echo "${qid_max}" > \
+		"${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_qid_max"
+	while [[ "$(cat "${queue_count_file}")" -ne $((qid_max + 1)) ]]; do
+		if (( retries-- == 0 )); then
+			echo "queue count did not change to $((qid_max + 1))"
+			return 1
+		fi
+		sleep 1
+	done
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	if [[ "$(nr_queue_dirs "${nvmedev}")" -ne "${qid_max}" ]]; then
+		echo "$(nr_queue_dirs "${nvmedev}") queue directories," \
+			"expected ${qid_max}"
+		return 1
+	fi
+	return 0
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
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2
+	_nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	qdir="/sys/class/nvme/${nvmedev}/queues"
+	cpu=$(last_online_cpu)
+
+	if [[ ! -f "${qdir}/1/io_cpu" ]]; then
+		SKIP_REASONS+=("missing per-queue io_cpu attribute")
+		skipped=true
+	elif [[ "$(nr_queue_dirs "${nvmedev}")" -lt 2 ]]; then
+		SKIP_REASONS+=("controller has fewer than 2 I/O queues")
+		skipped=true
+	else
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
diff --git a/tests/nvme/075.out b/tests/nvme/075.out
new file mode 100644
index 0000000..0613dfa
--- /dev/null
+++ b/tests/nvme/075.out
@@ -0,0 +1,2 @@
+Running nvme/075
+Test complete
-- 
2.55.0

