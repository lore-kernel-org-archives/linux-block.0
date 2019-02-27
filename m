Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DBC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B333A2183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfB0RR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:17:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:13079 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RR1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:17:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819352"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:17:25 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 00/13] lightnvm: bugfixes and improvements
Date:   Wed, 27 Feb 2019 18:14:29 +0100
Message-Id: <20190227171442.11853-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series provides a group of the bugfixes
or improvements for lightnvm and pblk device.

Most of the patches are rather simple and covers
some corner cases scenario, but we were able to hit
most of them in some scenarios. Few others close some
existing gaps which we were able to found.

Fedback is appreciated.

Igor Konopko (13):
  lightnvm: pblk: Line reference fix in GC
  lightnvm: pblk: Gracefully handle GC data malloc fail
  lightnvm: pblk: Fix put line back behaviour
  lightnvm: pblk: Rollback in gc read
  lightnvm: pblk: Count all read errors in stats
  lightnvm: pblk: Ensure that erase is chunk aligned
  lightnvm: pblk: Cleanly fail when there is not enough memory
  lightnvm: pblk: Set proper read stutus in bio
  lightnvm: pblk: Kick writer for flush requests
  lightnvm: pblk: Reduce L2P DRAM footprint
  lightnvm: pblk: Remove unused smeta_ssec field
  lightnvm: pblk: close opened chunks
  lightnvm: Inherit mdts from the parent nvme device

 drivers/lightnvm/core.c          |   9 ++-
 drivers/lightnvm/pblk-core.c     | 128 +++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-gc.c       |  47 +++++++-----
 drivers/lightnvm/pblk-init.c     |  30 ++++++--
 drivers/lightnvm/pblk-map.c      |   2 +
 drivers/lightnvm/pblk-read.c     |  13 ++--
 drivers/lightnvm/pblk-recovery.c |   2 +-
 drivers/lightnvm/pblk.h          |   4 +-
 drivers/nvme/host/lightnvm.c     |   1 +
 include/linux/lightnvm.h         |   1 +
 10 files changed, 193 insertions(+), 44 deletions(-)

-- 
2.17.1

