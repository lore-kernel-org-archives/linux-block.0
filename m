Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802336;
	b=PhG2TVQs4aguwK0nLgQehCEW4jLbQa7Ph3BAD6wPJd8qGsvYpfjGY5QxBlJufBd7Gaoo
	 pE3d5UoJmEVBf8A484V/faCIOsx1XL6m7JzChKKNCpVXMDbjwahzVgyO6TIgIqvvG+Yjr
	 e9t5YNU/0bT2Vb+I0R+ykcDJp8fBfx7hIofvakkoAriIFudBvMlTyWWcuRBBl5S5YjPD9
	 C1n0HbUKEQiHotKp1ai9zW7EwYvVPOHSoh74FQ9VeOTw7fmCoAqiS+QXfnEDCKfY1C10x
	 dCKQ/x59Fh8uo+je3puQQudD8RQhFifHDuzucDGpPDsoW/Cb6mcpo9VNDma2/Pk9psQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802336;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=vzfh1eP6a7zWDBwYoJP9movq1234lrvQ2gCxaKajCw0=;
	b=VkaH14J8udv1logRIR5hBsf1IjNPobzoKKogZD/TDWyKebC1c7uLJDEnypoCtHIkXJZ5
	 c29JjsANzVuDlHop2np5Cu2u04Zb85voyMgmayBU7O6h64Ku80Y2JccLPsQiV0aZ2xEyc
	 nqdb9fv1X9L2DjTslpQ3jWi81HmCfgFtNIkE0/Rpg5W0kfm7vCNT2m6wJOM5dnPyO3CO2
	 VTWoTv9X8sq6/iMer8q30J7JbRpG8B8eCxbNcQZGpGyOAbdaZJ85cn881klJr//GsIlpU
	 n1MP3tBy+ZDnTh2X6pP701JzzWH2HFgZ17mwu1qo0J3J6LYJLUc9YU8Z/V79OThps3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ww1xUVKy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npdypsi5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ww1xUVKy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npdypsi5;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80E606A32F
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD80E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ww1xUVKy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npdypsi5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ww1xUVKy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=npdypsi5
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2119D21F44;
	Wed,  4 Nov 2026 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzfh1eP6a7zWDBwYoJP9movq1234lrvQ2gCxaKajCw0=;
	b=Ww1xUVKyv+rIzcJ4+V+kVHwhslIt8HhmhicFKphOHXsbEsCkUQQUpLR79wHeaE2cAzMQXz
	AMlqDkgSX2bOQgsD+ul9uqRkOkPNjeZGwFGtM6qg6xJPlsopaLm3G/JvR5e3TawUBqBrAw
	ZZyB196vVYtvSrB3bO6WKalRIBmpNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzfh1eP6a7zWDBwYoJP9movq1234lrvQ2gCxaKajCw0=;
	b=npdypsi5zIkmvtk/yVH0QeADxqrE6ZzOrv41jxzZk2YlT9j4z0OnFte3IRluPk8hjHyWnL
	XnjzhqqYWVWUtpBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793802334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzfh1eP6a7zWDBwYoJP9movq1234lrvQ2gCxaKajCw0=;
	b=Ww1xUVKyv+rIzcJ4+V+kVHwhslIt8HhmhicFKphOHXsbEsCkUQQUpLR79wHeaE2cAzMQXz
	AMlqDkgSX2bOQgsD+ul9uqRkOkPNjeZGwFGtM6qg6xJPlsopaLm3G/JvR5e3TawUBqBrAw
	ZZyB196vVYtvSrB3bO6WKalRIBmpNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793802334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzfh1eP6a7zWDBwYoJP9movq1234lrvQ2gCxaKajCw0=;
	b=npdypsi5zIkmvtk/yVH0QeADxqrE6ZzOrv41jxzZk2YlT9j4z0OnFte3IRluPk8hjHyWnL
	XnjzhqqYWVWUtpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D49D4134F0;
	Wed,  4 Nov 2026 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XbjTKl1A62p1agAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:33 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:15 +0100
Subject: [PATCH blktests v2 3/6] nvme/078: test reconnect with fewer I/O
 queues
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-isolcpu-v2-3-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-Spam-Flag: NO

nvmf_set_io_queues() used to only set the io_queues entries for the
queue types it hands out, but the array is reused on every reconnect.
When the target granted fewer queues on a reconnect, the poll queue
count from the previous association survived, nvmf_map_queues() mapped
CPUs to hardware contexts which don't exist anymore and
blk_mq_map_swqueue() crashed with a NULL pointer dereference.

Connect with as many read, write and poll queues as there are online
CPUs, then lower attr_qid_max on the target to twice the number of
online CPUs, which makes the target drop the controller. After the
reconnect with fewer queues, check the queue count, that the queue
doesn't claim poll support and run verified I/O.

The problem is fixed by kernel commits 9588769af5fc ("nvme-fabrics:
reset io_queues before computing the queue mapping") and 36ede1aa85d5
("nvme-fabrics: clear the poll map if no poll queues are mapped").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/078     | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/078.out |   2 +
 2 files changed, 121 insertions(+)

diff --git a/tests/nvme/078 b/tests/nvme/078
new file mode 100755
index 000000000000..6efeb740e075
--- /dev/null
+++ b/tests/nvme/078
@@ -0,0 +1,119 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test reconnecting with fewer I/O queues. nvmf_set_io_queues used to only set
+# the io_queues entries for the queue types it hands out, but the array is
+# reused on every reconnect. When the target grants fewer queues on a
+# reconnect, the poll queue count from the previous association survived,
+# nvmf_map_queues mapped CPUs to hardware contexts which don't exist anymore
+# and blk_mq_map_swqueue crashed. Without the poll map fix, the poll map keeps
+# mapping all CPUs to the first hardware context and the queue claims poll
+# support.
+#
+# The stale io_queues entries were introduced for nvme-tcp by commit
+# 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited") and
+# for nvme-rdma by commit 5651cd3c4336 ("nvme-rdma: fix queue mapping when
+# queue count is limited"). The stale poll map was introduced for nvme-tcp by
+# commit 1a9460cef571 ("nvme-tcp: support simple polling") and for nvme-rdma by
+# commit 5651cd3c4336.
+#
+# Regression test for commits 9588769af5fc ("nvme-fabrics: reset io_queues
+# before computing the queue mapping") and 36ede1aa85d5 ("nvme-fabrics: clear
+# the poll map if no poll queues are mapped").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test reconnect with fewer I/O queues"
+QUICK=1
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_require_nvme_trtype tcp rdma
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+wait_for_queue_count() {
+	local nvmedev="$1"
+	local queue_count="$2"
+	local file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+	local retries=10
+
+	while [[ $(cat "${file}") -ne $((queue_count + 1)) ]]; do
+		if [[ "${retries}" == 0 ]]; then
+			echo "FAIL: queue count $(cat "${file}") instead of $((queue_count + 1))"
+			return 1
+		fi
+		sleep 1
+		retries=$((retries - 1))
+	done
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local nr_cpus
+	local nvmedev
+	local disk
+	local ns
+
+	_setup_nvmet
+
+	nr_cpus=$(getconf _NPROCESSORS_ONLN)
+
+	_nvmet_target_setup
+
+	if [[ ! -f "${cfs_path}/attr_qid_max" ]]; then
+		SKIP_REASONS+=("missing attr_qid_max feature")
+		_nvmet_target_cleanup
+		return 1
+	fi
+	if [[ $(cat "${cfs_path}/attr_qid_max") -lt $((3 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((3 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues "${nr_cpus}" \
+				--nr-poll-queues "${nr_cpus}" \
+				--keep-alive-tmo 1 \
+				--reconnect-delay 2; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
+		wait_for_queue_count "${nvmedev}" $((3 * nr_cpus))
+
+		# Changing attr_qid_max makes the target drop the controller.
+		# Reconnect with only enough queues for the read and default
+		# queues, so no queues are left for polling.
+		_set_attr $((2 * nr_cpus)) "${cfs_path}/attr_qid_max"
+		wait_for_queue_count "${nvmedev}" $((2 * nr_cpus))
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+
+		if [[ $(cat "/sys/block/${disk}/queue/io_poll") != 0 ]]; then
+			echo "FAIL: ${disk} claims poll support without poll queues"
+		fi
+
+		ns=$(_find_nvme_ns "${def_subsys_uuid}")
+		_run_fio_verify_io --size=32m --filename="/dev/${ns}" ||
+			echo "FAIL: fio verify"
+
+		_nvme_disconnect_subsys
+	else
+		echo "FAIL: controller not ready"
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/078.out b/tests/nvme/078.out
new file mode 100644
index 000000000000..53857c8914c0
--- /dev/null
+++ b/tests/nvme/078.out
@@ -0,0 +1,2 @@
+Running nvme/078
+Test complete

-- 
2.56.0

