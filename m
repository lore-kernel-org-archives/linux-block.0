Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E76483BD6
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964336; cv=none; b=pExOwnTtyOiMm2tTyrV7QydNcJ8eqwyJZAlRj2YCUbHTKyqlCvohIYgBM1LddhxWhg90DIjLjwPmTYS3KKdLpkHGudhZgWZmmv4pC4a3rTxr4yomA/r1fdzEi5GBrWz2hw5MSCl5MRAVDk+TkGj8seZO77B25NZFSycuPLV8TVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964336; c=relaxed/simple;
	bh=hHq2WIfAWDToAbtWskKiRv9GzK/jCEqzTU3YcS616b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdndoCHB105INXcVSaknyFaUZZiwKwkucywFLGPQOk9fpiXi39q1bxfd1vhmn8vQOMuaDeLtlHNq/f831IXHo7xcBcgVOlWQfb3yC20g0eMA+ikzUvFkNhDQr8kQJuAtd0qlhjvf7JC2ubWPcxQJgYbI0rVpB3W3tcDT8WgCahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mMf/Ny4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6y8waG68; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vpSxJXAS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y5u6gX/P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mMf/Ny4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6y8waG68";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vpSxJXAS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y5u6gX/P"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E749C22040;
	Wed, 14 Oct 2026 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYeNVTWkATSfJ5WxgpHapfwrBmkdA5cLYSKc+6TQcSA=;
	b=mMf/Ny4XYU0PTHv7laBt56xzpwfW+FbtOPGiw2w1sBl/YM9WXTABjREPG85dOHhjYq0cW8
	WspNm8iFdWhS2jhd5lwcgNED3BbG29lr+2CXNhT0MPHYGSWVRsN/Uxs0bvrXyIpeZOmahX
	KVPHt4uOaDxR9M9TLPO7XdDQBJ6imiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYeNVTWkATSfJ5WxgpHapfwrBmkdA5cLYSKc+6TQcSA=;
	b=6y8waG68KX+B5chQ4yY/xkKfhnBoaA/8dWnnEjClABfLrm/HMx06BMxT40zOy9nnlEIQWN
	10yTuVyzYjvjgZCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vpSxJXAS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="y5u6gX/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYeNVTWkATSfJ5WxgpHapfwrBmkdA5cLYSKc+6TQcSA=;
	b=vpSxJXAS7mRRRKUgbcmlRsKOsGIF8PrdwN4lyt5dr1jTqU2zoXytXy2ldKDZhXHJT+wY54
	/JhDIAmj7jFs9J7KwPeEz4nuIR4IbCw+5Kl74q8wiCu3hjVx4Tz29E24azFyja60bdCHpL
	+uj526AKlVPvuWJpKIOskdaEk2LohxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYeNVTWkATSfJ5WxgpHapfwrBmkdA5cLYSKc+6TQcSA=;
	b=y5u6gX/PGDo5CM9pGuKhmi57UsP2Rx8olw7M28Nw0ZdoF08EHzuvw0av7h1xGQfR78qEXL
	J4MXKAPc+hiO0wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B599A1368E;
	Wed, 14 Oct 2026 07:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pxf8I6E0z2rWPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:52:01 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:49 +0200
Subject: [PATCH blktests 3/5] nvme/071: test I/O queue limits per queue
 type
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-3-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E749C22040
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.51

From: Daniel Wagner <wagi@kernel.org>

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

The problem is fixed by kernel commit XXX ("nvme-fabrics: limit each
queue type to the number of online CPUs").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/071     | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |   2 ++
 2 files changed, 106 insertions(+)

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 000000000000..2ac5dd761876
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,104 @@
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
+# Regression test for commit XXX ("nvme-fabrics: limit each queue type to the
+# number of online CPUs").
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
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 000000000000..146809b91e0a
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete

-- 
2.56.0

