Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35451 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdDKOTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:19:07 -0400
Received: by mail-wm0-f42.google.com with SMTP id w64so65050439wma.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:19:07 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: fix type checks on rrpc
Date: Tue, 11 Apr 2017 16:18:57 +0200
Message-Id: <1491920338-2348-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
References: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

sector_t is always unsigned, therefore avoid < 0 checks on it.

Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4
