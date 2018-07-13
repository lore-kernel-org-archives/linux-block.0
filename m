Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35763 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbeGMJDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so4788619pgv.2
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:52 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/10] lightnvm: pblk: assume that chunks are closed on 1.2 devices
Date: Fri, 13 Jul 2018 10:48:45 +0200
Message-Id: <20180713084845.19511-11-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

We can't know if a block is closed or not on 1.2 devices, so assume
closed state to make sure that blocks are erased before writing.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index d023ea6116bc..537e98f2b24a 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -719,10 +719,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 
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
2.11.0
