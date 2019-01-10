Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B2C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FC5214C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAJOa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:30:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:22476 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbfAJOaz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 09:30:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 06:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="126590311"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2019 06:30:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3ACF108; Thu, 10 Jan 2019 16:30:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] : Switch to use new generic UUID API
Date:   Thu, 10 Jan 2019 16:30:51 +0200
Message-Id: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/lightnvm/pblk.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 85e38ed62f85..0a0aeb6ef314 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1362,10 +1362,7 @@ static inline unsigned int pblk_get_secs(struct bio *bio)
 
 static inline void pblk_setup_uuid(struct pblk *pblk)
 {
-	uuid_le uuid;
-
-	uuid_le_gen(&uuid);
-	memcpy(pblk->instance_uuid, uuid.b, 16);
+	guid_gen((guid_t *)&pblk->instance_uuid);
 }
 
 static inline char *pblk_disk_name(struct pblk *pblk)
-- 
2.20.1

