Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584ADC10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 15:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F42B205ED
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 15:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfDPPjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfDPPjM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 11:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B7CC308793F;
        Tue, 16 Apr 2019 15:39:10 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 131B15D9CA;
        Tue, 16 Apr 2019 15:39:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block: make sure that bvec length can't be overflowed
Date:   Tue, 16 Apr 2019 23:38:47 +0800
Message-Id: <20190416153847.8173-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Apr 2019 15:39:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec->bv_offset may be bigger than PAGE_SIZE sometimes, such as,
when one bio is splitted in the middle of one bvec via bio_split(),
and bi_iter.bi_bvec_done is used to build offset of the 1st bvec of
remained bio.

So we have to make sure that every bvec's offset is less than
PAGE_SIZE from bio_for_each_segment().

This patch fixes this issue reported by Zhang Yi When running nvme/011.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 3bc91879e1e2..f179b370066f 100644
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
+		bv->bv_offset = bvec->bv_offset % PAGE_SIZE;
 	}
 	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
 			   bvec->bv_len - iter_all->done);
-- 
2.9.5

