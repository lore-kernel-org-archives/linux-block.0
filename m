Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14698C433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 03:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiEQDxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiEQDxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 23:53:06 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BB113D1E2
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 20:53:03 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A4Qv/3KMOqUhbLT3vrR2elcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQTthW4khWEAyzcXCGHXMqvYNzD9KYp2bNzi/BsBuJ7Qm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnsiZ/0epuSbSZS4mYnJp6HcSFPm3fxoBVotNo0V0u98BCd?=
 =?us-ascii?q?J7/NwADcWZxaPgPyezrj9Qe5p7uwnLc/2LMYVvnZrzhnHAvs8B5POWaPH4Zlfx?=
 =?us-ascii?q?jhYuyzkNZ4yfOJAMXw2MkuGOEYJZz8q5FsFtL/ArhHCn/dw8Tp5fZYK3lU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIc2hoKP4Vw/fG8BcTimjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfUzSL39qynOpoV96faaslYssR0b9exoW5PwJE80l6QFgrX5VI3KNGKN1V?=
 =?us-ascii?q?dAR7sC0WKN+VLd8lXFh4xgPLlbAtNDIey1HV5nltz7/QX9N94hxeOM+Keuify2?=
 =?us-ascii?q?9QYVcShaL7Fn8xxiChuWVml/RAx9D5I/E5aGouVdoT7IQwVuUu2LQmkCQ/PYp8?=
 =?us-ascii?q?DG0LbvYRs9DRYh7wWUyROEgYSKdSSl4g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124280634"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 May 2022 11:53:02 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8E5424D17198;
        Tue, 17 May 2022 11:53:00 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 17 May 2022 11:53:02 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 17 May 2022 11:53:00 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <bvanassche@acm.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] common/multipath-over-rdma: Remove unused debug operation
Date:   Tue, 17 May 2022 11:52:58 +0800
Message-ID: <20220517035258.43945-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8E5424D17198.A6F3C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop ("for m in ;") will never be entered and it seems
unnecessary to debug sereval modules during test. So I try
to remove the debug operation.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 common/multipath-over-rdma | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index cef05ec..8b285e6 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -655,12 +655,6 @@ setup_test() {
 		fi
 	)
 
-	if [ -d /sys/kernel/debug/dynamic_debug ]; then
-		for m in ; do
-			echo "module $m +pmf" >/sys/kernel/debug/dynamic_debug/control
-		done
-	fi
-
 	setup_rdma || return $?
 	start_target || return $?
 	echo "Test setup finished" >>"$FULL"
-- 
2.34.1



