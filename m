Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C24C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D388D20883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCVOvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:51:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:54147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfCVOvY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:51:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593122"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:51:21 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 00/16] lightnvm: next set of improvements for 5.2
Date:   Fri, 22 Mar 2019 15:48:27 +0100
Message-Id: <20190322144843.9602-1-igor.j.konopko@intel.com>
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

First patch is the leftover from previous patchset, since we decided to
reorganize it a little. Second & third patches are the most crutial, since they
changes the approach to partial read path, so detailed review is needed
especially here.

Other patches are my other findings related to some bugs or potential
improvements, mostly related to some corner cases.

Changes v1 -> v2:
-dropped some not needed patches
-review feedback incorporated for some of the patches
-partial read path changes patch splitted into two patches

Igor Konopko (16):
  lightnvm: pblk: warn when there are opened chunks
  lightnvm: pblk: IO path reorganization
  lightnvm: pblk: simplify partial read path
  lightnvm: pblk: OOB recovery for closed chunks fix
  lightnvm: pblk: propagate errors when reading meta
  lightnvm: pblk: recover only written metadata
  lightnvm: pblk: wait for inflight IOs in recovery
  lightnvm: pblk: remove internal IO timeout
  lightnvm: pblk: fix spin_unlock order
  lightnvm: pblk: kick writer on write recovery path
  lightnvm: pblk: fix update line wp in OOB recovery
  lightnvm: pblk: do not read OOB from emeta region
  lightnvm: pblk: store multiple copies of smeta
  lightnvm: pblk: GC error handling
  lightnvm: pblk: use nvm_rq_to_ppa_list()
  lightnvm: track inflight target creations

 drivers/lightnvm/core.c          |  19 ++-
 drivers/lightnvm/pblk-cache.c    |   7 +-
 drivers/lightnvm/pblk-core.c     | 179 +++++++++++++++++----
 drivers/lightnvm/pblk-gc.c       |   5 +-
 drivers/lightnvm/pblk-init.c     |  59 ++++---
 drivers/lightnvm/pblk-rb.c       |   2 +-
 drivers/lightnvm/pblk-read.c     | 336 +++++++++++----------------------------
 drivers/lightnvm/pblk-recovery.c | 103 ++++++++----
 drivers/lightnvm/pblk-rl.c       |   3 +-
 drivers/lightnvm/pblk-write.c    |   1 +
 drivers/lightnvm/pblk.h          |  31 ++--
 include/linux/lightnvm.h         |   2 +
 12 files changed, 391 insertions(+), 356 deletions(-)

-- 
2.9.5

