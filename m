Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05295C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D030320657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAQM7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:59:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfAQM7X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 07:59:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 626BBAE47;
        Thu, 17 Jan 2019 12:59:22 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 2/2] nvme: test resize of a namespace with file-backed ns
Date:   Thu, 17 Jan 2019 13:59:06 +0100
Message-Id: <20190117125906.15479-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190117125906.15479-1-jthumshirn@suse.de>
References: <20190117125906.15479-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test resizing of a NVMe namespace by creating a file backed namespace over
nvme-loop with 1G size, connecting to it and then resizing it to 2G.

Check if /proc/partitions and blkdev --getsz $DEVICE see the updated size.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/nvme/029     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/029.out | 10 ++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/nvme/029
 create mode 100644 tests/nvme/029.out

diff --git a/tests/nvme/029 b/tests/nvme/029
new file mode 100755
index 000000000000..8c94af039d0f
--- /dev/null
+++ b/tests/nvme/029
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Johannes Thumshirn
+#
+# Test resize of a namespace with file-backed ns
+
+. tests/nvme/rc
+
+DESCRIPTION="test resize of a namespace with file-backed ns"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port
+	local nvmedev
+	local namespace
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	namespace="${nvmedev}n1"
+	cat "/sys/block/${namespace}/uuid"
+	cat "/sys/block/${namespace}/wwid"
+
+	cat /proc/partitions | grep ${namespace} | awk '{ print $3 }'
+	blockdev --getsz /dev/${namespace}
+
+	echo "Resizing"
+	truncate -s +1G "${file_path}"
+	printf 0 > ${NVMET_CFS}/subsystems/${subsys_name}/namespaces/1/enable
+	printf 1 > ${NVMET_CFS}/subsystems/${subsys_name}/namespaces/1/enable
+	sleep 1
+
+	cat /proc/partitions | grep ${namespace} | awk '{ print $3 }'
+	blockdev --getsz /dev/${namespace}
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	rm -f "${file_path}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
new file mode 100644
index 000000000000..e9571c7c9300
--- /dev/null
+++ b/tests/nvme/029.out
@@ -0,0 +1,10 @@
+Running nvme/029
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+1048576
+2097152
+Resizing
+2097152
+4194304
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.16.4

