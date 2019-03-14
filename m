Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9785C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A692184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfCNQHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:07:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:25202 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQHN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:07:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134072788"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:07:09 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 00/18] lightnvm: next set of improvements for 5.2
Date:   Thu, 14 Mar 2019 17:04:10 +0100
Message-Id: <20190314160428.3559-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is another set of fixes and improvements to both pblk and lightnvm
core. 

First patch fixes an issue related to format specifier introduced in
previous series (reported by 0-day). Second patch is another leftover from
previous patchset, since we decided to reorganize it a little. Third patch is
the most crutial, since it changes the approach to partial read path, so
detailed review is needed especially here.

Other patches are my other findings related to some bugs or potential
improvements, mostly related to some corner cases, so with a lower
priority to review for now.

I did some testing with QEMU, but as always feedback and testing is
appreciated.

Igor Konopko (18):
  lightnvm: pblk: fix warning in pblk_l2p_init()
  lightnvm: pblk: warn when there are opened chunks
  lightnvm: pblk: simplify partial read path
  lightnvm: pblk: OOB recovery for closed chunks fix
  lightnvm: pblk: propagate errors when reading meta
  lightnvm: pblk: recover only written metadata
  lightnvm: pblk: wait for inflight IOs in recovery
  lightnvm: pblk: fix spin_unlock order
  lightnvm: pblk: kick writer on write recovery path
  lightnvm: pblk: ensure that emeta is written
  lightnvm: pblk: fix update line wp in OOB recovery
  lightnvm: pblk: do not read OOB from emeta region
  lightnvm: pblk: store multiple copies of smeta
  lightnvm: pblk: GC error handling
  lightnvm: pblk: fix in case of lack of lines
  lightnvm: pblk: use nvm_rq_to_ppa_list()
  lightnvm: allow to use full device path
  lightnvm: track inflight target creations

 drivers/lightnvm/core.c          |  42 ++++++-
 drivers/lightnvm/pblk-core.c     | 166 ++++++++++++++++++++------
 drivers/lightnvm/pblk-gc.c       |   5 +-
 drivers/lightnvm/pblk-init.c     |  48 +++++---
 drivers/lightnvm/pblk-map.c      |   2 +-
 drivers/lightnvm/pblk-rb.c       |   2 +-
 drivers/lightnvm/pblk-read.c     | 243 +++++++--------------------------------
 drivers/lightnvm/pblk-recovery.c | 127 +++++++++++++++-----
 drivers/lightnvm/pblk-write.c    |  25 ++++
 drivers/lightnvm/pblk.h          |  16 +--
 include/linux/lightnvm.h         |   2 +
 11 files changed, 375 insertions(+), 303 deletions(-)

-- 
2.9.5

