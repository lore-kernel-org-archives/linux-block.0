Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B5DC10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5271206BA
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDPKTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:19:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:15155 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfDPKTY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 06:19:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 03:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="337926992"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 03:19:22 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v4 0/7] lightnvm: next set of improvements for 5.2
Date:   Tue, 16 Apr 2019 12:16:41 +0200
Message-Id: <20190416101648.10045-1-igor.j.konopko@intel.com>
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

First & second patches are the most crutial, since they changes
the approach to the partial read path, so detailed review is needed
especially here.

Other patches are my other findings related to some bugs or potential
improvements, mostly related to some corner cases.

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

Igor Konopko (7):
  lightnvm: pblk: IO path reorganization
  lightnvm: pblk: simplify partial read path
  lightnvm: pblk: recover only written metadata
  lightnvm: pblk: store multiple copies of smeta
  lightnvm: pblk: use nvm_rq_to_ppa_list()
  lightnvm: track inflight target creations
  lightnvm: do not remove instance under global lock

 drivers/lightnvm/core.c          |  75 +++++---
 drivers/lightnvm/pblk-cache.c    |   8 +-
 drivers/lightnvm/pblk-core.c     | 159 +++++++++++++----
 drivers/lightnvm/pblk-init.c     |  37 ++--
 drivers/lightnvm/pblk-rb.c       |  11 +-
 drivers/lightnvm/pblk-read.c     | 376 +++++++++++----------------------------
 drivers/lightnvm/pblk-recovery.c |  35 ++--
 drivers/lightnvm/pblk-rl.c       |   3 +-
 drivers/lightnvm/pblk.h          |  23 +--
 include/linux/lightnvm.h         |   1 +
 10 files changed, 333 insertions(+), 395 deletions(-)

-- 
2.9.5

