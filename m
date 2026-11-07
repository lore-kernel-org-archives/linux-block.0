Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045241;
	b=Z8Ek4fKCKpIdIgVmTfTnu298txwuKODL86gAI0+7WX9uwPoXQ4LZcFak6qgeo32UP4Xh
	 kZ7hCEhDe5dieJlae7viKsaOlItCEtRhDwVAxvcjqxlotfT9AmxDQLIwrzlClK2OGCQPI
	 Am6W9o94xgM1SVF4KBfXjKinp0zPJsIL+vksa+UxTUg/sgtXo/BZpQP1KFC6WNcvEPshy
	 Ckae0GAr4xZifEf+pH8y3aQXurYkE78KjOrXiIcEHxQQVnQhCuZePMA1tSnlhnnETJUx3
	 MhhcKcMs8KM1z827BsynW7somlPjisHMOw8Fuu0fyBfbraL8O0nU4MmF831mP1sHgSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ugr++g63dOTUo7x25BdGTGymn/sa1cS2lNnytoYqYMM=;
	b=wU+xS9hd48HnuyciWRC9tkBdKLjakNQ0WddZpLb+rava7Rco2TWNRYeTSncKlHPEkWOm
	 uMOf+FrEbewc2jbBWGyH6OrksqKCWBefLVzp+hKcdjgQmRRWWiKVvHmWnm4xV6qESvRyb
	 B5afDYVtnDRwP8kuAJJ2+E+29ZW30A1rkEzfoSd7YN8PHFVxPMeV7wV40kMW/vNPvPsCK
	 8fGy3MaWmbq5F//xXsIp/luL6LZNjtQUS6wyl47px03UFgD2r21oG7NC1Cn+5bt+VaGNf
	 SyQanf8a/htTivP6o4HrYaxjh2Pr/bVHP/amTX0UNVw0Jj0YSAwruC9O7BSLXaGa+bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crusoe.ai;
	spf=pass smtp.mailfrom=crusoe.ai;
	dkim=pass header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=EKnLvBQr;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE4606A33C
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 09:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28AE4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=EKnLvBQr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so13183425e9.1
        for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794045239; x=1794650039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ugr++g63dOTUo7x25BdGTGymn/sa1cS2lNnytoYqYMM=;
        b=EKnLvBQrq6PTqF/vhcJHnNiraMd50x39EHAjEuI0befUxiUrebHixe0X1ytkw9unqK
         C8x+YYmyoS/KQTKbO8FlVSP802iJifueTKMtfr02tg/wzKQef7cXOR9SNuxrtGjPrO/7
         gYc4SHEpoKc2r84UTwgB42ihRvbsELHXPngZ8jmgYxdkJWHP61XiV6hAp6JXWDhmUZ99
         MKvEnbEWi1FC2Bt/M2yBu84CgNSDzi4aezddJHec9UeYyVRhBdnOpni190R6GpZ1W3TC
         gynS/EYGL9B1gLNkf8W/WXHPTYid2ZSFw2tx7kX8vFdGJDMbUDl4BNF0wNa1wnJ+V8eH
         AaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045239; x=1794650039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ugr++g63dOTUo7x25BdGTGymn/sa1cS2lNnytoYqYMM=;
        b=ZXTvW/j+wqfSI41YuzRXqG5HjTzqH5OTyHwUOaBflMefQBe5bKXIxLWDUr1oBi/SzL
         eKPkybPPzbBCIXkYOTwpgGaEy7732ckhzlqydWEaqGKTahXWzJ7U0BFUtOL6iK9F/sJE
         rTO329iF+nvNhD+5r15odMwckQHAS7O10rq1/H8WiMeriDdPDxCTZ31uNWNkerwmerSB
         Qn1kpcWKY8Umf5iPb6eXf41pI3irVwe5CfHR+mXL75d5Am+QG0rqv8QfKoA0GWywYScz
         LaYGMyt66HslaT3ItM/yhFfG2tjoE7vWcqoHWoN+7P5sw8RN1J/oS6FCwgxS/sq1Srvh
         GT/g==
X-Gm-Message-State: APuU4Z8+Det/VVM2Y/fxwehBp3KanKlZht+cHOr0ZvdIfWTj/ssX1EmP
	TXgppJOQRu+TudGOedf8ADOOXVIb087kLbbRFD5EslWmVgiuHAINdWXBZWoCdzKnw+BSEjQTYuT
	Zuw53WxkNUw==
X-Gm-Gg: AYBFou0e204aCBa79ViGk56w1KWxm7KqGWwDl5kM3OkRbdQlyKNAXFzCR8BCtu/uerF
	5o3Ul1nQR1WvGJQko0BB8QDmd2dv+M5uXlTVtzuuYaVD7QCWjrMtuWyj5TUXZOqxHwUs651tI/F
	ZPCnIrdCH8rGVlyJnA7cpYM1gf0Z9nthnkuRWU2+rvj5ZRIANw9i9CIABlVFECpk97AScbyOqor
	Y8gH5ZbpUyye3igKhHH25k9uefYJs1IUxm03PN6jE+Z1E0bYdukfs5sYb3MZ3sSOdJQEapa9qNi
	SWBAt6AmxcUlZEirJ9yvfdrpocQN1j0YOP7rAqQXXGarH3jR692HEEK5ofAAbl6kEXeywkcjxCY
	Mny7hoYO4oP4gtMf0zo+cIeWD92HLSN6Uyhc/N/D6sfrKYtzvgUFMaRu0b/Phb4B6I9hmRV7fCP
	7lZXUxv9zKeUqDi8yKTL0WuIDYy/0580yJWC8OERTlkxOR1XbHBeHX5Qfhu5DPn/eEz+Ua7jTv3
	twBOH2zcPQZWjkm096+nnfJCMnrXdaMQJ+4MxYG0tijXy2hbb03M1qxZ0V+gGe2Q+qggIz8pagq
	lfEWzGrEfhW0mjTk26+vYVW5nQ5WhXz8+nnK0zMwG3jslLpCZ4CtTDgO/kptXXkGm5yqpSU0Ng=
	=
X-Received: by 2002:a05:600c:4454:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4b6dfba8640mr90223975e9.23.1794045239588;
        Sat, 07 Nov 2026 01:53:59 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([185.57.101.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm69546605e9.1.2026.11.07.01.53.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 01:53:59 -0800 (PST)
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
Subject: [PATCH blktests] nvme/081: test the per-queue io_cpu sysfs attribute
Date: Sat,  7 Nov 2026 09:53:50 +0000
Message-ID: <20261107095350.98072-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794015622.git.saravanand@crusoe.ai>
References: <cover.1794015622.git.saravanand@crusoe.ai>
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

[1] https://lore.kernel.org/linux-nvme/cover.1794015622.git.saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
This is the nvme/077 test posted with v7 [2], renumbered because other
pending blktests patches use nvme/076 to nvme/080. The test itself is
unchanged.

[2] https://lore.kernel.org/all/20261104140721.4489-1-saravanand@crusoe.ai/

 tests/nvme/081     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/081.out |   2 +
 2 files changed, 187 insertions(+)
 create mode 100755 tests/nvme/081
 create mode 100644 tests/nvme/081.out

diff --git a/tests/nvme/081 b/tests/nvme/081
new file mode 100755
index 0000000..0b4bce5
--- /dev/null
+++ b/tests/nvme/081
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

