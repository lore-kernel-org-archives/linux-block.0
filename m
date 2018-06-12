Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37097 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754278AbeFLKai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 06:30:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so33219846lfb.4
        for <linux-block@vger.kernel.org>; Tue, 12 Jun 2018 03:30:38 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: limit get chk meta request size
Date: Tue, 12 Jun 2018 12:30:08 +0200
Message-Id: <20180612103008.19436-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For devices that does not specify a limit on its transfer size, the
get_chk_meta command may send down a single I/O retrieving the full
chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
split up the I/Os to a maximum of 256KB and issue them separately to
improve I/O latency.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b9989717418d..3b644b0e9713 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i;
+	int ret, i, max_len;
+
+	/*
+	 * limit requests to maximum 256K to avoid issuing arbitrary large
+	 * requests when the device does not specific a maximum transfer size.
+	 */
+	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
@@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
 
 	while (left) {
-		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
+		len = min_t(unsigned int, left, max_len);
 
 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
 				dev_meta, len, offset);
-- 
2.11.0
