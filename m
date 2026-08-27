Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03932388E6B
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870652; cv=none; b=oKjYZPywFiAVIzIV9zp264q61PsSmaCJbK1UuSbpa3cBFbEG4jKen6w9nMquGuaUrPlc4Vm41cPaDb8kJEWcZeNmkODH/GcOV6sRISm91L2SJVjIr98Uo5ehfgj0teWlMXNUcdKB2VHGo0TUFHycmNOGkyihoETrvHun7YYJAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870652; c=relaxed/simple;
	bh=Gw3DjfD18tGnAKd1ghr74FncZJ7J3q3WLt/E2xOdgPM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nf3hV54DxLu8RA7CJ/yqrcQsEwTfNKKYBUNpkvAoXhLOktmSCGdj48CdNNIfBBT7G+cq4GfN3BJ+Nvo6hTOPquzjt5OenKyhDc+dycxz0OWvPGijbtxw7eCw5lRMfMyZljGMQpnsX0niVRpWxJ8fS3vMV1F5Jge4a7OPJKaA0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOinxDax; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOinxDax"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gw3DjfD18tGnAKd1ghr74FncZJ7J3q3WLt/E2xOdgPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787870647; v=1; x=1788475447;
 b=bOinxDax9oV6JHhfeRMOkOOAgvfUGsGrXlmwpvdbQEy9V5JkN3CsO4kazpju6yOe3v6tVFHi
 8ThO2adoCc5YIAwhXDd3yWhI36sS6VRREhr37EI7qvIAsDR3a67k1PPW39GsvRCfeElYPhERtTI
 lwMtIqlg3vEgRPsfoRa5IgMo=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ea4a59009cf8cca;
	Thu, 27 Aug 2026 22:44:07 +0000
X-Mizu-Trace-ID: 9ea4a59009cf8cca
X-Migadu-Flow: FLOW_OUT
Message-ID: <03b448d0-7f6a-41a6-bcfa-93e430aa7ac6@linux.dev>
Date: Fri, 28 Aug 2026 00:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC for-next 2/3] block: allow error injection rules to delay
 bios
From: Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>
References: <20260827000115.128093-1-haris.iqbal@linux.dev>
 <20260827000115.128093-3-haris.iqbal@linux.dev>
 <da2d8bda-5d88-4644-bc9a-3cc91851e5e1@linux.dev>
Content-Language: en-US
In-Reply-To: <da2d8bda-5d88-4644-bc9a-3cc91851e5e1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/27/26 15:02, Haris Iqbal wrote:
> 
> 
> On 8/27/26 02:01, Md Haris Iqbal wrote:
>> Error injection can only fail a bio today.  Add a delay_us option so that
>> a rule can hold a bio back first, to model a slow device.
>>
>> If a matching rule has delay_us set, the bio is held for that long.  
>> It is
>> then failed if the rule also has a status, or resubmitted below the
>> injection hook so that the rules are not applied to it again.
>>
>> The bio is submitted from a workqueue rather than from the timer, because
>> submitting a bio can sleep.  Bios with REQ_NOWAIT are never delayed, and
>> values above 600 seconds are rejected.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
>> ---
>>   block/blk-core.c        |  13 ++--
>>   block/blk.h             |   1 +
>>   block/error-injection.c | 147 ++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 142 insertions(+), 19 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 196bccf27f58..f28ccc4633d4 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -759,11 +759,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
>>       current->bio_list = NULL;
>>   }
>> -void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>> +void __submit_bio_noacct_nocheck(struct bio *bio, bool split)
>>   {
>> -    if (unlikely(blk_error_inject(bio)))
>> -        return;
>> -
>>       blk_cgroup_bio_start(bio);
>>       if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
>> @@ -793,6 +790,14 @@ void submit_bio_noacct_nocheck(struct bio *bio, 
>> bool split)
>>       }
>>   }
>> +void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>> +{
>> +    if (unlikely(blk_error_inject(bio)))
>> +        return;
>> +
>> +    __submit_bio_noacct_nocheck(bio, split);
>> +}
>> +
>>   static blk_status_t blk_validate_atomic_write_op_size(struct 
>> request_queue *q,
>>                            struct bio *bio)
>>   {
>> diff --git a/block/blk.h b/block/blk.h
>> index 50abfd932886..cdf6d8964da6 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -61,6 +61,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
>>                     struct task_struct *owner);
>>   int __bio_queue_enter(struct request_queue *q, struct bio *bio);
>>   void submit_bio_noacct_nocheck(struct bio *bio, bool split);
>> +void __submit_bio_noacct_nocheck(struct bio *bio, bool split);
>>   int bio_submit_or_kill(struct bio *bio, unsigned int flags);
>>   static inline bool blk_try_enter_queue(struct request_queue *q, bool 
>> pm)
>> diff --git a/block/error-injection.c b/block/error-injection.c
>> index 47cdd8973adc..9b823edf3f8a 100644
>> --- a/block/error-injection.c
>> +++ b/block/error-injection.c
>> @@ -6,9 +6,17 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/parser.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/workqueue.h>
>>   #include "blk.h"
>>   #include "error-injection.h"
>> +/*
>> + * Cap the delay so that a typo can't wedge a device for good.  This 
>> is still
>> + * well beyond the default hung task timeout, which is one of the 
>> things a
>> + * delay is useful for triggering.
>> + */
>> +#define BLK_ERROR_INJECT_MAX_DELAY_US    (600 * USEC_PER_SEC)
>> +
>>   struct blk_error_inject {
>>       struct list_head        entry;
>>       sector_t            start;
>> @@ -18,14 +26,91 @@ struct blk_error_inject {
>>       /* only inject every 1 / chance times */
>>       unsigned int            chance;
>> +
>> +    /* hold the bio for this long before submitting or failing it */
>> +    unsigned int            delay_us;
>>   };
>> +/*
>> + * A bio held by a delay rule.  This is self-contained on purpose: it 
>> does not
>> + * point back at the rule, so rules can be removed while delayed bios 
>> are
>> + * outstanding, and it does not point at the gendisk, so nothing has 
>> to be
>> + * cleaned up when the disk goes away.  A delayed bio holds no queue 
>> usage
>> + * counter reference either, so one that outlives its disk is failed 
>> by the
>> + * GD_DEAD check in __bio_queue_enter() once it is finally submitted.
>> + */
>> +struct blk_error_inject_delay {
>> +    struct delayed_work        dwork;
>> +    struct bio            *bio;
>> +    blk_status_t            status;
>> +};
>> +
>> +static struct workqueue_struct *blk_error_inject_wq;
>> +
>>   DEFINE_STATIC_KEY_FALSE(blk_error_injection_enabled);
>> +static void blk_error_inject_delay_work(struct work_struct *work)
>> +{
>> +    struct blk_error_inject_delay *d = 
>> container_of(to_delayed_work(work),
>> +            struct blk_error_inject_delay, dwork);
>> +    struct bio *bio = d->bio;
>> +    blk_status_t status = d->status;
>> +
>> +    kfree(d);
>> +
>> +    if (status != BLK_STS_OK) {
>> +        bio->bi_status = status;
>> +        bio_endio(bio);
>> +    } else {
>> +        /*
>> +         * Submit below the injection hook.  Re-entering it would match
>> +         * the same rule again and the bio would never be issued, so a
>> +         * bio that was delayed once skips error injection entirely
>> +         * from here on, including any other rule that covers it.
>> +         */
>> +        __submit_bio_noacct_nocheck(bio, false);
> 
> According to Sashiko, this will cause split bios to go through multiple 
> delays.
> 
> Initial look says that what Sashiko is saying is true. I will take a 
> deeper look and get back.

Tested and Confirmed. Bios that split, compound the delays.

We can add a BIO_ERROR_INJECTED flag and set it upon the first entry to 
__blk_error_inject for bios that should be delayed. Later split bio 
submissions will then be skipped.

> 
>> +    }
>> +}
>> +
>> +/*
>> + * Hand the bio to a workqueue that submits or fails it once the 
>> delay has
>> + * expired.  Both blk_mq_submit_bio() and ->submit_bio can sleep, so 
>> this can't
>> + * be completed from the timer itself.
>> + *
>> + * Returns false if the bio can't be delayed, in which case the 
>> caller handles
>> + * it immediately instead.
>> + */
>> +static bool blk_error_inject_delay(struct gendisk *disk, struct bio 
>> *bio,
>> +        blk_status_t status, unsigned int delay_us)
>> +{
>> +    struct blk_error_inject_delay *d;
>> +
>> +    /* never block a bio that asked not to be blocked */
>> +    if (bio->bi_opf & REQ_NOWAIT)
>> +        return false;
>> +
>> +    d = kmalloc_obj(*d, GFP_NOIO);
>> +    if (!d)
>> +        return false;
>> +
>> +    pr_info_ratelimited("%pg: delaying %s at sector %llu:%u by %uus\n",
>> +            disk->part0, blk_op_str(bio_op(bio)),
>> +            bio->bi_iter.bi_sector, bio_sectors(bio), delay_us);
>> +
>> +    d->bio = bio;
>> +    d->status = status;
>> +    INIT_DELAYED_WORK(&d->dwork, blk_error_inject_delay_work);
>> +    queue_delayed_work(blk_error_inject_wq, &d->dwork,
>> +            usecs_to_jiffies(delay_us));
>> +    return true;
>> +}
>> +
>>   bool __blk_error_inject(struct bio *bio)
>>   {
>>       struct gendisk *disk = bio->bi_bdev->bd_disk;
>>       struct blk_error_inject *inj;
>> +    blk_status_t status = BLK_STS_OK;
>> +    unsigned int delay_us = 0;
>>       rcu_read_lock();
>>       list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
>> @@ -45,29 +130,38 @@ bool __blk_error_inject(struct bio *bio)
>>           if (inj->chance > 1 && (get_random_u32() % inj->chance) != 0)
>>               continue;
>> -        pr_info_ratelimited("%pg: injecting %s error for %s at sector 
>> %llu:%u\n",
>> -                disk->part0, blk_status_to_str(inj->status),
>> -                blk_op_str(inj->op), bio->bi_iter.bi_sector,
>> -                bio_sectors(bio));
>> -        bio->bi_status = inj->status;
>> -        rcu_read_unlock();
>> -        bio_endio(bio);
>> -        return true;
>> +        status = inj->status;
>> +        delay_us = inj->delay_us;
>> +        break;
>>       }
>>       rcu_read_unlock();
>> -    return false;
>> +
>> +    if (delay_us && blk_error_inject_delay(disk, bio, status, delay_us))
>> +        return true;
>> +    if (status == BLK_STS_OK)
>> +        return false;
>> +
>> +    pr_info_ratelimited("%pg: injecting %s error for %s at sector 
>> %llu:%u\n",
>> +            disk->part0, blk_status_to_str(status),
>> +            blk_op_str(bio_op(bio)), bio->bi_iter.bi_sector,
>> +            bio_sectors(bio));
>> +    bio->bi_status = status;
>> +    bio_endio(bio);
>> +    return true;
>>   }
>>   static int error_inject_add(struct gendisk *disk, enum req_op op,
>>           sector_t start, u64 nr_sectors, blk_status_t status,
>> -        unsigned int chance)
>> +        unsigned int chance, unsigned int delay_us)
>>   {
>>       struct blk_error_inject *inj;
>>       int error = -EINVAL;
>>       if (op == REQ_OP_LAST)
>>           return -EINVAL;
>> -    if (status == BLK_STS_OK)
>> +    if (status == BLK_STS_OK && !delay_us)
>> +        return -EINVAL;
>> +    if (delay_us > BLK_ERROR_INJECT_MAX_DELAY_US)
>>           return -EINVAL;
>>       inj = kzalloc_obj(*inj);
>> @@ -86,6 +180,7 @@ static int error_inject_add(struct gendisk *disk, 
>> enum req_op op,
>>       inj->start = start;
>>       inj->status = status;
>>       inj->chance = chance;
>> +    inj->delay_us = delay_us;
>>       pr_debug_ratelimited("%pg: adding %s injection for %s at sector 
>> %llu:%llu\n",
>>               disk->part0, blk_status_to_str(status),
>> @@ -139,6 +234,7 @@ enum options {
>>       Opt_nr_sectors        = (1u << 18),
>>       Opt_status        = (1u << 19),
>>       Opt_chance        = (1u << 20),
>> +    Opt_delay_us        = (1u << 21),
>>       Opt_invalid,
>>   };
>> @@ -151,6 +247,7 @@ static const match_table_t opt_tokens = {
>>       { Opt_nr_sectors,        "nr_sectors=%u"        },
>>       { Opt_status,            "status=%s"        },
>>       { Opt_chance,            "chance=%u"        },
>> +    { Opt_delay_us,            "delay_us=%u"        },
>>       { Opt_invalid,            NULL,            },
>>   };
>> @@ -189,7 +286,7 @@ static ssize_t 
>> blk_error_injection_parse_options(struct gendisk *disk,
>>           char *options)
>>   {
>>       enum { Unset, Add, Removeall } action = Unset;
>> -    unsigned int option_mask = 0, chance = 1;
>> +    unsigned int option_mask = 0, chance = 1, delay_us = 0;
>>       enum req_op op = REQ_OP_LAST;
>>       u64 start = 0, nr_sectors = 0;
>>       blk_status_t status = BLK_STS_OK;
>> @@ -232,6 +329,9 @@ static ssize_t 
>> blk_error_injection_parse_options(struct gendisk *disk,
>>               if (!error && chance == 0)
>>                   error = -EINVAL;
>>               break;
>> +        case Opt_delay_us:
>> +            error = match_uint(args, &delay_us);
>> +            break;
>>           default:
>>               pr_warn("unknown parameter or missing value '%s'\n", p);
>>               error = -EINVAL;
>> @@ -243,7 +343,7 @@ static ssize_t 
>> blk_error_injection_parse_options(struct gendisk *disk,
>>       switch (action) {
>>       case Add:
>>           return error_inject_add(disk, op, start, nr_sectors, status,
>> -                chance);
>> +                chance, delay_us);
>>       case Removeall:
>>           if (option_mask & ~Opt_removeall)
>>               return -EINVAL;
>> @@ -279,10 +379,11 @@ static int blk_error_injection_show(struct 
>> seq_file *s, void *private)
>>       rcu_read_lock();
>>       list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
>> -        seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u",
>> +        seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u,delay_us=%u",
>>                  inj->start, inj->end,
>>                  blk_op_str(inj->op),
>> -               blk_status_to_tag(inj->status), inj->chance);
>> +               blk_status_to_tag(inj->status), inj->chance,
>> +               inj->delay_us);
>>           seq_putc(s, '\n');
>>       }
>>       rcu_read_unlock();
>> @@ -317,3 +418,19 @@ void blk_error_injection_exit(struct gendisk *disk)
>>   {
>>       error_inject_removeall(disk);
>>   }
>> +
>> +static int __init blk_error_injection_init_wq(void)
>> +{
>> +    /*
>> +     * WQ_MEM_RECLAIM so that a delayed bio on the reclaim path can 
>> still
>> +     * find a worker under memory pressure.  Note that this only 
>> guarantees
>> +     * a worker exists, not that it is free: submitting a bio can 
>> block on
>> +     * a queue freeze or on tag allocation, so a delayed bio can 
>> still be
>> +     * held up behind another one.
>> +     */
>> +    blk_error_inject_wq = alloc_workqueue("blk_error_inject", 
>> WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>> +    if (!blk_error_inject_wq)
>> +        panic("Failed to create blk_error_inject wq\n");
>> +    return 0;
>> +}
>> +subsys_initcall(blk_error_injection_init_wq);
> 
> 

