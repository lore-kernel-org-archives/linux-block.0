Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755982AbdDOS5O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:57:14 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 17/19] lightnvm: pblk-gc: fix an error pointer dereference in init
Date: Sat, 15 Apr 2017 20:55:51 +0200
Message-ID: <20170415185553.16098-18-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

These labels are reversed so we could end up dereferencing an error
pointer or leaking.

Fixes: 7f347ba6bb3a ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 9b147cf..f173fd4 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -527,10 +527,10 @@ int pblk_gc_init(struct pblk *pblk)
 
 	return 0;
 
-fail_free_main_kthread:
-	kthread_stop(gc->gc_ts);
 fail_free_writer_kthread:
 	kthread_stop(gc->gc_writer_ts);
+fail_free_main_kthread:
+	kthread_stop(gc->gc_ts);
 
 	return ret;
 }
-- 
2.9.3
