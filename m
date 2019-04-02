Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B53C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA9C20833
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 01:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDBBqu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfDBBqu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 21:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D2148B949;
        Tue,  2 Apr 2019 01:46:50 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAA5227BD3;
        Tue,  2 Apr 2019 01:46:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: fix build warning in __blk_bios_map_sg()
Date:   Tue,  2 Apr 2019 09:46:38 +0800
Message-Id: <20190402014638.25633-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 02 Apr 2019 01:46:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can
be mergeable") changes bvec merge by only considering two bvecs from
different bios. However, if the former bio doesn't inlcude any io bvec,
then the following warning may be triggered:

 warning: ‘bvec.bv_offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]

In practice, it shouldn't be triggered.

Fixes it by adding check on former bio, the check shouldn't add any cost
given 'bio->bi_iter' can be hit in cache.

Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8f96d683b577..1fc66d03893f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -527,7 +527,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			     struct scatterlist *sglist,
 			     struct scatterlist **sg)
 {
-	struct bio_vec bvec, bvprv = { NULL };
+	struct bio_vec uninitialized_var(bvec), bvprv = { NULL };
 	struct bvec_iter iter;
 	int nsegs = 0;
 	bool new_bio = false;
@@ -550,8 +550,10 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
  next_bvec:
 			new_bio = false;
 		}
-		bvprv = bvec;
-		new_bio = true;
+		if (likely(bio->bi_iter.bi_size)) {
+			bvprv = bvec;
+			new_bio = true;
+		}
 	}
 
 	return nsegs;
-- 
2.9.5

