Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2784FC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiFAGng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245200AbiFAGne (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:43:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06B8E1BF
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:43:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE9FB68AFE; Wed,  1 Jun 2022 08:43:29 +0200 (CEST)
Date:   Wed, 1 Jun 2022 08:43:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <20220601064329.GB22915@lst.de>
References: <20220531160535.3444915-1-hch@lst.de> <Ypa4xrAHUslpQPhN@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypa4xrAHUslpQPhN@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 08:54:30AM +0800, Ming Lei wrote:
> This way can't be safe, who can guarantee that all sync submission
> activities are gone after queue is frozen? We had lots of reports on
> blk_mq_sched_has_work() which triggers UAF.

Yes, we probably need a blk_mq_quiesce_queue call like in the incremental
patch below.  Do you have any good reproducer, though?

diff --git a/block/genhd.c b/block/genhd.c
index 9914d0f24fecd..155b64ff991f6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -652,9 +652,13 @@ void del_gendisk(struct gendisk *disk)
 	blk_mq_cancel_work_sync(q);
 
 	if (q->elevator) {
+		blk_mq_quiesce_queue(q);
+
 		mutex_lock(&q->sysfs_lock);
 		elevator_exit(q);
 		mutex_unlock(&q->sysfs_lock);
+
+		blk_mq_unquiesce_queue(q);
 	}
 
 	rq_qos_exit(q);
