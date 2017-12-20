Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755895AbdLTRWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so11131844wmf.4
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:35 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 21/25] lightnvm: pblk: ensure kthread alloc. before kicking it
Date: Wed, 20 Dec 2017 18:22:01 +0100
Message-Id: <20171220172205.26464-22-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

When creating the write thread, ensure that the kthread has been created
before initializing the timer responsible from kicking it. Otherwise, if
the kthread creation fails or gets killed from used space, we risk
kicking an empty thread structure.

Also, since the kthread creation can be interrupted form user space,
adapt the error path to not report an error when this happens, since it
is intentional that the instance creation is aborted.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 30ea592..3150b8f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -883,15 +883,19 @@ static int pblk_lines_init(struct pblk *pblk)
 
 static int pblk_writer_init(struct pblk *pblk)
 {
-	setup_timer(&pblk->wtimer, pblk_write_timer_fn, (unsigned long)pblk);
-	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
-
 	pblk->writer_ts = kthread_create(pblk_write_ts, pblk, "pblk-writer-t");
 	if (IS_ERR(pblk->writer_ts)) {
-		pr_err("pblk: could not allocate writer kthread\n");
-		return PTR_ERR(pblk->writer_ts);
+		int err = PTR_ERR(pblk->writer_ts);
+
+		if (err != -EINTR)
+			pr_err("pblk: could not allocate writer kthread (%d)\n",
+					err);
+		return err;
 	}
 
+	setup_timer(&pblk->wtimer, pblk_write_timer_fn, (unsigned long)pblk);
+	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
+
 	return 0;
 }
 
@@ -1042,7 +1046,8 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 
 	ret = pblk_writer_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize write thread\n");
+		if (ret != -EINTR)
+			pr_err("pblk: could not initialize write thread\n");
 		goto fail_free_lines;
 	}
 
-- 
2.9.3
