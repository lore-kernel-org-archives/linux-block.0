Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C0482F2
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382973; cv=none; b=c5v/fVxFo3XkZ1rw4C/ywnSbnu94jbU/v9+8ZlFCYncNwDV/HcKW9cxgdBo4E6PT0ZaItfrZtHqLJwQn1H4c2tHYlNyu5RptMASQkRM0TK9u8ljGsJaiYctjpVaFbFTwltgkkLpI4lMPbfxp021ElcE05HKoTc5dMUwLxKsTyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382973; c=relaxed/simple;
	bh=RZFzYgOgUbMiSblN9FereFOSXhDS+ute2ySt2jpstYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euivPkgpA9XlmT3KWdZfuzvapCFEbCFuwkzqeA55tmTSPRI4p36oDzQhOZHpDQqb1nY22zvIUw6u5FpkWsCPa2DxOusuBvzTjdmKXKQLqH4NthqvEO3pnMcE8WNlF+pS+H62rEYct3ORGAxJ0Yq9GU2IrcnEwIh5WcL7Dfd0WRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoOcb/bN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoOcb/bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C54C4CEEA;
	Fri, 20 Jun 2025 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750382971;
	bh=RZFzYgOgUbMiSblN9FereFOSXhDS+ute2ySt2jpstYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CoOcb/bNXuhAHSF0AZvD8DDmhqqERQTRFgEFUqoefkicdXeHNZmP+aSLov0QJk7tR
	 ASwNW34Y95m8KrtGOL0PWCEyaOOq07VXTRHzEQGeHBN6u5EQn4DnknVoJyLMgY3Pre
	 EABSpukSb5L66XIYtQER9Wy96oXpY++tFOTa/zkW70AdJLtgdhgQphECd6VHFDGAlL
	 HYZDSH37BrH38O++tBpeTwOPryd3lUt+cReFVtDlX6xJGCv7havECu4FIrXmFdA0yR
	 13CPRODUjvz4utqp7UO6EBE+lpianEzoL4dfnZ4BWaid8hzUDQQjOeLiGHcqrYDAv8
	 WmGuF/JXk/5JQ==
Message-ID: <ea9c6463-f602-4fcb-b343-dd1973304abf@kernel.org>
Date: Fri, 20 Jun 2025 10:29:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
 <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
 <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
 <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 02:13, Bart Van Assche wrote:
> 
> On 6/17/25 10:56 PM, Damien Le Moal wrote:
>> Can you check exactly the path that is being followed ? (your
>  > backtrace does not seem to have everything)
> 
> Hmm ... it is not clear to me why this information is required? My 
> understanding is that the root cause is the same as for the deadlock
> fixed by Christoph:
> 1. A bio is queued onto zwplug->bio_list. Before this happens, the
>     queue reference count is increased by one.
> 2. A value is written into a block device sysfs attribute and queue
>     freezing starts. The queue freezing code waits for completion of
>     all bios on zwplug->bio_list because the reference count owned by
>     these bios is only released when these bios complete.
> 3. blk_zone_wplug_bio_work() dequeues a bio from zwplug->bio_list,
>     calls dm_submit_bio() through a function pointer, dm_submit_bio()
>     calls submit_bio_noacct() indirectly and submit_bio_noacct() calls
>     bio_queue_enter() indirectly. bio_queue_enter() sees that queue
>     freezing has started and waits until the queue is unfrozen.
> 4. A deadlock occurs because (2) and (3) wait for each other
>     indefinitely.

Then we need to split DM BIOs immediately on submission, always.
So something like this totally untested patch should solve the issue.
Care to test ?

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 55e64ca869d7..12aa56352176 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1129,6 +1129,44 @@ static void
blk_zone_wplug_handle_native_zone_append(struct bio *bio)
        disk_put_zone_wplug(zwplug);
 }

+/**
+ * bio_needs_zone_write_plugging - Check if a BIO needs to be handled with zone
+ *                                write plugging
+ * @bio: The BIO being submitted
+ *
+ * Return true whenever @bio execution needs to be handled through zone
+ * write plugging. Return false otherwise.
+ */
+bool bio_needs_zone_write_plugging(struct bio *bio)
+{
+       if (!bdev_is_zoned(bio->bi_bdev))
+               return false;
+
+       /* Already handled ? */
+       if (bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING))
+               return false;
+
+       /* Ignore empty flush */
+       if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
+               return false;
+
+       /*
+        * Regular writes and write zeroes need to be handled through zone
+        * write plugging. Zone append operations only need zone write plugging
+        * if they are emulated.
+        */
+       switch (bio_op(bio)) {
+       case REQ_OP_ZONE_APPEND:
+               return bdev_emulates_zone_append(bio->bi_bdev);
+       case REQ_OP_WRITE:
+       case REQ_OP_WRITE_ZEROES:
+               return true;
+       default:
+               return false;
+       }
+}
+EXPORT_SYMBOL_GPL(bio_needs_zone_write_plugging);
+
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 21920991ab28..5c2d98a5fdf8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1771,16 +1771,6 @@ static void init_clone_info(struct clone_info *ci, struct
dm_io *io,
 }

 #ifdef CONFIG_BLK_DEV_ZONED
-static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
-                                          struct bio *bio)
-{
-       /*
-        * For mapped device that need zone append emulation, we must
-        * split any large BIO that straddles zone boundaries.
-        */
-       return dm_emulate_zone_append(md) && bio_straddles_zones(bio) &&
-               !bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
-}
 static inline bool dm_zone_plug_bio(struct mapped_device *md, struct bio *bio)
 {
        return dm_emulate_zone_append(md) && blk_zone_plug_bio(bio, 0);
@@ -1899,11 +1889,6 @@ static blk_status_t __send_zone_reset_all(struct
clone_info *ci)
 }

 #else
-static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
-                                          struct bio *bio)
-{
-       return false;
-}
 static inline bool dm_zone_plug_bio(struct mapped_device *md, struct bio *bio)
 {
        return false;
@@ -1928,8 +1913,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
        is_abnormal = is_abnormal_io(bio);
        if (static_branch_unlikely(&zoned_enabled)) {
                /* Special case REQ_OP_ZONE_RESET_ALL as it cannot be split. */
-               need_split = (bio_op(bio) != REQ_OP_ZONE_RESET_ALL) &&
-                       (is_abnormal || dm_zone_bio_needs_split(md, bio));
+               need_split = is_abnormal || bio_needs_zone_write_plugging(bio);
        } else {
                need_split = is_abnormal;
        }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c2b3ddea8b6d..c3cab300e4c2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -984,6 +984,8 @@ static inline bool bio_straddles_zones(struct bio *bio)
                disk_zone_no(bio->bi_bdev->bd_disk, bio_end_sector(bio) - 1);
 }

+bool bio_needs_zone_write_plugging(struct bio *bio);
+
 /*
  * Return how much within the boundary is left to be used for I/O at a given
  * offset.



-- 
Damien Le Moal
Western Digital Research
