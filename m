Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF29BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 07:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiARHEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 02:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiARHEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 02:04:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED94C061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 23:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ORSN9e15JyRxg79JiBN0SJHsITvQpXLhCCj7osd2HYw=; b=z5RxoCTm3tdVF4zOf2MXnfgck4
        h7GOI8Kjmfsd8QGo8NHtQffy7wIm5rVh/MGGuTphf349XD244ANGGaWdtW4s7b/a7zHY011acGYEP
        2jnj6+D9+LK1aj3e1q56mTKjq8WvpB+rlnC/dL+CqWdc0zuUv0FAGSf1GPTBYBON1gCgDyC/U1JEz
        +SYr+htypwfgyxx8d5SLBfGhksNKRgNJUGWpM7jwfw5ZQHwlH428YMjuTy1JVegsQqtBahAhiGKZ1
        GDjX1IhRhPRihAEV/5YbzUrUrg4d+F3OagtYXdJ9TVorlDiexNfPkFbrVuaV8TUTMeaqEpx/vLZkR
        /wxOTSIQ==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9iXt-000Vyu-U3; Tue, 18 Jan 2022 07:04:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: assign bi_bdev for cloned bios in blk_rq_prep_clone
Date:   Tue, 18 Jan 2022 08:04:44 +0100
Message-Id: <20220118070444.1241739-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_clone_fast() sets the cloned bio to have the same ->bi_bdev as the
source bio. This means that when request-based dm called setup_clone(),
the cloned bio had its ->bi_bdev pointing to the dm device. After Commit
0b6e522cdc4a ("blk-mq: use ->bi_bdev for I/O accounting")
__blk_account_io_start() started using the request's ->bio->bi_bdev for
I/O accounting, if it was set. This caused IO going to the underlying
devices to use the dm device for their I/O accounting.

Set up the proper ->bi_bdev in blk_rq_prep_clone based on the whole
device bdev for the queue the request is cloned onto.

Fixes: 0b6e522cdc4a ("blk-mq: use ->bi_bdev for I/O accounting")
Reported-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: the commit message is mostly from a different patch from Benjamin]
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6d4780580fcd..b5e35e63adad4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2976,6 +2976,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		bio = bio_clone_fast(bio_src, gfp_mask, bs);
 		if (!bio)
 			goto free_and_out;
+		bio->bi_bdev = rq->q->disk->part0;
 
 		if (bio_ctr && bio_ctr(bio, bio_src, data))
 			goto free_and_out;
-- 
2.30.2

