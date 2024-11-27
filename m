Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53B13C816
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690979; cv=none; b=MMm5MPXtdMMh5sUbhey4nu86kMJoFEtldKkbmE4CQ+31GRXTH7kn/97ITdhd29TNnH5jbZEqr0hj0pZ4pxWOoHTKYUqYERCtrimBHrCtv+IRTNeGIf5JLaFApGBuQZuahPMZmd2oOpyApMjv45CBqDl1spnvUJRgeKdHf2DTlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690979; c=relaxed/simple;
	bh=PGQGIShPYBpT/YSwHq7k0IXao3GL2M1WeLiE68Sx9d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0hHIYcZxUWSaKSq4azxFz+DS2ro2G0M6NknC2kVm26CHUezR3PUuQDjMJaRLQ+syfnrM+lilgvouHfbsV8/PEHFq/g44xTnxBEkYNW93NjYSjgc/sPvMzKIyFgC3fY6xhAKPXnnCsbFQMB+rZY5W4Xl+dvERmlG8nBavqcvAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdETaleb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdETaleb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E0C4CECC;
	Wed, 27 Nov 2024 07:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732690979;
	bh=PGQGIShPYBpT/YSwHq7k0IXao3GL2M1WeLiE68Sx9d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdETaleb+ZroswcjdF66/flilGYfx4CODhRgM7OV2giQlvPPkR/qoGrkHQKoUJ/PT
	 TT0Nwx/4ZsR81Gwu1TpIXuOlFjE02n0vw230tsqaTEEsnA8Et1fTFg4g5dwD6PjTA7
	 0H1fxvFg8etV9PioF/ib79XY79CRDDlmnLy+Gnq80d2BQTTni/JzLef0B0k1zy0i7h
	 mD5ezBf5/hRW3uRzLU0FIddTUVLCHaQmfSvRuyb6IQlFLiEFJQamLplDdqfeQ3zYoa
	 KY2L2geohCU0qdEIgWJLlkwoUdjnEYoU2u4Om8aDud+jFX8b89kR+iaBCqB/1JpgBD
	 JsE8FZf4L4mbQ==
Message-ID: <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
Date: Wed, 27 Nov 2024 16:02:42 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z0bAHKD-j49ILtgv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 3:45 PM, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 03:43:11PM +0900, Damien Le Moal wrote:
>> I thought about that one. The problem with it is the significant performance
>> penalty that the context switch to the zone write plug BIO work causes. But
>> that is for qd=1 writes only... If that is acceptable, that solution is
>> actually the easiest. The overhead is not an issue for HDDs and for ZNS SSDs,
>> zone append to the rescue ! So maybe for now, it is best to just do that.
> 
> The NOWAIT flag doesn't really make much sense for synchronous QD=1
> writes, the rationale for it is not block the submission thread when
> doing batch submissions with asynchronous completions.
> 
> So I think this should be fine (famous last words..)

Got something simple and working.
Will run it through our test suite to make sure it does not regress anything.

The change is:

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 263e28b72053..648b8d2534a4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -746,9 +746,25 @@ static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
        return false;
 }
 
-static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
-                                         struct bio *bio, unsigned int nr_segs)
+static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
+                                             struct blk_zone_wplug *zwplug)
 {
+       /*
+        * Take a reference on the zone write plug and schedule the submission
+        * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
+        * reference we take here.
+        */
+       WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
+       refcount_inc(&zwplug->ref);
+       queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+}
+
+static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
+                               struct blk_zone_wplug *zwplug,
+                               struct bio *bio, unsigned int nr_segs)
+{
+       bool schedule_bio_work = false;
+
        /*
         * Grab an extra reference on the BIO request queue usage counter.
         * This reference will be reused to submit a request for the BIO for
@@ -764,6 +780,16 @@ static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
         */
        bio_clear_polled(bio);
 
+       /*
+        * REQ_NOWAIT BIOs are always handled using the zone write plug BIO
+        * work, which can block. So clear the REQ_NOWAIT flag and schedule the
+        * work if this is the first BIO we are plugging.
+        */
+       if (bio->bi_opf & REQ_NOWAIT) {
+               schedule_bio_work = bio_list_empty(&zwplug->bio_list);
+               bio->bi_opf &= ~REQ_NOWAIT;
+       }
+
        /*
         * Reuse the poll cookie field to store the number of segments when
         * split to the hardware limits.
@@ -777,6 +803,9 @@ static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
         * at the tail of the list to preserve the sequential write order.
         */
        bio_list_add(&zwplug->bio_list, bio);
+
+       if (schedule_bio_work)
+               disk_zone_wplug_schedule_bio_work(disk, zwplug);
 }
 
 /*
@@ -970,7 +999,10 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
        zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
        if (!zwplug) {
-               bio_io_error(bio);
+               if (bio->bi_opf & REQ_NOWAIT)
+                       bio_wouldblock_error(bio);
+               else
+                       bio_io_error(bio);
                return true;
        }
 
@@ -979,9 +1011,11 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
        /*
         * If the zone is already plugged or has a pending error, add the BIO
-        * to the plug BIO list. Otherwise, plug and let the BIO execute.
+        * to the plug BIO list. Do the same for REQ_NOWAIT BIOs to ensure that
+        * we will not see a BLK_STS_AGAIN failure if we let the BIO execute.
+        * Otherwise, plug and let the BIO execute.
         */
-       if (zwplug->flags & BLK_ZONE_WPLUG_BUSY)
+       if (zwplug->flags & BLK_ZONE_WPLUG_BUSY || (bio->bi_opf & REQ_NOWAIT))
                goto plug;
 
        /*
@@ -999,7 +1033,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
 plug:
        zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
-       blk_zone_wplug_add_bio(zwplug, bio, nr_segs);
+       disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
 
        spin_unlock_irqrestore(&zwplug->lock, flags);
 
@@ -1083,19 +1117,6 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
 
-static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
-                                             struct blk_zone_wplug *zwplug)
-{
-       /*
-        * Take a reference on the zone write plug and schedule the submission
-        * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-        * reference we take here.
-        */
-       WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-       refcount_inc(&zwplug->ref);
-       queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
-}
-
 static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
                                       struct blk_zone_wplug *zwplug)
 {



-- 
Damien Le Moal
Western Digital Research
