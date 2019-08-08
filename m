Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77179C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C66521743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfHHUFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36600 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404052AbfHHUFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 16:05:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so43997329plt.3
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 13:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7hl1WyPR2VwzTL5TFVOZS8PC4G/b+Nlw5PBSgVersc=;
        b=RZzUQhJsmTmI/TJzFRyHlcxMJzWqbVEqAPP0nl6xFQRLSy2OMjIWY3NNy6JLtUGZqV
         HkVG51+uMKBZr6KFMtyEegloSz3HshkrEphW7awAmzkyxfNOS7vqhtungmVYcLkC+oV6
         uOIZyj3lQehDRnj8R6OZzh0dYv26kxtNy4e9SumDf/UDlCLuByomtlB1Lg0GArP/0KXf
         xx9tt9KcG+0dUZ1RwTdXydC5TSaOwCVTBbHSkSbpBxw/UKIM5cn+5JZQekCGO4MlvcKP
         RwM61pvu0N+R+smBLTIjgK13RLS28UExeUwyWRfXOIeSpwzXJhBYso74PE64IkGDroxG
         A4Bw==
X-Gm-Message-State: APjAAAU627C3zOO8IvwICYfedyvy9dH+8nm9F67eHZnyIzyFBAJPfR9Y
        RjRBa6oQTaarJ15nMmtbh7X6bEa3
X-Google-Smtp-Source: APXvYqzxvuqhlu6ro8pjL7k75Af57fh5By1NrcIjFJgC1aHRHp6dfw3jcjuhXSDfltcQFG80JEv/KQ==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89mr15893703plb.7.1565294719880;
        Thu, 08 Aug 2019 13:05:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm83307093pgq.26.2019.08.08.13.05.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:05:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 4/4] tests/srp/014: Add a test that triggers a SCSI reset while I/O is ongoing
Date:   Thu,  8 Aug 2019 13:05:06 -0700
Message-Id: <20190808200506.186137-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190808200506.186137-1-bvanassche@acm.org>
References: <20190808200506.186137-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test triggers the task management function handling code in the SRP
initiator and target drivers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/srp/014     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/srp/014.out |   2 +
 2 files changed, 109 insertions(+)
 create mode 100755 tests/srp/014
 create mode 100644 tests/srp/014.out

diff --git a/tests/srp/014 b/tests/srp/014
new file mode 100755
index 000000000000..8ecd8a439a82
--- /dev/null
+++ b/tests/srp/014
@@ -0,0 +1,107 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# Submit SCSI resets while a fio --verify job is running. This is a regression
+# test for Linux kernel commit fd5614124406 ("scsi: RDMA/srp: Fix a
+# sleep-in-invalid-context bug") # v5.3.
+
+. tests/srp/rc
+
+DESCRIPTION="Run sg_reset while I/O is ongoing"
+TIMED=1
+
+# $1: SCSI device of which to change the state to running, e.g. sdc.
+make_running() {
+	local dev=$1 sp state
+
+	for sp in /sys/class/scsi_device/*/device/block/"$dev"; do
+		if [ -e "$sp" ]; then
+			break
+		else
+			return 1
+		fi
+	done
+	sp=$(dirname "$(dirname "$sp")")/state
+	# If the SCSI error handler changed the device state to offline,
+	# change the state back to running.
+	state=$(<"$sp")
+	if [ "$state" = offline ]; then
+		echo running > "$sp"
+		echo "$dev: state $state -> running" >>"$FULL"
+	else
+		echo "$dev: state $state" >>"$FULL"
+	fi
+}
+
+# $1: dm device to examine, e.g.
+# /dev/disk/by-id/dm-uuid-mpath-360014056e756c6c62300000000000000
+make_all_running() {
+	local d h dev=$1
+
+	while [ -L "$dev" ]; do
+		dev=$(realpath "$dev")
+	done
+	dev=${dev#/dev/}
+	for h in /sys/class/block/*/holders/"$dev"; do
+		[ -e "$h" ] || continue
+		d=$(basename "$(dirname "$(dirname "$h")")")
+		make_running "$d"
+	done
+}
+
+# $1: dm device to act on.
+set_running_loop() {
+	local dev="$1"
+
+	[ -e "$dev" ] || return $?
+	while true; do
+		sleep 1
+		make_all_running "$dev"
+	done
+	echo "set_running_loop $dev finished" >>"$FULL"
+}
+
+# $1: dm device to reset periodically; $2: how long the reset loop should run.
+sg_reset_loop() {
+	local cmd dev="$1" duration="$2" deadline i=0 reset_type
+
+	[ -e "$dev" ] || return $?
+	[ -n "$duration" ] || return $?
+	reset_type=(-d -b)
+	deadline=$(($(uptime_s) + duration))
+	while true; do
+		sleep_until 1 ${deadline} || break
+		cmd="sg_reset --no-esc ${reset_type[i++ % 2]} $dev"
+		{ echo "+ $cmd"; eval "$cmd"; } >>"$FULL" 2>&1
+	done
+	echo "sg_reset_loop $dev finished" >>"$FULL"
+}
+
+test_sg_reset() {
+	local dev fio_status m job
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	sg_reset_loop "$dev" "$TIMEOUT" &
+	# Redirect stderr to suppress the bash "Terminated" message.
+	set_running_loop "$dev" 2>/dev/null &
+	job=$!
+	run_fio --verify=md5 --rw=randwrite --bs=64K --loops=$((10**6)) \
+		--iodepth=16 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --runtime="${TIMEOUT}" \
+		--filename="$dev" --name=sg-reset-test --thread --numjobs=1 \
+		--output="${RESULTS_DIR}/srp/fio-output-014.txt" \
+		>>"$FULL"
+	fio_status=$?
+	kill "$job"
+	make_all_running "$dev"
+	wait
+	return $fio_status
+}
+
+test() {
+	: "${TIMEOUT:=30}"
+	trap 'trap "" EXIT; teardown' EXIT
+	setup && test_sg_reset && echo Passed
+}
diff --git a/tests/srp/014.out b/tests/srp/014.out
new file mode 100644
index 000000000000..5e25d8e8672d
--- /dev/null
+++ b/tests/srp/014.out
@@ -0,0 +1,2 @@
+Configured SRP target driver
+Passed
-- 
2.22.0.770.g0f2c4a37fd-goog

