Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DBC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89E20834
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C89E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeK2S0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:26:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:13189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeK2S0J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 13:26:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 23:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,293,1539673200"; 
   d="scan'208";a="254297775"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2018 23:21:44 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v4 4/5] lightnvm: Disable interleaved metadata
Date:   Thu, 29 Nov 2018 08:16:05 +0100
Message-Id: <20181129071606.56942-5-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181129071606.56942-1-igor.j.konopko@intel.com>
References: <20181129071606.56942-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently pblk and lightnvm does only check for size
of OOB metadata and does not care wheather this meta
is located in separate buffer or is interleaved with
data in single buffer.

In reality only the first scenario is supported, where
second mode will break pblk functionality during any
IO operation.

The goal of this patch is to block creation of pblk
devices in case of interleaved metadata

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 6 ++++++
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b67bca810eb7..a728f861edd6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1179,6 +1179,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (geo->ext) {
+		pblk_err(pblk, "extended metadata not supported\n");
+		kfree(pblk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 60ac32b03fb6..ceb92610f43b 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -982,6 +982,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	if (geo->version != NVM_OCSSD_SPEC_12) {
 		geo->csecs = 1 << ns->lba_shift;
 		geo->sos = ns->ms;
+		geo->ext = ns->ext;
 	}
 
 	if (nvm_create_dma_pool(ndev))
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 216b373b7fea..2717e6141b1a 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -357,6 +357,7 @@ struct nvm_geo {
 	u32	clba;		/* sectors per chunk */
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
+	bool	ext;		/* metadata in extended data buffer */
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.14.5

