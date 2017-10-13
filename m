Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53863 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758273AbdJMMri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id q132so21530049wmd.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:37 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 32/58] lightnvm: pblk: use rqd->end_io for completion
Date: Fri, 13 Oct 2017 14:46:21 +0200
Message-Id: <20171013124647.32668-33-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

For consistency with the rest of pblk, use rqd->end_io to point to the
function taking care of ending the request on the completion path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk-read.c | 5 ++---
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0de3875..08d166a 100644
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
index d7c90c3..0299fc0 100644
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
2.9.3
