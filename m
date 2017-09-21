Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:39806 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdIUL0Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:26:24 -0400
Date: Thu, 21 Sep 2017 14:26:22 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 2/6] lightnvm: pblk: protect line bitmap while submitting
 meta io
Message-ID: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It seems pblk_dealloc_page would race against pblk_alloc_pages for
line bitmap for sector allocation.  The chances are very low but might
as well protect the bitmap properly.  It's not even in fast path.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a230125..b92eabc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -502,12 +502,14 @@ void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
 	u64 addr;
 	int i;
 
+	spin_lock(&line->lock);
 	addr = find_next_zero_bit(line->map_bitmap,
 					pblk->lm.sec_per_line, line->cur_sec);
 	line->cur_sec = addr - nr_secs;
 
 	for (i = 0; i < nr_secs; i++, line->cur_sec--)
 		WARN_ON(!test_and_clear_bit(line->cur_sec, line->map_bitmap));
+	spin_lock(&line->lock);
 }
 
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
-- 
2.5.0
