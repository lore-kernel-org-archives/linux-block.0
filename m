Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF8C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526BB20834
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526BB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeK2SZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:25:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:40583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeK2SZv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 13:25:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 23:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,293,1539673200"; 
   d="scan'208";a="254297343"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2018 23:21:26 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v4 0/5] lightnvm: Flexible metadata
Date:   Thu, 29 Nov 2018 08:16:01 +0100
Message-Id: <20181129071606.56942-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patches extends the way how pblk can
store L2P sector metadata. After this set of changes
any size of NVMe metadata is supported in pblk.
Also there is an support for case without NVMe metadata.

Changes v3 --> v4:
-rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
-split pblk_get_meta() calls and lba setting into
two operations for better core readability
-fixing compilation with CONFIG_NVM disabled
-getting rid of unnecessary memcpy for packed metadata
on write path
-support for drives with oob size >0 and <16B in packed
metadata mode
-minor commit message updates

Changes v2 --> v3:
-Rebase on top of ocssd/for-4.21/core
-get/set_meta_lba helpers were removed
-dma reallocation was replaced with single allocation
-oob metadata size was added to pblk structure
-proper checks on pblk creation were added
 
Changes v1 --> v2:
-Revert sector meta size back to 16b for pblk
-Dma pool for larger oob meta are handled in core instead of pblk
-Pblk oob meta helpers uses __le64 as input outpu instead of u64
-Other minor fixes based on v1 patch review

Igor Konopko (5):
  lightnvm: pblk: Move lba list to partial read context
  lightnvm: pblk: Helpers for OOB metadata
  lightnvm: Flexible DMA pool entry size
  lightnvm: Disable interleaved metadata
  lightnvm: pblk: Support for packed metadata

 drivers/lightnvm/core.c          | 30 ++++++++++++------
 drivers/lightnvm/pblk-core.c     | 61 +++++++++++++++++++++++++++++++------
 drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
 drivers/lightnvm/pblk-map.c      | 20 +++++++-----
 drivers/lightnvm/pblk-rb.c       |  3 ++
 drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-----------------
 drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
 drivers/lightnvm/pblk-sysfs.c    |  7 +++++
 drivers/lightnvm/pblk-write.c    |  9 +++---
 drivers/lightnvm/pblk.h          | 24 +++++++++++++--
 drivers/nvme/host/lightnvm.c     | 16 ++++++----
 include/linux/lightnvm.h         |  8 ++++-
 12 files changed, 233 insertions(+), 80 deletions(-)

-- 
2.14.5

