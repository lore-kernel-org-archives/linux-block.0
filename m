Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E709C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17C720854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5D/eg1Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCNLl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:41:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58388 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCNLl1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 07:41:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EBXRYG183918;
        Thu, 14 Mar 2019 11:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Wf5S91v88xQ9U+owKRxQaT1Vz7ONEtenpjCNh9Y+eW4=;
 b=5D/eg1Zhk/jLNrIsp9TSDrnzwWycFgGQ3P3E+bYaLSY1rg2oSI5I7JoSvXf4sw08zqI+
 EafTulXRn4agKyR33prNmd+xhJctybL2esySNb9+bOD69yHs4ZZdbwX32BU4ymycZdVs
 K3gahH2SumiCFzvCl+EP1y5YKKdZ4lLlAJs57N47uiRwfjxY3XKMsWTdARVZ+3FeJRZX
 +UsITxm2kuLP4mTMkoLGBSkUgYIZLWiMkrxALDjBK038b5gEXywFxTRSirD5/qEpjSlY
 q7O2Wx9XjWDBuHtaKUEop3l9IUZ5ZyVRkdXwIQEDZhRss3Sa+EVcB6KiWf11MDnwxzZY xA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r44wuge51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:41:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2EBfLNk011164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:41:21 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2EBfL0L030185;
        Thu, 14 Mar 2019 11:41:21 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 11:41:20 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Cc:     jack@suse.cz
Subject: [PATCH blktests 2/2] loop/001: verify all partitions are removed
Date:   Thu, 14 Mar 2019 19:45:17 +0800
Message-Id: <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
References: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140082
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop/001 does not test whether all partitions are removed successfully
during loop device partition scanning. As a result, the regression
introduced by 0da03cab87e6 ("loop: Fix deadlock when calling
blkdev_reread_part()") can not be detected.

The regression will generate below message in dmesg:

[  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)

and leave orphan partitions like below:

- /dev/loop0p1
- /sys/block/loop0/loop0p1

This patch verifies all partitions are removed by checking if there is
/sys/block/loopX/loopXpY left. The expected number of partitions left is 0.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tests/loop/001     | 5 +++++
 tests/loop/001.out | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tests/loop/001 b/tests/loop/001
index 47f760a..a0326b7 100755
--- a/tests/loop/001
+++ b/tests/loop/001
@@ -4,6 +4,9 @@
 #
 # Test loop device partition scanning. Regression test for commit e02898b42380
 # ("loop: fix LO_FLAGS_PARTSCAN hang").
+#
+# Test loop device paritition scanning. Regression test for commit 758a58d0bc67
+# ("loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
 
 . tests/loop/rc
 
@@ -24,9 +27,11 @@ test() {
 		mkpart primary 50% 100%
 
 	loop_device="$(losetup -P -f --show "$TMPDIR/img")"
+	loop_name=${loop_device:5}
 	lsblk -ln "$loop_device" | wc -l
 
 	losetup -d "$loop_device"
+	ls /sys/block/$loop_name | grep loop | wc -l
 	rm "$TMPDIR/img"
 	echo "Test complete"
 }
diff --git a/tests/loop/001.out b/tests/loop/001.out
index 75979f0..8c4917f 100644
--- a/tests/loop/001.out
+++ b/tests/loop/001.out
@@ -1,3 +1,4 @@
 Running loop/001
 3
+0
 Test complete
-- 
2.7.4

