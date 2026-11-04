Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802332;
	b=D/gTHuH8xwKAcxrxjaRBKpuTTLM6ZDER73eBT3zZxDU8LcaIrSswnDbRDqA8Req8MfUT
	 7YLTNOYwSmnq5XgoJAuoeWNEFW6wAVV3He7C6uvtK/rTASqxNP79WDkDGsjBBpfruOuv6
	 UK0aF6RSUpXcB083OLztz7bTECNXxyXgQma6MIrFwu+OXcepW3BoH4yoEJV7XnDAHbe4I
	 ji9DmHttMFJJqCVqjXWCicE3eY08/BQtbX50kW5QjGYNKszNqFksgIGG+ntPfKb/zTYE/
	 EZnJ2GUros3ytaePBlH7aUVzkydBaAbS+QRdFw5T3hFyu1sD6pe6UUN2MpIP+l4aqWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802332;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=QZvYRm9kpXyEiln1T+N2yehC7+ROhrO7cYIRp8yu6MI=;
	b=25VDHa+9nbVmuWe7B9wbIYWRmNKTUfCrcr+Q5RuVIK4Modn02/OUmUEyP/ookYuFtVcL
	 zBWaV0M/MobnD2cgF0VsIjtVjBCph8/9ZjQA7TcIhIO85rY+MMKOQqx5wxKJeHTaRVaiv
	 BV/2lmy62ipT+C1kL7oRfa4Zq1AWg5KwckOERmiJUg6fFwCfa1/RqgqUvL+vt1TUBUGlI
	 sTjDaGjyGuRPNyu8+YGSuFnCSaGj4RRfDQwKRY+niSIkdmmh6Ex8dJRG2w5NwRPTWT4Fx
	 gOwABNKyO5Ucw9lMZBf/Ko8mZKnULXB2b2EpULe3ar5EsuYeCDq6+0ZEuJCuukqh9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28912606A328
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 14:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28912606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 721771F790;
	Wed,  4 Nov 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21E64134F0;
	Wed,  4 Nov 2026 14:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCL3OllA62pvagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:30 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:13 +0100
Subject: [PATCH blktests v2 1/6] nvme/076: test I/O queue limits per queue
 type
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
Message-Id: <20261104-nvme-isolcpu-v2-1-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 721771F790
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

nvmf_nr_io_queues() limits each queue type to the number of online CPUs
when asking the controller for I/O queues, but nvmf_set_io_queues()
used to hand out the granted queues without these limits. With
nr_write_queues larger than the number of online CPUs, the default
queues got more queues than there are CPUs, some hardware contexts had
no CPU mapped and connecting their I/O queues failed with -EXDEV.

Connect with nr_io_queues set to the number of online CPUs and twice as
many write and poll queues, check that every hardware context has a CPU
mapped and that no queue type has more hardware contexts than online
CPUs, and run verified I/O.

The problem is fixed by kernel commit 99fd0cbae849 ("nvme-fabrics: limit
each queue type to the number of online CPUs").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/076     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/076.out |   2 +
 2 files changed, 108 insertions(+)

diff --git a/tests/nvme/076 b/tests/nvme/076
new file mode 100755
index 000000000000..d3389af63bd1
--- /dev/null
+++ b/tests/nvme/076
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test that no queue type gets more I/O queues than there are online CPUs.
+# nvmf_nr_io_queues limits each queue type to the number of online CPUs when
+# asking for I/O queues, but nvmf_set_io_queues used to hand out the granted
+# queues without these limits. With nr_write_queues larger than the number of
+# online CPUs, the default queues got more queues than CPUs, some hardware
+# contexts had no CPU mapped and connecting their I/O queues failed.
+#
+# The bug was introduced for nvme-tcp by commit 6486199378a5 ("nvme-tcp: fix
+# queue mapping when queue count is limited") and for nvme-rdma by commit
+# a249d3066de6 ("nvme-fabrics: add queue setup helpers").
+#
+# Regression test for commit 99fd0cbae849 ("nvme-fabrics: limit each queue
+# type to the number of online CPUs").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test I/O queue limits per queue type"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_have_debugfs
+	_require_nvme_trtype tcp rdma
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# Check that every hardware context has a software context mapped and that no
+# queue type has more hardware contexts than there are online CPUs.
+check_hctxs() {
+	local nvmedev="$1"
+	local nr_cpus="$2"
+	local disk
+	local hctx
+	local type
+	local -A nr_type=()
+
+	disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
+	for hctx in /sys/block/"${disk}"/mq/*; do
+		if ! compgen -G "${hctx}/cpu*[0-9]" > /dev/null; then
+			echo "FAIL: hctx $(basename "${hctx}") has no CPU mapped"
+		fi
+	done
+
+	for hctx in /sys/kernel/debug/block/"${disk}"/hctx*; do
+		type=$(cat "${hctx}/type")
+		nr_type[${type}]=$((${nr_type[${type}]:-0} + 1))
+	done
+	for type in "${!nr_type[@]}"; do
+		if [[ "${nr_type[${type}]}" -gt "${nr_cpus}" ]]; then
+			echo "FAIL: ${nr_type[${type}]} ${type} queues for ${nr_cpus} CPUs"
+		fi
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local nr_cpus
+	local nvmedev
+	local ns
+
+	_setup_nvmet
+
+	nr_cpus=$(getconf _NPROCESSORS_ONLN)
+
+	_nvmet_target_setup
+
+	# The bug only shows if the target grants a queue per online CPU for
+	# each queue type.
+	if [[ -f "${cfs_path}/attr_qid_max" ]] &&
+	   [[ $(cat "${cfs_path}/attr_qid_max") -lt $((3 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((3 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues $((2 * nr_cpus)) \
+				--nr-poll-queues $((2 * nr_cpus)); then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		check_hctxs "${nvmedev}" "${nr_cpus}"
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
diff --git a/tests/nvme/076.out b/tests/nvme/076.out
new file mode 100644
index 000000000000..f453b79ce2fb
--- /dev/null
+++ b/tests/nvme/076.out
@@ -0,0 +1,2 @@
+Running nvme/076
+Test complete

-- 
2.56.0

