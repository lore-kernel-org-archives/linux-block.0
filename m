Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C7C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11FE206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbfHAWJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:09:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46790 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfHAWJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:09:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so32766138plz.13
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGKJzWKJmZpsvxyUxVFTBz63fwcVcFFbAn/VInw9gnY=;
        b=jxQ+X2hIuYQHnzu1TUAs1mDLIqw6001VFd/0A4VAB/n+68bHAm9s1YHu+Ujg2gmRLd
         1KQcXWukYnF2CkZ36VQaTw98jlI1bQJGcKLp5sXW7XQ1dlJ5dbjn94EBCM1UrvLS7AZd
         kSneQHzEn5isgLv5DQNenpe+Nm+8DMZ3jCmU5DdZZoKexygaO6NkWzJ8rG7Cn2VG0Ll1
         VH4rj/80fBhJXuEhUbcXRWcZaliEMfGP1mJ7Q1Hk2gd7K7vGMZBGpmrK3pu/Qa5wQYTs
         Vq6tEi3p34G0IfhaUZPRa2w0BNaSEC/INASvDleOXyrba0pGvUVTOb/AeWRvY7cVrCSp
         i7Fg==
X-Gm-Message-State: APjAAAUltef+6y4fR71O8JUmaI7rqVRwuEuMQB3LWX9GotOCC9UOaIJ7
        J6TX5C1lRRtts5KI+X6fg4E=
X-Google-Smtp-Source: APXvYqxNQdGlXmNYwL59MJMvQ85h/YYL+aDYSQyEnLU+qO/UIq6SEgkT05756aeWGiQeuzK1rj6wWA==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr33931074plr.159.1564697386907;
        Thu, 01 Aug 2019 15:09:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r15sm79215287pfh.121.2019.08.01.15.09.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:09:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] tests/srp/014: Add a test that triggers a SCSI reset while I/O is ongoing
Date:   Thu,  1 Aug 2019 15:09:37 -0700
Message-Id: <20190801220937.133392-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test triggers the task management function handling code in the SRP
initiator and target drivers. This test verifies the following kernel
patch: fd5614124406 ("scsi: RDMA/srp: Fix a sleep-in-invalid-context
bug") # v5.3.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

A note regarding the copyright notice: I wrote this patch more than a year
ago. Hence the copyright attribution to Western Digital.

 tests/srp/014     | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/srp/014.out |   2 +
 2 files changed, 106 insertions(+)
 create mode 100755 tests/srp/014
 create mode 100644 tests/srp/014.out

diff --git a/tests/srp/014 b/tests/srp/014
new file mode 100755
index 000000000000..bc2e844abdd2
--- /dev/null
+++ b/tests/srp/014
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
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
+	local dev fio_status m job jobfile
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	sg_reset_loop "$dev" "$TIMEOUT" &
+	jobfile=$(mktemp)
+	# Redirect stderr to suppress the bash "Terminated" message.
+	(set_running_loop "$dev" 2>/dev/null & echo $! > "$jobfile")
+	job=$(<"$jobfile")
+	rm -f "$jobfile"
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

