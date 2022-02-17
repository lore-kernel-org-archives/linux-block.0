Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98A0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 03:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiBQD22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 22:28:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQD22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 22:28:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92C12F417
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:28:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id om7so4303095pjb.5
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DafoJMbLw6PCKxXBrE+9+LukVDxAQQTDVtc0OC6LrAQ=;
        b=WEt8nLsoK0Y747cO6oFFezK7ywa2TE7WXYuL4hVorDM7JmLYIXYP4FAR4AEr11ojKK
         poJW2iq2nm0vyv+ZH4w2J25HMUIGvaU3QFzXXzpLcM8YR5lqyxBnSkmUFH/02umJknyX
         NBbsZJFq+MiIsPtG+sRIxlKY1AeylQOEytWvk7mzl2eh9VelYMDWVsWK9SpEjfpP/wCW
         nd1KfKdifkvgltmUdzPZsKZvFdGCI6NqL22Uew70zt/Z2QA0hbS7GefM9Mbz2awf56e0
         0435tieZAtKZuZJ/CG7ofUDarxjKzlD8O5gI0suahMwZKhTkGWNh3FX+kvWCXPgOYl5n
         4dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DafoJMbLw6PCKxXBrE+9+LukVDxAQQTDVtc0OC6LrAQ=;
        b=EZwxvcEUQoBna0Ck5bDDt3m7Y2OSBjDSnLP8mFJNdZbFEScskq1T1WfvuCNELyqrho
         bi4yE3i9UZW6sm6mCvs61svZMf6ADLz0Ky8uhAtgdLpyU+ec3SA+j3auifhKYvkXvHAz
         yZxztlE2UDXZWJmFF8oZDzT6P5y1E3QLJNbfZvlrJMD7+scSI01eXe33qOUzz03UTPyO
         kBROI9TXrrGrZ32AEM3PpiPKHnSetYqTMdiLdk4wKATlIV5RFJ+W2LkyC4aWQ/fahrqo
         pr0Gcnn8pZb2JycIvKslBsXJIWh9cUwSq/dBQQPzkKxQScSGbPj+JFsqHA9ZK/K5qJIk
         Eoqg==
X-Gm-Message-State: AOAM533vsQtjNY9qa1/B5yn81LnEM25ov5j3gNwhBuZfn9MiioI0Xtc5
        3DuR7RfODZSr+uE1yptUatM=
X-Google-Smtp-Source: ABdhPJzhrpBlVKHRxtUHfxnAZPwOfGIyXU58Nk5GB5i29SNTbpPqa48vbh5Y9I0ySdsNCF0kSg2wfg==
X-Received: by 2002:a17:902:ce86:b0:14c:9139:5839 with SMTP id f6-20020a170902ce8600b0014c91395839mr1039418plg.168.1645068494320;
        Wed, 16 Feb 2022 19:28:14 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.70])
        by smtp.gmail.com with ESMTPSA id 4sm3397691pfh.125.2022.02.16.19.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:28:13 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     osandov@osandov.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [RFC V2 blktests] test/block/032: add test cases for switching queue qos
Date:   Thu, 17 Feb 2022 11:27:04 +0800
Message-Id: <20220217032704.99150-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add test case for switching rq qos policy while doing IO. It will
select a exist policy randomly to close and open it every round.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 tests/block/032     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/032.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/block/032
 create mode 100644 tests/block/032.out

diff --git a/tests/block/032 b/tests/block/032
new file mode 100644
index 0000000..aaecc75
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
+	local rqos=("blk-wbt" "blk-iolat" "blk-iocost" "blk-ioprio")
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

