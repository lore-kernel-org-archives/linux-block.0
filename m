Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B0C433E9
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AD920DD4
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599141481;
	bh=Q9X3kraQf24gMHiINdcylEgKUZPP4tHKeXx/ETBVA9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wjnETYMxqhaokrE3ribiOc3AzaGsM97gIJBlshes66jFGh9DdnPimsztM0UpJ+TTW
	 wb1j656x+ejQLQJGwmyy0vXV4R7vbjSehAE0y2+LOUxiqROMV06338rOA8b4lcUTh9
	 WAEzY75ox4pZxRrsJ7+Hj4QL5u7SUSwmh86EM9Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgICN5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgICMhH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Sep 2020 08:37:07 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D22206EF;
        Thu,  3 Sep 2020 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599136626;
        bh=Q9X3kraQf24gMHiINdcylEgKUZPP4tHKeXx/ETBVA9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyIPKVgxivwoxqpq077vyI8CFSHhWAJu6kgtqv9bwNKw+5+NOnxMiald2i/nWXR7R
         uoaOAms586+WKE4KTE5EFxlLFTk1pAvGZbmBboAruQ0hRmkqghDwvkl4XKCgYRfLra
         BfBzsVgCaL7DmyFB8pA78Es07tCZf1hLBoWkdtM4=
Date:   Thu, 3 Sep 2020 05:37:02 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200903123702.GA2928425@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200902031144.GC317674@T590>
 <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
 <20200903003545.GA638071@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903003545.GA638071@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 08:35:45AM +0800, Ming Lei wrote:
> On Wed, Sep 02, 2020 at 11:52:59AM -0600, Jens Axboe wrote:
> > On 9/1/20 9:11 PM, Ming Lei wrote:
> > > On Tue, Aug 25, 2020 at 10:17:32PM +0800, Ming Lei wrote:
> > >> Hi Jens,
> > >>
> > >> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> > >> and prepares for replacing srcu with percpu_ref.
> > >>
> > >> The 2nd patch replaces srcu with percpu_ref.
> > >>
> > >> V2:
> > >> 	- add .mq_quiesce_lock
> > >> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> > >> 	- trivial patch style change
> > >>
> > >>
> > >> Ming Lei (2):
> > >>   blk-mq: serialize queue quiesce and unquiesce by mutex
> > >>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
> > >>
> > >>  block/blk-core.c       |   2 +
> > >>  block/blk-mq-sysfs.c   |   2 -
> > >>  block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
> > >>  block/blk-sysfs.c      |   6 +-
> > >>  include/linux/blk-mq.h |   7 ---
> > >>  include/linux/blkdev.h |   6 ++
> > >>  6 files changed, 82 insertions(+), 66 deletions(-)
> > >>
> > >> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > >> Cc: Paul E. McKenney <paulmck@kernel.org>
> > >> Cc: Josh Triplett <josh@joshtriplett.org>
> > >> Cc: Sagi Grimberg <sagi@grimberg.me>
> > >> Cc: Bart Van Assche <bvanassche@acm.org>
> > >> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > >> Cc: Chao Leng <lengchao@huawei.com>
> > >> Cc: Christoph Hellwig <hch@lst.de>
> > > 
> > > Hello Guys,
> > > 
> > > Is there any objections on the two patches? If not, I'd suggest to move> on.
> > 
> > Seems like the nested case is one that should either be handled, or at
> > least detected.
> 
> Yeah, the 1st patch adds mutex for handling nested case correctly and efficiently.

That doesn't really do anything about handling nested quiesce/unquiesce.
It just prevents two threads from doing it at the same time, but anyone
can still undo the other's expected queue state. The following on top of
your series will at least detect the condition:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ef6c6fa8dab0..52b53f2bb567 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -249,6 +249,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 {
 	mutex_lock(&q->mq_quiesce_lock);
 
+	WARN_ON(!blk_queue_quiesced(q));
 	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 
 	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
--
