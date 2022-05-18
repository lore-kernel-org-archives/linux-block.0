Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 03:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiERDq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 23:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiERDqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 23:46:44 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFF36205F4
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 20:46:36 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AyIW86q7tLH8HwHNgpCR+qwxRtO7FchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0DwBm2YeXz3SaazeNmf8c9ggO9u/oRlT6sTdmtBkSwY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouOceSbv4ZH7I0ruNiGEL+9VJEsoNIsR4f18AWx?=
 =?us-ascii?q?m/PcdbjcXYXirgPm/xr68VMFijIIoK8yDFJIe/GNgxDfWJewrTZDKX+PB4tow9?=
 =?us-ascii?q?DMxgN1eWPzaYMEaQSRgYQ6GYBBVPFoTTpUkk4+VatPXG9FDgAvN4/NpvC6Il0o?=
 =?us-ascii?q?suIUB+eH9IrSiLfi5VG7Bzo4ew1nEPw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiNcWz6w0a93Cav2amW+IKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124306885"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 May 2022 11:44:46 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 84AC54D16FDF;
        Wed, 18 May 2022 11:44:45 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 18 May 2022 11:44:45 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 18 May 2022 11:44:45 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <osandov@fb.com>, <yi.zhang@redhat.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Date:   Wed, 18 May 2022 11:44:43 +0800
Message-ID: <20220518034443.46803-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 84AC54D16FDF.AA2A3
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
 tests/nvmeof-mp/001     | 7 +++++--
 tests/nvmeof-mp/001.out | 1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index f3e6394..82cb298 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -18,7 +18,11 @@ count_devices() {
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
@@ -27,7 +31,6 @@ wait_for_devices() {
 		sleep .1
 	done
 	echo "count_devices(): $devices <> $expected" >>"$FULL"
-	echo "count_devices(): $devices <> $expected"
 	[ "$devices" -ge $expected ]
 }
 
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



