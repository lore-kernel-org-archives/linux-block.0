Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35324 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426668AbdDUXdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id w64so25874584wma.0
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:02 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/5] lightnvm: pblk: fix bad error check
Date: Sat, 22 Apr 2017 01:32:46 +0200
Message-Id: <1492817569-13532-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix bad error check

Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 7065658..7eb62ec 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1273,7 +1273,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 retry_setup:
 	if (!pblk_line_set_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
-		if (new)
+		if (!new)
 			return NULL;
 
 		goto retry_setup;
-- 
2.7.4
