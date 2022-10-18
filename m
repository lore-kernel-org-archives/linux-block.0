Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDCC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 08:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRI4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJRI4C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 04:56:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070131ED2
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:56:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4246D68C4E; Tue, 18 Oct 2022 10:55:57 +0200 (CEST)
Date:   Tue, 18 Oct 2022 10:55:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018085557.GA28266@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017134244.GA24775@lst.de> <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 11:39:30AM +0300, Sagi Grimberg wrote:
> The only question in my mind is regarding patch 2/2 with the subtle
> ordering of nvme_set_queue_dying...

I think we need to sort that out as a pre-patch.  There is quite some
history there was a fair amount of dead lock potential earlier, but
I think I sorted quite a lot out there, including a new lock for setting
the gendisk size, which is what the comment refers to.

Something like this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c19..cb7623b5d2c8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5105,21 +5105,21 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 
 /*
  * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
+	/*
+	 * Mark the disk dead to prevent new opens, and set the capacity to 0
+	 * to end buffered writers dirtying pages that can't be synced.
+	 */
 	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-
 	set_capacity_and_notify(ns->disk, 0);
+
+	/* forcibly unquiesce queues to avoid blocking dispatch */
+	nvme_start_ns_queue(ns);
 }
 
 /**
