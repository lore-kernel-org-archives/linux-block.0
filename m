Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB42C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 01:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EAF21773
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 01:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfDQBLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQBLh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 21:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7B5E3199371;
        Wed, 17 Apr 2019 01:11:36 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87CD5608A5;
        Wed, 17 Apr 2019 01:11:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2] block: make sure that bvec length can't be overflow
Date:   Wed, 17 Apr 2019 09:11:26 +0800
Message-Id: <20190417011126.20430-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 17 Apr 2019 01:11:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec->bv_offset may be bigger than PAGE_SIZE sometimes, such as,
when one bio is splitted in the middle of one bvec via bio_split(),
and bi_iter.bi_bvec_done is used to build offset of the 1st bvec of
remained bio. And the remained bio's bvec may be re-submitted to fs
layer via ITER_IBVEC, such as loop and nvme-loop.

So we have to make sure that every bvec's offset is less than
PAGE_SIZE from bio_for_each_segment_all() because some drivers(loop,
nvme-loop) passes the splitted bvec to fs layer via ITER_BVEC.

This patch fixes this issue reported by Zhang Yi When running nvme/011.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 3bc91879e1e2..ff13cbc1887d 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -160,8 +160,9 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 		bv->bv_page = nth_page(bv->bv_page, 1);
 		bv->bv_offset = 0;
 	} else {
-		bv->bv_page = bvec->bv_page;
-		bv->bv_offset = bvec->bv_offset;
+		bv->bv_page = bvec_nth_page(bvec->bv_page, bvec->bv_offset /
+					    PAGE_SIZE);
+		bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;
 	}
 	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
 			   bvec->bv_len - iter_all->done);
-- 
2.9.5

