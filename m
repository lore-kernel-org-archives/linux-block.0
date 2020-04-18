Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE3C38A2F
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34F421D6C
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217798;
	bh=zD789dP6I9c4Z+1f02WB1iPpEHekSNenlssybZAeuw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzgC1mkJzYU4MsAqwy5hNIPoMHnUEVmgoc4wOtTuqQUp1+NVCN4vuG04PdW2/7Zyp
	 TALPT7mq7+K5q77YgfbkaAqXk1aFjeW/j9T3OqnaAd3qljsIhqPBhOPqthgIuXRku5
	 o21OPHkR0r9D+68RXvbARGoQ2YpD6ddXxWCoUIuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDRNty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgDRNtq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 09:49:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583F222250;
        Sat, 18 Apr 2020 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217786;
        bh=zD789dP6I9c4Z+1f02WB1iPpEHekSNenlssybZAeuw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkHCXCZEecFjHJcoeGrDZM+PZmu7axscy5lPU9Yz3QqbvyRN/aRsfof8+SovtDv6I
         vJoEZVRiKPtDYe+w7atVHISZFTGvrwmXH1ay2nSbKbiMbufMRcRaImtPSZn2LHfunw
         POtY/1tdFsM3XUlOhc6WUJGGMDq2KFDxwa7DMc9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Qian Cai <cai@lca.pw>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 73/73] block: fix busy device checking in blk_drop_partitions again
Date:   Sat, 18 Apr 2020 09:48:15 -0400
Message-Id: <20200418134815.6519-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
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

