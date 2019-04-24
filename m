Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1763C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A42175B
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDXLB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXLB6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 07:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2E8D309CC25;
        Wed, 24 Apr 2019 11:01:57 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72198600C1;
        Wed, 24 Apr 2019 11:01:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: don't run get_page() on pages from non-bvec iov iter
Date:   Wed, 24 Apr 2019 19:01:46 +0800
Message-Id: <20190424110146.17343-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Apr 2019 11:01:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The refcount has been increased for pages retrieved from non-bvec iov iter
via __bio_iov_iter_get_pages(), so don't need to do that again.

Otherwise, IO pages are leaked easily.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 7321ecbfc7cf ("block: change how we get page references in bio_iov_iter_get_pages")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index c81ed2dfee53..662d45752ec5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -992,7 +992,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	if (iov_iter_bvec_no_ref(iter))
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
-	else
+	else if (is_bvec)
 		bio_get_pages(bio);
 
 	return bio->bi_vcnt ? 0 : ret;
-- 
2.9.5

