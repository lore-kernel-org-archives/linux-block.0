Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D41EC433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517FC611C1
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhJPO2u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhJPO2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 10:28:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7FC061570
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ceT6eA8mdzSwHIbTO4TNF6qslH0cTv58+sKoeCffn4A=; b=XBQLVhdEUKSCos+ZzBAVBZEF/P
        Q1UNJY891frWdACZR9u7CBKDWZGLwee1b5If7o7vySUCGH6dOdxpQzkdoZ81sb579VIqm4kdmqtWR
        6JruCEoOmJPAllS9BehwD3IHFeAqeT4C+3TGZZkK2F+Nk95Mmsl2PDSUc3ireId8OyvJP3iHxBa3x
        sgvr+W1nt/IbZwyNOEQiVqnFGGvdNa/Ytcm5CsVOPcEMjfp/A+muBw/3Yt0uow9RLzotBO4o3tVDQ
        2pONKhB3xgS+hY8pltRMvMiwANQDgD0qg/TBVILR/gXaXBPTbaWoglT56eBKhuUSKYGEXhD3S0plm
        FAbfdcbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbkde-009ipU-Df; Sat, 16 Oct 2021 14:26:24 +0000
Date:   Sat, 16 Oct 2021 15:26:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Message-ID: <YWrhCiWGjfxqAca2@casper.infradead.org>
References: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
 <20211016043450.GA27231@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016043450.GA27231@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 06:34:50AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 15, 2021 at 11:07:40AM +0900, Shin'ichiro Kawasaki wrote:
> > To fix the issues, call the helper function disk_has_partitions() in
> > place of disk->part_tbl empty check. Since the function was removed with
> > the commit a33df75c6328, reimplement it to walk through entries in the
> > xarray disk->part_tbl.
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Matthew,
> 
> we talked about possiblig adding a xa_nr_entries helper a while ago.
> This would be a good place for it, as we could just check
> xa_nr_entries() > 1 for example.

Do I understand the problem correctly, that you don't actually want to
know whether there's more than one entry in the array, but rather that
there's an entry at an index other than 0?

If so, that's an easy question to answer, we just don't have a helper
for it yet.  Something like this should do:

static inline bool xa_is_trivial(const struct xarray *xa)
{
	void *entry = READ_ONCE(xa->xa_head);

	return entry || !xa_is_node(entry);
}

Probably needs a better name than that.

> > 
> > Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Cc: stable@vger.kernel.org # v5.14+
> > ---
> >  block/blk-settings.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index a7c857ad7d10..b880c70e22e4 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -842,6 +842,24 @@ bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
> >  }
> >  EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
> >  
> > +static bool disk_has_partitions(struct gendisk *disk)
> > +{
> > +	unsigned long idx;
> > +	struct block_device *part;
> > +	bool ret = false;
> > +
> > +	rcu_read_lock();
> > +	xa_for_each(&disk->part_tbl, idx, part) {
> > +		if (bdev_is_partition(part)) {
> > +			ret = true;
> > +			break;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * blk_queue_set_zoned - configure a disk queue zoned model.
> >   * @disk:	the gendisk of the queue to configure
> > @@ -876,7 +894,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
> >  		 * we do nothing special as far as the block layer is concerned.
> >  		 */
> >  		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
> > -		    !xa_empty(&disk->part_tbl))
> > +		    disk_has_partitions(disk))
> >  			model = BLK_ZONED_NONE;
> >  		break;
> >  	case BLK_ZONED_NONE:
> > -- 
> > 2.31.1
> ---end quoted text---
