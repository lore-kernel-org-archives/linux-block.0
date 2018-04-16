Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36622 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbeDPKZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id q13so21010642wre.3
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:50 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 11/11] lightnvm: pblk: remove dead function
Date: Mon, 16 Apr 2018 12:25:32 +0200
Message-Id: <1523874332-6272-12-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove dead function for manual sync. I/O

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk.h      | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index cc34d5d9652d..5f960a6609c8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -342,13 +342,6 @@ void pblk_write_should_kick(struct pblk *pblk)
 		pblk_write_kick(pblk);
 }
 
-void pblk_end_io_sync(struct nvm_rq *rqd)
-{
-	struct completion *waiting = rqd->private;
-
-	complete(waiting);
-}
-
 static void pblk_wait_for_meta(struct pblk *pblk)
 {
 	do {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 4b725bedc36a..9838d03e1f21 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -796,7 +796,6 @@ void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
 void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		unsigned long *lun_bitmap);
-void pblk_end_io_sync(struct nvm_rq *rqd);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
-- 
2.7.4
