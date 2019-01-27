Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D0C282C0
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8121473
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 06:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="YNSeHsGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfA0GzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 01:55:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46976 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfA0GzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 01:55:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so5864146pgp.13
        for <linux-block@vger.kernel.org>; Sat, 26 Jan 2019 22:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=from:to:cc:subject:date:message-id;
        bh=30AADu9Mki3/yTw40RMDs1oNU9yaFZLZVLOVpv25N/w=;
        b=YNSeHsGdlTk05cae8CRreRWE3i+Ehp+aXJkOEcC3zfXzRg50+BvY98MSv4zPIF6AI/
         9+fTQkGU/EozxMBAL7q53jieiyzr5vTEbBeex6vepQxLwM96K0ceXzgSxvJnNFR8oziB
         YAPsGC8XjInT1u4krqNU2RkVB1ZvUpa/1emNIdMNKSsVpwDBA3Ct8BJNCue8bRQ2d9vk
         WrZhJ77jK7W9SkVUxooX04jDBiKE4vl1Ou0pvQauNdLJLXAowS+18U7aVAI1oBT8ry4i
         vc3AWYozfZQ+hhoNJvxA22bkwwGOeLFB+4Ho+/oxr8Ae7F4KLn242JreOMjwcGkIXywl
         59Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=30AADu9Mki3/yTw40RMDs1oNU9yaFZLZVLOVpv25N/w=;
        b=WP6PMJg66UNnD0IY1w2TF2FfTV9xI4n8WnzYB5CbfJoJWm3izxO5c9phddsiE7cHF8
         EKuBfA0rESE5wdd5BGqTIGMR1Gi8x2aWl82URnd/ZNR9tXhyZEXCON3lNvXzKWmVFjid
         ag4WZlyIcObIw3Vgp+uaWdUOimR8l0fwW8qVxWi7+MFcBQMcGVUsaBGiQPn7LdQgH0WL
         VR/DQ2Icg9Xerrqkq7qm7x5M+++6K6YqUZ4xpshpZST+KiVhSSBL6py+B/AUBy7efC4p
         KUq1vIDpHd18v3hVTVWKKCmcTkem2YU4Tz7CKd7DthlZ8Uo8D5qxtGuSimGjpNl9Zc0Q
         tjEA==
X-Gm-Message-State: AJcUukez4q2IMbN34RCcGZZVOYCIKuukyPSSpOjocjRy6hd12OT4c0fy
        bkX+UrImyyLR9ccA5LVof8qAig==
X-Google-Smtp-Source: ALg8bN50BGr/nrsUD4dRYjVa0m52uyXVC3KVkdWQlqjS8oYVHEmMKBChLdKkJWF6jmhaGrGwdgR96A==
X-Received: by 2002:a63:920a:: with SMTP id o10mr15260837pgd.141.1548572108987;
        Sat, 26 Jan 2019 22:55:08 -0800 (PST)
Received: from bohr1.soe.ucsc.edu (bohr1.soe.ucsc.edu. [128.114.52.184])
        by smtp.gmail.com with ESMTPSA id g15sm121102896pfj.131.2019.01.26.22.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 22:55:08 -0800 (PST)
From:   Heiner Litz <hlitz@ucsc.edu>
To:     mb@lightnvm.io
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: pblk: fix race condition on GC
Date:   Sat, 26 Jan 2019 22:54:21 -0800
Message-Id: <20190127065421.10662-1-hlitz@ucsc.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes a race condition where a write is mapped to the last
sectors of a line. The write is synced to the device but the L2P is not
updated yet. When the line is garbage collected before the L2P update is
performed, the sectors are ignored by the GC logic and the line is freed
before all sectors are moved. When the L2P is finally updated, it contains
a mapping to a freed line, subsequent reads of the corresponding LBAs fail.

Note that looking up the L2P and checking the ppa in the write buffer needs
to be performed atomically, hence the refactor of pblk_lookup_l2p_rand.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-read.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 3789185144da..7c556b2218e4 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -529,13 +529,35 @@ static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 	int valid_secs = 0;
 	int i;
 
-	pblk_lookup_l2p_rand(pblk, ppa_list_l2p, lba_list, nr_secs);
-
+	spin_lock(&pblk->trans_lock);
 	for (i = 0; i < nr_secs; i++) {
 		if (lba_list[i] == ADDR_EMPTY)
 			continue;
 
+		ppa_list_l2p[i] = pblk_trans_map_get(pblk, lba_list[i]);
 		ppa_gc = addr_to_gen_ppa(pblk, paddr_list_gc[i], line->id);
+
+		/* Obtain ppa from cache if the sector has been synced to the
+		   device but the L2P has not been updated yet */
+		if(pblk_addr_in_cache(ppa_list_l2p[i])) {
+			struct pblk_rb *rb = &pblk->rwb;
+			struct pblk_rb_entry *entry;
+			struct pblk_w_ctx *w_ctx;
+			u64 pos = pblk_addr_to_cacheline(ppa_list_l2p[i]);
+
+#ifdef CONFIG_NVM_PBLK_DEBUG
+			/* Ensure that the access will not cause an overflow */
+			BUG_ON(pos >= rb->nr_entries);
+#endif
+
+			entry = &rb->entries[pos];
+			w_ctx = &entry->w_ctx;
+			if (pblk_ppa_comp(w_ctx->ppa, ppa_gc)) {
+				rqd->ppa_list[valid_secs++] = ppa_gc;
+				continue;
+			}
+		}
+
 		if (!pblk_ppa_comp(ppa_list_l2p[i], ppa_gc)) {
 			paddr_list_gc[i] = lba_list[i] = ADDR_EMPTY;
 			continue;
@@ -543,6 +565,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 
 		rqd->ppa_list[valid_secs++] = ppa_list_l2p[i];
 	}
+	spin_unlock(&pblk->trans_lock);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(valid_secs, &pblk->inflight_reads);
-- 
2.17.1

