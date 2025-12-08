Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD881ACA
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163663; cv=none; b=b/SuhmGw3342uGMlrvxdYHr1qNIvTZDMPCtVHCT5jFAMJr/Jnad90+br+bKYC6I62ECNF66PMexLUfqc9/f8J6esKV+ZtJi9a+B3HkZELa5SHhoQlrkCHPtZKYrwPWDvotMdjkmmR8GN0ABvgLn8tx7DUcIFT6KSLMqZqS1tAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163663; c=relaxed/simple;
	bh=aMnDv7LAYcmZpHYDj9xdqrRXYGzo+STkWQidK77/T/4=;
	h=Message-Id:References:Mime-Version:In-Reply-To:From:Date:To:
	 Subject:Content-Type; b=FE4/jo2M6QPQZOwU/cCi+M/YYPLHVfY7nRHQHjHz6x39wKOphlXKqVaAcOLvyG5VvajWDElDVGVgoqm2szWN2x/4OZ4WfU3UW+HcZhNyInAGdUd7tiXDe91uRnuvfCTWOXfHN+uKSdv7PiPWApJDLc3MpXiI8Jqgq6fJfHD/ONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=1PfjECai; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="1PfjECai"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765163643;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=g8czebmPQgM1auTyrSNeDIRpGgF4WSwBk2TXOonv9Co=;
 b=1PfjECaihwIqahMy0p1f9elkWko4uzUhZImom2XTA+In7jFRppwP4xjmty6pV6wp/Pt+WR
 j27saN0CCqjckm6ccx4wxNHLAXUuHK16VRGpCm2P0sfbAZsU8A4l2XtvJgODcpIYrV+QAD
 R3vfUrSCOX4edr8IBgXaT7lHo/rzc8IX56u4+9aLy35khXUPV3KxWD4Rq1FPhnDQ164F5a
 tCykga7RkbiEC1ay0YThIlW+chfrM9jMaDM55cohwCmro+SVgKhtN0w2ce1LxmviNbHKAD
 ENJf31iII4zgJjgMvZnFCHCjRSwPiebFIwLjqQxSdv6HR189cnEaTtPj4H1JWA==
Message-Id: <fb63b227-7f73-44a1-84a6-eecdd7496968@fnnas.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
References: <20251201083415.2407888-1-yukuai@fnnas.com> <20251201083415.2407888-3-yukuai@fnnas.com> <b6868832-a66a-4953-b6d3-afd0677c7319@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
In-Reply-To: <b6868832-a66a-4953-b6d3-afd0677c7319@linux.ibm.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 8 Dec 2025 11:13:59 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269364279+6d86d9+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<bvanassche@acm.org>, <yukuai@fnnas.com>
Subject: Re: [PATCH v4 02/12] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.160]) by smtp.feishu.cn with ESMTPS; Mon, 08 Dec 2025 11:14:00 +0800

Hi,

Sorry for the delay.

=E5=9C=A8 2025/12/1 23:11, Nilay Shroff =E5=86=99=E9=81=93:
>>  =20
>> -static int wbt_init(struct gendisk *disk)
>> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
>>   {
>>   	struct request_queue *q =3D disk->queue;
>> -	struct rq_wb *rwb;
>> -	int i;
>>   	int ret;
>> -
>> -	rwb =3D kzalloc(sizeof(*rwb), GFP_KERNEL);
>> -	if (!rwb)
>> -		return -ENOMEM;
>> -
>> -	rwb->cb =3D blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb)=
;
>> -	if (!rwb->cb) {
>> -		kfree(rwb);
>> -		return -ENOMEM;
>> -	}
>> +	int i;
>>  =20
>>   	for (i =3D 0; i < WBT_NUM_RWQ; i++)
>>   		rq_wait_init(&rwb->rq_wait[i]);
>> @@ -934,19 +948,24 @@ static int wbt_init(struct gendisk *disk)
>>   	return 0;
>>  =20
>>   err_free:
>> -	blk_stat_free_callback(rwb->cb);
>> -	kfree(rwb);
>> +	wbt_free(rwb);
>>   	return ret;
>> -
>>   }
> As we moved the allocation of @rwb out of wbt_init() function,
> it looks bit odd to still keep the release of @rwb, in case of
> failure, in wbt_init(). IMO, we should handle the failure (release
> of @rwb) in the respective callers of wbt_init() where we actually
> allocate @rwb.

OK, sounds reasonable.

>
>>  =20
>>   int wbt_set_lat(struct gendisk *disk, s64 val)
>>   {
>>   	struct request_queue *q =3D disk->queue;
>> +	struct rq_qos *rqos =3D wbt_rq_qos(q);
>> +	struct rq_wb *rwb =3D NULL;
>>   	unsigned int memflags;
>> -	struct rq_qos *rqos;
>>   	int ret =3D 0;
>>  =20
>> +	if (!rqos) {
>> +		rwb =3D wbt_alloc();
>> +		if (!rwb)
>> +			return -ENOMEM;
>> +	}
>> +
>>   	/*
>>   	 * Ensure that the queue is idled, in case the latency update
>>   	 * ends up either enabling or disabling wbt completely. We can't
>> @@ -956,9 +975,11 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>>  =20
>>   	rqos =3D wbt_rq_qos(q);
> Hmm, we have already evaluated wbt_rq_qos() above, so then
> why do we re-evaluate it here again? Can't we directly instead
> re-use the value of @rqos here?

Because I think queue_wb_lat_store() can concurrent, until rq_qos_mutex
is held and only one rq_qos_add() can succeed.

Good thing is that wbt can never be destroyed until the disk is removed.

>
>>   	if (!rqos) {
>> -		ret =3D wbt_init(disk);
>> +		ret =3D wbt_init(disk, rwb);
>>   		if (ret)
>>   			goto out;
>> +	} else if (rwb) {
>> +		wbt_free(rwb);
>>   	}
>>  =20
> As @rwb is allocated outside of ->freeze_lock, I think wbt_free()
> should be also called after we unfreeze the queue.

Sure.

>
> Thanks,
> --Nilay
>
