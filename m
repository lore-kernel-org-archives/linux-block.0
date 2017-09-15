Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50965 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdIOMZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:25:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id v142so7818883wmv.5
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:25:54 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 11/11] lightnvm: pblk: use rqd->end_io for completion
Date: Fri, 15 Sep 2017 14:25:39 +0200
Message-Id: <1505478339-13089-12-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
References: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For consistency with the rest of pblk, use rqd->end_io to point to the
function taking care of ending the request on the completion path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk-read.c | 5 ++---
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 76c3b20dc3d5..5e6a881e3434 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -261,13 +261,6 @@ void pblk_write_should_kick(struct pblk *pblk)
 		pblk_write_kick(pblk);
 }
 
-void pblk_end_bio_sync(struct bio *bio)
-{
-	struct completion *waiting = bio->bi_private;
-
-	complete(waiting);
-}
-
 void pblk_end_io_sync(struct nvm_rq *rqd)
 {
 	struct completion *waiting = rqd->private;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d7c90c303540..0299fc08291d 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -170,13 +170,12 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
-	new_bio->bi_private = &wait;
-	new_bio->bi_end_io = pblk_end_bio_sync;
 
 	rqd->bio = new_bio;
 	rqd->nr_ppas = nr_holes;
 	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
-	rqd->end_io = NULL;
+	rqd->end_io = pblk_end_io_sync;
+	rqd->private = &wait;
 
 	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
 		ppa_ptr = rqd->ppa_list;
-- 
2.7.4
