Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB1C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1CB214DA
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SwBiHcRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBKMZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40290 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBKMZe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25-v6so8550888ljk.7
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV7BdTFxfdzellee6uLIM4zSFMN2KdjxRkfq0QP0Mnw=;
        b=SwBiHcRHaReRUBX3NUdT3JJX8GHBqAYHk9Q3Y23lE33VP3qkEtK9T5TGtXLONXXdoC
         mIofGS8dl8HeeVZTG/N5JvdnHTVWkf5ONR6Y4FlZD6LNPNV5Ds4bINVtJEt6aIYVZ/6V
         Em7WJ7Ineffg52+1REN0QJ/WAFYwjczf0oUlWXn3FmvU1cqhczJpImGRQeqIkGLUwbYf
         edzjb2OQ077IL2CXd99IGoyfXGuknFyPOZ95hO5r/e249qQtVxZZLM/EVRGQCD83armx
         OCxS++XtssfsunN27u4LxK+0gYGONnVvqAB3Vfqsrq1sLJcl/3w3kMGfkSZSiy94fQYJ
         AOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV7BdTFxfdzellee6uLIM4zSFMN2KdjxRkfq0QP0Mnw=;
        b=sWwhJNfqiHv6qgWoyADDHhkLAavRjY/3COlk/Okqoa3SUi1oUW1b6LrjB7nBxG/bCl
         QPIrHmVnFXkZ2nL25SVUupMuZhHk+pItYd945GF2f/PpOTXudJgyO95E64RJgoBS22vJ
         seZW8EL5yU5wAWwF1scmuN2OovBmoq0XPFpUJ+4bFXOGDMsCPEeLqgkQViIiyGycahb9
         k/UyVVawUok6p8tgUXu/ddLmVvCo2j7+BLgMTlfSZLlPNMxgc5LSLUbAcS2Yw4J+ObI6
         EYDO6P0BQrEpoT1p35dRew78gUgWDxa6Ch93r7rhsVZxDxvX6syyNq7Ifk5R+A4fjWbu
         /IFA==
X-Gm-Message-State: AHQUAuZEWg+eUPy7aC87dXkOW12WwzXC/hkCwG5lgjXhMJD6o1wqdZkN
        o9gRHUciM/cmZWOi6/Qc3n1rlg==
X-Google-Smtp-Source: AHgI3IYAIQwYNPqNHt4HZTpxCTC8Z//w29sS8X6jPtLPb1FwvXaxauLhKhug1TooU36tx282bQmUWQ==
X-Received: by 2002:a2e:9855:: with SMTP id e21-v6mr7076398ljj.76.1549887932382;
        Mon, 11 Feb 2019 04:25:32 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:30 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 8/8] lightnvm: pblk: fix race condition on GC
Date:   Mon, 11 Feb 2019 13:25:09 +0100
Message-Id: <20190211122509.19910-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

This patch fixes a race condition where a write is mapped to the last
sectors of a line. The write is synced to the device but the L2P is not
updated yet. When the line is garbage collected before the L2P update
is performed, the sectors are ignored by the GC logic and the line is
freed before all sectors are moved. When the L2P is finally updated, it
contains a mapping to a freed line, subsequent reads of the
corresponding LBAs fail.

This patch introduces a per line counter specifying the number of
sectors that are synced to the device but have not been updated in the
L2P. Lines with a counter of greater than zero will not be selected
for GC.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  |  1 +
 drivers/lightnvm/pblk-gc.c    | 22 ++++++++++++++--------
 drivers/lightnvm/pblk-map.c   |  1 +
 drivers/lightnvm/pblk-rb.c    |  1 +
 drivers/lightnvm/pblk-write.c |  1 +
 drivers/lightnvm/pblk.h       |  1 +
 6 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2a9e9facf44f..6ca868868fee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1278,6 +1278,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&line->lock);
 
 	kref_init(&line->ref);
+	atomic_set(&line->sec_to_update, 0);
 
 	return 0;
 }
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2fa118c8eb71..26a52ea7ec45 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -365,16 +365,22 @@ static struct pblk_line *pblk_gc_get_victim_line(struct pblk *pblk,
 						 struct list_head *group_list)
 {
 	struct pblk_line *line, *victim;
-	int line_vsc, victim_vsc;
+	unsigned int line_vsc = ~0x0L, victim_vsc = ~0x0L;
 
 	victim = list_first_entry(group_list, struct pblk_line, list);
+
 	list_for_each_entry(line, group_list, list) {
-		line_vsc = le32_to_cpu(*line->vsc);
-		victim_vsc = le32_to_cpu(*victim->vsc);
-		if (line_vsc < victim_vsc)
+		if (!atomic_read(&line->sec_to_update))
+			line_vsc = le32_to_cpu(*line->vsc);
+		if (line_vsc < victim_vsc) {
 			victim = line;
+			victim_vsc = le32_to_cpu(*victim->vsc);
+		}
 	}
 
+	if (victim_vsc == ~0x0)
+		return NULL;
+
 	return victim;
 }
 
@@ -448,12 +454,12 @@ static void pblk_gc_run(struct pblk *pblk)
 
 	do {
 		spin_lock(&l_mg->gc_lock);
-		if (list_empty(group_list)) {
-			spin_unlock(&l_mg->gc_lock);
-			break;
-		}
 
 		line = pblk_gc_get_victim_line(pblk, group_list);
+		if (!line) {
+			spin_unlock(&l_mg->gc_lock);
+			break;
+		}
 
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 79df583ea709..7fbc99b60cac 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -73,6 +73,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		 */
 		if (i < valid_secs) {
 			kref_get(&line->ref);
+			atomic_inc(&line->sec_to_update);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
 			meta->lba = cpu_to_le64(w_ctx->lba);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index a6133b50ed9c..03c241b340ea 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -260,6 +260,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 							entry->cacheline);
 
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
+		atomic_dec(&line->sec_to_update);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
 		rb->l2p_update = pblk_rb_ptr_wrap(rb, rb->l2p_update, 1);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 06d56deb645d..6593deab52da 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -177,6 +177,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
+		atomic_dec(&line->sec_to_update);
 		kref_put(&line->ref, pblk_line_put);
 	}
 	spin_unlock(&pblk->trans_lock);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a6386d5acd73..ac3ab778e976 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -487,6 +487,7 @@ struct pblk_line {
 	__le32 *vsc;			/* Valid sector count in line */
 
 	struct kref ref;		/* Write buffer L2P references */
+	atomic_t sec_to_update;         /* Outstanding L2P updates to ppa */
 
 	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery metadata */
 
-- 
2.19.1

