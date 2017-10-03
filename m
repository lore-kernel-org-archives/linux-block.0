Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:48263 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdJCKGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id i82so13415537wmd.3
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:53 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 4/9] lightnvm: pblk: start gc if needed during init
Date: Tue,  3 Oct 2017 12:05:08 +0200
Message-Id: <1507025113-13351-5-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Start GC, if needed, directly after init, as we might
need to garbage collect to make room for user writes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1cc3de4..fb41182 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1022,6 +1022,10 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 			pblk->rwb.nr_entries);
 
 	wake_up_process(pblk->writer_ts);
+
+	/* Check if we need to start GC */
+	pblk_gc_should_kick(pblk);
+
 	return pblk;
 
 fail_stop_writer:
-- 
2.7.4
