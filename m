Received: from lf-2-31.ptr.blmpb.com (lf-2-31.ptr.blmpb.com [101.36.218.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4818263F4A
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727550; cv=none; b=R6LesrkgmO9gGhMGAcQk0a+4dTPdPDJG/9+EZq9Qa04GUCL0V8/WbeTUFo8p+PChP6DYyUGHYk2l/+GxngTdxrThN1l/GrNZcQSexwqGVSfzS042pzhiHESM+tv/in/2I8qMpOizy04Y8zxGgI+2zfWuKcbFUzlqLLvugnEAZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727550; c=relaxed/simple;
	bh=loM0lFlVsTE7xxzeJYMgK5odLypGtPcUIzHWSItRWrc=;
	h=To:Message-Id:Content-Type:From:Mime-Version:Subject:Date:
	 In-Reply-To:References; b=fuzDwEk6HAZkZXZLCNlLnBHbEJLYrnbS3BuOQmcWQRZZXHAnbBOpmxqeqd/d26Z9c6Tl0KwRxMq6mii+SCzggqX7FonvXuiErfRlsxBfeZgAdEEi0HW6J2DHsm37haI0tz+4RM2qeDYLzfV1fBrixG2y8Bg7XkBBeI0iyImpR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ZpBgpWuZ; arc=none smtp.client-ip=101.36.218.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ZpBgpWuZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763727465;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=loM0lFlVsTE7xxzeJYMgK5odLypGtPcUIzHWSItRWrc=;
 b=ZpBgpWuZae+ABETOUoIj2gbSxdjg/3gxp3ZN+L9doMNMa2ZUiCHSXVw2rmPWnOjJRsmzkS
 Z2TJit49ndaJedTchPuSGuDzxgopfyYGjXOuyBRBR+BHnfdgp6xdfH0AUb4IkqEJ01AxgF
 tJh9P54HZFgvutyOvlboKOXM45kkh8c9jRFY4+MrfQ1hxGW8VnoQtbs6iTlRsQCQwhXDhr
 0TrafI3zeu8WOtTzk012L2/K8jz9JQdQtDC0Kv0gSVU2PsswTLxbq5TW6dyhopjjGR+L1A
 oE309AEBQDChDbQaVoFcjlOjYjiraIkh/BQH0MTNgA/XBj0dzgjF2JaoT7BSmA==
X-Lms-Return-Path: <lba+269205868+788933+vger.kernel.org+yukuai@fnnas.com>
Organization: fnnas
Content-Transfer-Encoding: quoted-printable
To: "Hannes Reinecke" <hare@suse.de>, <axboe@kernel.dk>, 
	<nilay@linux.ibm.com>, <bvanassche@acm.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
Message-Id: <ca0d1a5f-3427-4833-aa50-f74c0bde52e1@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 21 Nov 2025 20:17:43 +0800
Subject: Re: [PATCH v6 4/8] blk-mq: add a new queue sysfs attribute async_depth
Date: Fri, 21 Nov 2025 20:17:42 +0800
In-Reply-To: <bf84ef70-9715-4722-b693-6e8519595b0c@suse.de>
References: <20251121052901.1341976-1-yukuai@fnnas.com> <20251121052901.1341976-5-yukuai@fnnas.com> <bf84ef70-9715-4722-b693-6e8519595b0c@suse.de>

Hi,

=E5=9C=A8 2025/11/21 15:14, Hannes Reinecke =E5=86=99=E9=81=93:
> On 11/21/25 06:28, Yu Kuai wrote:
>> Add a new field async_depth to request_queue and related APIs, this is
>> currently not used, following patches will convert elevators to use
>> this instead of internal async_depth.
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> =C2=A0 block/blk-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 block/blk-mq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ++++++
>> =C2=A0 block/blk-sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++=
++++++++++++++++++++++++++++++
>> =C2=A0 block/elevator.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 include/linux/blkdev.h |=C2=A0 1 +
>> =C2=A0 5 files changed, 51 insertions(+)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 14ae73eebe0d..cc5c9ced8e6f 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct=20
>> queue_limits *lim, int node_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_reclaim_release(GFP_KERNEL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->nr_requests =3D BLKDEV_DEFAULT_=
RQ;
>> +=C2=A0=C2=A0=C2=A0 q->async_depth =3D BLKDEV_DEFAULT_RQ;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return q;
>> =C2=A0 diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 6c505ebfab65..ae6ce68f4786 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4628,6 +4628,7 @@ int blk_mq_init_allocated_queue(struct=20
>> blk_mq_tag_set *set,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&q->requeue_lock);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->nr_requests =3D set->queue_dept=
h;
>> +=C2=A0=C2=A0=C2=A0 q->async_depth =3D set->queue_depth;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_init_cpu_queues(q, set->nr_=
hw_queues);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_map_swqueue(q);
>> @@ -4994,6 +4995,11 @@ struct elevator_tags=20
>> *blk_mq_update_nr_requests(struct request_queue *q,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->elevator->et =
=3D et;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Preserve relative value, both nr and async_d=
epth are at most=20
>> 16 bit
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * value, no need to worry about overflow.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 q->async_depth =3D max(q->async_depth * nr / q->nr_r=
equests, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->nr_requests =3D nr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (q->elevator && q->elevator->type->ops=
.depth_updated)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->elevator->type=
->ops.depth_updated(q);
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 8684c57498cc..5c2d29ac6570 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -127,6 +127,46 @@ queue_requests_store(struct gendisk *disk, const=20
>> char *page, size_t count)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +static ssize_t queue_async_depth_show(struct gendisk *disk, char=
=20
>> *page)
>> +{
>> +=C2=A0=C2=A0=C2=A0 guard(mutex)(&disk->queue->elevator_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 return queue_var_show(disk->queue->async_depth, page=
);
>> +}
>> +
>> +static ssize_t
>> +queue_async_depth_store(struct gendisk *disk, const char *page,=20
>> size_t count)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> +=C2=A0=C2=A0=C2=A0 unsigned int memflags;
>> +=C2=A0=C2=A0=C2=A0 unsigned long nr;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!queue_is_mq(q))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D queue_var_store(&nr, page, count);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (nr =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>> +=C2=A0=C2=A0=C2=A0 scoped_guard(mutex, &q->elevator_lock) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (q->elevator) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->a=
sync_depth =3D min(q->nr_requests, nr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
q->elevator->type->ops.depth_updated)
>> + q->elevator->type->ops.depth_updated(q);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t ret;
>> @@ -532,6 +572,7 @@ static struct queue_sysfs_entry _prefix##_entry =3D=
=20
>> {=C2=A0=C2=A0=C2=A0 \
>> =C2=A0 }
>> =C2=A0 =C2=A0 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
>> +QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
>> =C2=A0 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
>> =C2=A0 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
>> =C2=A0 QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
>> @@ -754,6 +795,7 @@ static struct attribute *blk_mq_queue_attrs[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &elv_iosched_entry.attr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &queue_requests_entry.attr,
>> +=C2=A0=C2=A0=C2=A0 &queue_async_depth_entry.attr,
>> =C2=A0 #ifdef CONFIG_BLK_WBT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &queue_wb_lat_entry.attr,
>> =C2=A0 #endif
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 5b37ef44f52d..5ff21075a84a 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -589,6 +589,7 @@ static int elevator_switch(struct request_queue=20
>> *q, struct elv_change_ctx *ctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_queue_flag_cl=
ear(QUEUE_FLAG_SQ_SCHED, q);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->elevator =3D N=
ULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->nr_requests =
=3D q->tag_set->queue_depth;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->async_depth =3D q->tag_se=
t->queue_depth;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_add_trace_msg(q, "elv switch: %s", ct=
x->name);
>> =C2=A0 diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index cdc68c41fa96..edddf17f8304 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -552,6 +552,7 @@ struct request_queue {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * queue settings
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nr_requests;=C2=A0=C2=A0=C2=A0 /* Max # of requests */
>> +=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 async_depth;=C2=A0=C2=A0=C2=A0 /* Max # of async requests */
>> =C2=A0 =C2=A0 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct blk_crypto_profile *crypto_profile=
;
>
> Hmm. Makes me wonder: async_depth is only used within the elevators, so
> maybe we should restrict visibility of that attribute when an elevator
> is selected?
> It feels kinda awkward having an attribute which does nothing if no
> elevator is loaded ...

To be honest, I can't think of how to implement this suitably, we'll have
to remove/create this entry while switching elevator, this doesn't seem
worth it to invent a new wheel.

>
> Cheers,
>
> Hannes

--=20
Thanks,
Kuai
