Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA21C6FD19
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 09:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCMJaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCMJaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 05:30:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3431DB9B
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 02:30:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C4921FE0C;
        Mon, 13 Mar 2023 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678699820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K/N3lYrEXrJehPAkOUtoRvd5PlfsCMaQHN+39jIMO18=;
        b=fsF9cWUNdWl9rtMWpA72eq/uruu1/pEZgC0qItNJ1V1ajQgK9koeeFDKl3bRqNGsnByzx7
        Edo6pt/w9oHJX8UhImj7bwWa4JpZk0q4JeisBUYRGG1tX9DT7chRYLUkqvaSthJqPM/kHA
        ZttWXTUsii1RnKa7nGsjXhlK7uXMr9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678699820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K/N3lYrEXrJehPAkOUtoRvd5PlfsCMaQHN+39jIMO18=;
        b=0hF89fLnoL4Kko5QLiyGO0gVx5cpRANxYMUgBmIp0TfwXlYuSTUVsVMX/VNEcdpfAeIv5N
        h6Cbd25LEdNHmBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4087413517;
        Mon, 13 Mar 2023 09:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vme9DyztDmR1HwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 09:30:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BBD86A06FD; Mon, 13 Mar 2023 10:30:19 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: do not reverse request order when flushing plug list
Date:   Mon, 13 Mar 2023 10:30:02 +0100
Message-Id: <20230313093002.11756-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=jack@suse.cz; h=from:subject; bh=egozsaCFkru9OyoX7aB4X4qFW6X+3gwRpXqqoOnNMdc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkDu0UJkKyEA3S6vpJp5hJCq/HDDfzzfz8R8nXdFZB 3Fx9/DWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZA7tFAAKCRCcnaoHP2RA2atrB/ 0WjrrM9iUtIRCLk8qdsfj6NU6xJvGtv5ld/4tphSMcam585IvNbP3SzHIflAOiLIkqbLw4qGXQBCho MaYMWWUyyeB/8zWZi6X7eRWqJJoBynnr1EzlxXAsbwtOtvp3kWPkMHq8VngfleOVab3VvB+uL4aqtA U1zqHCOeUgJlgFT5c4vcMgeajBc4WnONWxzymeCoXp/gLQwbJgEi524/vRbhpEtyx7jE2ZPARItkAS /bauJ9mB1LfJBkeHIZ5PnlFNkgZ4SWM00tcV7ckGWLzdFS05+Na26x90PumrX7cIMVLYzVQBF0xjU+ X3E6vIFqd5w5GK/hCbZmMlr+pkjRZY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 26fed4ac4eab ("block: flush plug based on hardware and software
queue order") changed flushing of plug list to submit requests one
device at a time. However while doing that it also started using
list_add_tail() instead of list_add() used previously thus effectively
submitting requests in reverse order. Also when forming a rq_list with
remaining requests (in case two or more devices are used), we
effectively reverse the ordering of the plug list for each device we
process. Submitting requests in reverse order has negative impact on
performance for rotational disks (when BFQ is not in use). We observe
10-25% regression in random 4k write throughput, as well as ~20%
regression in MariaDB OLTP benchmark on rotational storage on btrfs
filesystem.

Fix the problem by preserving ordering of the plug list when inserting
requests into the queuelist as well as by appending to requeue_list
instead of prepending to it.

Fixes: 26fed4ac4eab ("block: flush plug based on hardware and software queue order")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq.c         | 5 +++--
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0cb2ef18fe2..cf1a39adf9a5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2725,6 +2725,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	struct blk_mq_hw_ctx *this_hctx = NULL;
 	struct blk_mq_ctx *this_ctx = NULL;
 	struct request *requeue_list = NULL;
+	struct request **requeue_lastp = &requeue_list;
 	unsigned int depth = 0;
 	LIST_HEAD(list);
 
@@ -2735,10 +2736,10 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
 		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
-			rq_list_add(&requeue_list, rq);
+			rq_list_add_tail(&requeue_lastp, rq);
 			continue;
 		}
-		list_add_tail(&rq->queuelist, &list);
+		list_add(&rq->queuelist, &list);
 		depth++;
 	} while (!rq_list_empty(plug->mq_list));
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dd5ce1137f04..de0b0c3e7395 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -228,6 +228,12 @@ static inline unsigned short req_get_ioprio(struct request *req)
 	*(listptr) = rq;				\
 } while (0)
 
+#define rq_list_add_tail(lastpptr, rq)	do {		\
+	(rq)->rq_next = NULL;				\
+	**(lastpptr) = rq;				\
+	*(lastpptr) = &rq->rq_next;			\
+} while (0)
+
 #define rq_list_pop(listptr)				\
 ({							\
 	struct request *__req = NULL;			\
-- 
2.35.3

