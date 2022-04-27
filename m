Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 21:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiD0VhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiD0Vfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 17:35:30 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060D2716C
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:18 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id g8so212710pfh.5
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGtD7pTj2B4cUHsyyQ/puOKcndrpml9ymFj4xPybbpI=;
        b=P1WKJthTsp1W+j06dbtGA7NqfDgaaNNthVzqZk8f3KGq25k5x/OcwZxiwsWJAclOzd
         DJKmcYXSvNZ40KnXCdi4g7p0XoSoq8gcIfo6mfrSeHWa1LG9In2srSB+z0sMUkWmSywD
         q5W93FWHP4jLLUgEkFBvhpIh20D9lM1FPZXr0Q7a24/19VmohOKowdtCmozXcwqv5khu
         XSaWwFkmXnG5N6VOJrGowqcPnmpxix8I3NI0oURlIDYmuZIHUr+OvsCJt8SPTYW/MyS7
         Kr51q7o2iC3E27BbZjaEw3KblPADjpEoawJ5i3USfu2A7kh9sRnNgBZKK6LQytl0rWDO
         Am9A==
X-Gm-Message-State: AOAM530Pfbj2LTF2GSsg/jHWLLzsRYaaKv0+WCdaMGkBIOSE2yFJfCDN
        SO1Q0gYNqsJvMw6+3fpz+14=
X-Google-Smtp-Source: ABdhPJysQE1X3VUu848w22emoIC9+vFjvYCvE5B/Oh6jDbYgCjUUQOorOtIrM8Km3RjsL0neIDIiQw==
X-Received: by 2002:a63:ad0c:0:b0:374:50b4:c955 with SMTP id g12-20020a63ad0c000000b0037450b4c955mr25065883pgf.530.1651095138077;
        Wed, 27 Apr 2022 14:32:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id nm6-20020a17090b19c600b001cd4989fedbsm7700112pjb.39.2022.04.27.14.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:32:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 3/3] tests/scsi: Add tests for SCSI devices with gap zones
Date:   Wed, 27 Apr 2022 14:31:43 -0700
Message-Id: <20220427213143.2490653-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220427213143.2490653-1-bvanassche@acm.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/scsi/009     | 56 +++++++++++++++++++++++++++++++++++++
 tests/scsi/009.out |  2 ++
 tests/scsi/010     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 4 files changed, 130 insertions(+)
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out
 create mode 100644 tests/scsi/010
 create mode 100644 tests/scsi/010.out

diff --git a/tests/scsi/009 b/tests/scsi/009
new file mode 100755
index 000000000000..38f771f14e02
--- /dev/null
+++ b/tests/scsi/009
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Google LLC
+
+. tests/scsi/rc
+. common/scsi_debug
+
+DESCRIPTION="test gap zone support with BTRFS"
+QUICK=1
+
+requires() {
+	_have_fio &&
+	_have_module_param scsi_debug zone_cap_mb &&
+	_have_program mkfs.btrfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local params=(
+		delay=0
+		dev_size_mb=1024
+		sector_size=4096
+		zbc=host-managed
+		zone_cap_mb=3
+		zone_nr_conv=16
+		zone_size_mb=4
+	)
+	_init_scsi_debug "${params[@]}" || return 1
+
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail
+
+	mkfs.btrfs "${dev}" >>"${FULL}" 2>&1 &&
+	local mount_dir="$TMPDIR/mnt" &&
+	mkdir -p "${mount_dir}" &&
+	mount -t btrfs "${dev}" "${mount_dir}" &&
+	local fio_args=(
+		--size=1M
+		--directory="${mount_dir}"
+		--time_based
+		--runtime=10
+	) &&
+	_run_fio_verify_io "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	umount "${mount_dir}" >>"${FULL}" 2>&1
+
+	_exit_scsi_debug
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/scsi/009.out b/tests/scsi/009.out
new file mode 100644
index 000000000000..f6db2a371d9e
--- /dev/null
+++ b/tests/scsi/009.out
@@ -0,0 +1,2 @@
+Running scsi/009
+Test complete
diff --git a/tests/scsi/010 b/tests/scsi/010
new file mode 100644
index 000000000000..4fdc6f82e732
--- /dev/null
+++ b/tests/scsi/010
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Google LLC
+
+. tests/scsi/rc
+. common/null_blk
+. common/scsi_debug
+
+DESCRIPTION="test gap zone support with F2FS"
+QUICK=1
+
+requires() {
+	_have_fio &&
+	_have_modules null_blk &&
+	_have_module_param scsi_debug zone_cap_mb &&
+	_have_program mkfs.f2fs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local mount_dir="$TMPDIR/mnt"
+
+	local null_blk_params=(
+		blocksize=4096
+		completion_nsec=0
+		memory_backed=1
+		size=1024 # MB
+		submit_queues=1
+		power=1
+	)
+	_init_null_blk nr_devices=0 queue_mode=2 &&
+	_configure_null_blk nullb0 "${null_blk_params[@]}" || return $?
+	local cdev=/dev/nullb0
+
+	local scsi_debug_params=(
+		delay=0
+		dev_size_mb=1024
+		sector_size=4096
+		zbc=host-managed
+		zone_cap_mb=3
+		zone_nr_conv=0
+		zone_size_mb=4
+	)
+	_init_scsi_debug "${scsi_debug_params[@]}" &&
+	local zdev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
+	ls -ld "${cdev}" "${zdev}" >>"${FULL}" &&
+	mkfs.f2fs -m "${cdev}" -c "${zdev}" >>"${FULL}" 2>&1 &&
+	mkdir -p "${mount_dir}" &&
+	mount -t f2fs "${cdev}" "${mount_dir}" &&
+	local fio_args=(
+		--size=1M
+		--directory="${mount_dir}"
+		--time_based
+		--runtime=10
+	) &&
+	_run_fio_verify_io "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	umount "${mount_dir}" >>"${FULL}" 2>&1
+	_exit_scsi_debug
+	_exit_null_blk
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/scsi/010.out b/tests/scsi/010.out
new file mode 100644
index 000000000000..6581d5eb2c5a
--- /dev/null
+++ b/tests/scsi/010.out
@@ -0,0 +1,2 @@
+Running scsi/010
+Test complete
