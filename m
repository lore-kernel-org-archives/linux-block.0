Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDC4854E6
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964328; cv=none; b=pwijNMuOgtjeWa+93AbeXoxN14yHDySA5Ouo3myXEoAJVel13S9gI1bpvsy8QN6v3UFIRbxK902iLn110FD6/Y5zjO3lMykjkmTel6zwL9Iffs2uQM2+J1wLGLsMiSv7ufSmEEE8hmwY9L+VN0iyU3juezzR2P7jH0Ct+RprKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964328; c=relaxed/simple;
	bh=2+54v8L4Zhya08XvH5yrI6N/RsDrdV2ot2m70KUKSLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiOuxj0mRR8B1V4Fs7iguvHPxNvywGE8z3ppNkwLuga4djMF/FO0+fJTBNEwDLqG2ROhTVM9wAAAyUZZf+8h/XceYG+6qfPpsx2zH7cH7IogrH5zTBwJw6dGhTiV3DIQUnBg/QUoJDtml3FboRVQ/Xm9nwSo/NayrYkradRnUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QOGM8V3i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+FjF22i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QOGM8V3i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+FjF22i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QOGM8V3i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+FjF22i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QOGM8V3i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+FjF22i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C07501F7BF;
	Wed, 14 Oct 2026 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=QOGM8V3iLf/Drn9GjqJJWswH9z33anNCKraWMvkzQWu+/996Q5okjAkmH1BCbamCkJbXc6
	wEZ60siDKANN95saH3Au3jdxBnprbuAWCznNxK87GNPMxeGpOudJp6coIM5i8nf8os7Z0i
	B8LaTjwKVN5XUQw9QCG0recafhfCXaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=b+FjF22i7CH2CXZLv1NEQv4JwcDAG2SPlwwwmQjDwLgSZ5f2CXXXG5TUa2MV03Qq72kgni
	cLuzVjc5h3y4QrBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QOGM8V3i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b+FjF22i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=QOGM8V3iLf/Drn9GjqJJWswH9z33anNCKraWMvkzQWu+/996Q5okjAkmH1BCbamCkJbXc6
	wEZ60siDKANN95saH3Au3jdxBnprbuAWCznNxK87GNPMxeGpOudJp6coIM5i8nf8os7Z0i
	B8LaTjwKVN5XUQw9QCG0recafhfCXaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlKzFSyvoS91J6eXLTeDDZvSjF76Gj6XwClpVQ8S4I=;
	b=b+FjF22i7CH2CXZLv1NEQv4JwcDAG2SPlwwwmQjDwLgSZ5f2CXXXG5TUa2MV03Qq72kgni
	cLuzVjc5h3y4QrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D1D1368E;
	Wed, 14 Oct 2026 07:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5pfG6I0z2rZPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:52:02 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:51:50 +0200
Subject: [PATCH blktests 4/5] nvme/072: test poll support without poll
 queues
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-isolcpu-v1-4-2fd175a8ef00@kernel.org>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C07501F7BF
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

From: Daniel Wagner <wagi@kernel.org>

blk_mq_alloc_tag_set() initializes all queue maps. When nr_poll_queues
is set but the target grants no queues for polling, nvmf_map_queues()
used to leave the poll map in this state, with all CPUs mapped to the
first hardware context. The queue claimed poll support and polled I/O
was sent to a queue which isn't a poll queue.

Limit the target to twice the number of online CPUs, connect with as
many read, write and poll queues as there are online CPUs, so no queues
are left for polling, check that the queue doesn't claim poll support
and run verified I/O.

The problem is fixed by kernel commit XXX ("nvme-fabrics: clear the poll
map if no poll queues are mapped").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 tests/nvme/072     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/072.out |  2 ++
 2 files changed, 87 insertions(+)

diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 000000000000..72bf80d660f5
--- /dev/null
+++ b/tests/nvme/072
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Test that a controller without poll queues doesn't claim poll support.
+# blk_mq_alloc_tag_set initializes all queue maps. When nr_poll_queues is set
+# but the target grants no queues for polling, nvmf_map_queues used to leave
+# the poll map in this state, so the queue claimed poll support and polled I/O
+# was sent to a queue which isn't a poll queue.
+#
+# The bug was introduced for nvme-tcp by commit 1a9460cef571 ("nvme-tcp:
+# support simple polling") and for nvme-rdma by commit 5651cd3c4336
+# ("nvme-rdma: fix queue mapping when queue count is limited").
+#
+# Regression test for commit XXX ("nvme-fabrics: clear the poll map if no poll
+# queues are mapped").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test poll support without poll queues"
+QUICK=1
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
+	if [[ $(cat "${cfs_path}/attr_qid_max") -lt $((2 * nr_cpus)) ]]; then
+		SKIP_REASONS+=("target supports less than $((2 * nr_cpus)) I/O queues")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	# Only grant enough queues for the read and default queues, so no
+	# queues are left for polling.
+	_set_attr $((2 * nr_cpus)) "${cfs_path}/attr_qid_max"
+
+	if _nvme_connect_subsys --nr-io-queues "${nr_cpus}" \
+				--nr-write-queues "${nr_cpus}" \
+				--nr-poll-queues "${nr_cpus}"; then
+		_nvmf_wait_for_state "${def_subsysnqn}" "live" || echo FAIL
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+		disk=$(basename /sys/class/nvme/"${nvmedev}"/nvme*n*)
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
+	fi
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/072.out b/tests/nvme/072.out
new file mode 100644
index 000000000000..3f765b30a22b
--- /dev/null
+++ b/tests/nvme/072.out
@@ -0,0 +1,2 @@
+Running nvme/072
+Test complete

-- 
2.56.0

