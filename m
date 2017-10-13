Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49668 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758075AbdJMMrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so21112670wmd.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:13 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 07/58] lightnvm: pblk: protect line bitmap while submitting meta io
Date: Fri, 13 Oct 2017 14:45:56 +0200
Message-Id: <20171013124647.32668-8-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

It seems pblk_dealloc_page would race against pblk_alloc_pages for
line bitmap for sector allocation.The chances are very low but might
as well protect the bitmap properly.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 8150164..b53bb00 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -486,12 +486,14 @@ void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
 	u64 addr;
 	int i;
 
+	spin_lock(&line->lock);
 	addr = find_next_zero_bit(line->map_bitmap,
 					pblk->lm.sec_per_line, line->cur_sec);
 	line->cur_sec = addr - nr_secs;
 
 	for (i = 0; i < nr_secs; i++, line->cur_sec--)
 		WARN_ON(!test_and_clear_bit(line->cur_sec, line->map_bitmap));
+	spin_unlock(&line->lock);
 }
 
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
-- 
2.9.3
