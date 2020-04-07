Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F3C2BA2B
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14632078A
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 14:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgDGORE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:17:04 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:6849 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1728737AbgDGORE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 10:17:04 -0400
X-ASG-Debug-ID: 1586268998-0e408857446da600001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.236]) by bsf01.didichuxing.com with ESMTP id SocDcA0GUwJORJ7n; Tue, 07 Apr 2020 22:16:38 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 22:16:38 +0800
Date:   Tue, 7 Apr 2020 22:16:33 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <osandov@osandov.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Message-ID: <20200407141621.GA29060@192.168.3.9>
X-ASG-Orig-Subj: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Mail-Followup-To: osandov@osandov.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.236]
X-Barracuda-Start-Time: 1586268998
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3032
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0005 1.0000 -2.0178
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=MAILTO_TO_SPAM_ADDR
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81036
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    Includes a link to a likely spammer email
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify nvme module parameter write_queues to change hardware
queue count, then reset nvme controller to reinitialize nvme
with different queue count.

Attention, this test case may trigger a kernel panic.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 tests/nvme/033     | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  2 ++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..e3b9211
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,87 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2020 Weiping Zhang <zwp10758@gmail.com>
+#
+# Test nvme update hardware queue count larger than system cpu count
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme update hardware queue count larger than system cpu count"
+QUICK=1
+
+requires() {
+	_have_program dd
+}
+
+device_requires() {
+	_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local old_write_queues
+	local cur_hw_io_queues
+	local file
+	local sys_dev=$TEST_DEV_SYSFS/device
+
+	# backup old module parameter: write_queues
+	file=/sys/module/nvme/parameters/write_queues
+	if [[ ! -e "$file" ]]; then
+		echo "$file does not exist"
+		return 1
+	fi
+	old_write_queues="$(cat $file)"
+
+	# get current hardware queue count
+	file="$sys_dev/queue_count"
+	if [[ ! -e "$file" ]]; then
+		echo "$file does not exist"
+		return 1
+	fi
+	cur_hw_io_queues="$(cat "$file")"
+	# minus admin queue
+	cur_hw_io_queues=$((cur_hw_io_queues - 1))
+
+	# set write queues count to increase more hardware queues
+	file=/sys/module/nvme/parameters/write_queues
+	echo "$cur_hw_io_queues" > "$file"
+
+	# reset controller, make it effective
+	file="$sys_dev/reset_controller"
+	if [[ ! -e "$file" ]]; then
+		echo "$file does not exist"
+		return 1
+	fi
+	echo 1 > "$file"
+
+	# wait nvme reinitialized
+	for ((m = 0; m < 10; m++)); do
+		if [[ -b "${TEST_DEV}" ]]; then
+			break
+		fi
+		sleep 0.5
+	done
+	if (( m > 9 )); then
+		echo "nvme still not reinitialized after 5 seconds!"
+		return 1
+	fi
+
+	# read data from device (may kernel panic)
+	dd if="${TEST_DEV}" of=/dev/null bs=4096 count=1 status=none
+
+	# If all work well restore hardware queue to default
+	file=/sys/module/nvme/parameters/write_queues
+	echo "$old_write_queues" > "$file"
+
+	# reset controller
+	file="$sys_dev/reset_controller"
+	echo 1 > "$file"
+
+	# read data from device (may kernel panic)
+	dd if="${TEST_DEV}" of=/dev/null bs=4096 count=1 iflag=direct status=none
+	dd if=/dev/zero of="${TEST_DEV}" bs=4096 count=1 oflag=direct status=none
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..9648c73
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,2 @@
+Running nvme/033
+Test complete
-- 
2.18.1

