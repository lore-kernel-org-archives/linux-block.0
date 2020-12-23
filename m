Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D99BC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 12:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097C1204EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgLWMSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 07:18:45 -0500
Received: from m12-13.163.com ([220.181.12.13]:39023 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgLWMSp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 07:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=FcPx2
        DZiZ+GuOrv1VYhC+mYz5zqBfydTQJenNzGD+AM=; b=jZ9SR+Uo8mIjpduP0Fq++
        KBlpTHLf2wDD8BzcuLO56OMLGSqmdeBLNYy0i4PHH8vYi2JM+j0LufixmKpnzq86
        4is0efWBRIL11rz+oPVIEFYhfdkU7QLRoFSyUW2cGsX93WbatGO0Ev96geMmT0zY
        5Exq2Ngvi/0MiEaKseWHVU=
Received: from localhost (unknown [101.86.213.121])
        by smtp9 (Coremail) with SMTP id DcCowACn9ir12OJf4AawXQ--.17510S2;
        Wed, 23 Dec 2020 13:43:17 +0800 (CST)
Date:   Wed, 23 Dec 2020 13:43:17 +0800
From:   Hui Su <sh_def@163.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com, songmuchun@bytedance.com
Subject: [PATCH v2] blokc/blk-merge: remove the next_bvec label in
 __blk_bios_map_sg()
Message-ID: <20201223054317.GA1518010@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowACn9ir12OJf4AawXQ--.17510S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw43Wr1UKF18XF47Zw18Zrb_yoWfCFg_CF
        4Iyryxta9rAr4S934vy3Z5Xr92krW7Xr1jy343tay7AFWIgFWrCw17AFZxX393GayfC3s8
        J3WkXry5KF40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRirb17UUUUU==
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJhUEX1v2fmOcoAAAsk
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

remove the next_bvec label in __blk_bios_map_sg(),
simplify the logic of traversal bvec.

Signed-off-by: Hui Su <sh_def@163.com>
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


