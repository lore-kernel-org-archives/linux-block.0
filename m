Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bran.ispras.ru ([83.149.199.196]:34252 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751704AbdHGMsC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 08:48:02 -0400
From: Anton Volkov <avolkov@ispras.ru>
To: tom.leiming@gmail.com
Cc: axboe@fb.com, osandov@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, ldv-project@linuxtesting.org,
        khoroshilov@ispras.ru, Anton Volkov <avolkov@ispras.ru>
Subject: [PATCH] loop: fix to a race condition due to the early registration of device
Date: Mon,  7 Aug 2017 15:37:50 +0300
Message-Id: <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
In-Reply-To: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The early device registration made possible a race leading to allocations
of disks with wrong minors.

This patch moves the device registration further down the loop_init
function to make the race infeasible.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Volkov <avolkov@ispras.ru>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef83349..2fbd4089 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1996,10 +1996,6 @@ static int __init loop_init(void)
 	struct loop_device *lo;
 	int err;
 
-	err = misc_register(&loop_misc);
-	if (err < 0)
-		return err;
-
 	part_shift = 0;
 	if (max_part > 0) {
 		part_shift = fls(max_part);
@@ -2017,12 +2013,12 @@ static int __init loop_init(void)
 
 	if ((1UL << part_shift) > DISK_MAX_PARTS) {
 		err = -EINVAL;
-		goto misc_out;
+		goto err_out;
 	}
 
 	if (max_loop > 1UL << (MINORBITS - part_shift)) {
 		err = -EINVAL;
-		goto misc_out;
+		goto err_out;
 	}
 
 	/*
@@ -2041,6 +2037,11 @@ static int __init loop_init(void)
 		range = 1UL << MINORBITS;
 	}
 
+	err = misc_register(&loop_misc);
+	if (err < 0)
+		goto err_out;
+
+
 	if (register_blkdev(LOOP_MAJOR, "loop")) {
 		err = -EIO;
 		goto misc_out;
@@ -2060,6 +2061,7 @@ static int __init loop_init(void)
 
 misc_out:
 	misc_deregister(&loop_misc);
+err_out:
 	return err;
 }
 
-- 
2.7.4
