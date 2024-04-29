Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58B13AA43
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420115; cv=none; b=TuHH2oduryMzkWcXIKKx1mJHVLSn2LUHjad7wyyE8q3o/uJbPRtnvPOZhsqbMMVXb8VgXPoFKGK+QHBMNLczeJPbC3bmPkcTs4Sq7GA/BhjORl5LWjfZeTDo1z1OItFFSKvEsCMFGlPajXWPr/gudgN80hx/wo3PLFqfwAMMsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420115; c=relaxed/simple;
	bh=s1ULAB3yT/MW0mYVkZKZBEh6KsvKuqHkvlZmmRxaXdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EXyzZAkMACmf4rkL42BYylF8z5Z2WJgL2UX1QUufzwQSzCFvOKGIj9SYeeMi5tBSK2OMuvOKztX7Gq9Spj/aUiZDj8UWUVbLYQRHmldpDt2qT2Pm78Io1q6eFGG6LV2EsVJr8Y4qf8MXnPzTuawhpyp/HhTVaaMB8ci2cdfDgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AIX8ZyPx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AIX8ZyPx"
Message-ID: <f5efd37a-d154-4215-bb4a-5971bde6df57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714420112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HADa+sF+t//Pou2dqDkoLwPz+JzVkD4jRdeB/qAXQs=;
	b=AIX8ZyPx0cSe2eAXgPsvkQ1UQQwkPVa2TrxtMT8gZcfgR5IRyf4ipCwAmdI+Srpx3MeOP6
	lpNUpbDPQBPOcmQW7ByeeznFN3hu47Fcs+SrNUEoT7tS60+9Kjrs0MR0P9lpAbneEYND/M
	YipKuK49PEmce0mscLvllJw8GXxji/c=
Date: Mon, 29 Apr 2024 21:48:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] null_blk: Fix the WARNING: modpost: missing
 MODULE_DESCRIPTION()
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240429091227.6743-1-yanjun.zhu@linux.dev>
 <b42557c1-5462-4e58-8aac-3b6ee9ce6566@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <b42557c1-5462-4e58-8aac-3b6ee9ce6566@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/4/29 21:45, Chaitanya Kulkarni 写道:
> On 4/29/24 02:12, Zhu Yanjun wrote:
>> No functional changes intended.
>>
>> Fixes: f2298c0403b0 ("null_blk: multi queue aware block test driver")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>    drivers/block/null_blk/main.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index eed63f95e89d..aa084ae75e53 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -2121,4 +2121,5 @@ module_init(null_init);
>>    module_exit(null_exit);
>>    
>>    MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
>> +MODULE_DESCRIPTION("Null test block driver");
> why not :-
>
> "multi queue aware block test driver"

Thanks a lot. The above is from Kconfig.

Your suggestion is more fascinating. If everyone agrees, I will use yours.

>
>>    MODULE_LICENSE("GPL");
> irrespective of that, looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks

Zhu Yanjun

>
> -ck
>
>
-- 
I only represent myself.
Zhu Yanjun or Yanjun.Zhu

