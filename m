Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475FDC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 08:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiBXIzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiBXIzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 03:55:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD221164D2F
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 00:54:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g1so1302853pfv.1
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 00:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=32DByH6vX/KFle8OsvMqwALHe3eUcgPRF7B5vKXTRIk=;
        b=lY+Bd7Mqc2ONfTDXwfbUHKf9AyAiX4+yeOBOmqXxzxq2hw4/VGvmp8vdegSUPOh8h7
         hxItUp3stMQ+uQtxQ4/rxY6wk6n5swKU5LD5zuhsei0raqhXVlvZBpsB3vwByohADs7X
         319D9CdjGc+LDj3BUYXjC2d8TBdZ+927ua70WCBe5y2i8eEBkzZYZFLSM3WHix0VdDq4
         ojhRqYS8Hd9fOEX++Ay227HFVZKoa+TDOVs3/CPo5EApCh1PIH/2nrhp9u30pVvJHnJP
         gtNZRtA3i2TF93NoO+fWsyU+CxK457e2PZBB6Msh1t+AwbzQa0gj1gOmgpeHH/W5tRLa
         CQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=32DByH6vX/KFle8OsvMqwALHe3eUcgPRF7B5vKXTRIk=;
        b=gD5kMleDIol1MjO0+2avbg0R+7txRtfDJcnLSb0kw5s0qKmRlcYeg/z7JS82Mf83AN
         aX7hqVzJQxBOSCAiuyufxlTFlsacSvMaBTAM5Dqcq+liB2iXGZnV5Bf79E4+cLpCRhRN
         5WKmj7tdrkifnxUgK+MY1e9Z9PzEccll7Yn/7koDHsB3y2vBE3wnKu81tQt6G5Fl7svV
         3/oPyWJCH2+UuG+FXCDokfofVqYe6N4Az39Q6Rmls/Ywkai5K84MmHEIJHdiuRk51che
         4ra7I9Xb+igMHITsEC1Vz+vwF9zzhim8XLyjhpWJcIksAypmSUVAuHYE17RKXwci3h3N
         h7Tg==
X-Gm-Message-State: AOAM530zLvm+V5fx+SvRC8Wl/eONQoSHadwQoZUXoR8FYgJHQtv90BO/
        37s39cVDBh1b4uZBfsXyQ7c=
X-Google-Smtp-Source: ABdhPJx0Tjbh+2Cb+302RKiqZY3oHYqDGBel8NtW/RVa8dG+FeLk2GSyTxw57l8Xvh3bvczzNt3K9Q==
X-Received: by 2002:a05:6a00:88e:b0:4d2:4829:156c with SMTP id q14-20020a056a00088e00b004d24829156cmr1804682pfj.47.1645692889277;
        Thu, 24 Feb 2022 00:54:49 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q13sm2799300pfl.210.2022.02.24.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:54:48 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     osandov@osandov.com
Cc:     linux-block@vger.kernel.org
Subject: [RFC RESEND V3 blktests] block/032: add test case for open and close rqos policy w/ io
Date:   Thu, 24 Feb 2022 16:53:40 +0800
Message-Id: <20220224085340.53854-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test case is to test switching rqos policy w/ io running.
The fio is running under cgroup with blkio controller opened.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
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

