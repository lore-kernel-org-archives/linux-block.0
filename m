Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FFC04AAA
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6D205F4
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="q3kyI1v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfEDSkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36670 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfEDSid (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so6530399lfi.3
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1lcG8Ggb9dW/52mZyW7E7jyK+gtWmc0vHLu9grfrS4=;
        b=q3kyI1v6YZ08qjvL0Ba3sIUSXrJmIrajLiJNdL05tHU43pNHYLa1AZKfPXzZZpFCLa
         1qS1c4tugr2EWLrVoKXJSAYYOrQarPUpvQbk0n+8iCMox7hwAzHxn3qmAK26CKyuhmgZ
         TTWMUDxIRTKSEtro/ds4NDxVPk8gl37+y7NrfI9KrDycEJV7ZM2cp8ydx0GBWkrOggE2
         wOzzpw2fGh8xv4oXCTD+OU02MxwtB6sWleGg/DXYf2ppTkAku6pWsF6FCdQsKdZbkbo2
         gl6VVDlP+u8G00rADug77Rq6n19PWK2c8apPeQKZ7hocjIz0MtBuqdXRUYp2ih8qltBV
         EMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1lcG8Ggb9dW/52mZyW7E7jyK+gtWmc0vHLu9grfrS4=;
        b=qDGKRd3DNVLj1hFTBnRDA/cqy7ZBWNIx0N1nMG2BWf9HsLn66JCXfmXnDJ1dA8jwNk
         wHqwYn8wGgX0mWsp3U0IgnKILICeMziRZ8svsZVcfCZAKbsbD4eUEEYEUE5oxrRiHb3R
         T9hgyOR8ph3wqTrSUizgC/RTjxcGtWbNICOEVhDIJxUTgJPtxpV/Cx9aT9CsH9lqgu6l
         SB1t91YRUXUVnjBzCYk2AHgNLSpeTkLeTpvXS5fDzeNa71e15pI1cuXmRDmL+Iawluxj
         9IuBZ0mEoSGieKOx9ACflbN5LgfwB1/FLGtgSjnAPbNpglSKMQ7NlcuTW+sbRunmOOKe
         uYdQ==
X-Gm-Message-State: APjAAAUENLlU4hL9fLNN1cMrgXQixXoUhXG7YdQbuVcwaOdI5BQVouIj
        CtPcBA7+X2wPajJQli1a0+OlfA==
X-Google-Smtp-Source: APXvYqw3ZSlfd3Vh1uUsQUxb37Qx/r/Uid1RePZS/y5cMhSOt9dgUVWNeVzRapTZT3dKWow2RE2Yig==
X-Received: by 2002:a19:7b07:: with SMTP id w7mr447750lfc.82.1556995111393;
        Sat, 04 May 2019 11:38:31 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:30 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/26] lightnvm: pblk: gracefully handle GC vmalloc fail
Date:   Sat,  4 May 2019 20:37:50 +0200
Message-Id: <20190504183811.18725-6-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently when we fail on rq data allocation in gc, it skips moving
active data and moves line straigt to its free state. Losing user
data in the process.

Move the data allocation to an earlier phase of GC, where we can still
fail gracefully by moving line back to the closed state.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 65692e6d76e6..ea9f392a395e 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	struct pblk_line_ws *gc_rq_ws = container_of(work,
 						struct pblk_line_ws, ws);
 	struct pblk *pblk = gc_rq_ws->pblk;
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line *line = gc_rq_ws->line;
 	struct pblk_gc_rq *gc_rq = gc_rq_ws->priv;
@@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
 
 	up(&gc->gc_sem);
 
-	gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
-	if (!gc_rq->data) {
-		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
-					line->id, *line->vsc, gc_rq->nr_secs);
-		goto out;
-	}
-
 	/* Read from GC victim block */
 	ret = pblk_submit_read_gc(pblk, gc_rq);
 	if (ret) {
@@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	struct pblk_line *line = line_ws->line;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line_ws *gc_rq_ws;
 	struct pblk_gc_rq *gc_rq;
@@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	gc_rq->nr_secs = nr_secs;
 	gc_rq->line = line;
 
+	gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
+	if (!gc_rq->data)
+		goto fail_free_gc_rq;
+
 	gc_rq_ws = kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
 	if (!gc_rq_ws)
-		goto fail_free_gc_rq;
+		goto fail_free_gc_data;
 
 	gc_rq_ws->pblk = pblk;
 	gc_rq_ws->line = line;
@@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 
 	return;
 
+fail_free_gc_data:
+	vfree(gc_rq->data);
 fail_free_gc_rq:
 	kfree(gc_rq);
 fail_free_lba_list:
-- 
2.19.1

