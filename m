Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36267 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdIFKwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:54 -0400
Received: by mail-wm0-f43.google.com with SMTP id i145so28016413wmf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:54 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 18/18] lightnvm: pblk: remove unnecessary check
Date: Wed,  6 Sep 2017 12:51:11 +0200
Message-Id: <1504695071-25928-19-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A partial read I/O in pblk is an I/O where some sectors reside in the
write buffer in main memory and some are persisted on the device. Such
an I/O must at least contain 2 lbas, therefore checking for the case
where a single lba is mapped is not necessary.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f43d78e4ce78..46a37d51fa4d 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -242,7 +242,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
 	rqd->end_io = NULL;
 
-	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
+	if (unlikely(nr_holes == 1)) {
 		ppa_ptr = rqd->ppa_list;
 		dma_ppa_list = rqd->dma_ppa_list;
 		rqd->ppa_addr = rqd->ppa_list[0];
@@ -267,7 +267,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 #endif
 	}
 
-	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
+	if (unlikely(nr_holes == 1)) {
 		struct ppa_addr ppa;
 
 		ppa = rqd->ppa_addr;
-- 
2.7.4
