Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F43D7D89
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034660; cv=none; b=QgIzOfF/ere/rT2PpQ15Mx2OKNTdJQiibCJPO7vlqC84urzCyBYFjZ9LtGtZjDqra8vtj66HG+Q4jxrqMsktJQ/zstHn0Ubwx1bS8PMhLBfY87acZLMacMWVPJHg9BY0Qt3tSMMQS85N3JdaqHkGm0vEE1hKDujgeQxm126j0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034660; c=relaxed/simple;
	bh=pkVOD0eCRZIymdTyz41IN+4HPrww708w73WlG6rWSYA=;
	h=In-Reply-To:Cc:References:Content-Type:To:From:Subject:Date:
	 Mime-Version:Message-Id; b=cS1zDYi6+tflpHo4TDi5mMTwiOaZ4oWwbl6Mg2s2TtADB4z5XoN4sujWrKAzrcn3eo/L8h7powVSVU/rVWh0KTbaz4ogQzkGtQwMtbW04o5sMXCXYGke4egGHloHgnMDRgq3nBz5YJO9Sr3AgQuuNeA6AMRe8Oo4QIRGOU3vv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=q1S01wZt; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="q1S01wZt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1772034644;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=LXDma3vsb4q0KCMIrkMBaUr+IRBe58Upuc3EAUQaOUg=;
 b=q1S01wZtJsOqKBeNco+WjJNGAlAIZ1uweQQ71Y+z7VaEDjmWsIZPIy+hHiNHwPMyavdscG
 kL0qi8Cqv7qmLZxydTReziqb930uW3Ptt17EwQVWOp6pXtpc3kGzKwF1ZbShyFoqHb6MQC
 90y2G14f9g3LIPAqfTsikpo7W0WMLh5dnfakCVruowt/10AgoxGbGPNWZxwz41u/EvxZK9
 n08r4/Gth2s85lnUs4hGy0bWpUwWb8qmwFV9vUGE2DhxRHYQ2UQI+JG3bgRr750GRvof1l
 e6Be0+MPw4E3ujSB+ufu17IhaYzVqjHuV+V5yCjmLOWLJ5n373NDEHXtSXaeOw==
In-Reply-To: <20260225124556.1152510-1-nilay@linux.ibm.com>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <ming.lei@redhat.com>, 
	<yi.zhang@redhat.com>, <shinichiro.kawasaki@wdc.com>, <gjoyce@ibm.com>, 
	<yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Wed, 25 Feb 2026 23:50:41 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
References: <20260225124556.1152510-1-nilay@linux.ibm.com>
Reply-To: yukuai@fnnas.com
X-Lms-Return-Path: <lba+2699f1a52+2a791f+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH] block: break pcpu_alloc_mutex dependency on freeze_lock
Date: Wed, 25 Feb 2026 23:50:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <1a2c39d4-5d39-42c6-89f9-3ec473b44b06@fnnas.com>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/2/25 20:44, Nilay Shroff =E5=86=99=E9=81=93:
> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
> after ->freeze_lock is acquired or queue is frozen. This potentially
> creates a circular dependency involving ->fs_reclaim if reclaim is
> triggered simultaneously in a code path which first acquires ->pcpu_
> alloc_mutex. As the queue is already frozen while nr_hw_queue update
> allocates tagsets, the reclaim can't forward progress and thus it could
> cause a potential deadlock as reported in lockdep splat[1].
>
> Fix this by  pre-allocating tagset tags before we freeze queue during
> nr_hw_queue update. Later the allocated tagset tags could be safely
> installed and used after queue is frozen.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs8F=3DOV9s3La2kEQ34YndgfZP-B5PH=
S4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq.c | 53 +++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d5602ff62c7c..687fd47786a6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4793,10 +4793,10 @@ static void blk_mq_update_queue_map(struct blk_mq=
_tag_set *set)
>   	}
>   }
>  =20
> -static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
> -				       int new_nr_hw_queues)
> +static int blk_mq_prealloc_tag_set_tags(struct blk_mq_tag_set *set,
> +		       int new_nr_hw_queues, struct blk_mq_tags ***tags)

Personally I don't like the last parameter, since the return value is not
used at all, I feel it's better to return the new_tags instead.

>   {
> -	struct blk_mq_tags **new_tags;
> +	struct blk_mq_tags **new_tags =3D NULL;
>   	int i;
>  =20
>   	if (set->nr_hw_queues >=3D new_nr_hw_queues)
> @@ -4807,24 +4807,42 @@ static int blk_mq_realloc_tag_set_tags(struct blk=
_mq_tag_set *set,
>   	if (!new_tags)
>   		return -ENOMEM;
>  =20
> -	if (set->tags)
> -		memcpy(new_tags, set->tags, set->nr_hw_queues *
> -		       sizeof(*set->tags));
> -	kfree(set->tags);
> -	set->tags =3D new_tags;
> -
>   	for (i =3D set->nr_hw_queues; i < new_nr_hw_queues; i++) {
> -		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
> -			while (--i >=3D set->nr_hw_queues)
> -				__blk_mq_free_map_and_rqs(set, i);
> -			return -ENOMEM;
> +		if (blk_mq_is_shared_tags(set->flags))
> +			new_tags[i] =3D set->shared_tags;
> +		else {
> +			new_tags[i] =3D blk_mq_alloc_map_and_rqs(set, i,
> +					set->queue_depth);
> +			if (!new_tags[i])
> +				goto out_unwind;
>   		}
>   		cond_resched();
>   	}
>  =20
>   done:
> -	set->nr_hw_queues =3D new_nr_hw_queues;
> +	*tags =3D new_tags;
>   	return 0;
> +out_unwind:
> +	while (--i >=3D set->nr_hw_queues) {
> +		if (!blk_mq_is_shared_tags(set->flags))
> +			blk_mq_free_map_and_rqs(set, new_tags[i], i);
> +	}
> +	return -ENOMEM;
> +}
> +
> +static void blk_mq_init_tag_set_tags(struct blk_mq_tag_set *set,
> +		int new_nr_hw_queues, struct blk_mq_tags **new_tags)
> +{
> +	if (set->nr_hw_queues >=3D new_nr_hw_queues)
> +		goto done;
> +
> +	if (set->tags)
> +		memcpy(new_tags, set->tags, set->nr_hw_queues *
> +		       sizeof(*set->tags));
> +	kfree(set->tags);
> +	set->tags =3D new_tags;
> +done:
> +	set->nr_hw_queues =3D new_nr_hw_queues;
>   }
>  =20
>   /*
> @@ -5113,6 +5131,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>   	unsigned int memflags;
>   	int i;
>   	struct xarray elv_tbl;
> +	struct blk_mq_tags **new_tags;
>   	bool queues_frozen =3D false;
>  =20
>   	lockdep_assert_held(&set->tag_list_lock);
> @@ -5147,11 +5166,13 @@ static void __blk_mq_update_nr_hw_queues(struct b=
lk_mq_tag_set *set,
>   		if (blk_mq_elv_switch_none(q, &elv_tbl))
>   			goto switch_back;
>  =20
> +	if (blk_mq_prealloc_tag_set_tags(set, nr_hw_queues, &new_tags) < 0)
> +		goto switch_back;
> +
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>   		blk_mq_freeze_queue_nomemsave(q);
>   	queues_frozen =3D true;
> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> -		goto switch_back;
> +	blk_mq_init_tag_set_tags(set, nr_hw_queues, new_tags);

It looks ok just leave set->nr_hw_queues =3D nr_hw_queues, and the patch sh=
ould
be much simpler.

>  =20
>   fallback:
>   	blk_mq_update_queue_map(set);

--=20
Thansk,
Kuai
