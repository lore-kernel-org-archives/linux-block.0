Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45370 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755136AbdDMTcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 15:32:55 -0400
Date: Thu, 13 Apr 2017 22:32:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lightnvm: pblk-gc: fix an error pointer dereference in init
Message-ID: <20170413193241.GA591@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These labels are reversed so we could end up dereferencing an error
pointer or leaking.

Fixes: 7f347ba6bb3a ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 9b147cfd8a41..f173fd4ea947 100644
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
