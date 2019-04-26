Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E80C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45E206A3
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfDZKpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfDZKpf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 06:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8555D30820E6;
        Fri, 26 Apr 2019 10:45:35 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A261001E6C;
        Fri, 26 Apr 2019 10:45:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: fix handling for BIO_NO_PAGE_REF
Date:   Fri, 26 Apr 2019 18:45:20 +0800
Message-Id: <20190426104521.30602-2-ming.lei@redhat.com>
In-Reply-To: <20190426104521.30602-1-ming.lei@redhat.com>
References: <20190426104521.30602-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 26 Apr 2019 10:45:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 399254aaf489211 ("block: add BIO_NO_PAGE_REF flag") introduces
BIO_NO_PAGE_REF, and once this flag is set for one bio, all pages
in the bio won't be get/put during IO.

However, if one bio is submitted via __blkdev_direct_IO_simple(),
even though BIO_NO_PAGE_REF is set, pages still may be put.

Fixes this issue by avoiding to put pages if BIO_NO_PAGE_REF is
set.

Fixes: 399254aaf489211 ("block: add BIO_NO_PAGE_REF flag")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 24615c76c1d0..bb28e2ead679 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -264,7 +264,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio_for_each_segment_all(bvec, &bio, i, iter_all) {
 		if (should_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		if (!bio_flagged(&bio, BIO_NO_PAGE_REF))
+			put_page(bvec->bv_page);
 	}
 
 	if (unlikely(bio.bi_status))
-- 
2.9.5

