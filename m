Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:45825 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdIOMf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:35:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id g206so7970860wme.0
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:35:59 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove redundant check on read path
Date: Fri, 15 Sep 2017 14:35:50 +0200
Message-Id: <1505478953-16915-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
References: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A partial read I/O in pblk is an I/O where some sectors reside in the
write buffer in main memory and some are persisted on the device. Such
an I/O must at least contain 2 lbas, therefore checking for the case
where a single lba is mapped is not necessary.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 402f8eff6a2e..71c58503f1a4 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -235,7 +235,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->end_io = pblk_end_io_sync;
 	rqd->private = &wait;
 
-	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
+	if (unlikely(nr_holes == 1)) {
 		ppa_ptr = rqd->ppa_list;
 		dma_ppa_list = rqd->dma_ppa_list;
 		rqd->ppa_addr = rqd->ppa_list[0];
@@ -260,7 +260,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 #endif
 	}
 
-	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
+	if (unlikely(nr_holes == 1)) {
 		struct ppa_addr ppa;
 
 		ppa = rqd->ppa_addr;
-- 
2.7.4
