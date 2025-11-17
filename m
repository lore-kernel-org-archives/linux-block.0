Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCD2D8DCA
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380801; cv=none; b=Xnd0yrlyS4Oonn48UnqhWNA8cnAoMNGH6XZj9OITMt8/wkVcGD7N7jC98UGhjywgu5DnJx6LP+QjYszP0vThaD+vLoVQN0gPPybOGAK9OFlvDAckXJS6ga3DXkBachFeq3RWF9m4jgy7pWw6feG515/ttoA1OjIprgxig6xn/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380801; c=relaxed/simple;
	bh=ScAdWyzR+ifPRaS32GXMuhIx4ajy7jd/eosLdEmgUkg=;
	h=Message-Id:Mime-Version:To:From:Subject:Date:Content-Type:
	 In-Reply-To:References:Cc; b=c+O53W3sAwVcTQujhzn5h8GjoAQ2ZGrtFDQXIeRIPPGeKqCkb6gGPaKI6vRqUarSQxzBAHYFVIvrdSwCyZrmGfl44VcDGOa04zIfEKSjBVPCdsV6ZqNWkdgFgv8ZYJNfWfw6Gk2DDDArE6CtD0YDO6yg28DFgrD4aBEUoLzTSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=dSTAZKY9; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="dSTAZKY9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763380793;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cIWozImjZOMvOu+x5AhhTe+4yoSOYNaoWWmlOYGZVkk=;
 b=dSTAZKY9XZQzqZ2mnIcCnNmAelAPzYCjMeWrmBRLx2g1V1KfDmWbZyoVYeB97XntuFOop0
 2jI8i5xBG/TGYTMs+FCkT834J6ew2N8G3Mfp3LT5K3tBTs9N3bR4+kkVN64oFfB7zLDhyp
 S9dC1R8LCkj4AgegTV4H1F8HK1ZUmwHzqPDvK6a/l/wARN/+1qH4AIRsnmWGTTgowxdtMv
 52X2Otp97uY0DZ2q+iVtfx/+NZ/zvzLMaNu/KKB0rujJNAMvChOb3dTON5h881GnNFOaL4
 6o5Ae+xmp0FVNDCmqVWXpwMqXxoGZjoI8Gp6gOhM7K47D39nxQwnFxf5sdUwXQ==
Reply-To: yukuai@fnnas.com
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Message-Id: <c03dbc61-6df0-4640-adc7-2e6d01ad42b9@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Ming Lei" <ming.lei@redhat.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper rq_qos_add_freezed()
Date: Mon, 17 Nov 2025 19:59:49 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <aRsM34hifFrUNe6w@fedora>
X-Lms-Return-Path: <lba+2691b0e37+a0040e+vger.kernel.org+yukuai@fnnas.com>
References: <20251116041024.120500-1-yukuai@fnnas.com> <20251116041024.120500-2-yukuai@fnnas.com> <aRsAdF3GxNJ3Q1Qv@fedora> <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com> <aRsHVyvL8sMrmDlt@fedora> <8cca91f6-cfe2-4ef7-a072-dd48c3ee243b@fnnas.com> <aRsM34hifFrUNe6w@fedora>
Cc: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<tj@kernel.org>, "Yu Kuai" <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Organization: fnnas
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Mon, 17 Nov 2025 19:59:50 +0800

Hi,

=E5=9C=A8 2025/11/17 19:54, Ming Lei =E5=86=99=E9=81=93:
> On Mon, Nov 17, 2025 at 07:39:57PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> =E5=9C=A8 2025/11/17 19:30, Ming Lei =E5=86=99=E9=81=93:
>>> On Mon, Nov 17, 2025 at 04:43:11PM +0530, Nilay Shroff wrote:
>>>> On 11/17/25 4:31 PM, Ming Lei wrote:
>>>>> On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
>>>>>> queue should not be freezed under rq_qos_mutex, see example index
>>>>>> commit 9730763f4756 ("block: correct locking order for protecting bl=
k-wbt
>>>>>> parameters"), which means current implementation of rq_qos_add() is
>>>>>> problematic. Add a new helper and prepare to fix this problem in
>>>>>> following patches.
>>>>>>
>>>>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>>>>> ---
>>>>>>    block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
>>>>>>    block/blk-rq-qos.h |  2 ++
>>>>>>    2 files changed, 29 insertions(+)
>>>>>>
>>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>>>> index 654478dfbc20..353397d7e126 100644
>>>>>> --- a/block/blk-rq-qos.c
>>>>>> +++ b/block/blk-rq-qos.c
>>>>>> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
>>>>>>    	mutex_unlock(&q->rq_qos_mutex);
>>>>>>    }
>>>>>>   =20
>>>>>> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
>>>>>> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
>>>>>> +{
>>>>>> +	struct request_queue *q =3D disk->queue;
>>>>>> +
>>>>>> +	WARN_ON_ONCE(q->mq_freeze_depth =3D=3D 0);
>>>>>> +	lockdep_assert_held(&q->rq_qos_mutex);
>>>>>> +
>>>>>> +	if (rq_qos_id(q, id))
>>>>>> +		return -EBUSY;
>>>>>> +
>>>>>> +	rqos->disk =3D disk;
>>>>>> +	rqos->id =3D id;
>>>>>> +	rqos->ops =3D ops;
>>>>>> +	rqos->next =3D q->rq_qos;
>>>>>> +	q->rq_qos =3D rqos;
>>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>> +
>>>>>> +	if (rqos->ops->debugfs_attrs) {
>>>>>> +		mutex_lock(&q->debugfs_mutex);
>>>>>> +		blk_mq_debugfs_register_rqos(rqos);
>>>>>> +		mutex_unlock(&q->debugfs_mutex);
>>>>>> +	}
>>>>> It will cause more lockdep splat to let q->debugfs_mutex depend on qu=
eue freeze,
>>>>>
>>>> I think we already have that ->debugfs_mutex dependency on ->freeze_lo=
ck.
>>>> for instance,
>>>>     ioc_qos_write  =3D> freeze-queue
>>>>      blk_iocost_init
>>>>        rq_qos_add
>>> Why is queue freeze needed in above code path?
>>>
>>> Also blk_iolatency_init()/rq_qos_add() doesn't freeze queue.
>> I don't quite understand, rq_qos_add() always require queue freeze, prev=
ent
>> deference q->rq_qos from IO path concurrently.
>>
>>>> and also,
>>>>     queue_wb_lat_store  =3D> freeze-queue
>>>>       wbt_init
>>>>         rq_qos_add
>>> Not all wbt_enable_default()/wbt_init() is called with queue frozen, bu=
t Kuai's
>>> patchset changes all to freeze queue before registering debugfs entry, =
people will
>>> complain new warning.
>> Yes, but the same as above, rq_qos_add() from wbt_init() will always fre=
eze queue
>> before this set, so I don't understand why is there new warning?
> The in-tree rq_qos_add() registers debugfs after queue is unfreeze, but
> your patchset basically moves queue freeze/unfreeze to callsite of rq_qos=
_add(),
> then debugfs register is always done with queue frozen.
>
> Dependency between queue freeze and q->debugfs_mutex is introduced in som=
e
> code paths, such as, elevator switch, blk_iolatency_init, ..., this way
> will trigger warning because it isn't strange to run into memory
> allocation in debugfs_create_*().

Yes, I realized I do misunderstand in previous email.

>
>>>>> Also blk_mq_debugfs_register_rqos() does _not_ require queue to be fr=
ozen,
>>>>> and it should be fine to move blk_mq_debugfs_register_rqos() out of q=
ueue
>>>>> freeze.
>>>>>
>>>> Yes correct, but I thought this pacthset is meant only to address inco=
rrect
>>>> locking order between ->rq_qos_mutex and ->freeze_lock. So do you sugg=
est
>>>> also refactoring code to avoid ->debugfs_mutex dependency on ->freeze_=
lock?
>>>> If yes then shouldn't that be handled in a separate patchset?
>>> It is fine to fix in that way, but at least regression shouldn't be cau=
sed.
>>>
>>> More importantly we shouldn't add new unnecessary dependency on queue f=
reeze.
>> This is correct, I'll work on the v2 set to move debugfs_mutex outside o=
f freeze
>> queue, however, as you suggested before we should we should fix this inc=
orrect
>> lock order first. How about I make them in a single set?
> That is fine, but patches for moving debugfs_mutex should be put before
> this patchset, which is always friendly for 'git bisect'.

Sounds good :)

Thanks,
Kuai

>
>
> Thanks,
> Ming
>
>
