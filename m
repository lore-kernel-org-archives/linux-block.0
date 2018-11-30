Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA9C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B82146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16B82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeK3W63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:58:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:41003 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeK3W62 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 17:58:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 03:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="108549597"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2018 03:49:26 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v5 4/5] lightnvm: Disable interleaved metadata
Date:   Fri, 30 Nov 2018 12:44:01 +0100
Message-Id: <20181130114402.43793-5-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181130114402.43793-1-igor.j.konopko@intel.com>
References: <20181130114402.43793-1-igor.j.konopko@intel.com>
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
index ff6a6df369c3..e8055b796381 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1175,6 +1175,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
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
index ba268d7cf141..f145fc0220d6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -990,6 +990,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	geo = &dev->geo;
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
+	geo->ext = ns->ext;
 
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7afedaddbd15..5d865a5d5cdc 100644
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

