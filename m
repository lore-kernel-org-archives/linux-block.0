Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EDEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 14:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjGNObL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjGNObK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 10:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2835B7
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EqDN388KOkDryK72KmM4dqhAezeccTVywSbmBxIwGp0=; b=dIzMXjGp1vB8HqzNIN9FkOWMUl
        yJ3GayZtzmNbMxTsmlHijBgSQqwZsaaITLMX7CpIZXsAoaC91eJ8GSc65nGOqh7uFCe7dTTxBRjre
        FzTCyYJfeuPMnsd5dDoFyVuxGll+VKOz9LpT9/j3szuhs8F0vbbbP6AS6eeCiQtBlPzwy8mTH0u9o
        9qNBZySlYZYaAACZIvE4NfgHWVe9mJ7QLdY/b9VRukGvhArVUt/rLRGmnxjykPa2HeNCL6Wy89doG
        XFhuiK6kUhYYp8FcDzLApBRiZRVvD7lh2ecQDKZ7IX9AnXOW5tNvJB7AY8B9Xs+oAnA068Vdrcd+W
        ZyLuwKNw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJoI-006Omx-2h;
        Fri, 14 Jul 2023 14:30:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] block: queue data commands from the flush state machine at the head
Date:   Fri, 14 Jul 2023 16:30:14 +0200
Message-Id: <20230714143014.11879-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We used to insert the data commands following a pre-flush to the head
of the queue until commit 1e82fadfc6b ("blk-mq: do not do head insertions
post-pre-flush commands").  Not doing this seems to cause hangs of
such commands on NFS workloads when exported from file systems with
SATA SSDs.  I have no idea why this would starve these workloads,
but doing a semantic revert of this patch (which looks quite different
due to various other changes) fixes the hangs.

Fixes: 1e82fadfc6b ("blk-mq: do not do head insertions post-pre-flush commands")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index dba392cf22bec6..8220517c2d67da 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -189,7 +189,7 @@ static void blk_flush_complete_seq(struct request *rq,
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
 		spin_lock(&q->requeue_lock);
-		list_add_tail(&rq->queuelist, &q->flush_list);
+		list_add(&rq->queuelist, &q->requeue_list);
 		spin_unlock(&q->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
-- 
2.39.2

