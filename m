Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802347;
	b=48hzscCkLjqq6c8gE78l5snqYNAqVSq2OZC+6Ell3YCk2AvWPU6tfZe3EUQtTaopUP6T
	 0g8EaTAqlXZQrzkBNqxgrtpS73Vuxg+c3sUlGpC4B1oJfiFE3cadeAb2gYJF3XukQPGD0
	 wLd2ftfbdmMk7FI2N9xroe9DvIjgdSyZ7GpTiT0aT8/srtdQSJ8FBD7Q6UImWur9B3ssI
	 9TFjB0FjxdkE+fCCEmcKz1COHGd1Pbl/PRHnvxHy8H+sIjeSJ7xADDtWtQB4RCsgesMhB
	 TaD3VVc2reu4ZEx2Q2n/Z7O9R2FeTOMfEionZ+i5mNbOvYobJUOw2jmWVmFci4tDq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802347;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=sf+EO5eIrp0iU+aKiWLBDNrUdJbwzm3Px+eNbDlmAW0=;
	b=fUCJ3OYICQRGRTeJ1ru+W+1kpKEu1K0UqbF+rqORWoPot4rJkZv3SfWrHU9ZHYrP//yD
	 4b9kjoyUOiPyqggAN9YsxdXbSMeaXAT9fQ8cor2/F+yDy+RzWhakxmr9PThA8sIoF7oyw
	 SZeuTaCWTSPxUFKNWlkEMxz7aiBRPZzql0/JenYkI7P34EM/PTuuWEpybDMWF+jFO+Op1
	 koyTYUlVzZUM+feob34ceht/O4kapZVBMquSLUVzGcStiRgHBiKQHWtX+iMUwVxmohlYq
	 YclBDPe7bBT0lH0e03p6vOUji+AeBi/XGShbEbjEdh4VINzoLy43mRdiZ2UOYN5JOjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93226606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93226606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F168B21F44;
	Wed,  4 Nov 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7084134F0;
	Wed,  4 Nov 2026 14:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDQlIGhA62ofawAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:44 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:17 +0100
Subject: [PATCH blktests v2 5/6] nvme/079: test connect with an isolated
 CPU
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
Message-Id: <20261104-nvme-isolcpu-v2-5-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: F168B21F44
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Since kernel commit a46c27026da1 ("blk-mq: don't schedule block kworker
on isolated CPUs") isolated CPUs are removed from the CPU mask of the
hardware contexts. If only isolated CPUs are mapped to a hardware
context, the mask is empty and blk_mq_alloc_request_hctx fails with
-EXDEV. The fabrics transports allocate the Connect command for each
I/O queue this way, so the connect fails, e.g. with isolcpus=domain or
with an isolated cpuset partition.

Isolate the last online CPU with a cpuset partition, connect with the
default number of I/O queues and run verified I/O from a housekeeping
CPU and from the isolated CPU. To make sure the test exercises the
problem, it checks that the hardware context of the isolated CPU has an
empty CPU mask, that the I/O of the isolated CPU runs on that CPU, and
traces nvme_setup_cmd on the queue of the hardware context: the
housekeeping CPUs must not submit commands on it, the isolated CPU must.

The problem is fixed by kernel commit XXX ("blk-mq: allow passthrough
requests on hctxs without online CPUs").

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/079     | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/079.out |   2 +
 2 files changed, 178 insertions(+)

diff --git a/tests/nvme/079 b/tests/nvme/079
new file mode 100755
index 000000000000..775b864fdd25
--- /dev/null
+++ b/tests/nvme/079
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test connecting with an isolated CPU. blk-mq removes the CPUs which are
+# isolated, e.g. with a cpuset isolated partition, from the CPU mask of the
+# hardware contexts. If a hardware context ends up without a CPU, the Connect
+# command for its I/O queue can't be allocated and the connect fails. Run I/O
+# from a housekeeping CPU and from the isolated CPU and trace the queue IDs of
+# the commands to verify that the hardware context of the isolated CPU is used
+# and works.
+#
+# The bug was introduced by commit a46c27026da1 ("blk-mq: don't schedule block
+# kworker on isolated CPUs").
+#
+# Regression test for commit XXX ("blk-mq: allow passthrough requests on hctxs
+# without online CPUs").
+
+. tests/nvme/rc
+. common/cgroup
+
+DESCRIPTION="Test connect with an isolated CPU"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_min_cpus 2
+	_have_cgroup2_controller_file cpuset cpuset.cpus.partition
+	_have_tracefs
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+isolate_cpu() {
+	local cpu="$1"
+	local partition
+
+	_init_cgroup2 || return 1
+	_set_attr "+cpuset" "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	_set_attr "${cpu}" "${CGROUP2_DIR}/cpuset.cpus"
+	_set_attr "isolated" "${CGROUP2_DIR}/cpuset.cpus.partition"
+
+	partition=$(cat "${CGROUP2_DIR}/cpuset.cpus.partition")
+	if [[ "${partition}" != "isolated" ]]; then
+		SKIP_REASONS+=("failed to isolate CPU ${cpu}: ${partition}")
+		_exit_cgroup2
+		return 1
+	fi
+
+	return 0
+}
+
+run_io() {
+	local ns="$1"
+
+	_run_fio_verify_io --size=32m --filename="/dev/${ns}"
+}
+
+# Set isolated_hctx to the index of the hardware context the software context
+# of the CPU is mapped to, if the CPU mask of the hardware context is empty.
+find_isolated_hctx() {
+	local nvmedev="$1"
+	local cpu="$2"
+	local ctx
+	local hctx
+
+	for ctx in /sys/class/nvme/"${nvmedev}"/nvme*n*/mq/*/cpu"${cpu}"; do
+		[[ -d "${ctx}" ]] || continue
+		hctx="$(dirname "${ctx}")"
+		if [[ -n "$(cat "${hctx}/cpu_list")" ]]; then
+			SKIP_REASONS+=("hctx of CPU ${cpu} has CPUs: $(cat "${hctx}/cpu_list")")
+			return 1
+		fi
+		isolated_hctx="$(basename "${hctx}")"
+		return 0
+	done
+
+	SKIP_REASONS+=("no hctx found for CPU ${cpu}")
+	return 1
+}
+
+check_io() {
+	local nvmedev="$1"
+	local cpu="$2"
+	local trace_dir="$3"
+	local ns
+	local isolated_hctx
+	local qid
+	local nr_cmds
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	find_isolated_hctx "${nvmedev}" "${cpu}" || return 1
+	qid=$((isolated_hctx + 1))
+
+	_nvme_have_setup_cmd_event "${trace_dir}" || return 1
+
+	# The test runs on the housekeeping CPUs, which must not use the
+	# hardware context of the isolated CPU.
+	_nvme_trace_qid_start "${trace_dir}" "${nvmedev#nvme}" "${qid}"
+	run_io "${ns}" || echo "FAIL: I/O from housekeeping CPU"
+	nr_cmds=$(_nvme_trace_qid_stop "${trace_dir}")
+	if [[ "${nr_cmds}" -ne 0 ]]; then
+		echo "FAIL: ${nr_cmds} commands from housekeeping CPUs on qid ${qid}"
+	fi
+
+	# Moving the subshell into the partition confines it to the
+	# isolated CPU, so its I/O uses the hardware context of the
+	# isolated CPU.
+	_nvme_trace_qid_start "${trace_dir}" "${nvmedev#nvme}" "${qid}"
+	(
+		local allowed
+
+		_set_attr "${BASHPID}" "${CGROUP2_DIR}/cgroup.procs"
+		allowed=$(awk '/^Cpus_allowed_list:/ { print $2 }' \
+				"/proc/${BASHPID}/status")
+		if [[ "${allowed}" != "${cpu}" ]]; then
+			echo "FAIL: subshell runs on CPUs ${allowed}"
+			exit 1
+		fi
+		run_io "${ns}"
+	) || echo "FAIL: I/O from isolated CPU ${cpu}"
+	nr_cmds=$(_nvme_trace_qid_stop "${trace_dir}")
+	if [[ "${nr_cmds}" -eq 0 ]]; then
+		echo "FAIL: no commands from isolated CPU ${cpu} on qid ${qid}"
+	fi
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local cpu
+	local nvmedev
+	local trace_dir="/sys/kernel/debug/tracing/instances/blktests-nvme-079"
+	local skipped=false
+
+	_setup_nvmet
+
+	# Isolate the last online CPU. Without nr_io_queues there is usually
+	# one I/O queue per online CPU, so its hardware context has no other
+	# CPU.
+	cpu=$(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online)
+	if ! isolate_cpu "${cpu}"; then
+		return 1
+	fi
+
+	_nvmet_target_setup
+
+	if _nvme_connect_subsys; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		mkdir "${trace_dir}"
+		check_io "${nvmedev}" "${cpu}" "${trace_dir}" || skipped=true
+		rmdir "${trace_dir}"
+
+		_nvme_disconnect_subsys
+	else
+		echo "FAIL: controller not ready"
+	fi
+
+	_nvmet_target_cleanup
+	_exit_cgroup2
+
+	if [[ "${skipped}" = true ]]; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/079.out b/tests/nvme/079.out
new file mode 100644
index 000000000000..59246c004ea3
--- /dev/null
+++ b/tests/nvme/079.out
@@ -0,0 +1,2 @@
+Running nvme/079
+Test complete

-- 
2.56.0

