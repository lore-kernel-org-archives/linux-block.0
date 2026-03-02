Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DB2D59E8
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428291; cv=none; b=SbTNWWGMESOxg/3TFPsWMcJKWKu6QmhpoXrG+bVYtU1SDT9Tnd8gX63Jx4eFXbjcRfm+s7S7eP5yD2x89UHFpzwcxFUNUt9AQEgnU4h3IkWi0R00j1x5pgpluuT5ircJ0J3QfdDVt4Qsjudf29se1aryiNlFeoJZn+qMTI+tn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428291; c=relaxed/simple;
	bh=prQVDTPeOL7+0d46ysWRFR+lJl1MQfYpjil3cMDPYDY=;
	h=From:Date:Content-Type:In-Reply-To:Message-Id:Mime-Version:Cc:
	 References:To:Subject; b=DJRXMMbp5RzohbrL8G3jfDk6l/2sXKrCzzwfu8wccG2Im6QJdu538Pz70bZhWbPXXr8OyFmn2KmQJ1vDnoRD7nspygq55RAAU3WyOZXiYrYrKR2fZejwsqAQQwgOTSC13SUmALjos7Mb5stWugAVhFoYgOPUksCwDhhLMnE5CnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=WvZ4i9Nk; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="WvZ4i9Nk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1772428281;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vE+32WZBcGMy6O9LCnYiFZD++G5I1NHPdTs2FwUjXNE=;
 b=WvZ4i9NkwOPtr50Y2RdaKrZnGc7nlwfPjt8bY0Ua/NvCk8RrUAO8l0eM6M1V7kEKfEXIuu
 q8HvGJhvhOfCBj31uZTUiRnG33o/FiAYlUbmSmJNP5AlI/giee3ZrIFVF8FTZABw/KL3gV
 NHiC7x/W2U+nqB/n0NoKOa8yRl3BsnZQhIlH5ffWlk/JEa/xgYG/8PNIDiYaeAUSZ8+zAJ
 3fLGOUXm9edn4NMXiXFokI7ojVmoXXpinC0aUno0M3lPCawO+BYLRViL1nANpL1V992NZs
 Ru8AUdpqTTZM87TT6bLf8QVdehDWcNRovFoEpLnPBKHA2xDaWMANKy1UhCjmyw==
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 2 Mar 2026 13:11:16 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260301125951.582690-1-nilay@linux.ibm.com>
Message-Id: <8eaab53b-6525-4a9f-9a4b-94ce7e7fc09f@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: <axboe@kernel.dk>, <hch@lst.de>, <ming.lei@redhat.com>, 
	<yi.zhang@redhat.com>, <shinichiro.kawasaki@wdc.com>, <gjoyce@ibm.com>, 
	<yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+269a51bf7+2b3752+vger.kernel.org+yukuai@fnnas.com>
References: <20260301125951.582690-1-nilay@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCHv2] block: break pcpu_alloc_mutex dependency on freeze_lock
Received: from [192.168.1.104] ([39.182.0.182]) by smtp.feishu.cn with ESMTPS; Mon, 02 Mar 2026 13:11:18 +0800
Content-Language: en-US

Hi,

=E5=9C=A8 2026/3/1 20:59, Nilay Shroff =E5=86=99=E9=81=93:
> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
> after ->freeze_lock is acquired or queue is frozen. This potentially
> creates a circular dependency involving ->fs_reclaim if reclaim is
> triggered simultaneously in a code path which first acquires ->pcpu_
> alloc_mutex. As the queue is already frozen while nr_hw_queue update
> allocates tagsets, the reclaim can't forward progress and thus it could
> cause a potential deadlock as reported in lockdep splat[1].
>
> Fix this by pre-allocating tagset tags before we freeze queue during
> nr_hw_queue update. Later the allocated tagset tags could be safely
> installed and used after queue is frozen.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs8F=3DOV9s3La2kEQ34YndgfZP-B5PH=
S4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>    - Make blk_mq_prealloc_tag_set_tags() return the tags pointer directly=
,
>      encoding error conditions using ERR_PTR(). Update caller to use IS_E=
RR()
>      to distinguish between success and failure. (Yu Kuai)
> ---
>   block/blk-mq.c | 45 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9af8c3dec3f6..a27bade45de3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4793,38 +4793,45 @@ static void blk_mq_update_queue_map(struct blk_mq=
_tag_set *set)
>   	}
>   }
>  =20
> -static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
> -				       int new_nr_hw_queues)
> +static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
> +				struct blk_mq_tag_set *set,
> +				int new_nr_hw_queues)
>   {
>   	struct blk_mq_tags **new_tags;
>   	int i;
>  =20
>   	if (set->nr_hw_queues >=3D new_nr_hw_queues)
> -		goto done;
> +		return NULL;
>  =20
>   	new_tags =3D kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags =
*),
>   				GFP_KERNEL, set->numa_node);
>   	if (!new_tags)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  =20
>   	if (set->tags)
>   		memcpy(new_tags, set->tags, set->nr_hw_queues *
>   		       sizeof(*set->tags));
> -	kfree(set->tags);
> -	set->tags =3D new_tags;
>  =20
>   	for (i =3D set->nr_hw_queues; i < new_nr_hw_queues; i++) {
> -		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
> -			while (--i >=3D set->nr_hw_queues)
> -				__blk_mq_free_map_and_rqs(set, i);
> -			return -ENOMEM;
> +		if (blk_mq_is_shared_tags(set->flags))
> +			new_tags[i] =3D set->shared_tags;

I think usually we'll keep the braces for if branch.

Otherwise feel free to add:

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

> +		else {
> +			new_tags[i] =3D blk_mq_alloc_map_and_rqs(set, i,
> +					set->queue_depth);
> +			if (!new_tags[i])
> +				goto out_unwind;
>   		}
>   		cond_resched();
>   	}
>  =20
> -done:
> -	set->nr_hw_queues =3D new_nr_hw_queues;
> -	return 0;
> +	return new_tags;
> +out_unwind:
> +	while (--i >=3D set->nr_hw_queues) {
> +		if (!blk_mq_is_shared_tags(set->flags))
> +			blk_mq_free_map_and_rqs(set, new_tags[i], i);
> +	}
> +	kfree(new_tags);
> +	return ERR_PTR(-ENOMEM);
>   }
>  =20
>   /*
> @@ -5113,6 +5120,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>   	unsigned int memflags;
>   	int i;
>   	struct xarray elv_tbl;
> +	struct blk_mq_tags **new_tags;
>   	bool queues_frozen =3D false;
>  =20
>   	lockdep_assert_held(&set->tag_list_lock);
> @@ -5147,11 +5155,18 @@ static void __blk_mq_update_nr_hw_queues(struct b=
lk_mq_tag_set *set,
>   		if (blk_mq_elv_switch_none(q, &elv_tbl))
>   			goto switch_back;
>  =20
> +	new_tags =3D blk_mq_prealloc_tag_set_tags(set, nr_hw_queues);
> +	if (IS_ERR(new_tags))
> +		goto switch_back;
> +
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>   		blk_mq_freeze_queue_nomemsave(q);
>   	queues_frozen =3D true;
> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> -		goto switch_back;
> +	if (new_tags) {
> +		kfree(set->tags);
> +		set->tags =3D new_tags;
> +	}
> +	set->nr_hw_queues =3D nr_hw_queues;
>  =20
>   fallback:
>   	blk_mq_update_queue_map(set);

--=20
Thansk,
Kuai
