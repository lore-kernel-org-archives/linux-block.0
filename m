Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA44C433F5
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiEUMa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiEUMaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 08:30:25 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6157087203
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:30:24 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Acr7/6KBaqQF+MhVW/9zhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDVHr1Tgh0DQAzGYfWGmCb6yDNGOmKd4iPovj9UoDusKAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSX0iZfQZoOGvzX+X9Jb7I1f9W3HyyvNnF1o9PYAw8+1yR2Z?=
 =?us-ascii?q?U+pQwLysEaByEmcq4yvSwTewErtUiatvrNYUQkmttwTHQEbAtRpWra6HL48JIm?=
 =?us-ascii?q?T00gctNNejRatBfajd1ahnEJRpVNT8/E5I/muajhnjldHtboU2cvqM04kDMwAc?=
 =?us-ascii?q?327/oWOc50PTiqd59xx7e/zyZuT+iRExyCTBW8hLdmlrEuwMFtXqTtFouKYCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1j3ioKjstpCHfLbeIvo7mq3AS3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124401706"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 May 2022 20:30:23 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 47BA04D1718A;
        Sat, 21 May 2022 20:30:22 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 21 May 2022 20:30:23 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 21 May 2022 20:30:23 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <osandov@fb.com>, <yi.zhang@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>
CC:     <linux-block@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests v2] nvmeof-mp/001: Set expected count properly
Date:   Sat, 21 May 2022 20:30:20 +0800
Message-ID: <20220521123020.90046-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 47BA04D1718A.A65DD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The number of block devices will increase according
to the number of RDMA-capable NICs.
For example, nvmeof-mp/001 with two RDMA-capable NICs
got the following error:
-------------------------------------
    Configured NVMe target driver
    -count_devices(): 1 <> 1
    +count_devices(): 2 <> 1
    Passed
-------------------------------------

Set expected count properly by calculating the number
of RDMA-capable NICs.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/nvmeof-mp/001     | 11 +++++++----
 tests/nvmeof-mp/001.out |  1 -
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index f3e6394..70a4455 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -18,17 +18,20 @@ count_devices() {
 }
 
 wait_for_devices() {
-	local expected=1 i devices
+	local expected=0 i devices
+
+	for i in $(rdma_network_interfaces); do
+		((expected++))
+	done
 
 	use_blk_mq y || return $?
 	for ((i=0;i<100;i++)); do
 		devices=$(count_devices)
-		[ "$devices" -ge $expected ] && break
+		[ "$devices" -ge "$expected" ] && break
 		sleep .1
 	done
 	echo "count_devices(): $devices <> $expected" >>"$FULL"
-	echo "count_devices(): $devices <> $expected"
-	[ "$devices" -ge $expected ]
+	[ "$devices" -ge "$expected" ]
 }
 
 test() {
diff --git a/tests/nvmeof-mp/001.out b/tests/nvmeof-mp/001.out
index 2ce8d17..a7d4cb9 100644
--- a/tests/nvmeof-mp/001.out
+++ b/tests/nvmeof-mp/001.out
@@ -1,3 +1,2 @@
 Configured NVMe target driver
-count_devices(): 1 <> 1
 Passed
-- 
2.34.1



