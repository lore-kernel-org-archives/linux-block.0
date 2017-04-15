Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755634AbdDOS4u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:50 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 14/19] lightnvm: fix type checks on rrpc
Date: Sat, 15 Apr 2017 20:55:48 +0200
Message-ID: <20170415185553.16098-15-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

sector_t is always unsigned, therefore avoid < 0 checks on it.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/rrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 5dba544..cf0e28a 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -817,7 +817,7 @@ static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 
 	for (i = 0; i < npages; i++) {
 		/* We assume that mapping occurs at 4KB granularity */
-		BUG_ON(!(laddr + i >= 0 && laddr + i < rrpc->nr_sects));
+		BUG_ON(!(laddr + i < rrpc->nr_sects));
 		gp = &rrpc->trans_map[laddr + i];
 
 		if (gp->rblk) {
@@ -846,7 +846,7 @@ static int rrpc_read_rq(struct rrpc *rrpc, struct bio *bio, struct nvm_rq *rqd,
 	if (!is_gc && rrpc_lock_rq(rrpc, bio, rqd))
 		return NVM_IO_REQUEUE;
 
-	BUG_ON(!(laddr >= 0 && laddr < rrpc->nr_sects));
+	BUG_ON(!(laddr < rrpc->nr_sects));
 	gp = &rrpc->trans_map[laddr];
 
 	if (gp->rblk) {
-- 
2.9.3
