Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602E620684
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QotagJh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQKCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:02:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbgGQKCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 06:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594980165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yvjBKlJb8Du7CF73fCXAkemhJli/ZokRx8V/ijvnaw=;
        b=QotagJh7WKAelMWUv+MrCICCDpwhLhuA8xXpdrlrM3ey8XdAG/5AXRsdcrpY72s3WLchdM
        ZSN5ehgJI23g6VNcJUjdh5Vncx1hX6YYYVdPwOcsvDLn5MFL77Hh0ELJi7OaeN+5Np1n48
        VeA3KOYGyJuScDm5LaihvrNer6y+qs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-F10iFazuM0Ss0QTef7VVZw-1; Fri, 17 Jul 2020 06:02:43 -0400
X-MC-Unique: F10iFazuM0Ss0QTef7VVZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B78C8005B0;
        Fri, 17 Jul 2020 10:02:42 +0000 (UTC)
Received: from T590 (ovpn-13-1.pek2.redhat.com [10.72.13.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4E9E8FA27;
        Fri, 17 Jul 2020 10:02:36 +0000 (UTC)
Date:   Fri, 17 Jul 2020 18:02:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Message-ID: <20200717100232.GD670561@T590>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 17, 2020 at 09:19:50AM +0000, Damien Le Moal wrote:
> On 2020/07/17 18:12, Ming Lei wrote:
> > On Fri, Jul 17, 2020 at 08:22:45AM +0000, Damien Le Moal wrote:
> >> On 2020/07/17 16:50, Ming Lei wrote:
> >>> On Fri, Jul 17, 2020 at 02:45:25AM +0000, Damien Le Moal wrote:
> >>>> On 2020/07/16 23:35, Christoph Hellwig wrote:
> >>>>> On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:
> >>>>>> Max append sectors needs to be aligned to physical block size, otherwise
> >>>>>> we can end up in a situation where it's off by 1-3 sectors which would
> >>>>>> cause short writes with asynchronous zone append submissions from an FS.
> >>>>>
> >>>>> Huh? The physical block size is purely a hint.
> >>>>
> >>>> For ZBC/ZAC SMR drives, all writes must be aligned to the physical sector size.
> >>>
> >>> Then the physical block size should be same with logical block size.
> >>> The real workable limit for io request is aligned with logical block size.
> >>
> >> Yes, I know. This T10/T13 design is not the brightest thing they did... on 512e
> >> SMR drives, addressing is LBA=512B unit, but all writes in sequential zones must
> >> be 4K aligned (8 LBAs).
> > 
> > Then the issue isn't related with zone append command only. Just wondering how this
> > special write block size alignment is enhanced in sequential zones. So far, write
> > from FS or raw block size is only logical block size aligned.
> 
> This is not enforced in sd/sd_zbc.c. If the user issues a non 4K aligned
> request, it will get back an "unaligned write" error from the drive. zonefs and
> dm-zoned define a 4K block size to avoid that. For applications doing raw block
> device accesses, they have to issue properly aligned writes.

OK, then I guess either:

1) the same write alignment issue for zone append can be handled in
same way with normal write on seq zone

OR

2) add one new limit for write on seq zone, such as: zone_write_block_size

Then the two cases can be dealt with in same way, and physical block
size is usually a hint as Christoph mentioned, looks a bit weird to use
it in this way, or at least the story should be documented.

> 
> > 
> >>
> >>>
> >>>> However, sd/sd_zbc does not change max_hw_sectors_kb to ensure alignment to 4K
> >>>> on 512e disks. There is also nullblk which uses the default max_hw_sectors_kb to
> >>>> 255 x 512B sectors, which is not 4K aligned if the nullb device is created with
> >>>> 4K block size.
> >>>
> >>> Actually the real limit is from max_sectors_kb which is <= max_hw_sectors_kb, and
> >>> both should be aligned with logical block size, IMO.
> >>
> >> Yes, agreed, but for nullblk device created with block size = 4K it is not. So
> > 
> > That is because the default magic number of BLK_SAFE_MAX_SECTORS.
> > 
> >> one driver to patch for sure. However, I though having some forced alignment in
> >> blk_queue_max_hw_sectors() for limit->max_hw_sectors and limit->max_sectors
> >> would avoid tripping on weird values for weird drives...
> > 
> > Maybe we can update it once the logical block size is available, such
> > as:
> > 
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 9a2c23cd9700..f9cbaadaa267 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -311,6 +311,14 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
> >  }
> >  EXPORT_SYMBOL(blk_queue_max_segment_size);
> >  
> > +static unsigned blk_queue_round_sectors(struct request_queue *q,
> > +		unsigned sectors)
> > +{
> > +	u64 bytes = sectors << 9;
> > +
> > +	return (unsigned)round_down(bytes, queue_logical_block_size(q));
> > +}
> > +
> >  /**
> >   * blk_queue_logical_block_size - set logical block size for the queue
> >   * @q:  the request queue for the device
> > @@ -330,6 +338,9 @@ void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
> >  
> >  	if (q->limits.io_min < q->limits.physical_block_size)
> >  		q->limits.io_min = q->limits.physical_block_size;
> > +
> > +	q->limits.max_sectors = blk_queue_round_sectors(q,
> > +			q->limits.max_sectors)
> >  }
> >  EXPORT_SYMBOL(blk_queue_logical_block_size);
> 
> Yes, something like this was what I had in mind so that 4Kn drives get a
> sensible value aligned to the 4K LBA, always. However, with the above, there is
> no guarantee that max_sectors is already set when the logical block size is set.
> I am not sure about the reverse either. So the rounding may need to be in both
> blk_queue_logical_block_size() and blk_queue_max_hw_sectors().

OK, that looks better.

Thanks,
Ming

