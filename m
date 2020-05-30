Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34511C433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078C32074B
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6ZjCEB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE3MyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 08:54:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727947AbgE3MyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 08:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590843254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mb7Ci6N9efQpgnN4dwUWzbdN+GGBhnyQYBPTDL0YyC0=;
        b=i6ZjCEB/z2UfaV5iQLifUBdJnP4xl18UFwzpSNKJZeil8gGwd5Xp/FIouoqkSn9dBRZT/v
        hlb6Fs8quBPyRr0pZSiDHW8TAmNQXTYL10apRAR6jXX7MuDlHAAIMWRiCLhFh7SbcmTf/G
        mG2BCd566vQsj80DgMXBrQn8sIYVQso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-_qq0pylCPuKFomNUGVVysw-1; Sat, 30 May 2020 08:54:10 -0400
X-MC-Unique: _qq0pylCPuKFomNUGVVysw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E708014D7;
        Sat, 30 May 2020 12:54:09 +0000 (UTC)
Received: from T590 (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78AD578908;
        Sat, 30 May 2020 12:54:01 +0000 (UTC)
Date:   Sat, 30 May 2020 20:53:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org,
        Acshai Manoj <acshai.manoj@microfocus.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH v2] block: improve discard bio alignment in
 __blkdev_issue_discard()
Message-ID: <20200530125356.GA1143142@T590>
References: <20200529163418.101606-1-colyli@suse.de>
 <20200529225505.GA1121169@T590>
 <e08d0bda-a597-4f69-ab06-26706b718da1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08d0bda-a597-4f69-ab06-26706b718da1@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 06:07:07PM +0800, Coly Li wrote:
> On 2020/5/30 06:55, Ming Lei wrote:
> > On Sat, May 30, 2020 at 12:34:18AM +0800, Coly Li wrote:
> >> This patch improves discard bio split for address and size alignment in
> >> __blkdev_issue_discard(). The aligned discard bio may help underlying
> >> device controller to perform better discard and internal garbage
> >> collection, and avoid unnecessary internal fragment.
> >>
> >> Current discard bio split algorithm in __blkdev_issue_discard() may have
> >> non-discarded fregment on device even the discard bio LBA and size are
> >> both aligned to device's discard granularity size.
> >>
> >> Here is the example steps on how to reproduce the above problem.
> >> - On a VMWare ESXi 6.5 update3 installation, create a 51GB virtual disk
> >>   with thin mode and give it to a Linux virtual machine.
> >> - Inside the Linux virtual machine, if the 50GB virtual disk shows up as
> >>   /dev/sdb, fill data into the first 50GB by,
> >> 	# dd if=/dev/zero of=/dev/sdb bs=4096 count=13107200
> >> - Discard the 50GB range from offset 0 on /dev/sdb,
> >> 	# blkdiscard /dev/sdb -o 0 -l 53687091200
> >> - Observe the underlying mapping status of the device
> >> 	# sg_get_lba_status /dev/sdb -m 1048 --lba=0
> >>   descriptor LBA: 0x0000000000000000  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000000000800  blocks: 16773120  deallocated
> >>   descriptor LBA: 0x0000000000fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000001000000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x00000000017ff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000001800000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x0000000001fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000002000000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x00000000027ff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000002800000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x0000000002fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000003000000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x00000000037ff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000003800000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x0000000003fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000004000000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x00000000047ff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000004800000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x0000000004fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000005000000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x00000000057ff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000005800000  blocks: 8386560  deallocated
> >>   descriptor LBA: 0x0000000005fff800  blocks: 2048  mapped (or unknown)
> >>   descriptor LBA: 0x0000000006000000  blocks: 6291456  deallocated
> >>   descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
> >>
> >> Although the discard bio starts at LBA 0 and has 50<<30 bytes size which
> >> are perfect aligned to the discard granularity, from the above list
> >> these are many 1MB (2048 sectors) internal fragments exist unexpectedly.
> >>
> >> The problem is in __blkdev_issue_discard(), an improper algorithm causes
> >> an improper bio size which is not aligned.
> >>
> >>  25 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >>  26                 sector_t nr_sects, gfp_t gfp_mask, int flags,
> >>  27                 struct bio **biop)
> >>  28 {
> >>  29         struct request_queue *q = bdev_get_queue(bdev);
> >>    [snipped]
> >>  56
> >>  57         while (nr_sects) {
> >>  58                 sector_t req_sects = min_t(sector_t, nr_sects,
> >>  59                                 bio_allowed_max_sectors(q));
> >>  60
> >>  61                 WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
> >>  62
> >>  63                 bio = blk_next_bio(bio, 0, gfp_mask);
> >>  64                 bio->bi_iter.bi_sector = sector;
> >>  65                 bio_set_dev(bio, bdev);
> >>  66                 bio_set_op_attrs(bio, op, 0);
> >>  67
> >>  68                 bio->bi_iter.bi_size = req_sects << 9;
> >>  69                 sector += req_sects;
> >>  70                 nr_sects -= req_sects;
> >>    [snipped]
> >>  79         }
> >>  80
> >>  81         *biop = bio;
> >>  82         return 0;
> >>  83 }
> >>  84 EXPORT_SYMBOL(__blkdev_issue_discard);
> >>
> >> At line 58-59, to discard a 50GB range, req_sets is set as return value
> >> of bio_allowed_max_sectors(q), which is 8388607 sectors. In the above
> >> case, the discard granularity is 2048 sectors, although the start LBA
> >> and discard length are aligned to discard granularity, seq_sets never
> >> has chance to be aligned to discard granularity. This is why there are
> >> some still-mapped 2048 sectors segment in every 4 or 8 GB range.
> >>
> >> Because queue's max_discard_sectors is aligned to discard granularity,
> >> if req_sects at line 58 is set to a value closest to UINT_MAX and
> >> aligned to q->limits.max_discard_sectors, then all consequent split bios
> >> inside device driver are (almostly) aligned to discard_granularity of
> >> the device queue.
> >>
> >> This patch introduces bio_aligned_discard_max_sectors() to return the
> >> closet to UINT_MAX and aligned to q->limits.discard_granularity value,
> >> and replace bio_allowed_max_sectors() with this new inline routine to
> >> decide the split bio length.
> >>
> >> But we still need to handle the situation when discard start LBA is not
> >> aligned to q->limits.discard_granularity, otherwise even the length is
> >> aligned, current code may still leave 2048 segment around every 4BG
> >> range. Thereforeto calculate req_sects, firstly the start LBA of discard
> >> request command is checked, if it is not aligned to discard granularity,
> >> the first split location should make sure following bio has bi_sector
> >> aligned to discard granularity. Then there won't be still-mapped segment
> >> in the middle of the discard range.
> >>
> >> The above is how this patch improves discard bio alignment in
> >> __blkdev_issue_discard(). Now with this patch, after discard with same
> >> command line mentiond previously, sg_get_lba_status returns,
> >> descriptor LBA: 0x0000000000000000  blocks: 106954752  deallocated
> >> descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
> >>
> >> We an see there is no 2048 sectors segment anymore, everything is clean.
> >>
> >> Reported-by: Acshai Manoj <acshai.manoj@microfocus.com>
> >> Signed-off-by: Coly Li <colyli@suse.de>
> >> Cc: Bart Van Assche <bvanassche@acm.org>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Cc: Enzo Matsumiya <ematsumiya@suse.com>
> >> Cc: Hannes Reinecke <hare@suse.com>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >> Cc: Ming Lei <ming.lei@redhat.com>
> >> Cc: Xiao Ni <xni@redhat.com>
> >> ---
> >> Changelog:
> >> v2: replace 9 with SECTOR_SHIFT as suggested by Bart Van Assche.
> >> v1: initial version.
> >>
> >>  block/blk-lib.c | 25 +++++++++++++++++++++++--
> >>  block/blk.h     | 15 +++++++++++++++
> >>  2 files changed, 38 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/blk-lib.c b/block/blk-lib.c
> >> index 5f2c429d4378..2fc0e3cc1ed8 100644
> >> --- a/block/blk-lib.c
> >> +++ b/block/blk-lib.c
> >> @@ -55,8 +55,29 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >>  		return -EINVAL;
> >>  
> >>  	while (nr_sects) {
> >> -		sector_t req_sects = min_t(sector_t, nr_sects,
> >> -				bio_allowed_max_sectors(q));
> >> +		sector_t granularity_aligned_lba;
> >> +		sector_t req_sects;
> >> +
> >> +		granularity_aligned_lba =
> >> +			round_up(sector, q->limits.discard_granularity);
> >> +
> >> +		/*
> >> +		 * Check whether the discard bio starts at a discard_granularity
> >> +		 * aligned LBA,
> >> +		 * - If no: set (granularity_aligned_lba - sector) to bi_size of
> >> +		 *   the first split bio, then the second bio will start at a
> >> +		 *   discard_granularity aligned LBA.
> >> +		 * - If yes: use bio_aligned_discard_max_sectors() as the max
> >> +		 *   possible bi_size of th first split bio. Then when this bio
> >> +		 *   is split in device drive, the split ones are always easier
> >> +		 *   to be aligned to max_discard_sectors of the device's queue.
> >> +		 */
> >> +		if (granularity_aligned_lba == sector)
> >> +			req_sects = min_t(sector_t, nr_sects,
> >> +					  bio_aligned_discard_max_sectors(q));
> >> +		else
> >> +			req_sects = min_t(sector_t, nr_sects,
> >> +					  granularity_aligned_lba - sector);
> > 
> > min_non_zero() may be cleaner.
> 
> It seems no value in these two min_t() can be zero.
> 
> Could you please give me more hint ?

Looks I misunderstood it, so it is fine in this way.

> 
> 
> 
> >>  
> >>  		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
> >>  
> >> diff --git a/block/blk.h b/block/blk.h
> >> index 0a94ec68af32..dc5369e7e1fb 100644
> >> --- a/block/blk.h
> >> +++ b/block/blk.h
> >> @@ -292,6 +292,21 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
> >>  	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
> >>  }
> >>  
> >> +/*
> >> + * The max bio size which is aligned to q->limits.max_discard_sectors. This
> >> + * is a hint to split large discard bio in generic block layer, then if device
> >> + * driver needs to split the discard bio into smaller ones, their bi_size can
> >> + * be very probably and easily ligned to max_discard_sectors of the device's
> >> + * queue.
> >> + */
> >> +static inline unsigned int bio_aligned_discard_max_sectors(
> >> +					struct request_queue *q)
> >> +{
> >> +	return round_down(UINT_MAX,
> >> +			 (q->limits.max_discard_sectors << SECTOR_SHIFT))
> >> +			>> SECTOR_SHIFT;
> >> +}
> > 
> > The above may not be correct, what if q->limits.max_discard_sectors is
> > less enough? raid10 may use default 512k max discard bytes. Then
> > bio_aligned_discard_max_sectors() can return bigger value than
> > q->limits.max_discard_sectors, and breaks this discard limit.
> 
> It seems like I should use roundup() indeed. Thanks for the hint, let me
> improve in v3 patch.

Actually, bio_aligned_discard_max_sectors() needn't to be <=
q->limits.max_discard_sectors because we will split this discard
request.

Thinking of the issue further, the above stuff should have been done
in blk_bio_discard_split() instead of __blkdev_issue_discard() in which
we should simply create/submit one non-overflow bio, and shouldn't care
the granularity aligned stuff. blk_bio_discard_split() is supposed to
consider all kinds of queue limit and decide how to split.



Thanks,
Ming

