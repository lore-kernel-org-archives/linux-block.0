Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55961 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758291AbdJMMrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id u138so21645162wmu.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:40 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 35/58] lightnvm: pblk: remove redundant check on read path
Date: Fri, 13 Oct 2017 14:46:24 +0200
Message-Id: <20171013124647.32668-36-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

A partial read I/O in pblk is an I/O where some sectors reside in the
write buffer in main memory and some are persisted on the device. Such
an I/O must at least contain 2 lbas, therefore checking for the case
where a single lba is mapped is not necessary.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 402f8ef..71c5850 100644
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
2.9.3
