Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C092874FF;
	Fri, 23 May 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987838; cv=none; b=ZGJVVPvzkHMhqx8XRZUtnhHxmZ1oYV0yRiyQEAW1/SvVXZiJMz9tRLxAxe6e5HtYJRvI7FWMfvhtFVVFZYJughpyts69x6prFg3XwtM+la+FWUkH2f5SmWEi0EvnqUpHxgtESwC387JVppsWQjMO5hAVPR47wUl8s9y3URNd9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987838; c=relaxed/simple;
	bh=4f3ocmL38PSOLqrQWfeNOXn3VrYmoSkK8rEqZrkcNhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpfN1JbaENCCJmUy4BME216pUsWGJlJBTJqBel0rKtRGcy+stRe2GY+uxDydRtnM7igNHKeFvTAAj7bj5l46HiS3DcM+sdapKk2Pt0YdhY0Zv6j7SB7lwl+GFRbFzjRUJEUQCnHpQi4m605ihI7Wz66sUzDF5t+TPTt5MQAQhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTvzmEK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTvzmEK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B5C4CEEB;
	Fri, 23 May 2025 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747987837;
	bh=4f3ocmL38PSOLqrQWfeNOXn3VrYmoSkK8rEqZrkcNhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iTvzmEK/Qzt54LM99nSv75INhYHzrxCmyf9RUpZh7iCBvJnzShZX1AIe20TCi5P/l
	 9RllN3Iv3lb9VJcbqi3svTzfXSrlU23qxzYffRNLww/Nt31Uw88n5qrGegnDb4kuU0
	 0oI7iNfAglSEJLZ6WzXGz7Y7qS0Fue/BLvp4XwOB9Eq9dWXxT870SGL9MwylUlBwJt
	 BcnKVjBAr4qF83rJzpd5oR+ZJNdqz5Ri3z6Hj4XDwk0npdJDfhmcchEkSkg9OEBV0s
	 aoP1IxvpsnIUiW67rh6KFISRPr+CeWHURJVoQFLGxcZuualvtkgi4IliG/oy9oyum4
	 +tDVpsJDQnZwg==
Message-ID: <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Date: Fri, 23 May 2025 10:10:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 19:38, Jens Axboe wrote:
> On 5/22/25 11:14 AM, Bart Van Assche wrote:
>> blk_mq_freeze_queue() never terminates if one or more bios are on the plug
>> list and if the block device driver defines a .submit_bio() method.
>> This is the case for device mapper drivers. The deadlock happens because
>> blk_mq_freeze_queue() waits for q_usage_counter to drop to zero, because
>> a queue reference is held by bios on the plug list and because the
>> __bio_queue_enter() call in __submit_bio() waits for the queue to be
>> unfrozen.
>>
>> This patch fixes the following deadlock:
>>
>> Workqueue: dm-51_zwplugs blk_zone_wplug_bio_work
>> Call trace:
>>  __schedule+0xb08/0x1160
>>  schedule+0x48/0xc8
>>  __bio_queue_enter+0xcc/0x1d0
>>  __submit_bio+0x100/0x1b0
>>  submit_bio_noacct_nocheck+0x230/0x49c
>>  blk_zone_wplug_bio_work+0x168/0x250
>>  process_one_work+0x26c/0x65c
>>  worker_thread+0x33c/0x498
>>  kthread+0x110/0x134
>>  ret_from_fork+0x10/0x20
>>
>> Call trace:
>>  __switch_to+0x230/0x410
>>  __schedule+0xb08/0x1160
>>  schedule+0x48/0xc8
>>  blk_mq_freeze_queue_wait+0x78/0xb8
>>  blk_mq_freeze_queue+0x90/0xa4
>>  queue_attr_store+0x7c/0xf0
>>  sysfs_kf_write+0x98/0xc8
>>  kernfs_fop_write_iter+0x12c/0x1d4
>>  vfs_write+0x340/0x3ac
>>  ksys_write+0x78/0xe8
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Yu Kuai <yukuai1@huaweicloud.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: stable@vger.kernel.org
>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>
>> Changes compared to v1: fixed a race condition. Call bio_zone_write_plugging()
>>   only before submitting the bio and not after it has been submitted.
>>
>>  block/blk-core.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index b862c66018f2..713fb3865260 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -621,6 +621,13 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>>  	return BLK_STS_OK;
>>  }
>>  
>> +/*
>> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
>> + * set because this causes blk_mq_freeze_queue() to deadlock if
>> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
>> + * on the plug list is not necessary since a q_usage_counter reference is held
>> + * while a bio is on the plug list.
>> + */
>>  static void __submit_bio(struct bio *bio)
>>  {
>>  	/* If plug is not used, add new plug here to cache nsecs time. */
>> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>>  
>>  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>  		blk_mq_submit_bio(bio);
>> -	} else if (likely(bio_queue_enter(bio) == 0)) {
>> +	} else {
>>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
>> +		bool zwp = bio_zone_write_plugging(bio);
>> +
>> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
>> +			goto finish_plug;
>>  	
>>  		if ((bio->bi_opf & REQ_POLLED) &&
>>  		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
>> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>>  		} else {
>>  			disk->fops->submit_bio(bio);
>>  		}
>> -		blk_queue_exit(disk->queue);
>> +
>> +		if (!zwp)
>> +			blk_queue_exit(disk->queue);
>>  	}
> 
> This is pretty ugly, and I honestly absolutely hate how there's quite a
> bit of zoned_whatever sprinkling throughout the core code. What's the
> reason for not unplugging here, unaligned writes? Because you should
> presumable have the exact same issues on non-zoned devices if they have
> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
> on a freeze.
> 
> A somewhat similar case was solved for IOPOLL and queue entering. That
> would be another thing to look at. Maybe a live enter could work if the
> plug itself pins it?

What about this patch, completely untested...

 diff --git a/block/blk-core.c b/block/blk-core.c
index e8cc270a453f..3d2dec088a54 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -621,6 +621,32 @@ static inline blk_status_t blk_check_zone_append(struct
request_queue *q,
        return BLK_STS_OK;
 }

+static inline void disk_submit_bio(struct bio *bio)
+{
+       struct gendisk *disk = bio->bi_bdev->bd_disk;
+       bool need_queue_enter = !bio_zone_write_plugging(bio);
+
+       /*
+        * BIOs that are issued from a zone write plug already hold a reference
+        * on the device queue usage counter.
+        */
+       if (need_queue_enter) {
+               if (unlikely(bio_queue_enter(bio)))
+                       return;
+       }
+
+       if ((bio->bi_opf & REQ_POLLED) &&
+           !(disk->queue->limits.features & BLK_FEAT_POLL)) {
+               bio->bi_status = BLK_STS_NOTSUPP;
+               bio_endio(bio);
+       } else {
+               disk->fops->submit_bio(bio);
+       }
+
+       if (need_queue_enter)
+               blk_queue_exit(disk->queue);
+}
+
 static void __submit_bio(struct bio *bio)
 {
        /* If plug is not used, add new plug here to cache nsecs time. */
@@ -631,20 +657,10 @@ static void __submit_bio(struct bio *bio)

        blk_start_plug(&plug);

-       if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
+       if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
                blk_mq_submit_bio(bio);
-       } else if (likely(bio_queue_enter(bio) == 0)) {
-               struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-               if ((bio->bi_opf & REQ_POLLED) &&
-                   !(disk->queue->limits.features & BLK_FEAT_POLL)) {
-                       bio->bi_status = BLK_STS_NOTSUPP;
-                       bio_endio(bio);
-               } else {
-                       disk->fops->submit_bio(bio);
-               }
-               blk_queue_exit(disk->queue);
-       }
+       else
+               disk_submit_bio(bio)

        blk_finish_plug(&plug);
 }



-- 
Damien Le Moal
Western Digital Research
