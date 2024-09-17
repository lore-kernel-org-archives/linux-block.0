Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139E4594D;
	Tue, 17 Sep 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557873; cv=none; b=DVWGbDZg9GQ+gTUlFQUJqKChTb1CW4p9GjlOXkX/WcWYgEksEW/7vpa28bhFGZngbcO9Dz6K1tGcDtYZwzVsSmyBxlDtX06j2KKhEr63d91XXX6oaIemc1fJP0zFZ0qMDpiLEEjXPIO758PWj/QvdN0eXxO/CqbVYydnM8qn1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557873; c=relaxed/simple;
	bh=X8vjfoYlPbAxQw8Py+2hLWq0kqxUupoSphWKecqxkmM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GxNQLPQftzmTM1swEY0lfjJrR+1ZwvmkPH6xHuRT7t+FYstaFNMw3xEGmp04RCNO50WAOkhDMb/k9/TGeHncb39HmVrX9p1mym7jvCyEu0g5zEEVHi5EHr8508Q/baJnVd/LXLSQx6wOhZXBdoG35/1HdMutKzdBasBpQeUmQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3qEzGn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3qEzGn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB2C4CEC6;
	Tue, 17 Sep 2024 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557872;
	bh=X8vjfoYlPbAxQw8Py+2hLWq0kqxUupoSphWKecqxkmM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B3qEzGn51fC5JCwWjeiT/tro8LjflbyM4r2j0dtAHC9keNFjiI+LrQbgpnVTyg2xI
	 NdXn3572pA6aYydBt3x2/SCHV+bG9NvnH/rQwlg0O2AxcuVyV15toWrBYRda9dSq9b
	 g55H3km5oaHKZ4Q4Zkm2jgSmx60ZQnK495LRc/AP25nltC1MZ10KuQDYGGBn77k1di
	 N+XNTSBUM8DzOgnT3fGQTAspxa+83mjFVRwCXLjhIPGgfXVN1SOUIINlq8zaLr/8zn
	 A/MWS6fMAjyT4Bs/2h2B4XH0bNbamTKkCHZMzwLdiGEuzrIOCNIgTptiPm2vZbHjHK
	 P+AlN23lWI5Qw==
Message-ID: <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
Date: Tue, 17 Sep 2024 09:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
From: Damien Le Moal <dlemoal@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai3@huawei.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240917070729.15752-1-amishin@t-argos.ru>
 <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/17 16:21, Damien Le Moal wrote:
> On 2024/09/17 16:07, Aleksandr Mishin wrote:
>> In null_alloc_dev() device size is a subject to overflow because 'g_gb'
>> (which is module parameter, may have any value and is not validated
>> anywhere) is not cast to a larger data type before performing arithmetic.
>>
>> Cast 'g_gb' to unsigned long to prevent overflow.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>  drivers/block/null_blk/main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 2f0431e42c49..5edbf9c0aceb 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>  		return NULL;
>>  	}
>>  
>> -	dev->size = g_gb * 1024;
>> +	dev->size = (unsigned long)g_gb * 1024;
> 
> This still does not prevent overflows... So what about doing a proper check ?

This still does not prevent overflows on 32-bits architectures.

> 
>>  	dev->completion_nsec = g_completion_nsec;
>>  	dev->submit_queues = g_submit_queues;
>>  	dev->prev_submit_queues = g_submit_queues;
> 

-- 
Damien Le Moal
Western Digital Research

