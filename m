Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41465 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1040867AbdDUUyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 16:54:47 -0400
Date: Fri, 21 Apr 2017 23:54:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] lightnvm: don't print a warning for ADDR_EMPTY
Message-ID: <20170421205437.fom72nbe3rfngdra@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reading from ADDR_EMPTY is out of bounds.  The current code generates a
static checker warning because we check for out of bounds "lba" before
we check for ADDR_EMPTY, so the second check is always false.  It looks
like we intended ADDR_EMPTY to be a no-op without printing a warning.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index c9daa33e8d9c..4a12f14d78c6 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -410,15 +410,15 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 	struct ppa_addr ppa;
 	int valid_secs = 0;
 
+	if (lba == ADDR_EMPTY)
+		goto out;
+
 	/* logic error: lba out-of-bounds */
 	if (lba >= pblk->rl.nr_secs) {
 		WARN(1, "pblk: read lba out of bounds\n");
 		goto out;
 	}
 
-	if (lba == ADDR_EMPTY)
-		goto out;
-
 	spin_lock(&pblk->trans_lock);
 	ppa = pblk_trans_map_get(pblk, lba);
 	spin_unlock(&pblk->trans_lock);
