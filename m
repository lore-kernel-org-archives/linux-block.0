Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE0C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AECD2084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 13:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZNiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:38:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:48544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDZNiC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 09:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 06:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="152591237"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2019 06:38:00 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v5 0/3] lightnvm: next set of improvements for 5.2
Date:   Fri, 26 Apr 2019 15:35:10 +0200
Message-Id: <20190426133513.23966-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is another set of fixes and improvements to both pblk and lightnvm
core. 

Changes v4 -> v5:
-dropped patches which were already pulled into for-5.2/core branch
-rebasing of other patches
-multiple copies of smeta patch moved into last position in series
so it would be easier to pull only previous patches if needed

Changes v3 -> v4:
-dropped patches which were already pulled into for-5.2/core branch
-major changes for patch #2 based on code review
-patch #6 modified to use krefs
-new patch #7 which extends the patch #6

Changes v2 -> v3:
-dropped some not needed patches
-dropped patches which were already pulled into for-5.2/core branch
-commit messages cleanup

Changes v1 -> v2:
-dropped some not needed patches
-review feedback incorporated for some of the patches
-partial read path changes patch splited into two patches


Igor Konopko (3):
  lightnvm: pblk: simplify partial read path
  lightnvm: pblk: use nvm_rq_to_ppa_list()
  lightnvm: pblk: store multiple copies of smeta

 drivers/lightnvm/pblk-core.c     | 159 ++++++++++++++----
 drivers/lightnvm/pblk-init.c     |  23 ++-
 drivers/lightnvm/pblk-rb.c       |  11 +-
 drivers/lightnvm/pblk-read.c     | 339 ++++++++++-----------------------------
 drivers/lightnvm/pblk-recovery.c |  27 ++--
 drivers/lightnvm/pblk-rl.c       |   3 +-
 drivers/lightnvm/pblk.h          |  19 +--
 7 files changed, 252 insertions(+), 329 deletions(-)

-- 
2.9.5

