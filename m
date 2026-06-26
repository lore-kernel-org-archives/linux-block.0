Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BF48CFC
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438774; cv=none; b=pR3pDrg06QkVP23FcDpOoJecFPCcBXIARdOrakTaZhevb0VQndNsTIlDt7wVqSKL8JQNemVRt1AGcq6ZanP5VXZBa1oifZ+Kamv/AXcCJWChPFCDipuCrj7LeqRNyTXKybYXupY8JI0s5+ZH9cjPBgvBW8tLHZmn1ep4xsnmksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438774; c=relaxed/simple;
	bh=+/WAlLUYrz7tyLTHNwaqj0AveS0acL2JC+wZkxWT9zo=;
	h=Mime-Version:In-Reply-To:To:From:Subject:Message-Id:Content-Type:
	 References:Cc:Date; b=TnnIUHjDCHT6ovR8515//3N4pDvz9w/hqm1vgZIzVtv3ymPcK0Mt3DUoC+yq559FZAePUhr9vsy9qtftwNE2JziHB/nA0rhsObcmQJBT8KC//rroLKrZ0f7Rqnk+mAQmkafAZt7sMGX5WSQ8M43X9+4Po8k/GxhvFGUOLV0bSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=LGujZFHT; arc=none smtp.client-ip=209.127.231.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="LGujZFHT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782438759;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uJQCt90HbiUJ/J7L6Qv7Yed3QW//1eI/IRidisxAhrY=;
 b=LGujZFHTrsulr+5de9KUlBVbwZuOL3E2gRm/TebEHNZyBB8LoKM0KI6wtsdX0pc9LO+jZi
 WtQ6SrLzkmawsnn3jnnlW5MQOtZJaUnUmi94IvZP4LOU7th8AVqw+8e5P6ZiZIANwDjRoG
 FKbFIMqbRu4QiqVkvePZvSopCFP9CcKQjPswNLt6gqIsI7K62KBXT3Js40dgcfkocUYka+
 a/bOT7CKKTvJPCYsqWHPlmm1UZzQu4MiQvBoNME+EKHQDVfLrvZ0kQIys4wL2I30KyG+2q
 RStwemVeVw7X+vX5SWpgT7QByx1pbY3Ydgp6hCLpmmVtwIPFYhkgRMTamHVYWA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
Content-Transfer-Encoding: quoted-printable
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and blkg destruction
Reply-To: yukuai@fygo.io
X-Lms-Return-Path: <lba+26a3ddb66+a7157d+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Fri, 26 Jun 2026 01:52:37 +0000
Message-Id: <749d17be-ff9f-4f70-a948-0133f02eec93@fygo.io>
Content-Type: text/plain; charset=UTF-8
References: <20260624064625.1743650-1-yukuai@kernel.org> <20260624064625.1743650-5-yukuai@kernel.org> <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com> <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
Cc: "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Christoph Hellwig" <hch@lst.de>, "Tang Yizhou" <yizhou.tang@shopee.com>, 
	"Ming Lei" <ming.lei@redhat.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fygo.io>
Date: Fri, 26 Jun 2026 09:52:34 +0800

Hi,

=E5=9C=A8 2026/6/26 9:50, yu kuai =E5=86=99=E9=81=93:
> Hi,
>
> =E5=9C=A8 2026/6/25 23:08, Nilay Shroff =E5=86=99=E9=81=93:
>> On 6/24/26 12:16 PM, Yu Kuai wrote:
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 7baccfb690fe..f7e788a7fe95 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk
>>> *disk, const struct blkcg_policy *pol)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pol->pd_alloc_fn || !=
pol->pd_free_fn))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memflags =3D bl=
k_mq_freeze_queue(q);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&q->blkcg_mutex);
>>>  =C2=A0 retry:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&q->queue_lock);
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* blkg_list is pushed at the he=
ad, reverse walk to
>>> initialize parents first */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_reverse(blkg, &q->b=
lkg_list, q_node) {
>>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk
>>> *disk, const struct blkcg_policy *pol)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(pol->plid, q->blkcg_pols);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&q->queue_lock);
>>>  =C2=A0 out:
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->blkcg_mutex);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze=
_queue(q, memflags);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pinned_blkg)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkg_put(pinned=
_blkg);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pd_prealloc)
>> If the policy allocation fails, we jump to the lable enomem: and
>> teardown pds.
>> But I see this path still only acquires ->queue_lock. Don't we also need
>> to protect it with ->blkcg_mutex?
> Yes, I agree we should protect it as well.

Just take a closer look at the code, the enomem is already protected by
blkcg_mutex :)

>
>> Moreover I still see race between blkg insertion in blkg_create() which
>> still doesn't use ->blkcg_mutex and so list traversal in
>> bfq_end_wr_async()
>> may still race with blkg_create(), isn't it? I remember you once told
>> this will be handled in another series but I couldn't find that yet.
> This is the set:
>
> [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu
> Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>
>
> Noted that set just make sure queue_lock is not nested under other atomic
> context, and that set do not acquire blkcg_mutex for blkg_create() yet. H=
owerver,
> with that set it'll be easy to convert all queue_lock to blkcg_mtuex for =
blkg
> protection, and together with lots of blk-cgroup code cleanups.
>
>
>> Thanks,
>> --Nilay
>>
>>
>>
>>
--=20
Thanks,
Kuai
