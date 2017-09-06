Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34701 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbdIFKUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:20:33 -0400
Received: by mail-wm0-f42.google.com with SMTP id 137so26987418wmj.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:20:33 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] block: export symbol for bio_copy_kern
Date: Wed,  6 Sep 2017 12:20:25 +0200
Message-Id: <1504693225-11715-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Export symbol for bio_copy_kern so that we can use it in modules.

Reported-by: Andiry Xu <t-jianxu@microsoft.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 6745759028da..cface315ace5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1610,6 +1610,7 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
 	bio_put(bio);
 	return ERR_PTR(-ENOMEM);
 }
+EXPORT_SYMBOL(bio_copy_kern);
 
 /*
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
-- 
2.7.4
