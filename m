Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3936C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF322507
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 21:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DF322507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeKNHnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:43:45 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:22201 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbeKNHnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 02:43:45 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 14 Nov 2018 08:13:38 +1030
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gMgTB-0000QV-Uz; Wed, 14 Nov 2018 08:43:37 +1100
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1gMgTB-0005Mc-Rm; Wed, 14 Nov 2018 08:43:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Date:   Wed, 14 Nov 2018 08:43:37 +1100
Message-Id: <20181113214337.20581-1-david@fromorbit.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
fall into an endless loop in the discard code. The test is creating
a device that is exactly 2^32 sectors in size to test mkfs boundary
conditions around the 32 bit sector overflow region.

mkfs issues a discard for the entire device size by default, and
hence this throws a sector count of 2^32 into
blkdev_issue_discard(). It takes the number of sectors to discard as
a sector_t - a 64 bit value.

The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
takes this sector count and casts it to a 32 bit value before
comapring it against the maximum allowed discard size the device
has. This truncates away the upper 32 bits, and so if the lower 32
bits of the sector count is zero, it starts issuing discards of
length 0. This causes the code to fall into an endless loop, issuing
a zero length discards over and over again on the same sector.

Fixes: ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 block/blk-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e8b3bb9bf375..144e156ed341 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -55,9 +55,12 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		return -EINVAL;
 
 	while (nr_sects) {
-		unsigned int req_sects = min_t(unsigned int, nr_sects,
+		sector_t req_sects = min_t(sector_t, nr_sects,
 				bio_allowed_max_sectors(q));
 
+		WARN_ON_ONCE(req_sects == 0);
+		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
+
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
-- 
2.19.1

