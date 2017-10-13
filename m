Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47021 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbdJMMrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id m72so21267047wmc.1
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:45 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 40/58] lightnvm: pblk: remove useless line
Date: Fri, 13 Oct 2017 14:46:29 +0200
Message-Id: <20171013124647.32668-41-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e38e918..43866ad 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	/* Mark emeta metadata sectors as bad sectors. We need to consider bad
 	 * blocks to make sure that there are enough sectors to store emeta
 	 */
-	bit = lm->sec_per_line;
 	off = lm->sec_per_line - lm->emeta_sec[0];
 	bitmap_set(line->invalid_bitmap, off, lm->emeta_sec[0]);
 	while (nr_bb) {
-- 
2.9.3
