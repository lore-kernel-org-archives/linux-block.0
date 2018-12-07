Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BEC64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C8820850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 08:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C8820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLGIdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:33:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:54436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGIdE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 03:33:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="105602431"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2018 00:33:03 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v2 2/2] lightnvm: pblk: Ensure that bio is not freed on recovery
Date:   Fri,  7 Dec 2018 09:25:50 +0100
Message-Id: <20181207082550.10409-2-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181207082550.10409-1-igor.j.konopko@intel.com>
References: <20181207082550.10409-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we are using PBLK with 0 sized metadata during recovery
process we need to reference a last page of bio. Currently
KASAN reports use-after-free in that case, since bio is
freed on IO completion.

This patch adds addtional bio reference to ensure, that we
can still use bio memory after IO completion. It also ensures
that we are not reusing the same bio on retry_rq path.

Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 009faf5db40f..3fcf062d752c 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		rq_ppas = pblk->min_write_pgs;
 	rq_len = rq_ppas * geo->csecs;
 
+retry_rq:
 	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+	bio_get(bio);
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PREAD;
@@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
 
-retry_rq:
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		bio_put(bio);
+		bio_put(bio);
 		return ret;
 	}
 
@@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 		if (padded) {
 			pblk_log_read_err(pblk, rqd);
+			bio_put(bio);
 			return -EINTR;
 		}
 
 		pad_distance = pblk_pad_distance(pblk, line);
 		ret = pblk_recov_pad_line(pblk, line, pad_distance);
-		if (ret)
+		if (ret) {
+			bio_put(bio);
 			return ret;
+		}
 
 		padded = true;
+		bio_put(bio);
 		goto retry_rq;
 	}
 
 	pblk_get_packed_meta(pblk, rqd);
+	bio_put(bio);
+
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
 		u64 lba = le64_to_cpu(meta->lba);
-- 
2.17.1

