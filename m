Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:49013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbdJMMrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id i124so21105798wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:44 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 39/58] lightnvm: pblk: fix changing GC group list for a line
Date: Fri, 13 Oct 2017 14:46:28 +0200
Message-Id: <20171013124647.32668-40-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

pblk_line_gc_list seems to had a bug since the introduction of pblk in
getting GC list for a line. In b20ba1bc7 while redesigning the GC
algorithm, the naming for the GC thresholds was altered, but the
values for high_thrs and mid_thrs were not. The result is that when
moving to the GC lists, the mid threshold is never evaluated.

Fixes: a4bd217b4("lightnvm: physical block device (pblk) target")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index c7239c4..56ece7d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -678,8 +678,8 @@ static int pblk_lines_init(struct pblk *pblk)
 	lm->blk_bitmap_len = BITS_TO_LONGS(geo->nr_luns) * sizeof(long);
 	lm->sec_bitmap_len = BITS_TO_LONGS(lm->sec_per_line) * sizeof(long);
 	lm->lun_bitmap_len = BITS_TO_LONGS(geo->nr_luns) * sizeof(long);
-	lm->high_thrs = lm->sec_per_line / 2;
-	lm->mid_thrs = lm->sec_per_line / 4;
+	lm->mid_thrs = lm->sec_per_line / 2;
+	lm->high_thrs = lm->sec_per_line / 4;
 	lm->meta_distance = (geo->nr_luns / 2) * pblk->min_write_pgs;
 
 	/* Calculate necessary pages for smeta. See comment over struct
-- 
2.9.3
