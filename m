Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28BEC43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 02:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EF821974
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 02:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600051391;
	bh=27dg1GaHxtA1tt20l0F/6Ncprab3IqRGxLp9Vj+lgIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vdHWlQA71H9a8iH4nXOgHT5z4lsjMK9ys9x293xOKyk5r3leBOAitC4y8ONAI7u7h
	 DlGSNkKGcIRfykILEnhMNhbfRaH8SKTkRDGuxcNRq64Z9++0jEgUyBSbxjgvPXcbiZ
	 KXtJk6CJIiOlLdoH5aDbjOaSLUi5CGGNVzPDUqAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINCnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Sep 2020 22:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgINCnJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Sep 2020 22:43:09 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D58217BA;
        Mon, 14 Sep 2020 02:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600051388;
        bh=27dg1GaHxtA1tt20l0F/6Ncprab3IqRGxLp9Vj+lgIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0RdoBXtScurwBwMaS1qwa57wXA2RvMfBZWLVRamS7QYRn3C2VCqSOmwwEUAtL5Koo
         82aulJmmqtaFoyGuz1NW+0Wm2VAkf/D82WUej5Tx12TlH2cfunY4uDZqNEiTPo+hu9
         saIFg2ZTQfe2IepFxhgm4U8uaNmYhqd49AXMsB5Y=
Date:   Sun, 13 Sep 2020 19:43:06 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: allow 'chunk_sectors' to be non-power-of-2
Message-ID: <20200914024306.GA3657769@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-4-snitzer@redhat.com>
 <20200912140630.GC210077@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912140630.GC210077@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 12, 2020 at 10:06:30PM +0800, Ming Lei wrote:
> On Fri, Sep 11, 2020 at 05:53:38PM -0400, Mike Snitzer wrote:
> > It is possible for a block device to use a non power-of-2 for chunk
> > size which results in a full-stripe size that is also a non
> > power-of-2.
> > 
> > Update blk_queue_chunk_sectors() and blk_max_size_offset() to
> > accommodate drivers that need a non power-of-2 chunk_sectors.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > ---
> >  block/blk-settings.c   | 10 ++++------
> >  include/linux/blkdev.h | 12 +++++++++---
> >  2 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index b09642d5f15e..e40a162cc946 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -172,15 +172,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
> >   *
> >   * Description:
> >   *    If a driver doesn't want IOs to cross a given chunk size, it can set
> > - *    this limit and prevent merging across chunks. Note that the chunk size
> > - *    must currently be a power-of-2 in sectors. Also note that the block
> > - *    layer must accept a page worth of data at any offset. So if the
> > - *    crossing of chunks is a hard limitation in the driver, it must still be
> > - *    prepared to split single page bios.
> > + *    this limit and prevent merging across chunks. Note that the block layer
> > + *    must accept a page worth of data at any offset. So if the crossing of
> > + *    chunks is a hard limitation in the driver, it must still be prepared
> > + *    to split single page bios.
> >   **/
> >  void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
> >  {
> > -	BUG_ON(!is_power_of_2(chunk_sectors));
> >  	q->limits.chunk_sectors = chunk_sectors;
> >  }
> >  EXPORT_SYMBOL(blk_queue_chunk_sectors);
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 453a3d735d66..e72bcce22143 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1059,11 +1059,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
> >  static inline unsigned int blk_max_size_offset(struct request_queue *q,
> >  					       sector_t offset)
> >  {
> > -	if (!q->limits.chunk_sectors)
> > +	unsigned int chunk_sectors = q->limits.chunk_sectors;
> > +
> > +	if (!chunk_sectors)
> >  		return q->limits.max_sectors;
> >  
> > -	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
> > -			(offset & (q->limits.chunk_sectors - 1))));
> > +	if (is_power_of_2(chunk_sectors))
> > +		chunk_sectors -= (offset & (chunk_sectors - 1));
> > +	else
> > +		chunk_sectors -= sector_div(offset, chunk_sectors);
> > +
> > +	return min(q->limits.max_sectors, chunk_sectors);
> >  }
> >  
> >  static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
> > -- 
> > 2.15.0
> > 
> 
> is_power_of_2() is cheap enough for fast path, so looks fine to support
> non-power-of-2 chunk sectors.
> 
> Maybe NVMe PCI can remove the power_of_2() limit too.

I'd need to see the justification for that. The boundary is just a
suggestion in NVMe. The majority of IO never crosses it so the
calculation is usually wasted CPU cycles. Crossing the boundary is going
to have to be very costly on the device side in order to justify the
host side per-IO overhead for a non-power-of-2 split. 
