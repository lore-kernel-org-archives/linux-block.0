Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D0346E54
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726962; cv=none; b=leHNVLHYlPYEj6u0eqC+t7jgP7/6PzTwxDkuPT85iqJFQcXzQCx7KhkZllhryBRC3F7jW9noGO7oGaTKVReMLqH/5f7hP1C2wZcyeTm6Od6iQi20rquBRm7j7LkEHjfTpDI7+Fp7bipW4mxUyr90ZQOgxeXOeTdMslm+A9o9cUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726962; c=relaxed/simple;
	bh=7ptclDskioJBZA7o1AXsLLScrA33NSxWqgkvo86Ycvs=;
	h=Subject:Mime-Version:Content-Type:Cc:Date:References:In-Reply-To:
	 To:From:Message-Id; b=bnYVo4q1qYSCMLjWNuYs+sIFME4DEm9Ztn+LhfDS0VUnYhjGGXyu1TIChWfRyEwUjA9zSazMDup6vj3M0MMF2u72rFCWb2TLe6BZUzJf8BHZecbMl8ruXkzg/b5vQR/pL8+U1pkWZ+kn82bLQKZ/MfZdc1+CHR0DWyiHaB2xAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=JIyrReC6; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="JIyrReC6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763726954;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bEPWHuLP3UHGud3d/Xo7ybe520mKMqwRMcpzOVMNoYc=;
 b=JIyrReC61OGapm1N6BOkRG6zUF7qv9bnoB5Hp1QnTYejsjeTsqJElNtd++C8dyMB420wVz
 l1h5MyLmtFKJ2onJwDIpFpXtY8/WufKbPSrWujZYRGf4qCq3/+OhL33c8VhAF5nk1XJ/Se
 Xx4T0Bxys0uijsT2Cp6xt8BYBn0/5LapdNZgxreOMGIJLGv9yTS2JbS3LX7YqX8w3wW96b
 wOHyZkeEU8OY7gsBc+0xZwq0VfEpm8yq7YmROjDjtrP/6aHxNmJA8qcEVwvio+qq0959oQ
 rjNJGT01OmysL0N7mOtW73ofZ6m7Ev6//tzybKqErQIQHmzgMljNZbwHYOqRyQ==
Subject: Re: [PATCH v2 2/9] blk-rq-qos: fix possible debugfs_mutex deadlock
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: fnnas
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Fri, 21 Nov 2025 20:09:11 +0800
Cc: "Jens Axboe" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"Tejun Heo" <tj@kernel.org>, "Ming Lei" <ming.lei@redhat.com>, 
	"Bart Van Assche" <bvanassche@acm.org>, "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 21 Nov 2025 20:09:09 +0800
References: <20251121062829.1433332-1-yukuai@fnnas.com> <20251121062829.1433332-3-yukuai@fnnas.com> <13eb8452-7629-4555-9380-8ba93b2241ab@linux.ibm.com>
X-Lms-Return-Path: <lba+269205668+82088b+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <13eb8452-7629-4555-9380-8ba93b2241ab@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
To: "Nilay Shroff" <nilay@linux.ibm.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <39cd3964-2276-407b-b029-09b8a75112a1@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Language: en-US

Hi,

=E5=9C=A8 2025/11/21 18:40, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 11/21/25 11:58 AM, Yu Kuai wrote:
>> +void blkg_conf_exit(struct blkg_conf_ctx *ctx)
>> +{
>> +	__blkg_conf_exit(ctx);
>> +	if (ctx->bdev) {
>> +		struct request_queue *q =3D ctx->bdev->bd_queue;
>> +
>> +		mutex_lock(&q->debugfs_mutex);
>> +		blk_mq_debugfs_register_rq_qos(q);
>> +		mutex_unlock(&q->debugfs_mutex);
>> +
>>   		ctx->bdev =3D NULL;
>>   	}
>>   }
> Why do we need to add debugfs register from blkg_conf_exit() here?
> Does any caller using above API, really registers/adds q->rqos? I
> see blk-iococst, blk-iolatency and wbt don't use this API.

Yes, this sounds reasonable. We should add this when we really have
such rq qos policy.

>
>> @@ -724,8 +724,12 @@ void wbt_enable_default(struct gendisk *disk)
>>   	if (!blk_queue_registered(q))
>>   		return;
>>  =20
>> -	if (queue_is_mq(q) && enable)
>> +	if (queue_is_mq(q) && enable) {
>>   		wbt_init(disk);
>> +		mutex_lock(&q->debugfs_mutex);
>> +		blk_mq_debugfs_register_rq_qos(q);
>> +		mutex_unlock(&q->debugfs_mutex);
>> +	}
>>   }
>>   EXPORT_SYMBOL_GPL(wbt_enable_default);
> I see we do have still one code path left in which the debugfs register
> could be invoked while queue remains freezed:
>
> ioc_qos_write:
> blkg_conf_open_bdev_frozen        =3D> freezs the queue
>    wbt_enable_default
>      blk_mq_debugfs_register_rq_qos
>       =20
> Thanks,
> --Nilay
>
>

--=20
Thanks,
Kuai
