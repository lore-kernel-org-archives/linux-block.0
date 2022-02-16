Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF942C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 12:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiBPMBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:01:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiBPMBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 07:01:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35274271E1E
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 04:00:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso2142207pjh.5
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 04:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GCdIUFdujlOzAKymVHoLCjyy0z76tPnSzT+6kO8LwWY=;
        b=VpOFOuvhXjUv2E2IuKYyPHXPM0cR/te4hKts3kgukz5bppZaQYGoCJfklbNgCwFkKL
         jEe/NgIwPiASQI53Wutj7s2N42bf9OG35/iIeS1TSQCofdvaPAsnltYnOhsltWnYorzf
         Stjgzwq7e89y3hsmVqvuU/jk0J6XZyw70FgXfj6GkUu4pE8hSjMQRQdZqzkrGDg+zK3j
         T2AvKf4qla1q6UJ2d5ETbwLZxM6xzKbm6ptsDzpO0Vs5+xufit2by9drVo4mmigRiRzK
         chkXsnGhiIAQNDbvq4GUx5rr+BsPWOYhIDiqSSdprG5vS1+SuUST0qaq2xfIrT15CSvt
         ia3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GCdIUFdujlOzAKymVHoLCjyy0z76tPnSzT+6kO8LwWY=;
        b=NheVM5HTLGZ96SMoKegAir3Qnmtq+4n3C1oWjvTyGyM+6oOpy3dIdU3mfFQ636cCAl
         4JHl9Or10Q/6TTlojeHVV+AQ0NYz0INOH1RHTiZYCj2OtjBeBGOAUEgfdtRwfPXFZCPT
         aVpxEr9QCqj2L2h+Eb4/3OhgvEu9rnaCvxjXYfL8KKSoc/eQcEl8lh9ZnCLm/ub1xWBm
         xuWZdXu8Kh9WnYcUZWhwaXG+/zH4Pr93V6e5sOvLdlIF0KyysNQLlLe6HXf/zkeWHlBE
         EEzC4aXuHgEieA819PM/q79VrpRsPBMuZ7nhCifZu96qKU55xY28KkDB+7CosuMMWRP0
         nRdg==
X-Gm-Message-State: AOAM532AWGuc3NDEPjC2oXhNOJbZL1zPNH2Elws/pJ5qt/EHm30HeNK1
        BQ4C7/tWfN5/JNTNtosIoEA=
X-Google-Smtp-Source: ABdhPJz3z8WQkEsGeJwy1bwdL8/bg2zNQcroQdFBJX3jYLpd4WJT7E5MtbA1e8450+m56SB1Ls2NzQ==
X-Received: by 2002:a17:90a:120f:b0:1b8:7ba9:e48f with SMTP id f15-20020a17090a120f00b001b87ba9e48fmr1308130pja.59.1645012856627;
        Wed, 16 Feb 2022 04:00:56 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.73])
        by smtp.gmail.com with ESMTPSA id k14sm44471132pff.25.2022.02.16.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 04:00:56 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     osandov@osandov.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [[RFC blktests]] test/block/032: add test cases for switching queue qos
Date:   Wed, 16 Feb 2022 19:59:47 +0800
Message-Id: <20220216115947.85220-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 tests/block/032     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/032.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/block/032
 create mode 100644 tests/block/032.out

diff --git a/tests/block/032 b/tests/block/032
new file mode 100644
index 0000000..bb10506
--- /dev/null
+++ b/tests/block/032
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Wang Jianchao
+#
+# Threads doing IO to a device, while we switch rqos
+
+. tests/block/rc
+
+DESCRIPTION="switch rqos while doing IO"
+TIMED=1
+CAN_BE_ZONED=1
+
+requires() {
+	_have_fio
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local rqos=("wbt" "iolat" "iocost" "io-prio")
+
+	if _test_dev_is_rotational; then
+		size="32m"
+	else
+		size="1g"
+	fi
+
+	# start fio job
+	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" &
+
+	start_time=$(date +%s)
+	timeout=${TIMEOUT:=900}
+	while kill -0 $! 2>/dev/null; do
+		idx=$((RANDOM % ${#rqos[@]}))
+		pol=${rqos[$idx]}
+		cat ${TEST_DEV_SYSFS}/queue/qos | grep "\[$pol\]" > /dev/null
+		if [ $? -eq 0 ];then
+			echo "-$pol" > ${TEST_DEV_SYSFS}/queue/qos
+			if [ $? -ne 0 ];then
+				echo "$pol"
+				cat ${TEST_DEV_SYSFS}/queue/qos
+			fi
+		else
+			echo "+$pol" > ${TEST_DEV_SYSFS}/queue/qos
+			if [ $? -ne 0 ];then
+				echo "$pol"
+				cat ${TEST_DEV_SYSFS}/queue/qos
+			fi
+		fi
+		sleep .2
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout + 15 )); then
+			echo "fio did not finish after $timeout seconds!"
+			break
+		fi
+	done
+
+	FIO_PERF_FIELDS=("read iops")
+	_fio_perf_report
+
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

