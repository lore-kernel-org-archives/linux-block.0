Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A6C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEDF20651
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAPCQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:16:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfAPCQM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 21:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AA4113AA9;
        Wed, 16 Jan 2019 02:16:12 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D04E6107F;
        Wed, 16 Jan 2019 02:16:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fs: gfs2: fix build failure
Date:   Wed, 16 Jan 2019 10:16:02 +0800
Message-Id: <20190116021602.27130-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 02:16:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is one bio_for_each_segment_all() not converted, so fix it.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: eb754eb2a953ead0 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/gfs2/lops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index ef68bf6232e7..15deefeaafd0 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -390,8 +390,9 @@ static void gfs2_end_log_read(struct bio *bio)
 	struct page *page;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all(bvec, bio, i, iter_all) {
 		page = bvec->bv_page;
 		if (bio->bi_status) {
 			int err = blk_status_to_errno(bio->bi_status);
-- 
2.14.4

