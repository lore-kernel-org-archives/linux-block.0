Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC9C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4721019
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3fWsyPPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfE2JA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 05:00:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2JA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 05:00:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T8rpkS122261;
        Wed, 29 May 2019 09:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qzKOCogXcL/6jHjtuPxzkF+o1nWPqgvVV75aCmit2Mo=;
 b=3fWsyPPGEuQqBALF2YoE47zD2FwXrUlNRE88fJt3jc1XPsRGM6Sj0C/BTdR6DIdTF4cc
 DaTgZVCwoNE+3lDufADHy8k6H6lKzwm4CYAi2KeCHe/aksuLAHOZ9d723MMQSFbe42Cf
 Hf0LSttFvPU9wvSNWBrXG2hB4X68qijvxGQts/2QTqi2830h/G1TrifutXvTk66WDxiF
 1kvuOt7iKt5j/pSOlKFlvdN07/8KS9e7uYiXarFFs6dPSIRPx+A8kbC06gqUqQyI6Ubt
 F4dYHD6fjQmh4tYnJxPhCt0dPHzvHwWM5viS99HKdeouygUzDloAZc4oHmzKYAETaLTl xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tgbjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 09:00:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T8xLD9025013;
        Wed, 29 May 2019 09:00:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fnb9fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 09:00:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4T90rCm002216;
        Wed, 29 May 2019 09:00:53 GMT
Received: from localhost.localdomain (/101.95.182.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 02:00:52 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH blktests] block: add queue freeze/unfreeze sequence test
Date:   Wed, 29 May 2019 17:00:27 +0800
Message-Id: <20190529090027.25224-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290060
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reproduce the hang fixed by
7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 tests/block/022 | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 tests/block/022

diff --git a/tests/block/022 b/tests/block/022
new file mode 100755
index 0000000..e3ac197
--- /dev/null
+++ b/tests/block/022
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Bob Liu <bob.liu@oracle.com>
+#
+# Test hang caused by freeze/unfreeze sequence. Regression
+# test for 7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="Test hang caused by freeze/unfreeze sequence"
+TIMED=1
+
+requires() {
+	_have_null_blk && _have_module_param null_blk shared_tags
+}
+
+hotplug_test() {
+	while :
+	do
+		echo 1 > /sys/kernel/config/nullb/"$1"/power
+		echo 0 > /sys/kernel/config/nullb/"$1"/power
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	: "${TIMEOUT:=30}"
+
+	if ! _init_null_blk shared_tags=1 nr_devices=0 queue_mode=2; then
+		return 1
+	fi
+
+	mkdir -p /sys/kernel/config/nullb/0
+	mkdir -p /sys/kernel/config/nullb/1
+	hotplug_test 0 &
+	pid0=$!
+	hotplug_test 1 &
+	pid1=$!
+
+	#bind process to two different CPU
+	taskset -p 1 $pid0 >/dev/null
+	taskset -p 2 $pid1 >/dev/null
+
+	sleep "$TIMEOUT"
+	{
+		kill -9 $pid0
+		wait $pid0
+		kill -9 $pid1
+		wait $pid1
+	} 2>/dev/null
+
+	rmdir /sys/kernel/config/nullb/1
+	rmdir /sys/kernel/config/nullb/0
+
+	_exit_null_blk
+	echo "Test complete"
+}
+
-- 
2.9.5

