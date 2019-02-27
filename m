Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B552183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfB0RRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:17:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:25365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RRz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:17:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819458"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:17:53 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
Date:   Wed, 27 Feb 2019 18:14:34 +0100
Message-Id: <20190227171442.11853-6-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when unknown error occurs on read path
there is only dmesg information about it, but it
is not counted in sysfs statistics. Since this is
still an error we should also count it there.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index eabcbc119681..a98b2255f963 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
 		atomic_long_inc(&pblk->read_failed);
 		break;
 	default:
+		atomic_long_inc(&pblk->read_failed);
 		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
 	}
 #ifdef CONFIG_NVM_PBLK_DEBUG
-- 
2.17.1

