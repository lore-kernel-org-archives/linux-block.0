Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33164 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeC2WHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id x70-v6so3501381lfa.0
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:07 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/37] lightnvm: pblk: allow allocation of new lines during shutdown
Date: Fri, 30 Mar 2018 00:04:57 +0200
Message-Id: <20180329220524.30363-11-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When shutting down pblk the write buffer is flushed and if the
current line can't fit the data in the write buffer we need
to allocate a new line, so remove the check that prevents this.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 22e61cd4f801..8848443a0721 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1407,13 +1407,6 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	l_mg->data_line = new;
 
 	spin_lock(&l_mg->free_lock);
-	if (pblk->state != PBLK_STATE_RUNNING) {
-		l_mg->data_line = NULL;
-		l_mg->data_next = NULL;
-		spin_unlock(&l_mg->free_lock);
-		goto out;
-	}
-
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
-- 
2.11.0
