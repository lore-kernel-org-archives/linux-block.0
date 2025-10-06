Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C441A9FB3;
	Mon,  6 Oct 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715897; cv=pass; b=X7GfZS/gwreTAsEDhdzZfPbWZzqKkdSHVS2t+hX5PYptKbUoh7hECE15IVjMuBZWjchsevzT+7VlibV0Sgl44ht8aubPQ306rlGmVUftrG4wqllVQLzSTVFsa1sSWzYwIAdFMAi+2cFszsW2ghwgCNQAnBsb6dpGshTG47zXWmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715897; c=relaxed/simple;
	bh=jjIl0nqSSkyWwW5ny8VmXYPStzzy5sW4Vo4U1n1NiCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEtNlhm5GQOHITNzUx9mzujtnPgL2TR4NLaG0eWEvyjrvZEOmuhM5QUkytsRJZctFI1JitxaKSmk+efSEPRy9uNArB3mOBla/e0QpUSKEU1tm39Ec2ZQuXe1sPzGObpAP+swOA8xEStmq1cV6YxOBrJtgxLY5VcfyN/+QWHfruM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=AlO7Tvvp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="AlO7Tvvp"
ARC-Seal: i=1; a=rsa-sha256; t=1759715868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F9dHfa3fjP/CjifAght5PqoVABMJWvz/9kAsl1qLVohLRnZH0vyY3N7+tkCVahqAZSJ4pGxopbMYYNXbblkfvFsnfiGflqkNPoRNNqo9i144jHtMQAb29l8mptYjcWYyHXBNAhq0u9qgdp8deK4oKNOIVluWfAu0M1jdRBaRZBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759715868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0KzPODIwtT/gBCZCni7pFtUuEDHEM0mg2yw5SS0aE3g=; 
	b=UYGpMTRIQBLF4bsky0g3qlXclgb32yMRyT9CvWWX3l/kNNyQGKEQMT9cSB2g4mExrDLzDo2kk0b4gXDj1waCiGNdLnsnKKC8ks07D5FWYBGK+1XjKQLUbp6ahlCX1GPOpfokI9Scwjn4J8dO4xc+3a1l/dnkteqYaX/rfYQn97E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759715868;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0KzPODIwtT/gBCZCni7pFtUuEDHEM0mg2yw5SS0aE3g=;
	b=AlO7TvvpvIAIphZTltU5u/ZdMXJeG4X+GUYIBUq3rV/4z/6WhybCW61R//2ihNAl
	W1k4Toq1Kti8SXnVs/2Mdpq+lhGOh9Gpnpqm3UJaspIu78tBjsQ9BorOrfLww6ay5Tj
	tjeK67YO6G2MMxDDkzNHZ6sbKApQrCM05O7TnOVg=
Received: by mx.zohomail.com with SMTPS id 175971586559510.290897249693785;
	Sun, 5 Oct 2025 18:57:45 -0700 (PDT)
Message-ID: <f7fd8fa3-6368-48c1-93b2-942d9d0f75c7@yukuai.org.cn>
Date: Mon, 6 Oct 2025 09:57:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] blk-mq: add a new queue sysfs attribute async_depth
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-4-yukuai1@huaweicloud.com>
 <91799590-15cd-437d-900f-8bc372f7298b@linux.ibm.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <91799590-15cd-437d-900f-8bc372f7298b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/2 23:10, Nilay Shroff 写道:
>
> On 9/30/25 12:41 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Add a new field async_depth to request_queue and related APIs, this is
>> currently not used, following patches will convert elevators to use
>> this instead of internal async_depth.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-core.c       |  1 +
>>   block/blk-mq.c         |  4 ++++
>>   block/blk-sysfs.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   block/elevator.c       |  1 +
>>   include/linux/blkdev.h |  1 +
>>   5 files changed, 54 insertions(+)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index dd39ff651095..76df70cfc103 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>>   	fs_reclaim_release(GFP_KERNEL);
>>   
>>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
>> +	q->async_depth = BLKDEV_DEFAULT_RQ;
>>   
>>   	return q;
>>   
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 09f579414161..260e54fa48f0 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -529,6 +529,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>>   			data->rq_flags |= RQF_USE_SCHED;
>>   			if (ops->limit_depth)
>>   				ops->limit_depth(data->cmd_flags, data);
>> +			else if (!blk_mq_sched_sync_request(data->cmd_flags))
>> +				data->shallow_depth = q->async_depth;
>>   		}
> In the subsequent patches, I saw that ->limit_depth is still used for the
> BFQ scheduler. Given that, it seems more consistent to also retain ->limit_depth
> for the mq-deadline and Kyber schedulers, and set data->shallow_depth within their
> respective ->limit_depth methods. If we take this approach, the additional
> blk_mq_sched_sync_request() check above becomes unnecessary.
>
> So IMO:
> - Keep ->limit_depth for all schedulers (bfq, mq-deadline, kyber).
> - Remove the extra blk_mq_sched_sync_request() check from the core code.

I was thinking to save a function call for deadline and kyber, however, I don't
have preference here and I can do this in the next version.

Thanks,
Kuai

> Thanks,
> --Nilay
>
