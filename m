Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35332 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdEWKil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 06:38:41 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so21610237qtb.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 03:38:41 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Josef Bacik <jbacik@fb.com>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH] nbd: don't leak nbd_config
Date: Tue, 23 May 2017 12:38:31 +0200
Message-Id: <1495535911-29036-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nbd_config is allocated in nbd_alloc_config(), but never freed.

Fixes: 5ea8d10802ec ("nbd: separate out the config information")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9a7bb2c29447..882fb9efbab1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -940,6 +940,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
+	kfree(nbd->config);
 	nbd->config = NULL;
 	nbd->tag_set.timeout = 0;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
-- 
2.4.3
