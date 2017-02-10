Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36223 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdBJK5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 05:57:02 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 4/5] md: remove unnecessary check on mddev
Date: Fri, 10 Feb 2017 18:56:16 +0800
Message-Id: <1486724177-14817-5-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1486724177-14817-1-git-send-email-tom.leiming@gmail.com>
References: <1486724177-14817-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

mddev is never NULL and neither is ->bio_set, so
remove the check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/md.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3425c2b779a6..2835f09b9e71 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -193,9 +193,6 @@ EXPORT_SYMBOL_GPL(bio_alloc_mddev);
 struct bio *bio_clone_mddev(struct bio *bio, gfp_t gfp_mask,
 			    struct mddev *mddev)
 {
-	if (!mddev || !mddev->bio_set)
-		return bio_clone(bio, gfp_mask);
-
 	return bio_clone_bioset(bio, gfp_mask, mddev->bio_set);
 }
 EXPORT_SYMBOL_GPL(bio_clone_mddev);
-- 
2.7.4
