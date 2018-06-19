Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40698 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756548AbeFSJHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 05:07:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so20534466wmc.5
        for <linux-block@vger.kernel.org>; Tue, 19 Jun 2018 02:07:38 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2 devices
Date: Tue, 19 Jun 2018 11:06:29 +0200
Message-Id: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

We can't know if a block is closed or not on 1.2 devices, so assume
closed state to make sure that blocks are erased before writing.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

This patch applies on:
ssh://github.com/OpenChannelSSD/linux branch for-4.19/core

 drivers/lightnvm/pblk-init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index aa24264..3b8aa4a 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 
 		/*
 		 * In 1.2 spec. chunk state is not persisted by the device. Thus
-		 * some of the values are reset each time pblk is instantiated.
+		 * some of the values are reset each time pblk is instantiated,
+		 * so we have to assume that the block is closed.
 		 */
 		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
-			chunk->state =  NVM_CHK_ST_FREE;
+			chunk->state =  NVM_CHK_ST_CLOSED;
 		else
 			chunk->state = NVM_CHK_ST_OFFLINE;
 
-- 
2.7.4
