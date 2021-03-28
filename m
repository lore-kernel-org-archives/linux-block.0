Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF4C433DB
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206B061948
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhC1XMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 19:12:47 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43662 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhC1XMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 19:12:17 -0400
Received: by mail-pf1-f174.google.com with SMTP id q5so8665454pfh.10
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 16:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47jvXGcqX6hLdNjYkHs2tuipAkJFTgLSciFhcwyAcHk=;
        b=JaDq3J9fJ03xfKaz5gbVWdGBYSBU3Jq9jO52Id1W4Bd/4EXYK+0WG9HWk1ttt9vOm3
         ZEMaYNWf+Vt6jguDe+TfK++0slXsdUrHyb0n5MtaFvPwhZ5LKJSuy2njvcUVF3FdjzGS
         N7Q3j9vO16jfAdeg8GQGq86M0hG5BhM0FWd01Em/0L49lZdshsOl+8QDHWGmZvZN1yx5
         g0DcP9LJyMJs64AK5JH0hBXOvUVR9Yfbas72xAabokyRmsN9NcOG6b25f7dPpo9W08p7
         q01OwdIVMkHvLGbRDPSya+JUYGdPOEuVMUcAUGBNgLD0jJgyUjhn3/QDCnpXagDRqQu4
         X9gQ==
X-Gm-Message-State: AOAM5326g7rrwXfV0nVwANcqlTHGpUVTkwxGGqbmT3qNJ7yyQN/vLp5Q
        AmkcWQW6Sm13TaQy/OkU9jo=
X-Google-Smtp-Source: ABdhPJxr/x8l+3WThMBz9vIen+GQzg1lJA+9yFo5qz2jMjg7Or6YF/XhWTVT7Molw7SSZmE4zsskqA==
X-Received: by 2002:a63:c348:: with SMTP id e8mr2982896pgd.36.1616973137280;
        Sun, 28 Mar 2021 16:12:17 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id gg22sm14305622pjb.20.2021.03.28.16.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:12:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH blktests] tests/block/031: Add a test for sharing a tag set across hardware queues
Date:   Sun, 28 Mar 2021 16:12:09 -0700
Message-Id: <20210328231210.3707-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for sharing a tag set across hardware queues has been added
recently to the Linux kernel. See also the BLK_MQ_F_TAG_HCTX_SHARED flag,
Linux kernel commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
tagset"; v5.10) and commit 0905053bdb5b ("null_blk: Support shared tag
bitmap"; v5.10). Add a test that triggers the shared tag set code in the
block layer core.

Cc: John Garry <john.garry@huawei.com>
Cc: Don Brace<don.brace@microsemi.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/031     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/block/031.out |  1 +
 2 files changed, 44 insertions(+)
 create mode 100755 tests/block/031
 create mode 100644 tests/block/031.out

diff --git a/tests/block/031 b/tests/block/031
new file mode 100755
index 000000000000..7940f9fa1114
--- /dev/null
+++ b/tests/block/031
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2021 Google LLC
+#
+# Test support for sharing a tag set across hardware queues ("host tag set").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="test host tagset support"
+TIMED=1
+
+requires() {
+	_have_null_blk && _have_module_param null_blk shared_tag_bitmap
+}
+
+test() {
+	local fio_status bs=512
+
+	: "${TIMEOUT:=30}"
+	if ! _init_null_blk nr_devices=0 queue_mode=2 shared_tag_bitmap=1; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=$bs size=1\
+	     submit_queues="$(nproc)" memory_backed=1 power=1; then
+		echo "Configuring null_blk failed"
+		return 1
+	fi
+	fio --verify=md5 --rw=randwrite --bs=$bs --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --runtime="${TIMEOUT}" --thread \
+		--name=block-031 --filename=/dev/nullb0 \
+		--output="${RESULTS_DIR}/block/fio-output-031.txt" \
+		>>"$FULL"
+	fio_status=$?
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	case $fio_status in
+		0) echo "Passed";;
+		*) echo "Failed (fio status = $fio_status)";;
+	esac
+}
diff --git a/tests/block/031.out b/tests/block/031.out
new file mode 100644
index 000000000000..863339fb8ced
--- /dev/null
+++ b/tests/block/031.out
@@ -0,0 +1 @@
+Passed
