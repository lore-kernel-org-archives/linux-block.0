Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD3C77B7A
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjFGG3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFGG3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 02:29:30 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 23:29:28 PDT
Received: from h2.cmg1.smtp.forpsi.com (h2.cmg1.smtp.forpsi.com [81.2.195.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7819BD
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 23:29:28 -0700 (PDT)
Received: from lenoch ([80.95.121.122])
        by cmgsmtp with ESMTPSA
        id 6mecqGugwPm6C6meeqpVZ9; Wed, 07 Jun 2023 08:28:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1686119304; bh=aU66E9WZfeBovpSYlA3ge6G9nwNBhlWKLuZdsm8m8W4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=1pwkvJRpYG/7wbwgIls+opjphZ7032VZA0FArBoKGBBpxFBjPPfQ5WU6d0gKLTnEl
         N+B17m1Xu60pLqujxkc/KnC5AQBiKaO47zolx6+Bgq58Ts7K7pj57StKVDmqdNBRvJ
         Sj4BR8XBgt8pwS1twRZJNHSasqpBMs5T/PMaE7CjY4fzhXnR1CLpTBYkquzWNlSXaU
         VYtBxPmb2Js6CEUHQk1dTIstGDlPxKm3zdPqsOXGx/eTZXKhLOEErtRrUH77jyfWFw
         5zP09BPgbf7zd5f/DCZR+9a80VzLhHknz0zDkZNbhMmC9c5o2sNVDjK9C4hm8z09Kb
         ncpAmO6Utl9vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1686119304; bh=aU66E9WZfeBovpSYlA3ge6G9nwNBhlWKLuZdsm8m8W4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=1pwkvJRpYG/7wbwgIls+opjphZ7032VZA0FArBoKGBBpxFBjPPfQ5WU6d0gKLTnEl
         N+B17m1Xu60pLqujxkc/KnC5AQBiKaO47zolx6+Bgq58Ts7K7pj57StKVDmqdNBRvJ
         Sj4BR8XBgt8pwS1twRZJNHSasqpBMs5T/PMaE7CjY4fzhXnR1CLpTBYkquzWNlSXaU
         VYtBxPmb2Js6CEUHQk1dTIstGDlPxKm3zdPqsOXGx/eTZXKhLOEErtRrUH77jyfWFw
         5zP09BPgbf7zd5f/DCZR+9a80VzLhHknz0zDkZNbhMmC9c5o2sNVDjK9C4hm8z09Kb
         ncpAmO6Utl9vg==
Date:   Wed, 7 Jun 2023 08:28:22 +0200
From:   Ladislav Michl <oss-lists@triops.cz>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: ratelimit warning in bio_check_ro
Message-ID: <ZIAjht591AEza3c4@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfM0OIj9IHylIP9dqNvM3EuRlW16BlM0CylJBPtYqIuuaDfd+KpoMxNg4cxaqyWwCLjHYRBRbgF14QJyZNhnNIg51pTti7y2exu92QThmX7zywfndydGm
 YoxtpsrMMSnCwbS1BkcrW0nlRYQ24/sXBotIdCQBxQDLwehf7f4pu+f/BaX/IrdNz+OdnLqrtZ19lTpUSDNX9BBG+kWed8IPiWg=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ladislav Michl <ladis@linux-mips.org>

Until 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
a WARN_ONCE was used to print a warning. Current pr_warn causes
log flood, so use pr_warn_ratelimited instead.
Once there adjust message to match the one used in bio_check_eod.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Fixes: 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1da77e7d6289..fbd9f4102703 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -496,8 +496,8 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
+		pr_warn_ratelimited("%s: attempt to write to read-only device %pg\n",
+				    current->comm, bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
 	}
 }
-- 
2.32.0

