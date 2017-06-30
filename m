Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35909 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbdF3P5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:07 -0400
Received: by mail-wm0-f50.google.com with SMTP id 62so114237531wmw.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:57:01 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 10/10] lightnvm: pblk: set line bitmap check under debug
Date: Fri, 30 Jun 2017 17:56:43 +0200
Message-Id: <1498838203-21539-11-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Do bitmap checks only when debug mode is enable. The line bitmap used
for mapping to physical addresses is fairly large (~512KB) and it is
expensive to do this checks on the fast path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e6f42cddc8ec..11fe0c5b2a9c 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1561,11 +1561,14 @@ static void pblk_line_should_sync_meta(struct pblk *pblk)
 void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	struct pblk_line_meta *lm = &pblk->lm;
 	struct list_head *move_list;
 
+#ifdef CONFIG_NVM_DEBUG
+	struct pblk_line_meta *lm = &pblk->lm;
+
 	WARN(!bitmap_full(line->map_bitmap, lm->sec_per_line),
 				"pblk: corrupt closed line %d\n", line->id);
+#endif
 
 	spin_lock(&l_mg->free_lock);
 	WARN_ON(!test_and_clear_bit(line->meta_line, &l_mg->meta_bitmap));
-- 
2.7.4
