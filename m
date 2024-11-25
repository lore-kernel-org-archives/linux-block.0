Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212371B87EE
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569059; cv=none; b=opxEDTnKH7RgBj5IiLu8XK9txO3gXoKxe804MjsFJbISGFkBuELinOiODpReK9Ib5Nd2zaKWlqDgiPfTyy4Ys+jIMIBI5wZwkInGjrLveKp6qIevG8IPSBCu78B0wsCc0qSOj+3E7Yxd9qSebkioLQfzU26jwrom1iTZdjb5C6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569059; c=relaxed/simple;
	bh=dUQAKjh55WmijhFumTlOUeOEmtgvgwBkufP4vev5i7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMFSHWUeMD1udDhJ/TTRr6zYXQzhKF3sO113Nr+vBlbQ7HTq9kypsXkOVKIdgkRGKWqAwjW6HT56xMTokSZaJVpcVfzS6yNnuZSrAEAx73BMroMxQ9d0slBtYCk2rypn0HFDyZ+DwSsIyv0jVopOpWRBqV835IY9ZmjAa+tLMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rp8SJUQk; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rp8SJUQk"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Xxyzj3zBFz6CmQwN;
	Mon, 25 Nov 2024 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1732569054; x=1735161055; bh=OpX4poWCTbCcgdBwVAKwl+EuxkRXCSqpL0y
	18mVMOf4=; b=rp8SJUQkiYoABsRpdJiWhtu1wrwdfeGEzvbJwvlpJuCYFIBZLgB
	mSaIPV7qPUNIG4Hthone1ZL85jzIvijytJd6daAya95WyU4ruFWuJrbYfEAVkRAS
	AgTN9MlkI85+NeD8mvVHwtu5d4hewIJi2Pm4RF7S4MqdwyIpBukVd4JcrdJTgHFe
	sYcuCTnjK5/ZZJMity5RDnKq9tOp6aBBOm/ce3b+lEPRM2TZGFrCUHPWVgJStEGr
	uTNqR4BaNX2ctNP8DhzrF6QH+Jk8sx50Z9NY4nyIqAXSbMnEeQJxI2ABMY85Haic
	6VJ71qGBv82ILKOLqCHvv/jtYtNEnKQ5HPA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qVVwwosMs81D; Mon, 25 Nov 2024 21:10:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Xxyzd3tqxz6CmQyl;
	Mon, 25 Nov 2024 21:10:52 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [blktests] zbd/012: Test requeuing of zoned writes and queue freezing
Date: Mon, 25 Nov 2024 13:10:48 -0800
Message-ID: <20241125211048.1694246-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test concurrent requeuing of zoned writes and request queue freezing. Whi=
le
test test passes with kernel 6.9, it triggers a hang with kernels 6.10 an=
d
later. This shows that this hang is a regression introduced by the zone
write plugging code.

sysrq: Show Blocked State
task:(udev-worker)   state:D stack:0     pid:75392 tgid:75392 ppid:2178  =
 flags:0x00000006
Call Trace:
 <TASK>
 __schedule+0x3e8/0x1410
 schedule+0x27/0xf0
 blk_mq_freeze_queue_wait+0x6f/0xa0
 queue_attr_store+0x60/0xc0
 kernfs_fop_write_iter+0x13e/0x1f0
 vfs_write+0x25b/0x420
 ksys_write+0x65/0xe0
 do_syscall_64+0x82/0x160
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/zbd/012     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/012.out |  2 ++
 2 files changed, 72 insertions(+)
 create mode 100644 tests/zbd/012
 create mode 100644 tests/zbd/012.out

diff --git a/tests/zbd/012 b/tests/zbd/012
new file mode 100644
index 000000000000..0551d01011af
--- /dev/null
+++ b/tests/zbd/012
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Google LLC
+
+. tests/scsi/rc
+. common/scsi_debug
+
+DESCRIPTION=3D"test requeuing of zoned writes and queue freezing"
+QUICK=3D1
+
+requires() {
+	_have_fio_zbd_zonemode
+}
+
+toggle_iosched() {
+	while true; do
+		for iosched in none mq-deadline; do
+			echo "${iosched}" > "/sys/class/block/$(basename "$zdev")/queue/sched=
uler"
+			sleep .1
+		done
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local qd=3D1
+	local scsi_debug_params=3D(
+		delay=3D0
+		dev_size_mb=3D1024
+		every_nth=3D$((2 * qd))
+		max_queue=3D"${qd}"
+		opts=3D0x8000          # SDEBUG_OPT_HOST_BUSY
+		sector_size=3D4096
+		statistics=3D1
+		zbc=3Dhost-managed
+		zone_nr_conv=3D0
+		zone_size_mb=3D4
+	)
+	_init_scsi_debug "${scsi_debug_params[@]}" &&
+	local zdev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
+	ls -ld "${zdev}" >>"${FULL}" &&
+	{ toggle_iosched & } &&
+	toggle_iosched_pid=3D$! &&
+	local fio_args=3D(
+		--direct=3D1
+		--filename=3D"${zdev}"
+		--iodepth=3D"${qd}"
+		--ioengine=3Dio_uring
+		--ioscheduler=3Dnone
+		--name=3Dpipeline-zoned-writes
+		--output=3D"${RESULTS_DIR}/fio-output-zbd-092.txt"
+		--runtime=3D"${TIMEOUT:-30}"
+		--rw=3Drandwrite
+		--time_based
+		--zonemode=3Dzbd
+	) &&
+	_run_fio "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=3Dtrue
+
+	kill "${toggle_iosched_pid}" 2>&1
+	_exit_scsi_debug
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/zbd/012.out b/tests/zbd/012.out
new file mode 100644
index 000000000000..8ff654950c5f
--- /dev/null
+++ b/tests/zbd/012.out
@@ -0,0 +1,2 @@
+Running zbd/012
+Test complete
