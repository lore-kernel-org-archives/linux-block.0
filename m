Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F5ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIUSFc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIUSF1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184077560
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OSLO2Q+em7ygzioePBX0gVGV2sXfg6BZdJmIzfsHhoE=; b=aqYmDhv9M/hZEUbgv9PaWfctFe
        QSU5caNjDC8oU8Zyo1M+xvAgWTgnKeh5wKqZu/W6zrDSMxpThDuxJVngXQjVIM27QJHiSJMsNcDG2
        xUV4/ETKvWYGs+8d3QxmzXGHPBexC9EtCW0Nd2eFB/26In0rCHDdwuasTfBfiEhp/eLzyg6kqBorh
        x/DbmTP+34U86J8JUaEyi00whoxjmUjWaNae2G5yHswndhNp6DGu9fyrxVRIGzHAOke+fgFL1iVsF
        2/eb+GRRfi6Tw0FVHflbpObluG/1q0SuCMq3NxkaUnbgyI3nA5PXUSecaGLE8P14vGcAQIbd55BwT
        6KDIWS7g==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob468-00CGZq-F9; Wed, 21 Sep 2022 18:05:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 09/17] blk-iocost: simplify ioc_name
Date:   Wed, 21 Sep 2022 20:04:53 +0200
Message-Id: <20220921180501.1539876-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just directly dereference the disk name instead of going through multiple
hoops to find the same value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7936e5f5821c7..cba9d3ad58e16 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -664,17 +664,13 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
 }
 
-static const char *q_name(struct request_queue *q)
-{
-	if (blk_queue_registered(q))
-		return kobject_name(q->kobj.parent);
-	else
-		return "<unknown>";
-}
-
 static const char __maybe_unused *ioc_name(struct ioc *ioc)
 {
-	return q_name(ioc->rqos.q);
+	struct gendisk *disk = ioc->rqos.q->disk;
+
+	if (!disk)
+		return "<unknown>";
+	return disk->disk_name;
 }
 
 static struct ioc_gq *pd_to_iocg(struct blkg_policy_data *pd)
-- 
2.30.2

