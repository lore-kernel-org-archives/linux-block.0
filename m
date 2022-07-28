Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0185C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiG1Pfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG1Pfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 11:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E95B61B7BC
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659022545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=co9k6FCRwybaqu2K2lkTGvTayTdtBDNtJFNeUOoFIFQ=;
        b=J19kn9uc4k8sXy3yqH85p6Exgkc8WrvsimSoA+GeMfHBu6HoR0dhwyfM37AkLKj2DDXYz9
        Ryx0FHGqLrqaL2DYibav82cQmyosy8wRNccFEO+TBu62nTd1tL26jaxfjFWpZJX7SmOxDp
        c19yQUnlXY5wwuUIH74G+yTlNHxiwj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-Bij5K36nO-m_xx_oWAYCcw-1; Thu, 28 Jul 2022 11:35:40 -0400
X-MC-Unique: Bij5K36nO-m_xx_oWAYCcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28B471019C8D;
        Thu, 28 Jul 2022 15:35:40 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD142026D64;
        Thu, 28 Jul 2022 15:35:35 +0000 (UTC)
Date:   Thu, 28 Jul 2022 23:35:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 3/6] block: move ->bio_split to the gendisk
Message-ID: <YuKswxbzK9OBirGr@T590>
References: <20220727162300.3089193-1-hch@lst.de>
 <20220727162300.3089193-4-hch@lst.de>
 <5323f3a1-14ac-eafb-3b5a-493fea2e86f5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5323f3a1-14ac-eafb-3b5a-493fea2e86f5@suse.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 10:07:14AM +0200, Hannes Reinecke wrote:
> On 7/27/22 18:22, Christoph Hellwig wrote:
> > Only non-passthrough requests are split by the block layer and use the
> > ->bio_split bio_set.  Move it from the request_queue to the gendisk.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >   block/blk-core.c       | 9 +--------
> >   block/blk-merge.c      | 7 ++++---
> >   block/blk-sysfs.c      | 2 --
> >   block/genhd.c          | 8 +++++++-
> >   drivers/md/dm.c        | 2 +-
> >   include/linux/blkdev.h | 3 ++-
> >   6 files changed, 15 insertions(+), 16 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 123468b9d2e43..59f13d011949d 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -377,7 +377,6 @@ static void blk_timeout_work(struct work_struct *work)
> >   struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
> >   {
> >   	struct request_queue *q;
> > -	int ret;
> >   	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
> >   			GFP_KERNEL | __GFP_ZERO, node_id);
> > @@ -396,13 +395,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
> >   	if (q->id < 0)
> >   		goto fail_srcu;
> > -	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
> > -	if (ret)
> > -		goto fail_id;
> > -
> >   	q->stats = blk_alloc_queue_stats();
> >   	if (!q->stats)
> > -		goto fail_split;
> > +		goto fail_id;
> >   	q->node = node_id;
> > @@ -439,8 +434,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
> >   fail_stats:
> >   	blk_free_queue_stats(q->stats);
> > -fail_split:
> > -	bioset_exit(&q->bio_split);
> >   fail_id:
> >   	ida_free(&blk_queue_ida, q->id);
> >   fail_srcu:
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 6e29fb28584ef..30872a3537648 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -331,18 +331,19 @@ static struct bio *bio_split_rw(struct bio *bio, struct request_queue *q,
> >   struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
> >   		       unsigned int *nr_segs)
> >   {
> > +	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
> >   	struct bio *split;
> 
> What happens for nvme-multipath?
> While I know that we shouldn't split on a path, experience shows that we
> _will_ do it eventually.

You mean contiguous bios should be mapped to one same path? If yes, at
least the current block layer can't do that, here dm-mapth is same with
nvme-mpath, since bio is always split first, and the split small bio
can be mapped to other path.



Thanks,
Ming

