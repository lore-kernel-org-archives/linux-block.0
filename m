Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58E2D47FF
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379616; cv=none; b=dsMNnVf2cYpHAb7k1tLCcYQyt3XeF4eRTSvHwunzRl9SlND+NzuG+tDFH8/SnuKlzcuYCgJFcNC++4El2mixYt+KmK8pTPY1JPfOIONg3fSBYR+8MjWqSaHmkpuWm0Am035038je+csmcFwRICaY1yx0CvDiR6rRbjRtdYqaxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379616; c=relaxed/simple;
	bh=kqQfKSR+qRG5Csh+GFo9xw6k0Pz9+rguIawQptE3eR8=;
	h=Content-Type:Subject:Mime-Version:Message-Id:To:Cc:From:Date:
	 In-Reply-To:References; b=Z+7Yxpcmiog+0AK0SsP8cESC3B3vboSwLZqltEhayaCx1ikt7W7lb3zpKgPuZ4VOfU98ldRjyRXexi9D8FKrK1fGjrTwxOyVqxVgCOAzOMv/S3iYJDVPQ1DRp5aNhWqHUXi3Kan8YBUw36Pc9tzWvmUWFY8hZ68qFYYKFZCeDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=BjlXbtTA; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="BjlXbtTA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763379602;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3Qfm6dB2l9gh4+qoNtEfzT86BmK7pHpPHzt4nJ9SH/o=;
 b=BjlXbtTA0coYb5k/l2ZuPN3OjJ9cVlOJe6axokdr443L8+tN8mcuBo9YMVWzVKi8WbUTVa
 poddC8qdoAWAgKIBlTpeTzr+xHKsPssRWB655aD+CJ7Ewt4TSTmelYft9XdyZ6dKjwAdj2
 6vT+riIrtHwG8wMH90vXu0LtPc8JyG9Gl72pRFyMBtXa0jzgkOldNqGia599pIwzH0VZVR
 BSa9HPIzcCKwtllslg5Ov+QtKTMrGCObON7xWd21/utcv+W3oCCnUtuHn+CEQvfEIFjRNS
 LEbeqYuvqbjJxvSldHTNQrwAOkzN+FZXjD8xUkFpG++ZXeAO9P11n31OklYZAQ==
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper rq_qos_add_freezed()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Mon, 17 Nov 2025 19:39:59 +0800
Message-Id: <8cca91f6-cfe2-4ef7-a072-dd48c3ee243b@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Language: en-US
X-Lms-Return-Path: <lba+2691b0990+3db064+vger.kernel.org+yukuai@fnnas.com>
To: "Ming Lei" <ming.lei@redhat.com>, "Nilay Shroff" <nilay@linux.ibm.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 17 Nov 2025 19:39:57 +0800
In-Reply-To: <aRsHVyvL8sMrmDlt@fedora>
Content-Transfer-Encoding: quoted-printable
References: <20251116041024.120500-1-yukuai@fnnas.com> <20251116041024.120500-2-yukuai@fnnas.com> <aRsAdF3GxNJ3Q1Qv@fedora> <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com> <aRsHVyvL8sMrmDlt@fedora>
Organization: fnnas

Hi,

=E5=9C=A8 2025/11/17 19:30, Ming Lei =E5=86=99=E9=81=93:
> On Mon, Nov 17, 2025 at 04:43:11PM +0530, Nilay Shroff wrote:
>>
>> On 11/17/25 4:31 PM, Ming Lei wrote:
>>> On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
>>>> queue should not be freezed under rq_qos_mutex, see example index
>>>> commit 9730763f4756 ("block: correct locking order for protecting blk-=
wbt
>>>> parameters"), which means current implementation of rq_qos_add() is
>>>> problematic. Add a new helper and prepare to fix this problem in
>>>> following patches.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>>> ---
>>>>   block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
>>>>   block/blk-rq-qos.h |  2 ++
>>>>   2 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>> index 654478dfbc20..353397d7e126 100644
>>>> --- a/block/blk-rq-qos.c
>>>> +++ b/block/blk-rq-qos.c
>>>> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
>>>>   	mutex_unlock(&q->rq_qos_mutex);
>>>>   }
>>>>  =20
>>>> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
>>>> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
>>>> +{
>>>> +	struct request_queue *q =3D disk->queue;
>>>> +
>>>> +	WARN_ON_ONCE(q->mq_freeze_depth =3D=3D 0);
>>>> +	lockdep_assert_held(&q->rq_qos_mutex);
>>>> +
>>>> +	if (rq_qos_id(q, id))
>>>> +		return -EBUSY;
>>>> +
>>>> +	rqos->disk =3D disk;
>>>> +	rqos->id =3D id;
>>>> +	rqos->ops =3D ops;
>>>> +	rqos->next =3D q->rq_qos;
>>>> +	q->rq_qos =3D rqos;
>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>> +
>>>> +	if (rqos->ops->debugfs_attrs) {
>>>> +		mutex_lock(&q->debugfs_mutex);
>>>> +		blk_mq_debugfs_register_rqos(rqos);
>>>> +		mutex_unlock(&q->debugfs_mutex);
>>>> +	}
>>> It will cause more lockdep splat to let q->debugfs_mutex depend on queu=
e freeze,
>>>
>> I think we already have that ->debugfs_mutex dependency on ->freeze_lock=
.
>> for instance,
>>    ioc_qos_write  =3D> freeze-queue
>>     blk_iocost_init
>>       rq_qos_add
> Why is queue freeze needed in above code path?
>
> Also blk_iolatency_init()/rq_qos_add() doesn't freeze queue.

I don't quite understand, rq_qos_add() always require queue freeze, prevent
deference q->rq_qos from IO path concurrently.

>
>> and also,
>>    queue_wb_lat_store  =3D> freeze-queue
>>      wbt_init
>>        rq_qos_add
> Not all wbt_enable_default()/wbt_init() is called with queue frozen, but =
Kuai's
> patchset changes all to freeze queue before registering debugfs entry, pe=
ople will
> complain new warning.

Yes, but the same as above, rq_qos_add() from wbt_init() will always freeze=
 queue
before this set, so I don't understand why is there new warning?

>
>>> Also blk_mq_debugfs_register_rqos() does _not_ require queue to be froz=
en,
>>> and it should be fine to move blk_mq_debugfs_register_rqos() out of que=
ue
>>> freeze.
>>>
>> Yes correct, but I thought this pacthset is meant only to address incorr=
ect
>> locking order between ->rq_qos_mutex and ->freeze_lock. So do you sugges=
t
>> also refactoring code to avoid ->debugfs_mutex dependency on ->freeze_lo=
ck?
>> If yes then shouldn't that be handled in a separate patchset?
> It is fine to fix in that way, but at least regression shouldn't be cause=
d.
>
> More importantly we shouldn't add new unnecessary dependency on queue fre=
eze.

This is correct, I'll work on the v2 set to move debugfs_mutex outside of f=
reeze
queue, however, as you suggested before we should we should fix this incorr=
ect
lock order first. How about I make them in a single set?

>
> Thanks,
> Ming
>
>
