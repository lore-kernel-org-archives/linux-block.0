Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6490C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8692D2243E
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJcF3k1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8692D2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbeKOCGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=papcWxloEQE8c8vyKvyq1fINjxLlmJwTRehyLyCSAwE=; b=RJcF3k1Vu+NQVN9PsOKF34D2Rq
        83pOrbUDR4GTJ0SOTIna3bF1aowtlufuIrHXIysGKRy2pTrsqsW5NfetYaPRHMlxo52fc3hWckrb5
        E9NF21n6G4pKjKeYmPSKbDR0yG2Es9idsZMq7Ms0fXFJD1Sz+ruEYsUMCmIgrm8JdMrUUUP/d9+fT
        3U6rKRsKsV+WR0Khaf5H+9WVkH5i2c2uPg1toYzkumKftQztsi/dT2tFvT0oLY2I05Ip7Yq7+SRrN
        bftVeiL4uTRc1qhC4V/PKg/ZCCPqKz0aoRAKADQTFJvp6pe/E3gf47SS51sMKmavidIziq3XGjkBb
        WhZivN9A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcv-0006Dm-3U; Wed, 14 Nov 2018 16:02:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 10/16] blk-cgroup: move locking into blkg_destroy_all
Date:   Wed, 14 Nov 2018 17:02:13 +0100
Message-Id: <20181114160219.28328-11-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 717ab38a6c67..3ba23b9bfeb9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -349,8 +349,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 
-	lockdep_assert_held(q->queue_lock);
-
+	spin_lock_irq(q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
@@ -360,6 +359,7 @@ static void blkg_destroy_all(struct request_queue *q)
 	}
 
 	q->root_blkg = NULL;
+	spin_unlock_irq(q->queue_lock);
 }
 
 /*
@@ -1182,9 +1182,7 @@ int blkcg_init_queue(struct request_queue *q)
 	return 0;
 
 err_destroy_all:
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
 	return ret;
 err_unlock:
 	spin_unlock_irq(q->queue_lock);
@@ -1222,10 +1220,7 @@ void blkcg_drain_queue(struct request_queue *q)
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
-
 	blk_throtl_exit(q);
 }
 
-- 
2.19.1

