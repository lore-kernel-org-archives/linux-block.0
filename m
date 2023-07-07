Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC5C0015E
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGGJqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGGJqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:46:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088241BE9
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AC7vG1A2pMZEGPxwZG9McURvrIvQLWC1/NGcjUkvtzc=; b=RDgf71d7Rm6yD0myzPlz8fAG8V
        9JtFH2PIyFqhIhxY8s1sbggLlNgpdGLHiU7l8jwHRlSCzSdgIEVBo504E+S+fsfsZ0r+pzKjXMgeq
        rHKPk1QZHtt2pcQ1z0q2G44ecIAz/VMPlSfJQwWyqYRR+tXZyWt+8PFSC2BfUvB9OK0+DFjmWExeg
        RJIdHUiDbVWVgLa4a/hrP/IW3vJneo7VWqyf8KzboU7POPFwof9nRoCcxWxu8jWbHtm78F0gdXAdK
        yhnqYuNLsrG3XieQX02qXVvuSknXcbEvrQIHwHBe0aqC640Geox1AA3KqGkePS5+gf/OI0KBziEVm
        dtG5wDNg==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHi2s-0049hq-14;
        Fri, 07 Jul 2023 09:46:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Date:   Fri,  7 Jul 2023 11:46:14 +0200
Message-Id: <20230707094616.108430-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094616.108430-1-hch@lst.de>
References: <20230707094616.108430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_config_discard currently skips updating the discard limits if they
were set before because blk_queue_max_discard_sectors used to update the
configurable max_discard_sectors limit unconditionally.  Now that this
has been fixed we can update the discard limits even if they were set
to deal with the case of a reset changing the limits after e.g. a
firmware update.

Fixes: 3831761eb859 ("nvme: only reconfigure discard if necessary")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff29..2d6c1f4ad7f5c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1734,10 +1734,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 	queue->limits.discard_granularity = size;
 
-	/* If discard is already enabled, don't reset queue limits */
-	if (queue->limits.max_discard_sectors)
-		return;
-
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
-- 
2.39.2

