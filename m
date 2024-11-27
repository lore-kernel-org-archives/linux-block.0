Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48E29CF2
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684731; cv=none; b=spS1NpSDr+ZF/Wvb89OFl5WVW8usUjfQX5Ap7pp7yqbRP4VQWu1hzbaf2124ORkgKOf6IBCEQetvCEAhHT+pmsAvPLx/gfKHy8Tu51OUq+jeCfhMTrnulUGaT51ZHdl/UF+zHrNQz7hlbVNTzfHD8tD0Ut6jkhyyqWo/OVnCOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684731; c=relaxed/simple;
	bh=AlQ8pjnpxmkcXa28BhDiIHyboQoXse62VLLxQx3zPGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHvnfOL/blSnQRvbmaHjv8SPmEB9PhKbGlRFtX0Ov0FYJQITBtGN+FuXsc0yAVbSCj+PjrgfutDSxd3ptV8wQgXaFj1jIA1eU5ko4Zs8+9kBWH0ncP7/UP7BlokynIBnNmJQkTlF0Eere33d9Z46kymfMgW29dUgP9h+Ip6lygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2YEOdhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2YEOdhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91D8C4CECC;
	Wed, 27 Nov 2024 05:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732684731;
	bh=AlQ8pjnpxmkcXa28BhDiIHyboQoXse62VLLxQx3zPGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f2YEOdhMr9gavD8EmrLGxFLB7pYRq10LYbO86fezC/4SQFQqm8fB8yJM3DQvLU5Me
	 0nfOWXsKPBfbV1xt/SFSOWMS5OZcM91bHQTPw/w1OeUrAELTfik7ZWQmTTIoePdoay
	 gMYTQ9tha2OBLxAYP2WBGkgyr5XMp8rz2MtiIYZznLT1Lza0io0M8j+FUhdveItIhT
	 yVNiX2P2QtBrh3NoZ0fztcisFv4fJoCYTnvKyY9QVJESF4RmK+Kn81dBxKApHR7voR
	 AmIxGCX+nPYDSyiEcycSuIKYXcGn+2p2KJP/o+ReKOctTIDz+kRzoToLGlwBBOavGX
	 HjhBrZG3F4PHw==
Message-ID: <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
Date: Wed, 27 Nov 2024 14:18:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/26/24 10:44 PM, Bart Van Assche wrote:
> On 11/26/24 12:34 AM, Damien Le Moal wrote:
>> Of note, is that by simply creating the scsi_debug device in a vm manually, I
>> get this lockdep splat:
>>
>> [   51.934109] ======================================================
>> [   51.935916] WARNING: possible circular locking dependency detected
>> [   51.937561] 6.12.0+ #2107 Not tainted
>> [   51.938648] ------------------------------------------------------
>> [   51.940351] kworker/u16:4/157 is trying to acquire lock:
>> [   51.941805] ffff9fff0aa0bea8 (&q->limits_lock){+.+.}-{4:4}, at:
>> disk_update_zone_resources+0x86/0x170
>> [   51.944314]
>> [   51.944314] but task is already holding lock:
>> [   51.945688] ffff9fff0aa0b890 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at:
>> blk_revalidate_disk_zones+0x15f/0x340
>> [   51.948527]
>> [   51.948527] which lock already depends on the new lock.
>> [   51.948527]
>> [   51.951296]
>> [   51.951296] the existing dependency chain (in reverse order) is:
>> [   51.953708]
>> [   51.953708] -> #1 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
>> [   51.956131]        blk_queue_enter+0x1c9/0x1e0
> 
> I have disabled the blk_queue_enter() lockdep annotations locally
> because these annotations cause too many false positive reports.
> 
>>> +DESCRIPTION="test requeuing of zoned writes and queue freezing"
>>
>> There is no requeueing going on here so this description is inaccurate.
> 
> The combination of the scsi_debug options every_nth=$((2 * qd)) and opts=0x8000
> should cause requeuing, isn't it?

Indeed. I did not know these options..

>>> +        --name=pipeline-zoned-writes
>>
>> Nothing is pipelined here since this is a qd=1 run.
> 
> Agreed. I will change the fio job name.

After some debugging, I understood the issue. It is not a problem with the
queue usage counter but rather an issue with REQ_NOWAIT BIOs that may be failed
with bio_wouldblock_error() *after* having been processed by
blk_zone_plug_bio(). E.g. blk_mq_get_new_requests() may fail to get a request
due to REQ_NOWAIT being set and fail the BIO using bio_wouldblock_error(). This
in turn will lead to a call to disk_zone_wplug_set_error() which will mark the
zone write plug with the ERROR flag. However, since the BIO failure is not from
a failed request, we are not calling disk_zone_wplug_unplug_bio(), which if
called would run the error recovery for the zone. That is, the zone write plug
of the BLK_STS_AGAIN failed BIO is left "busy", which result in the BIO to be
added to the plug BIO list when it is re-submitted again. But we donot have any
write BIO on-going for this zone, the BIO ends up stuck in the zone write plug
list holding a queue reference count, which causes the freeze to never terminate.

One "simple" fix is something like this:

iff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 263e28b72053..d6334ed5b9be 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1158,10 +1158,18 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
         * If the BIO failed, mark the plug as having an error to trigger
         * recovery.
         */
-       if (bio->bi_status != BLK_STS_OK) {
+       switch (bio->bi_status) {
+       case BLK_STS_OK:
+               break;
+       case BLK_STS_AGAIN:
+               if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
+                       disk_zone_wplug_unplug_bio(disk, zwplug);
+               break;
+       default:
                spin_lock_irqsave(&zwplug->lock, flags);
                disk_zone_wplug_set_error(disk, zwplug);
                spin_unlock_irqrestore(&zwplug->lock, flags);
+               break;
        }

        /* Drop the reference we took when the BIO was issued. */

BUT ! I really do not like this fix because it causes a failure when the BIO is
retried, because the zone write pointer was advanced for the BIO the first time
it was submitted (and failed with EAGAIN). This results in going through the
error recovery procedure for a zone every time a BIO that failed with EAGAIN is
resubmitted. Not nice.

On the other hand, if we take a "big hammer" approach and simply ignore the
REQ_NOWAIT flag, things work fine. This patch does that:

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 263e28b72053..492bcbb04a74 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -491,8 +491,7 @@ static void blk_zone_wplug_bio_work(struct work_struct *work);
  * Return a pointer to the zone write plug with the plug spinlock held.
  */
 static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
-                                       sector_t sector, gfp_t gfp_mask,
-                                       unsigned long *flags)
+                                       sector_t sector, unsigned long *flags)
 {
        unsigned int zno = disk_zone_no(disk, sector);
        struct blk_zone_wplug *zwplug;
@@ -520,7 +519,7 @@ static struct blk_zone_wplug
*disk_get_and_lock_zone_wplug(struct gendisk *disk,
         * so that it is not freed when the zone write plug becomes idle without
         * the zone being full.
         */
-       zwplug = mempool_alloc(disk->zone_wplugs_pool, gfp_mask);
+       zwplug = mempool_alloc(disk->zone_wplugs_pool, GFP_NOIO);
        if (!zwplug)
                return NULL;

@@ -939,7 +938,6 @@ static bool blk_zone_wplug_handle_write(struct bio *bio,
unsigned int nr_segs)
        struct gendisk *disk = bio->bi_bdev->bd_disk;
        sector_t sector = bio->bi_iter.bi_sector;
        struct blk_zone_wplug *zwplug;
-       gfp_t gfp_mask = GFP_NOIO;
        unsigned long flags;

        /*
@@ -965,10 +963,20 @@ static bool blk_zone_wplug_handle_write(struct bio *bio,
unsigned int nr_segs)
                return false;
        }

-       if (bio->bi_opf & REQ_NOWAIT)
-               gfp_mask = GFP_NOWAIT;
+       /*
+        * A no-wait BIO may be failed after blk_zone_plug_bio() returns,
+        * e.g. blk_mq_get_new_requests() may fail the BIO with
+        * bio_wouldblock_error() in blk_mq_submit_bio(), after
+        * blk_zone_plug_bio() was called. We cannot easily handle such failure
+        * as we may be handling emulated zone append operations that rely on
+        * the write pointer tracking done in blk_zone_wplug_prepare_bio().
+        * Failing the BIO with bio_wouldblock_error() will break this tracking
+        * and result in failure for the following BIOs submitted.
+        * Avoid such issue by ignoring the REQ_NOWAIT flag.
+        */
+       bio->bi_opf &= ~REQ_NOWAIT;

-       zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
+       zwplug = disk_get_and_lock_zone_wplug(disk, sector, &flags);
        if (!zwplug) {
                bio_io_error(bio);
                return true;
@@ -1673,7 +1681,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone,
unsigned int idx,
        if (!wp_offset || wp_offset >= zone->capacity)
                return 0;

-       zwplug = disk_get_and_lock_zone_wplug(disk, zone->wp, GFP_NOIO, &flags);
+       zwplug = disk_get_and_lock_zone_wplug(disk, zone->wp, &flags);
        if (!zwplug)
                return -ENOMEM;
        spin_unlock_irqrestore(&zwplug->lock, flags);

I really prefer this second solution as it is more efficient and safer.

On another note: Changing the iodepth from 1 to some higher value result in the
test failing because of unaligned write pointer errors. I think that io_uring
is unsafe for writes to zoned block device at high queue depth because of the
asynchronous request submission that can happen (as that potentially reorders
SQEs that are otherwise correclty queued and sequential for a zone).
I would like to fix that as well, but that is another issue.

-- 
Damien Le Moal
Western Digital Research
