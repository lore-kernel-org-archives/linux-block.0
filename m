Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DEFC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Jun 2022 16:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiFDQGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jun 2022 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jun 2022 12:06:45 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF1D286DB
        for <linux-block@vger.kernel.org>; Sat,  4 Jun 2022 09:06:43 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AoBmlja7lT8QiakvHruQ96AxRtPHFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0jZUnTAfWGzSOfqOYGHxe9tya4S+90gHuMPcx9VqSVY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouOYeSXu65H7I0ruNiGEL+9VJEUxMoQe9c57DGV?=
 =?us-ascii?q?S/OAVJXYGaRXrr+a3xq+rD+Nogc8gBNfkMZlZuXx6yzzdS/E8TvjrWKXL495T3?=
 =?us-ascii?q?DYqgYZNFOnXfMMaaBJwYB+GaBpKUmr7orpWcPyA3yG5KmMH7gnO4/df3oQa9yQ?=
 =?us-ascii?q?puJCFDTYfUoXiqR1po3ul?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Abu8oxKtJhzys0IvT+aPHbcmX7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124705925"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jun 2022 00:06:43 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8A84E4D1716E;
        Sun,  5 Jun 2022 00:06:40 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 5 Jun 2022 00:06:41 +0800
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 5 Jun 2022 00:06:41 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 5 Jun 2022 00:06:40 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <shinichiro.kawasaki@wdc.com>
CC:     <linux-block@vger.kernel.org>, <logang@deltatee.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] nvme/033: Remove volatile output
Date:   Sun, 5 Jun 2022 00:06:38 +0800
Message-ID: <20220604160638.1118-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8A84E4D1716E.A7BE9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The output of _nvme_discover() will be changed according to
${nvme_trtype} and the number of NICs. For example: nvme/033
with nvme_trtype=tcp and two NICs got the following error:
------------------------------------------------
 Running nvme/033
-Discovery Log Number of Records 1, Generation counter X
+Discovery Log Number of Records 2, Generation counter X
 =====Discovery Log Entry 0======
-trtype:  loop
+trtype:  tcp
+subnqn:  nqn.2014-08.org.nvmexpress.discovery
+=====Discovery Log Entry 1======
+trtype:  tcp
 subnqn:  blktests-subsystem-1
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
------------------------------------------------

Remove volatile output to fix the issue.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/nvme/033     | 2 --
 tests/nvme/033.out | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index c6a3f7f..90aee81 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -54,8 +54,6 @@ test_device() {
 	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 
-	_nvme_discover "${nvme_trtype}" | _filter_discovery
-
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
 	compare_dev_info "${nsdev}"
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
index 6f45a1d..eb508be 100644
--- a/tests/nvme/033.out
+++ b/tests/nvme/033.out
@@ -1,7 +1,3 @@
 Running nvme/033
-Discovery Log Number of Records 1, Generation counter X
-=====Discovery Log Entry 0======
-trtype:  loop
-subnqn:  blktests-subsystem-1
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
2.23.0



