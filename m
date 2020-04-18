Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78000C38A2F
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B26621BE5
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219067;
	bh=zD789dP6I9c4Z+1f02WB1iPpEHekSNenlssybZAeuw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQydfQPct35Hl7/SjToAo7scHondD4j24blmqhk+1RCoyt/ioYLQhEcbppsD5bfSp
	 ho5pb5jRgugpSYMPdWxikPsHtaId0BzfvSHlhXUzw9lJXgCQ9qbJKqAL6895Nu6A/d
	 bqKrdnhdALN9zmck+VTKLwrp+WkCPz+fbqsOjFow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDROLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgDROKn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3341921D6C;
        Sat, 18 Apr 2020 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219043;
        bh=zD789dP6I9c4Z+1f02WB1iPpEHekSNenlssybZAeuw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uwf//iDQQHmX0KoOaTnJoi7txlixRZEZiId/k4o6QZFx3FjDAjtBHJdtgVLo2ErX9
         b2k5n6B6ikgnf11YQW+TTxFad1X2kpMcKRBlnzj37gV10cSS3x2Gm8dAtUk7ab6K7x
         uxTqFi/cpDNLCiLStVlNjmf+IWScD1DPjXTjj0a4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Qian Cai <cai@lca.pw>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 75/75] block: fix busy device checking in blk_drop_partitions again
Date:   Sat, 18 Apr 2020 10:09:10 -0400
Message-Id: <20200418140910.8280-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit cb6b771b05c3026a85ed4817c1b87c5e6f41d136 ]

The previous fix had an off by one in the bd_openers checking, counting
the callers blkdev_get.

Fixes: d3ef5536274f ("block: fix busy device checking in blk_drop_partitions")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5f3b2a959aa51..ebe4c2e9834bd 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -468,7 +468,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_openers)
+	if (bdev->bd_part_count || bdev->bd_openers > 1)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.20.1

