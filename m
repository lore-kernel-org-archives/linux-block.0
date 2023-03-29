Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACAC74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 09:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjC2JDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjC2JC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 05:02:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5309423C
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:02:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC24F219E2;
        Wed, 29 Mar 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680080526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ2cMbhE9n5GVfjaaGV9CfBtF0MZY0yHt+5KA5Ek/K8=;
        b=wt4lcub9Q2fxfLOgnKlzF2te93wLF4PrvBYjAYeajGP2cMQHvpmL9zhBPm5siC0pm3EunV
        DPn/+hY38lsMsjDO5pv7lyJETsUgExIjICUvRI3OVzUOgfPJIzmfZL2F2FzqL6NPs5nBL6
        zokFEN63RMGv/ZLWpLefCQqlmJdk+pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680080526;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ2cMbhE9n5GVfjaaGV9CfBtF0MZY0yHt+5KA5Ek/K8=;
        b=neBq5m714jPJ9FH3U4VL6O8HMo4Qys+ERYB2kH3ITQJ8eF7xvLIn3XfSE2LU+BcCA9LFQJ
        ljoyn3vVgE6dc9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD298138FF;
        Wed, 29 Mar 2023 09:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ne33NY7+I2RgdgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 4/4] nvme/047: Test different queue types for fabrics transports
Date:   Wed, 29 Mar 2023 11:02:02 +0200
Message-Id: <20230329090202.8351-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
References: <20230329090202.8351-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test if the fabrics transports are handling different queues types
correctly.

Currently, only TCP and RDMA from the fabric transport family support
this feature, so limit the test to these two.

We also issue some I/O to make sure that not just the plain connect
works. For this we have to use a file system which supports direct I/O
and hence we use a device backend.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/047     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 000000000000..d56d3be185b0
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 SUSE LLC
+#
+# Test if the fabrics transports are handling different queues types correctly.
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="test different queue types for fabric transports"
+
+requires() {
+	_nvme_requires
+	_have_xfs
+	_have_fio
+	_require_nvme_trtype tcp rdma
+	_have_kver 4 21
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local nvmedev
+	local loop_dev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 512M "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--nr-write-queues 1 || echo FAIL
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--nr-write-queues 1 \
+		--nr-poll-queues 1 || echo FAIL
+
+	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 000000000000..915d0a2389ca
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.40.0

