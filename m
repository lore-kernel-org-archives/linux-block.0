Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945DBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 08:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiBXIOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiBXINd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 03:13:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA33720E7B0
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 00:12:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso5027278pju.4
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 00:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2gUtwz2XT30takhrE4qNbeayWAmeKBPeOvMDrxWjT6s=;
        b=LXUUwr0xVYGaadDo2aKDFNjGW0GECjcVdyowC5kkRakFgRVmDYiAdw2TKby660U0zN
         oOBOoe4P1m/xysN3aVz13f+tXDWsZXyfIZYShixOWFBvkd5E9suGS1K7Z5wo5f2wsK/b
         a5PA1HJx3peQxbassJPG3+SuI1cmvB7Db6A6m+y+QOzVq2KoM1+qzNOnndqiePwCY05W
         ayX3jQqY1QdyaepxmBXjJ2ltQr2Z8Sl1lCASlFrqycOJ2JzyIZ0xqKxw2D6n9hvo5vaB
         4yUOcIhmD1j9lQkQMdpDGdj4LqwFgd9zIveUbZVWUQOEurDyqn4e3lpcBkyH7n9HR8FH
         zQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2gUtwz2XT30takhrE4qNbeayWAmeKBPeOvMDrxWjT6s=;
        b=z4rmZLF9jZ1Edr0Q0GwHxsIuLYyyHwK/AgxT5/n6hUu7LAmwto7NH/b56qeaG5B7F3
         Oq3lvFThtPm/QWDdj7TLELx9drxBrMtYwBdz/TBjWyPHARRI+M45EhdQGF5lCgk8H0kK
         4l37DwifXp/JLxSXxobdtoLPoL8A7baCsWuhCVJ2nWJLhB1lKRezpZRXvJGNKQDQ7i1R
         Ute/Uz5UHCm6qIpyS7/Zk8usNo/1T9W06ktTpMw/d355AeaXRMVbIqvvHExU96OqM8lD
         PTumh8hmNe6seiGtWsia6skB5kMNBUnAWdJDADYntX4Xb9LmHqj91ko0o+AbjkbcwZyB
         emcA==
X-Gm-Message-State: AOAM531lI+IX2sbEzZSOlpii/T5cFbj4U/T3tXbc3OrO5P3AztLpjG/D
        UkFeZ4kO5qj5Embvksk0LcE=
X-Google-Smtp-Source: ABdhPJxrSaoAoshXMDaCmQ4CTIGC938qfQjUGYIuQDhC5d/78c6pjC4GaHCrRoLRY2zcobrqQlSSZQ==
X-Received: by 2002:a17:902:aa8a:b0:14f:460d:bf2e with SMTP id d10-20020a170902aa8a00b0014f460dbf2emr1468720plr.144.1645690373182;
        Thu, 24 Feb 2022 00:12:53 -0800 (PST)
Received: from localhost.localdomain ([103.112.79.202])
        by smtp.gmail.com with ESMTPSA id l2sm2337769pfc.183.2022.02.24.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:12:52 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     osandov@osandov.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [RFC V3 blktests] block/032: add test case for open and close rqos policy w/ io
Date:   Thu, 24 Feb 2022 16:11:38 +0800
Message-Id: <20220224081138.53098-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: root <root@localhost.localdomain>

This test case is to test switching rqos policy w/ io running.
The fio is running under cgroup with blkio controller opened.

Signed-off-by: root <root@localhost.localdomain>
---
 tests/block/032     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/032.out |  2 ++
 2 files changed, 88 insertions(+)
 create mode 100755 tests/block/032
 create mode 100644 tests/block/032.out

diff --git a/tests/block/032 b/tests/block/032
new file mode 100755
index 0000000..c256ff2
--- /dev/null
+++ b/tests/block/032
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Wang Jianchao
+#
+# Stress test to run the fio in cgroup and iocost/iolatency/ioprio switching
+# concurrently. It mainly to verify the lifecycle of rqos when rqos policy
+# is deactivated.
+
+. tests/block/rc
+. common/cgroup
+
+DESCRIPTION="Stress test for concurrent fio in cgroup and rqos policy switching"
+TIMED=1
+
+requires() {
+	_have_cgroup2_controller io && _have_fio
+}
+
+test_device() {
+
+	echo "Running ${TEST_NAME}"
+
+	_init_cgroup2
+
+	# setup cgroups
+	local cgrp2_dir=$(_cgroup2_base_dir)
+	echo "+io" > ${cgrp2_dir}/cgroup.subtree_control
+	echo "+io" > "${CGROUP2_DIR}/cgroup.subtree_control"
+
+	if _test_dev_is_rotational; then
+		size="32m"
+	else
+		size="1g"
+	fi
+
+	local rqos=("wbt" "iolat" "iocost" "ioprio")
+	local devn=`cat ${TEST_DEV_SYSFS}/dev`
+	local cgrp
+
+	fio_jobs=()
+	for ((cgrp=0; cgrp<8; cgrp++))
+	do
+		mkdir -p "$CGROUP2_DIR/block032-$cgrp"
+		fio_jobs+=("--name=job$cgrp" "--cgroup="blktests/block032-$cgrp"")
+	done
+
+	# start fio job
+	fio --rw=randread --direct=1 --ioengine=libaio --iodepth=128 \
+	    --bs=4K --group_reporting=1 --loops=100000 --runtime=120 \
+	    --filename=${TEST_DEV} --size=${size} \
+	    "${fio_jobs[@]}" > /dev/null &
+
+	start_time=$(date +%s)
+	timeout=${TIMEOUT:=900}
+	while kill -0 $! 2>/dev/null; do
+		idx=$((RANDOM % ${#rqos[@]}))
+		pol=${rqos[$idx]}
+		cat ${TEST_DEV_SYSFS}/queue/qos | grep "\[$pol\]" > /dev/null
+		if [ $? -eq 0 ];then
+			echo "-$pol" > ${TEST_DEV_SYSFS}/queue/qos
+		else
+			echo "+$pol" > ${TEST_DEV_SYSFS}/queue/qos
+			case $pol in
+				"iocost")
+					echo "$devn enable=1 ctrl=auto" > ${cgrp2_dir}/io.cost.qos
+					echo "$devn ctrl=auto" > ${cgrp2_dir}/io.cost.model
+					;;
+				"iolat")
+					;;
+				"ioprio")
+					;;
+				*)
+					;;
+			esac
+		fi
+		sleep .2
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout + 15 )); then
+			echo "fio did not finish after $timeout seconds!"
+			break
+		fi
+	done
+
+	_exit_cgroup2
+	echo "Test complete"
+}
diff --git a/tests/block/032.out b/tests/block/032.out
new file mode 100644
index 0000000..3604e9e
--- /dev/null
+++ b/tests/block/032.out
@@ -0,0 +1,2 @@
+Running block/032
+Test complete
-- 
2.17.1

