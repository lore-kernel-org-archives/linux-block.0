Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B86946C
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209408; cv=none; b=nem0EYKl+o3uTYvrzrN8h0dPvVXG1Kl98iIeMmdwZyY9NJgg4BXphdoZZS3w4NWNDvmm9rm9YeNCwnjSj5JH3IQx81ArWJlLd6A+02QXJaQuVZHT+42fhSGVrkF0C2R4w+gPzG3Fn1Py+HRoCAZAE77Z5I4Se1ZDG9jV5O4l7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209408; c=relaxed/simple;
	bh=p+uER8WuyRRVzNg+EdwdAt76d59KYQ0wTK9immabVpo=;
	h=From:Subject:To:Mime-Version:References:Date:In-Reply-To:
	 Content-Type:Message-Id; b=T4W3V6QOPwYPeDM1vrd7lR0c8vVDu37rhq8LL4ThetzD6VjQN6ugiRCNwgm2LzaWLSl2+Q9hXGKRP45Z8g0uEeOnZOAQtd3f69EpzyQ6VmL2ON6fLIyHYg8COe9Oo64I9p5JjNXSz6IVKh4FdxmzUUIYXEFOMbuQeMEjI5Be9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=yC81uHX+; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="yC81uHX+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768209392;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=p+uER8WuyRRVzNg+EdwdAt76d59KYQ0wTK9immabVpo=;
 b=yC81uHX+1wihZv9Dfh9Ct54D6ZWnjAW1CliJk9Q+ER6yhkLTUNA9vmM5oZmOYp3k1xnD68
 XTpefslfr6TQFTR8Dt/1DAsTn99NrQW6IFHJT4TlEjQnA4sK45Q+sVwCCcgdUHWsLKFH+o
 JqTMcPqC+13D2UbvdmUQgtNuK1GWH5ZHwy6jNDwa/y0vlQfN84XyD6HNYWq7tpq35sdoto
 IUPYiKmAaQKWmB3/dzTrgcxORlz77MN8FpQLI2Kbn2G0Ak9gDNSpr9gcDmawAMkCtIF3rO
 ea6i1lElgTWbodyC5m/GoChvN/qm5GxkD2SSSnrfuXOqFAks25/ZfoydRSPVAA==
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v8 2/8] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Mon, 12 Jan 2026 17:16:30 +0800
X-Lms-Return-Path: <lba+26964bbef+9eb808+vger.kernel.org+yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Hannes Reinecke" <hare@suse.de>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260109065230.653281-1-yukuai@fnnas.com> <20260109065230.653281-3-yukuai@fnnas.com> <b6110ffc-f999-49a1-8a7e-ce51af51e211@suse.de>
Date: Mon, 12 Jan 2026 17:16:29 +0800
In-Reply-To: <b6110ffc-f999-49a1-8a7e-ce51af51e211@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <25dc9258-30af-4132-bd38-ba055ed61005@fnnas.com>
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com

Hi=EF=BC=8C

=E5=9C=A8 2026/1/12 15:38, Hannes Reinecke =E5=86=99=E9=81=93:
> On 1/9/26 07:52, Yu Kuai wrote:
>> If wbt is disabled by default and user configures wbt by sysfs, queue
>> will be frozen first and then pcpu_alloc_mutex will be held in
>> blk_stat_alloc_callback().
>>
>> Fix this problem by allocating memory first before queue frozen.
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> ---
>> =C2=A0 block/blk-wbt.c | 108 ++++++++++++++++++++++++++++---------------=
-----
>> =C2=A0 1 file changed, 63 insertions(+), 45 deletions(-)
>>
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index abc2190689bb..9bef71ec645d 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -93,7 +93,7 @@ struct rq_wb {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq_depth rq_depth;
>> =C2=A0 };
>> =C2=A0 -static int wbt_init(struct gendisk *disk);
>> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
>> =C2=A0 =C2=A0 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
>> =C2=A0 {
>> @@ -698,6 +698,41 @@ static void wbt_requeue(struct rq_qos *rqos,=20
>> struct request *rq)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 +static int wbt_data_dir(const struct request *rq)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const enum req_op op =3D req_op(rq);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (op =3D=3D REQ_OP_READ)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return READ;
>> +=C2=A0=C2=A0=C2=A0 else if (op_is_write(op))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return WRITE;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* don't account */
>> +=C2=A0=C2=A0=C2=A0 return -1;
>> +}
>> +
>> +static struct rq_wb *wbt_alloc(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb =3D kzalloc(sizeof(*rwb), GFP_KERN=
EL);
>> +> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index e0a70d26972b..a580688c3ad5 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -636,11 +636,8 @@ static ssize_t queue_wb_lat_show(struct gendisk=20
>> *disk, char *page)
>> =C2=A0 static ssize_t queue_wb_lat_store(struct gendisk *disk, const cha=
r=20
>> *page,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t count)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> -=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 val;
>> -=C2=A0=C2=A0=C2=A0 unsigned int memflags;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D queue_var_store64(&val, pa=
ge);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> @@ -648,40 +645,8 @@ static ssize_t queue_wb_lat_store(struct gendisk=20
>> *disk, const char *page,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val < -1)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that the queue is idled, in case the =
latency update
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * ends up either enabling or disabling wbt com=
pletely. We can't
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * have IO inflight if that happens.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>> -
>> -=C2=A0=C2=A0=C2=A0 rqos =3D wbt_rq_qos(q);
>> -=C2=A0=C2=A0=C2=A0 if (!rqos) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D wbt_init(disk);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 ret =3D count;
>> -=C2=A0=C2=A0=C2=A0 if (val =3D=3D -1)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D wbt_default_latency_=
nsec(q);
>> -=C2=A0=C2=A0=C2=A0 else if (val >=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val *=3D 1000ULL;
>> -
>> -=C2=A0=C2=A0=C2=A0 if (wbt_get_min_lat(q) =3D=3D val)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> -
>> -=C2=A0=C2=A0=C2=A0 blk_mq_quiesce_queue(q);
>> -
>> -=C2=A0=C2=A0=C2=A0 mutex_lock(&disk->rqos_state_mutex);
>> -=C2=A0=C2=A0=C2=A0 wbt_set_min_lat(q, val);
>> -=C2=A0=C2=A0=C2=A0 mutex_unlock(&disk->rqos_state_mutex);
>> -
>> -=C2=A0=C2=A0=C2=A0 blk_mq_unquiesce_queue(q);
>> -out:
>> -=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>> -
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 ret =3D wbt_set_lat(disk, val);
>> +=C2=A0=C2=A0=C2=A0 return ret ? ret : count;
>> =C2=A0 }
>> =C2=A0 =C2=A0 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 0974875f77bd..abc2190689bb 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -93,6 +93,8 @@ struct rq_wb {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq_depth rq_depth;
>> =C2=A0 };
>> =C2=A0 +static int wbt_init(struct gendisk *disk);
>> +
>> =C2=A0 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return container_of(rqos, struct rq_wb, r=
qos);
>> @@ -506,7 +508,7 @@ u64 wbt_get_min_lat(struct request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RQWB(rqos)->min_lat_nsec;
>> =C2=A0 }
>> =C2=A0 -void wbt_set_min_lat(struct request_queue *q, u64 val)
>> +static void wbt_set_min_lat(struct request_queue *q, u64 val)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos =3D wbt_rq_qos(q);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rqos)
>> @@ -741,7 +743,7 @@ void wbt_init_enable_default(struct gendisk *disk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(wbt_=
init(disk));
>> =C2=A0 }
>> =C2=A0 -u64 wbt_default_latency_nsec(struct request_queue *q)
>> +static u64 wbt_default_latency_nsec(struct request_queue *q)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We default to 2msec for non-rotat=
ional storage, and 75msec
>> @@ -902,7 +904,7 @@ static const struct rq_qos_ops wbt_rqos_ops =3D {
>> =C2=A0 #endif
>> =C2=A0 };
>> =C2=A0 -int wbt_init(struct gendisk *disk)
>> +static int wbt_init(struct gendisk *disk)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb;
>> @@ -949,3 +951,45 @@ int wbt_init(struct gendisk *disk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 =C2=A0 }
>> +
>> +int wbt_set_lat(struct gendisk *disk, s64 val)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> +=C2=A0=C2=A0=C2=A0 unsigned int memflags;
>> +=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that the queue is idled, in case the =
latency update
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ends up either enabling or disabling wbt com=
pletely. We can't
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * have IO inflight if that happens.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>> +
>> +=C2=A0=C2=A0=C2=A0 rqos =3D wbt_rq_qos(q);
>> +=C2=A0=C2=A0=C2=A0 if (!rqos) {
>
> Isn't 'if (!wbt_rq_qos(q))' sufficient here?
> 'rqos' is never used, and might even trigger an 'unused variable'
> compiler warning ...

Yes

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D wbt_init(disk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (val =3D=3D -1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D wbt_default_latency_=
nsec(q);
>> +=C2=A0=C2=A0=C2=A0 else if (val >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val *=3D 1000ULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (wbt_get_min_lat(q) =3D=3D val)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +
>> +=C2=A0=C2=A0=C2=A0 blk_mq_quiesce_queue(q);
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&disk->rqos_state_mutex);
>> +=C2=A0=C2=A0=C2=A0 wbt_set_min_lat(q, val);
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&disk->rqos_state_mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 blk_mq_unquiesce_queue(q);
>> +out:
>> +=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
>> index 925f22475738..6e39da17218b 100644
>> --- a/block/blk-wbt.h
>> +++ b/block/blk-wbt.h
>> @@ -4,16 +4,13 @@
>> =C2=A0 =C2=A0 #ifdef CONFIG_BLK_WBT
>> =C2=A0 -int wbt_init(struct gendisk *disk);
>> =C2=A0 void wbt_init_enable_default(struct gendisk *disk);
>> =C2=A0 void wbt_disable_default(struct gendisk *disk);
>> =C2=A0 void wbt_enable_default(struct gendisk *disk);
>> =C2=A0 =C2=A0 u64 wbt_get_min_lat(struct request_queue *q);
>> -void wbt_set_min_lat(struct request_queue *q, u64 val);
>> -bool wbt_disabled(struct request_queue *);
>> -
>> -u64 wbt_default_latency_nsec(struct request_queue *);
>> +bool wbt_disabled(struct request_queue *q);
>> +int wbt_set_lat(struct gendisk *disk, s64 val);
>> =C2=A0 =C2=A0 #else
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!rwb)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 rwb->cb =3D blk_stat_alloc_callback(wb_timer_fn, wbt=
_data_dir, 2,=20
>> rwb);
>> +=C2=A0=C2=A0=C2=A0 if (!rwb->cb) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(rwb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return rwb;
>> +}
>> +
>> +static void wbt_free(struct rq_wb *rwb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 blk_stat_free_callback(rwb->cb);
>> +=C2=A0=C2=A0=C2=A0 kfree(rwb);
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Enable wbt if defaults are configured that way
>> =C2=A0=C2=A0 */
>> @@ -739,8 +774,17 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
>> =C2=A0 =C2=A0 void wbt_init_enable_default(struct gendisk *disk)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (__wbt_enable_default(disk))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(wbt_init(disk))=
;
>> +=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!__wbt_enable_default(disk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 rwb =3D wbt_alloc();
>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!rwb))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(wbt_init(disk, rwb)))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wbt_free(rwb);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static u64 wbt_default_latency_nsec(struct request_queue *=
q)
>> @@ -755,19 +799,6 @@ static u64 wbt_default_latency_nsec(struct=20
>> request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 75000000UL=
L;
>> =C2=A0 }
>> =C2=A0 -static int wbt_data_dir(const struct request *rq)
>> -{
>> -=C2=A0=C2=A0=C2=A0 const enum req_op op =3D req_op(rq);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (op =3D=3D REQ_OP_READ)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return READ;
>> -=C2=A0=C2=A0=C2=A0 else if (op_is_write(op))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return WRITE;
>> -
>> -=C2=A0=C2=A0=C2=A0 /* don't account */
>> -=C2=A0=C2=A0=C2=A0 return -1;
>> -}
>> -
>> =C2=A0 static void wbt_queue_depth_changed(struct rq_qos *rqos)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RQWB(rqos)->rq_depth.queue_depth =3D=20
>> blk_queue_depth(rqos->disk->queue);
>> @@ -779,8 +810,7 @@ static void wbt_exit(struct rq_qos *rqos)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb =3D RQWB(rqos);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_stat_remove_callback(rqos->dis=
k->queue, rwb->cb);
>> -=C2=A0=C2=A0=C2=A0 blk_stat_free_callback(rwb->cb);
>> -=C2=A0=C2=A0=C2=A0 kfree(rwb);
>> +=C2=A0=C2=A0=C2=A0 wbt_free(rwb);
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> @@ -904,22 +934,11 @@ static const struct rq_qos_ops wbt_rqos_ops =3D {
>> =C2=A0 #endif
>> =C2=A0 };
>> =C2=A0 -static int wbt_init(struct gendisk *disk)
>> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> -=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb;
>> -=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -
>> -=C2=A0=C2=A0=C2=A0 rwb =3D kzalloc(sizeof(*rwb), GFP_KERNEL);
>> -=C2=A0=C2=A0=C2=A0 if (!rwb)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> -
>> -=C2=A0=C2=A0=C2=A0 rwb->cb =3D blk_stat_alloc_callback(wb_timer_fn, wbt=
_data_dir, 2,=20
>> rwb);
>> -=C2=A0=C2=A0=C2=A0 if (!rwb->cb) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(rwb);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < WBT_NUM_RWQ; i++=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq_wait_init(&rwb=
->rq_wait[i]);
>> @@ -939,38 +958,38 @@ static int wbt_init(struct gendisk *disk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D rq_qos_add(&rwb->rqos, disk, RQ_Q=
OS_WBT, &wbt_rqos_ops);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->rq_qos_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_stat_add_callback(q, rwb->cb);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> -
>> -err_free:
>> -=C2=A0=C2=A0=C2=A0 blk_stat_free_callback(rwb->cb);
>> -=C2=A0=C2=A0=C2=A0 kfree(rwb);
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> -
>> =C2=A0 }
>> =C2=A0 =C2=A0 int wbt_set_lat(struct gendisk *disk, s64 val)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> +=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos =3D wbt_rq_qos(q);
>> +=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int memflags;
>> -=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!rqos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rwb =3D wbt_alloc();
>
> Similar here...
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rwb)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that the queue is idled, i=
n case the latency update
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ends up either enabling or disabl=
ing wbt completely. We can't
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have IO inflight if that happens.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memflags =3D blk_mq_freeze_queue(q);
>> -
>> -=C2=A0=C2=A0=C2=A0 rqos =3D wbt_rq_qos(q);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rqos) {
>
> Huh? Am I reading this correctly that we have
> two calls for 'if (!rqos)' after this change?
> That looks odd ...

Because if wbt is initialized, it will never be freed until disk removal.
The first check is used to allocate memory before queue frozen. The second
check is used to initialize wbt.

>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D wbt_init(disk);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D wbt_init(disk, rwb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wbt_=
free(rwb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val =3D=3D -1)
>> @@ -990,6 +1009,5 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_unquiesce_queue(q);
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(q, memflags);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>
> Cheers,
>
> Hannes

--=20
Thansk,
Kuai
