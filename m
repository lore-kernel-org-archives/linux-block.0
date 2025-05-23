Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDC2063F0
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019029; cv=none; b=Qs1/2i9/H6HEk4NTDKvndZvETDoKtavk2U+rZsMsEUTzAKqEU50SeubwSmG803GzT4fc1Nqf2SlPYgpgnsSEq2t/fxnV2rlW/4YJf3QJVK3RvrrtGWa+6uA8uPDQZDvf/xPJpfbSxQ7P7jUisEr5E407L6wEcRIoTg2/0EOiYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019029; c=relaxed/simple;
	bh=rDT63Qk2UcRNonrXbbWRTJSM7xQEY/7XRoM4X5xRvXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmVQjC1FzRUJRVE52zpRWJSN7NjOBKLwUEvikf6mudStpKkgjAEgpM4FHvNKvd2Vhv84CqXsSZrIidbuUyWtFMDih0oKlS7jXfDdFzLkW9sE1Z355vtLdvGZ3Wo2E6wA9AUiw2h8QOZhNE9F+Ydjm5TFNuTl8davmnBbu5L4b/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lZ1SGgEB; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lZ1SGgEB"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3rkV6b2Pzlsv6K;
	Fri, 23 May 2025 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1748019025; x=1750611026; bh=sI/oeVU0O/42Zi/pTOMDGtHxYBoJqhWA8cc
	enBvSEw8=; b=lZ1SGgEBqaZOuCAkqHccDVk3pS36BZxLu6szMM31OVdeUDH3qsF
	MTOB42vjGbaRDCVeJPvXWtOD/sT1vEiYJD9HCJS7ilmOfct+Zk4stinXiYWW6FZF
	Pism+0VSzd+K8/696fFvbrPWYvNhWpiQeazByt6NusHzwVQlmVyoD0vGH9+V7Vzt
	6lOUerThw2vdUh0ATz7bJxo/t2G39fyFvUcrZ53N8rOx0OCoydkZc7zByaVfDNBP
	6zAMOthoOyLNet2l6adTM9XGa5hk2tIMA9zDhesPh8V7exzSISJvEDxboq2YuQ97
	mDsFM5zUpeuWr2cRhTIt37qG9tjIvkiYK/A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0Y-9binsC0op; Fri, 23 May 2025 16:50:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3rkQ46VrzlgqyV;
	Fri, 23 May 2025 16:50:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Date: Fri, 23 May 2025 09:49:55 -0700
Message-ID: <20250523164956.883024-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since there is no test yet in the blktests repository for a device mapper
driver stacked on top of a zoned block device, add such a test. This test
triggers the following deadlock in kernel versions 6.10..6.14:

Call Trace:
 <TASK>
 __schedule+0x43f/0x12f0
 schedule+0x27/0xf0
 __bio_queue_enter+0x10e/0x230
 __submit_bio+0xf0/0x280
 submit_bio_noacct_nocheck+0x185/0x3d0
 blk_zone_wplug_bio_work+0x1ad/0x1f0
 process_one_work+0x17b/0x330
 worker_thread+0x2ce/0x3f0
 kthread+0xec/0x220
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Call Trace:
 <TASK>
 __schedule+0x43f/0x12f0
 schedule+0x27/0xf0
 blk_mq_freeze_queue_wait+0x6f/0xa0
 queue_attr_store+0x14f/0x1b0
 kernfs_fop_write_iter+0x13b/0x1f0
 vfs_write+0x253/0x420
 ksys_write+0x64/0xe0
 do_syscall_64+0x82/0x160
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/zbd/013     | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/013.out |   2 +
 2 files changed, 112 insertions(+)
 create mode 100755 tests/zbd/013
 create mode 100644 tests/zbd/013.out

diff --git a/tests/zbd/013 b/tests/zbd/013
new file mode 100755
index 000000000000..88aea23ee68a
--- /dev/null
+++ b/tests/zbd/013
@@ -0,0 +1,110 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Google LLC
+
+. tests/zbd/rc
+. common/null_blk
+
+DESCRIPTION=3D"test stacked drivers and queue freezing"
+QUICK=3D1
+
+requires() {
+	_have_driver dm-crypt
+	_have_fio
+	_have_module null_blk
+	_have_program cryptsetup
+}
+
+# Trigger blk_mq_freeze_queue() repeatedly because there is a bug in the
+# Linux kernel 6.10..6.14 zoned block device code that triggers a deadlo=
ck
+# between zoned writes and queue freezing.
+queue_freeze_loop() {
+	while true; do
+		echo 4 >"$1"
+		sleep .1
+		echo 8 >"$1"
+		sleep .1
+	done
+}
+
+test() {
+	set -e
+
+	echo "Running ${TEST_NAME}"
+
+	_init_null_blk nr_devices=3D0 queue_mode=3D2
+
+	# A small conventional block device for the LUKS header.
+	local null_blk_params=3D(
+		blocksize=3D4096
+		completion_nsec=3D0
+		memory_backed=3D1
+		size=3D4            # MiB
+		submit_queues=3D1
+		power=3D1
+	)
+	_configure_null_blk nullb0 "${null_blk_params[@]}"
+	local hdev=3D/dev/nullb0
+
+	# A larger zoned block device for the data.
+	local null_blk_params=3D(
+		blocksize=3D4096
+		completion_nsec=3D0
+		memory_backed=3D1
+		size=3D1024         # MiB
+		submit_queues=3D1
+		zoned=3D1
+		power=3D1
+	)
+	_configure_null_blk nullb1 "${null_blk_params[@]}"
+	local zdev=3D/dev/nullb1
+
+	local luks_passphrase=3Dthis-passphrase-is-not-secret
+	{ echo "${luks_passphrase}" |
+		  cryptsetup luksFormat --batch-mode ${zdev} \
+			     --header ${hdev}; }
+	local luks_vol_name=3Dzbd-013
+	{ echo "${luks_passphrase}" |
+		  cryptsetup luksOpen \
+			     --batch-mode "${zdev}" "${luks_vol_name}" \
+			     --header ${hdev}; }
+	local luksdev=3D"/dev/mapper/${luks_vol_name}"
+	local dmdev
+	dmdev=3D"$(basename "$(readlink "${luksdev}")")"
+	ls -ld "${hdev}" "${zdev}" "${luksdev}" "/dev/${dmdev}" >>"${FULL}"
+	local zdev_basename
+	zdev_basename=3D$(basename "$zdev")
+	local max_sectors_zdev
+	max_sectors_zdev=3D/sys/block/"${zdev_basename}"/queue/max_sectors_kb
+	echo 4 > "${max_sectors_zdev}"
+	echo "${zdev_basename}: max_sectors_kb=3D$(<"${max_sectors_zdev}")" >>"=
${FULL}"
+	local max_sectors_dm
+	max_sectors_dm=3D/sys/block/"${dmdev}"/queue/max_sectors_kb
+	echo "${dmdev}: max_sectors_kb=3D$(<"${max_sectors_dm}")" >>"${FULL}"
+	queue_freeze_loop /sys/block/"$dmdev"/queue/read_ahead_kb &
+	local loop_pid=3D$!
+	local fio_args=3D(
+		--bs=3D64M
+		--direct=3D1
+		--filename=3D"${luksdev}"
+		--runtime=3D"$TIMEOUT"
+		--time_based
+		--zonemode=3Dzbd
+	)
+	if ! _run_fio_verify_io "${fio_args[@]}" >>"${FULL}" 2>&1; then
+		fail=3Dtrue
+	fi
+
+	set +e
+
+	kill "${loop_pid}"
+	cryptsetup luksClose "${luks_vol_name}"
+	_exit_null_blk
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/zbd/013.out b/tests/zbd/013.out
new file mode 100644
index 000000000000..afc2364a9b73
--- /dev/null
+++ b/tests/zbd/013.out
@@ -0,0 +1,2 @@
+Running zbd/013
+Test complete
