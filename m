Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBBC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5D220848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfCENyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:62720 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENyC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161511"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:00 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 0/8] lightnvm: bugfixes and improvements
Date:   Tue,  5 Mar 2019 14:51:12 +0100
Message-Id: <20190305135120.29284-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series provides a group of the bugfixes or improvements
for lightnvm and pblk device.

Most of the patches are rather simple and covers some corner cases
scenario, but we were able to hit most of them in some scenarios.
Few others close some existing gaps which we were able to found.

Changes v2->v1:
-skipped patches which were applied in v1
-dropped not needed patch for pblk_should_kick_write()
-patch which scan for opened chunks on pblk creation do not close
chunk anymore, just print the warning
-unknown read errors are counted seperately from read unrecoverable

Igor Konopko (8):
  lightnvm: pblk: Gracefully handle GC vmalloc fail
  lightnvm: pblk: Fix put line back behaviour
  lightnvm: pblk: Count all read errors in stats
  lightnvm: pblk: Ensure that erase is chunk aligned
  lightnvm: pblk: Cleanly fail when there is not enough memory
  lightnvm: pblk: Set proper read stutus in bio
  lightnvm: pblk: warn about opened chunk on factory init
  lightnvm: Inherit mdts from the parent nvme device

 drivers/lightnvm/core.c       |  9 +++++++--
 drivers/lightnvm/pblk-core.c  | 15 +++++++++++++++
 drivers/lightnvm/pblk-gc.c    | 35 +++++++++++++++++++----------------
 drivers/lightnvm/pblk-init.c  | 24 +++++++++++++++++++-----
 drivers/lightnvm/pblk-map.c   |  1 +
 drivers/lightnvm/pblk-read.c  | 11 +++++------
 drivers/lightnvm/pblk-sysfs.c |  3 ++-
 drivers/lightnvm/pblk.h       |  2 ++
 drivers/nvme/host/lightnvm.c  |  1 +
 include/linux/lightnvm.h      |  1 +
 10 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.9.5

