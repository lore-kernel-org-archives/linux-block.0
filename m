Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC50BC07E99
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF7A61923
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 12:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGHMqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:46:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhGHMqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 08:46:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F8CB201BF;
        Thu,  8 Jul 2021 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625748234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4HBJ9j3raPc5OQynJOO5Jq31LuNuXGgUK0tD1yAAz0=;
        b=sWvKQnWc94bZ1fP4UEJt71N35uFn7oCLbc0csxkGx4o+LVmDT2pyO7HqvbXaKCwahkZKxF
        MkPJTMcVDWZxdBgJLBnDIKZ71EDBp41dd/wd5oYFGaNJXpG1ziztI6xniHN1m8IXcMSpqa
        uBLOyVv5yXoOiwRfosNF4MCI2cpnyRI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1286D12FF6;
        Thu,  8 Jul 2021 12:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0PxXAwrz5mCCYAAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 08 Jul 2021 12:43:54 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 3/3] xen/blkfront: don't trust the backend response data blindly
Date:   Thu,  8 Jul 2021 14:43:45 +0200
Message-Id: <20210708124345.10173-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210708124345.10173-1-jgross@suse.com>
References: <20210708124345.10173-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Today blkfront will trust the backend to send only sane response data.
In order to avoid privilege escalations or crashes in case of malicious
backends verify the data to be within expected limits. Especially make
sure that the response always references an outstanding request.

Introduce a new state of the ring BLKIF_STATE_ERROR which will be
switched to in case an inconsistency is being detected. Recovering from
this state is possible only via removing and adding the virtual device
again (e.g. via a suspend/resume cycle).

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use READ_ONCE() for reading the producer index
- check validity of producer index only after memory barrier (Jan Beulich)
- use virt_rmb() as barrier (Jan Beulich)
---
 drivers/block/xen-blkfront.c | 66 ++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 80701860870a..ecdbb0381b4c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -80,6 +80,7 @@ enum blkif_state {
 	BLKIF_STATE_DISCONNECTED,
 	BLKIF_STATE_CONNECTED,
 	BLKIF_STATE_SUSPENDED,
+	BLKIF_STATE_ERROR,
 };
 
 struct grant {
@@ -89,6 +90,7 @@ struct grant {
 };
 
 enum blk_req_status {
+	REQ_PROCESSING,
 	REQ_WAITING,
 	REQ_DONE,
 	REQ_ERROR,
@@ -543,7 +545,7 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 
 	id = get_id_from_freelist(rinfo);
 	rinfo->shadow[id].request = req;
-	rinfo->shadow[id].status = REQ_WAITING;
+	rinfo->shadow[id].status = REQ_PROCESSING;
 	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
 
 	rinfo->shadow[id].req.u.rw.id = id;
@@ -572,6 +574,7 @@ static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_inf
 
 	/* Copy the request to the ring page. */
 	*final_ring_req = *ring_req;
+	rinfo->shadow[id].status = REQ_WAITING;
 
 	return 0;
 }
@@ -847,8 +850,11 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 
 	/* Copy request(s) to the ring page. */
 	*final_ring_req = *ring_req;
-	if (unlikely(require_extra_req))
+	rinfo->shadow[id].status = REQ_WAITING;
+	if (unlikely(require_extra_req)) {
 		*final_extra_ring_req = *extra_ring_req;
+		rinfo->shadow[extra_id].status = REQ_WAITING;
+	}
 
 	if (new_persistent_gnts)
 		gnttab_free_grant_references(setup.gref_head);
@@ -1402,8 +1408,8 @@ static enum blk_req_status blkif_rsp_to_req_status(int rsp)
 static int blkif_get_final_status(enum blk_req_status s1,
 				  enum blk_req_status s2)
 {
-	BUG_ON(s1 == REQ_WAITING);
-	BUG_ON(s2 == REQ_WAITING);
+	BUG_ON(s1 < REQ_DONE);
+	BUG_ON(s2 < REQ_DONE);
 
 	if (s1 == REQ_ERROR || s2 == REQ_ERROR)
 		return BLKIF_RSP_ERROR;
@@ -1436,7 +1442,7 @@ static bool blkif_completion(unsigned long *id,
 		s->status = blkif_rsp_to_req_status(bret->status);
 
 		/* Wait the second response if not yet here. */
-		if (s2->status == REQ_WAITING)
+		if (s2->status < REQ_DONE)
 			return false;
 
 		bret->status = blkif_get_final_status(s->status,
@@ -1555,11 +1561,17 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
  again:
-	rp = rinfo->ring.sring->rsp_prod;
-	rmb(); /* Ensure we see queued responses up to 'rp'. */
+	rp = READ_ONCE(rinfo->ring.sring->rsp_prod);
+	virt_rmb(); /* Ensure we see queued responses up to 'rp'. */
+	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
+		pr_alert("%s: illegal number of responses %u\n",
+			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
+		goto err;
+	}
 
 	for (i = rinfo->ring.rsp_cons; i != rp; i++) {
 		unsigned long id;
+		unsigned int op;
 
 		RING_COPY_RESPONSE(&rinfo->ring, i, &bret);
 		id = bret.id;
@@ -1570,14 +1582,28 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		 * look in get_id_from_freelist.
 		 */
 		if (id >= BLK_RING_SIZE(info)) {
-			WARN(1, "%s: response to %s has incorrect id (%ld)\n",
-			     info->gd->disk_name, op_name(bret.operation), id);
-			/* We can't safely get the 'struct request' as
-			 * the id is busted. */
-			continue;
+			pr_alert("%s: response has incorrect id (%ld)\n",
+				 info->gd->disk_name, id);
+			goto err;
 		}
+		if (rinfo->shadow[id].status != REQ_WAITING) {
+			pr_alert("%s: response references no pending request\n",
+				 info->gd->disk_name);
+			goto err;
+		}
+
+		rinfo->shadow[id].status = REQ_PROCESSING;
 		req  = rinfo->shadow[id].request;
 
+		op = rinfo->shadow[id].req.operation;
+		if (op == BLKIF_OP_INDIRECT)
+			op = rinfo->shadow[id].req.u.indirect.indirect_op;
+		if (bret.operation != op) {
+			pr_alert("%s: response has wrong operation (%u instead of %u)\n",
+				 info->gd->disk_name, bret.operation, op);
+			goto err;
+		}
+
 		if (bret.operation != BLKIF_OP_DISCARD) {
 			/*
 			 * We may need to wait for an extra response if the
@@ -1602,7 +1628,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_DISCARD:
 			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
 				struct request_queue *rq = info->rq;
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
+
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
 					   info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 				info->feature_discard = 0;
@@ -1614,13 +1641,13 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_FLUSH_DISKCACHE:
 		case BLKIF_OP_WRITE_BARRIER:
 			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
 				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
 			if (unlikely(bret.status == BLKIF_RSP_ERROR &&
 				     rinfo->shadow[id].req.u.rw.nr_segments == 0)) {
-				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
+				pr_warn_ratelimited("blkfront: %s: empty %s op failed\n",
 				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
@@ -1635,8 +1662,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_READ:
 		case BLKIF_OP_WRITE:
 			if (unlikely(bret.status != BLKIF_RSP_OKAY))
-				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
-					"request: %x\n", bret.status);
+				dev_dbg_ratelimited(&info->xbdev->dev,
+					"Bad return from blkdev data request: %x\n", bret.status);
 
 			break;
 		default:
@@ -1662,6 +1689,11 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 
 	return IRQ_HANDLED;
+
+ err:
+	info->connected = BLKIF_STATE_ERROR;
+	pr_alert("%s disabled for further use\n", info->gd->disk_name);
+	return IRQ_HANDLED;
 }
 
 
-- 
2.26.2

