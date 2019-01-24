Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51928C41518
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F79D21872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfAXOWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:22:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:6830 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXOWL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:22:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 06:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="313135096"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2019 06:22:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F82812A; Thu, 24 Jan 2019 16:22:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lightnvm: Use u64 instead of __le64 for CPU visible side
Date:   Thu, 24 Jan 2019 16:22:07 +0200
Message-Id: <20190124142207.9060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sparse complains about using strict data types:

drivers/lightnvm/pblk-read.c:254:43: warning: incorrect type in assignment (different base types)
drivers/lightnvm/pblk-read.c:254:43:    expected restricted __le64 <noident>
drivers/lightnvm/pblk-read.c:254:43:    got unsigned long long [unsigned] [usertype] <noident>
drivers/lightnvm/pblk-read.c:255:29: warning: cast from restricted __le64
drivers/lightnvm/pblk-read.c:268:29: warning: cast from restricted __le64
drivers/lightnvm/pblk-read.c:328:41: warning: incorrect type in assignment (different base types)
drivers/lightnvm/pblk-read.c:328:41:    expected restricted __le64 <noident>
drivers/lightnvm/pblk-read.c:328:41:    got unsigned long long [unsigned] [usertype] <noident>

In the code it seems explicit that lba_list_mem and lba_list_media members of
struct pblk_pr_ctx are used on CPU side, which means they should not be of
strict types.

Change types of lba_list_mem and lba_list_media members to be u64.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/lightnvm/pblk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 12bf02df4204..72ae8755764e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -131,8 +131,8 @@ struct pblk_pr_ctx {
 	unsigned int bio_init_idx;
 	void *ppa_ptr;
 	dma_addr_t dma_ppa_list;
-	__le64 lba_list_mem[NVM_MAX_VLBA];
-	__le64 lba_list_media[NVM_MAX_VLBA];
+	u64 lba_list_mem[NVM_MAX_VLBA];
+	u64 lba_list_media[NVM_MAX_VLBA];
 };
 
 /* Pad context */
-- 
2.20.1

