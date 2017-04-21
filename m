Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35322 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426666AbdDUXdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:02 -0400
Received: by mail-wm0-f44.google.com with SMTP id w64so25874444wma.0
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:01 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/5] lightnvm: pblk: fix race condition on line retry
Date: Sat, 22 Apr 2017 01:32:45 +0200
Message-Id: <1492817569-13532-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a pblk line fails (or is recovered), make sure to take the line
management lock.

Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a2bcd09..7065658 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1050,13 +1050,14 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 	spin_lock(&l_mg->free_lock);
 	l_mg->data_line = line;
 	list_del(&line->list);
-	spin_unlock(&l_mg->free_lock);
 
 	ret = pblk_line_prepare(pblk, line);
 	if (ret) {
 		list_add(&line->list, &l_mg->free_list);
+		spin_unlock(&l_mg->free_lock);
 		return ret;
 	}
+	spin_unlock(&l_mg->free_lock);
 
 	pblk_rl_free_lines_dec(&pblk->rl, line);
 
@@ -1140,6 +1141,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	line->invalid_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
+	l_mg->data_line = retry_line;
 	spin_unlock(&l_mg->free_lock);
 
 	if (pblk_line_erase(pblk, retry_line))
@@ -1147,8 +1149,6 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 
 	pblk_rl_free_lines_dec(&pblk->rl, retry_line);
 
-	l_mg->data_line = retry_line;
-
 	return retry_line;
 }
 
-- 
2.7.4
