Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B131C77B60
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbjDEPrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjDEPrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 11:47:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A075FF7
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:47:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9360D1FF78;
        Wed,  5 Apr 2023 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680709597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+d7byf7E4FRcokSibsW01g7yp7GQa9FjQJ/goiUPdo=;
        b=LSFqOcdUH056XR42CkVStfw4c+i3SlNDrCm/rAlXu1f8id1sypSp20H7GumDFzSGdr3CZo
        yyW+6BR129+MK0CBahbhpB3tyQ80ksEGpoYFO4T2BVM3rbedoB8gHyBWXot9tfpBJ0pSlQ
        ij1n3kLzZvtCnGENhDXkVQq15lZjun4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680709597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+d7byf7E4FRcokSibsW01g7yp7GQa9FjQJ/goiUPdo=;
        b=QF4vJNU10apIu56OMr4YvvfOIUfq0gnR/zgMj3CqVxw4ZLq2ELJhGAi74kwP0CiIGT931X
        5354H7ik3t3LDhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 867DA13A10;
        Wed,  5 Apr 2023 15:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qmLTIN2XLWTgNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:37 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 4/4] nvme/048: test queue count changes on reconnect
Date:   Wed,  5 Apr 2023 17:46:30 +0200
Message-Id: <20230405154630.16298-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |  3 ++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

diff --git a/tests/nvme/048 b/tests/nvme/048
new file mode 100755
index 000000000000..bc4766e82159
--- /dev/null
+++ b/tests/nvme/048
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Daniel Wagner, SUSE Labs
+#
+# Test queue count changes on reconnect
+
+. tests/nvme/rc
+
+DESCRIPTION="Test queue count changes on reconnect"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype tcp rdma fc
+	_require_min_cpus 2
+}
+
+set_max_qid() {
+	local port="$1"
+	local subsys_name="$2"
+	local max_qid="$3"
+
+	_set_nvmet_attr_qid_max "${subsys_name}" "${max_qid}"
+
+	# Setting qid_max forces a disconnect and the reconntect attempt starts
+	# 10s after connection lost, thus we will see the connecting state.
+	_nvmf_wait_for_state "${subsys_name}" "connecting"
+	_nvmf_wait_for_state "${subsys_name}" "live"
+}
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local file_path="${TMPDIR}/img"
+
+	echo "Running ${TEST_NAME}"
+
+	hostid="$(uuidgen)"
+	if [ -z "$hostid" ] ; then
+		echo "uuidgen failed"
+		return 1
+	fi
+
+	if ! _detect_nvmet_subsys_attr "attr_qid_max"; then
+		SKIP_REASONS+=("missing attr_qid_max feature")
+		return 1
+	fi
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112861"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}"
+
+	_nvmf_wait_for_state "${subsys_name}" "live"
+
+	set_max_qid "${port}" "${subsys_name}" 1
+	set_max_qid "${port}" "${subsys_name}" 128
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
new file mode 100644
index 000000000000..7f986ef9637d
--- /dev/null
+++ b/tests/nvme/048.out
@@ -0,0 +1,3 @@
+Running nvme/048
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.40.0

