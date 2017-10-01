Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:11825 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdJANXF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:23:05 -0400
Date: Sun, 1 Oct 2017 16:23:03 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 1/6] lightnvm: pblk: remove useless line
Message-ID: <20171001132302.GA5668@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1f8aa94..4ffd1d6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1053,7 +1053,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	/* Mark emeta metadata sectors as bad sectors. We need to consider bad
 	 * blocks to make sure that there are enough sectors to store emeta
 	 */
-	bit = lm->sec_per_line;
 	off = lm->sec_per_line - lm->emeta_sec[0];
 	bitmap_set(line->invalid_bitmap, off, lm->emeta_sec[0]);
 	while (nr_bb) {
-- 
2.7.4
