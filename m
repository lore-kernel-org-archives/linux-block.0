Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37311 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdFZJ6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:32 -0400
Received: by mail-wm0-f44.google.com with SMTP id i127so3037575wma.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:26 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 17/20] lightnvm: pblk: add lock assertions on helpers
Date: Mon, 26 Jun 2017 11:57:26 +0200
Message-Id: <1498471049-25505-18-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add lockdep assertions on helper functions.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index d815cdad56b8..ed41cd7700b3 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -295,6 +295,8 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 	struct list_head *move_list = NULL;
 	int vsc = le32_to_cpu(*line->vsc);
 
+	lockdep_assert_held(&line->lock);
+
 	if (!vsc) {
 		if (line->gc_group != PBLK_LINEGC_FULL) {
 			line->gc_group = PBLK_LINEGC_FULL;
@@ -502,6 +504,8 @@ u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
 	u64 addr;
 	int i;
 
+	lockdep_assert_held(&line->lock);
+
 	/* logic error: ppa out-of-bounds. Prevent generating bad address */
 	if (line->cur_sec + nr_secs > pblk->lm.sec_per_line) {
 		WARN(1, "pblk: page allocation out of bounds\n");
-- 
2.7.4
