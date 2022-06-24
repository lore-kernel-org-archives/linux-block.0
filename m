Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098EC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 07:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiFXHud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 03:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXHuc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 03:50:32 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCCB653A5D
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 00:50:30 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AX4MS5KryrN+z2JPr5Z26FicLG7teBmIqZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmVMCGyOPfyCYjH1LdogbImzpE0Hv8fXm9M2T1Zp/C02QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlpJW2R?=
 =?us-ascii?q?hdvPLzklvkfUgVDDmd1OqguFLrveCLi7pTPlhaaG5fr67A0ZK0sBqUc++BqESR?=
 =?us-ascii?q?E8fsTKxgTYR2ZweG72rS2Tq9rnMtLBNLrPYUesXFh1zafDv85SIvKQKTi+tNTm?=
 =?us-ascii?q?jw3g6hz8Vz2DyYCQWM3Kk2ePFsUYRFKYK/SVdyA3hHXGwC0YnrMzUbv31Xu8Q?=
 =?us-ascii?q?=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6HyvFKuN8t8O9xiHfWROBjyj7skDnNV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxraGTdZMgpHjJYVcqKRcdcL+7Scq9qB/nmqKdgrNhWYtKPjOW2l?=
 =?us-ascii?q?dARbsKheCJrlHd8kbFltK1u50PT0EHMqyUMbFlt7eB3CCIV8Yn3MKc8L2lwcPX?=
 =?us-ascii?q?z3JWRwlsbK16hj0JcjqzIwlnQhVcH5olGN657spDnTCpfnMadYCVHX8ANtKz3O?=
 =?us-ascii?q?Hjpdb3ZwIcHR475E2rhTOs0rTzFB+VxVM/flp0sM4fzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125704134"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jun 2022 15:50:29 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 510124D68A22;
        Fri, 24 Jun 2022 15:50:26 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Jun 2022 15:50:26 +0800
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Jun 2022 15:50:26 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Jun 2022 15:50:26 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-block@vger.kernel.org>
CC:     <shinichiro.kawasaki@wdc.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the expected SKIP_REASON
Date:   Fri, 24 Jun 2022 15:50:23 +0800
Message-ID: <20220624075023.23104-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 510124D68A22.A3E3B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In _have_kernel_option(), SKIP_REASON = "kernel option NVME_MULTIPATH
has not been enabled" is expected but all nvmeof-mp tests are skipped
due to the SKIP_REASON. For example:
-----------------------------------------------------
./check nvmeof-mp/001
nvmeof-mp/***                                                [not run]
    kernel option NVME_MULTIPATH has not been enabled
-----------------------------------------------------

Avoid the issue by unsetting the SKIP_REASON.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/nvmeof-mp/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index dcb2e3c..9c91f8c 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -24,6 +24,11 @@ and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
+	# In _have_kernel_option(), SKIP_REASON = "kernel option
+	# NVME_MULTIPATH has not been enabled" is expected so
+	# avoid skipping tests by unsetting the SKIP_REASON
+	unset SKIP_REASON
+
 	_have_configfs || return
 	required_modules=(
 		dm_multipath
-- 
2.34.1



