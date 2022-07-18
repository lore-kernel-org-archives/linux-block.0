Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 13:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiGRNHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiGRNHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 09:07:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767222BFC
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 06:07:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44AE468AA6; Mon, 18 Jul 2022 15:07:26 +0200 (CEST)
Date:   Mon, 18 Jul 2022 15:07:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release
 for never added disks
Message-ID: <20220718130725.GA19204@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <YtUJXGhFBw5yrf7N@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtUJXGhFBw5yrf7N@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 03:18:52PM +0800, Ming Lei wrote:
> Request queue is allocated successfully, but disk allocation may fail,
> so blk_mq_exit_queue still may be missed in this case.

Yes.  That's a separate issue, though and solved by this one liner:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d716b7f3763f3..70177ee74295b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 
 	disk = __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
-		blk_put_queue(q);
+		blk_mq_destroy_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(GD_OWNS_QUEUE, &disk->state);
