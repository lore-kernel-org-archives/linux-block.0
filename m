Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32951 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeD3JKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12so10640705wmc.0
        for <linux-block@vger.kernel.org>; Mon, 30 Apr 2018 02:10:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 09/11] lightnvm: pblk: check for chunk size before allocating it
Date: Mon, 30 Apr 2018 11:10:07 +0200
Message-Id: <1525079409-6588-10-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Do the check for the chunk state after making sure that the chunk type
is supported.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4
