Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34103 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759683AbdEWPuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 11:50:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so22763382qtb.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 08:50:06 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Josef Bacik <jbacik@fb.com>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH v2 2/2] nbd: don't leak nbd_config
Date: Tue, 23 May 2017 17:49:55 +0200
Message-Id: <1495554595-30945-2-git-send-email-idryomov@gmail.com>
In-Reply-To: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
References: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nbd_config is allocated in nbd_alloc_config(), but never freed.

Fixes: 5ea8d10802ec ("nbd: separate out the config information")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e725d8d5ab0b..f3f191ba8ca4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1021,6 +1021,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 			}
 			kfree(config->socks);
 		}
+		kfree(nbd->config);
 		nbd->config = NULL;
 
 		nbd->tag_set.timeout = 0;
-- 
2.4.3
