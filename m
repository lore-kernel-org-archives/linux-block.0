Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42750 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1040684AbdDUUxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 16:53:13 -0400
Date: Fri, 21 Apr 2017 23:53:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] lightnvm: potential underflow in pblk_read_rq()
Message-ID: <20170421205301.3ds7jrgcktuldvrp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a static checker fix, and perhaps not a real bug.  The static
checker thinks that nr_secs could be negative.  It would result in
zeroing more memory than intended.  Anyway, even if it's not a bug,
changing this variable to unsigned makes the code easier to audit.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index bce7ed5fc73f..c9daa33e8d9c 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -288,7 +288,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	int nr_secs = pblk_get_secs(bio);
+	unsigned int nr_secs = pblk_get_secs(bio);
 	struct nvm_rq *rqd;
 	unsigned long read_bitmap; /* Max 64 ppas per request */
 	unsigned int bio_init_idx;
