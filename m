Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C022C43218
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 23:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487F020820
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 23:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDhf1Lyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbfFJXgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:36:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41538 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390524AbfFJXgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 19:36:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ANZHHn157019;
        Mon, 10 Jun 2019 23:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ntWK+pCt536OibhyKkZTvsoWXYa7hqywIuXD5qrZOVw=;
 b=HDhf1LyvwT2q07uWLPJhlfX17Y9eEOuQbJXH/RGkebIezj2Iy2Vf0WPx55cSpPNyHyil
 YlJtyoGRp/VJuI8iHBORSfyXe5hjMoz4fX0YvwVgdjNKapWKLga3R6szNyX3ABaMW+eq
 WAW3DWL3WxSxDdBG0Kz2HZ2UOBILyQIDAioe3zIl+tACSgUSDaS92jIQEspcreXaC0lg
 zQ1QL5ruRIbee3ix2Hj67ByqgeV6SVWbqA8C2xST0md9YeYRr630WClJI3uMHeO0I/Ml
 H4i6MgMrZbjWzsnCDtNmiACGDcFIWxqeZeAE4KVxf9caPItcnyDPFPxwbRzw5TLYAQve FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqhqmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 23:35:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ANYmvq042495;
        Mon, 10 Jun 2019 23:35:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t1jph4qa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 23:35:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5ANZfcv010048;
        Mon, 10 Jun 2019 23:35:41 GMT
Received: from localhost.localdomain (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 16:35:40 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     yi.zhang@redhat.com, osandov@fb.com, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v2 blktests] block: add freeze/unfreeze sequence test
Date:   Tue, 11 Jun 2019 07:35:06 +0800
Message-Id: <20190610233506.23610-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reproduce the hang fixed by
7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").

--
v2:
- Add 022.out

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 tests/block/022     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out |  2 ++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

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
diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 0000000..14d43cb
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,2 @@
+Running block/022
+Test complete
-- 
2.9.5

