Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089BC28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4924392
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 00:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="36tPzAQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE3AN4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 20:13:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE3AN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 20:13:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U09dGU113810
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 00:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=lFdygXG/gVMztufS+flhBzf3rRJzfm/EiCMMg09dOl0=;
 b=36tPzAQbmYwb6V56olonbRC+eg9tVhVw3caOT4DbBC7OmI0skFzveB5NTeNfxZihi1Gw
 avmjlOGXuHKfL77Cpb1RsEkVIDsap+PPh/3Gp3I1dN8pyxi9HkQI3auoNgt3YbVn1LbA
 Kl6EF0GtHhR4vT0h1Ew3BWdB71P8+qqCJmS9puHJJBP+Ad3+x5v4c6rQQ83R60Uw3OqN
 2ET5hL1VKFlBlyTgwYDWzdFJeB/oQGGazvGhWSfJ5wLjt7QmyQUY9W8ZPxFMw7lt1JgL
 M8/GNXhnhSpzDFRRQ6lhljNLyCFr+EkKeCklfZIXXf7yjfuLILyZsPfnyn667krjiB0E Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbqcxyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 00:13:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U0CXq7187145
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 00:13:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh740s13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 00:13:54 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U0DqBA031909
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 00:13:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 17:13:52 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2] blktests: block/022: Add tests to verify read-only state transitions
Date:   Wed, 29 May 2019 20:13:52 -0400
Message-Id: <20190530001352.349-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=903
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=944 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300000
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have had several regressions wrt. read-only device handling. This
is mainly caused by the fact that the device ro state can be set both
by the user as well as the device.

Add a series of tests that verify that all the intersections of user
policy vs. device state changes are handled correctly in the block
layer.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

v2: Hadn't verified the non-sdebug-wp parameter case after I changed
output format. Fixed.
---
 tests/block/022     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out | 22 +++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

diff --git a/tests/block/022 b/tests/block/022
new file mode 100755
index 000000000000..2ce2cabc8ec9
--- /dev/null
+++ b/tests/block/022
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Martin K. Petersen <martin.petersen@oracle.com>
+#
+# Test that device read-only state transitions are handled correctly.
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="test that device read-only state transitions are handled correctly"
+
+requires() {
+	_have_scsi_debug
+}
+
+get_ro() {
+	local sys="/sys/block/${SCSI_DEBUG_DEVICES[0]}"
+	local ROSTATE=()
+
+	for part in "${sys}"/ro "${sys}"/*/ro; do
+		ROSTATE+=("$(cat "${part}")")
+	done
+
+	echo "${ROSTATE[*]}"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_scsi_debug dev_size_mb=128 num_parts=3; then
+		return 1
+	fi
+
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+	local sys="/sys/block/${SCSI_DEBUG_DEVICES[0]}"
+	local wp="/sys/module/scsi_debug/parameters/wp"
+
+	echo "Verify that device comes up read-write"
+	get_ro
+
+	echo "Verify that setting partition 2 read-only works"
+	blockdev --setro "${dev}2"
+	get_ro
+
+	echo "Verify that setting whole disk read-only works"
+	blockdev --setro "${dev}"
+	get_ro
+
+	echo "Verify that device revalidate works for whole disk policy"
+	echo 1 > "${sys}/device/rescan"
+	get_ro
+
+	echo "Verify that setting whole disk device back to read-write works"
+	blockdev --setrw "${dev}"
+	get_ro
+
+	echo "Verify that device revalidate works for partition policy"
+	echo 1 > "${sys}/device/rescan"
+	get_ro
+
+	echo "Verify setting hardware device read-only"
+	if [[ -f "${wp}" ]]; then
+		echo 1 > "${wp}"
+		echo 1 > "${sys}/device/rescan"
+		get_ro
+	else
+		echo "1 1 1 1"
+	fi
+
+	echo "Verify setting hardware device read-write"
+	if [[ -f "${wp}" ]]; then
+		echo 0 > "${wp}"
+		echo 1 > "${sys}/device/rescan"
+		get_ro
+	else
+		echo "0 0 1 0"
+	fi
+
+	echo "Verify that partition read-only policy is lost after BLKRRPART"
+	blockdev --setro "${dev}2"
+	blockdev --rereadpt "${dev}"
+	get_ro
+
+	echo "Verify that whole disk read-only policy persists after BLKRRPART"
+	blockdev --setro "${dev}"
+	blockdev --rereadpt "${dev}"
+	get_ro
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 000000000000..c89d6d81903d
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,22 @@
+Running block/022
+Verify that device comes up read-write
+0 0 0 0
+Verify that setting partition 2 read-only works
+0 0 1 0
+Verify that setting whole disk read-only works
+1 1 1 1
+Verify that device revalidate works for whole disk policy
+1 1 1 1
+Verify that setting whole disk device back to read-write works
+0 0 1 0
+Verify that device revalidate works for partition policy
+0 0 1 0
+Verify setting hardware device read-only
+1 1 1 1
+Verify setting hardware device read-write
+0 0 1 0
+Verify that partition read-only policy is lost after BLKRRPART
+0 0 0 0
+Verify that whole disk read-only policy persists after BLKRRPART
+1 1 1 1
+Test complete
-- 
2.21.0

