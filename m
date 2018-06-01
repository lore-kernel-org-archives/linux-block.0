Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34281 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeFANFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:05:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id o9-v6so14736777lfk.1
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:05:03 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/18] lightnvm: pblk: check for chunk size before allocating it
Date: Fri,  1 Jun 2018 15:04:23 +0200
Message-Id: <20180601130432.30866-10-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Do the check for the chunk state after making sure that the chunk type
is supported.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b52855f9336b..9e3a43346d4c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -751,14 +751,14 @@ static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
 		chunk->cnlb = chunk_meta->cnlb;
 		chunk->wp = chunk_meta->wp;
 
-		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
-			continue;
-
 		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
 			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
 			continue;
 		}
 
+		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
+			continue;
+
 		set_bit(pos, line->blk_bitmap);
 		nr_bad_chks++;
 	}
-- 
2.11.0
