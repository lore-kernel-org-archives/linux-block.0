Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE2FC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 06:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73739222BB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 06:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgLWGHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 01:07:55 -0500
Received: from m12-17.163.com ([220.181.12.17]:60099 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgLWGHy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 01:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=+qzX9
        e/A20Xku17b5CKfRVqXOFJkSi0RqKcf8lKRqUQ=; b=fc3GI7Q6/nWTAZeH/WyKI
        MPmX1oo105ToMnFo6lN14unoiiYy2AB4+dnGJkc7jYZp62fzQQ0voqiComssJYI6
        yjqqqNu0P4PmZnOgfdyPezNZrhBm+nSaMfRR5rrvzVYDs/cdYrE1YBiOF24kcb8U
        OsF0H+c6SbN6Lr8Z8ofGtM=
Received: from localhost (unknown [101.86.213.121])
        by smtp13 (Coremail) with SMTP id EcCowACHn4s+yOJfq4JZbQ--.31614S2;
        Wed, 23 Dec 2020 12:31:58 +0800 (CST)
Date:   Wed, 23 Dec 2020 12:31:58 +0800
From:   sh <sh_def@163.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com, songmuchun@bytedance.com
Subject: [PATCH] blokc/blk-merge: remove the next_bvec label in
 __blk_bios_map_sg()linux-block@vger.kernel.org (open list:BLOCK LAYER)
Message-ID: <20201223043158.GA1502002@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowACHn4s+yOJfq4JZbQ--.31614S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw43ZF1xXw13Cw1kGFW8Xrb_yoWfCrX_CF
        4Iyryxta9rAr4fu34vy3Z5Xr92krW7Xr1jy343tay7AFWSgF4rCw17AFZxX393GayfC3s8
        J3WkXry3KF40qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR4lkDUUUUU==
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBQR4EX1++IOgj+gAAs0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

remove the next_bvec label in __blk_bios_map_sg(), simplify the logic
of traversal bvec.

Signed-off-by: sh <sh_def@163.com>
---
 block/blk-merge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..aa113cbc0f35 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -494,15 +494,15 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			 * to bio
 			 */
 			if (new_bio &&
-			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))
-				goto next_bvec;
+			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg)) {
+				new_bio = false;
+				continue;
+			}
 
 			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE)
 				nsegs += __blk_bvec_map_sg(bvec, sglist, sg);
 			else
 				nsegs += blk_bvec_map_sg(q, &bvec, sglist, sg);
- next_bvec:
-			new_bio = false;
 		}
 		if (likely(bio->bi_iter.bi_size)) {
 			bvprv = bvec;
-- 
2.25.1


