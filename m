Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF2C4167B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUIVj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 03:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLUIVh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 03:21:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1006E8D;
        Wed, 21 Dec 2022 00:21:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFFC267373; Wed, 21 Dec 2022 09:21:31 +0100 (CET)
Date:   Wed, 21 Dec 2022 09:21:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     zhangyanjun@cestc.cn
Cc:     sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix multipath crash caused by flush request
 when blktrace is enabled
Message-ID: <20221221082131.GA23644@lst.de>
References: <20221220063233.43932-1-zhangyanjun@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220063233.43932-1-zhangyanjun@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just checking for ->bio seems to be:

 - simpler
 - faster

and does not require block layer internals.  So why not just this:


diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bbb73ef8b2548..424c8a467a0c2a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -893,7 +893,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 
-	if (req->cmd_flags & REQ_NVME_MPATH)
+	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
