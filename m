Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EC1E9919
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769762; cv=none; b=YeVmUZ3k3ziHU1gPuLQ0BYRIGwfXFAHfqP9snrS1XHpj7GDB5b+8a8pIXN9s5+0Chxa2a+r8KNAkCA6xjzT18eS2iEDxn/6ATbzu+ReRdU2yrXrhfis1UIFkfmnUF8dUpLN2qvWD8oaKFc1vXxkRlZqa61iqBP+9uTdkTKcbeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769762; c=relaxed/simple;
	bh=mp/DpKDO63SINoJsoZlU1by8t2dH//xNEV/MsjilbCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CCh6p8IJmFf2h//UpNuT/YOAzr6xiVjGwlIv52OpPViXkBi4RJiUdbREoB9lz6QujK5fMvZDOUzcxA3QAYha+YJTH+F06cAq4QJBExXYBc+rcVVcKdABuLvGAlEzZAHSKEF+bedaEKfaPhw8Fnf4frEC1Inhijl+byLRPtqcZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PC/3AfEU; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PC/3AfEU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BLFGUfinJ8YbNWyXKp5QPWRQMuhqsyUWlhz9bd+mpIs=;
	b=PC/3AfEUAu544SRaI4Z3z7XzUDtjuwl9wRN3SFmw2VqcOw1tudhqOknRlu3d9BUwHWg3opduV
	3OSO4AzET9xfZpuqEONIKj4/CA4u+fyPWoWasaPJI4S+Xw5HgHdDhuDGjMpmbHgqBAwW90+YR7Q
	PomiqNsQyPK/oZ+/fnpZFlQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h5CmH5SkhznTVx;
	Thu, 23 Jul 2026 09:13:03 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E96A402AB;
	Thu, 23 Jul 2026 09:22:34 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 09:22:33 +0800
Message-ID: <eb6d809b-a233-48a3-95e9-7284ae3bd4db@huawei.com>
Date: Thu, 23 Jul 2026 09:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] nbd: skip queue freeze when setting size at device
 startup
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-6-yangerkun@huawei.com>
 <7cc2fb8d-32b4-4fc9-a440-e125ba290374@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <7cc2fb8d-32b4-4fc9-a440-e125ba290374@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/22 11:49, yu kuai 写道:
> Hi,
> 
> 在 2026/7/13 14:56, Yang Erkun 写道:
>> Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
>> introduce queue freeze/unfreeze in nbd_set_size to avoid inflight
>> commands see this inconsistent limits. However, this cannot be happened
>> when device setup since the capacity is still 0.
> 
> Same reason above, 0 capacity disk will only reject non-zero sized bio from
> bio_check_eod().

Mabye we have reached an agreement on this issue? Flush bio will be 
reject since not enable write cache.

> 
>>
>> time nbd-client --name myexport --connections 96 127.0.0.1 1234
>>
>> Before this patchset:
>> real    0m2.195s
>> user    0m0.005s
>> sys     0m0.022s
>>
>> After this patchset:
>> real    0m0.090s
>> user    0m0.004s
>> sys     0m0.018s
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 21 ++++++++++++++-------
>>    1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 400f638e832e..2c7b09c70da2 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -331,7 +331,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
>>    	nsock->sent = 0;
>>    }
>>    
>> -static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
>> +static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize,
>> +			bool freeze)
>>    {
>>    	struct queue_limits lim;
>>    	int error;
>> @@ -371,7 +372,13 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
>>    
>>    	lim.logical_block_size = blksize;
>>    	lim.physical_block_size = blksize;
>> -	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
>> +
>> +	if (freeze)
>> +		error = queue_limits_commit_update_frozen(nbd->disk->queue,
>> +				&lim);
>> +	else
>> +		error = queue_limits_commit_update(nbd->disk->queue, &lim);
>> +
>>    	if (error)
>>    		return error;
>>    
>> @@ -1563,7 +1570,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>>    		args->index = i;
>>    		queue_work(nbd->recv_workq, &args->work);
>>    	}
>> -	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
>> +	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
>>    }
>>    
>>    static int nbd_start_device_ioctl(struct nbd_device *nbd)
>> @@ -1631,13 +1638,13 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>>    	case NBD_SET_SOCK:
>>    		return nbd_add_socket(nbd, arg, false);
>>    	case NBD_SET_BLKSIZE:
>> -		return nbd_set_size(nbd, config->bytesize, arg);
>> +		return nbd_set_size(nbd, config->bytesize, arg, true);
>>    	case NBD_SET_SIZE:
>> -		return nbd_set_size(nbd, arg, nbd_blksize(config));
>> +		return nbd_set_size(nbd, arg, nbd_blksize(config), true);
>>    	case NBD_SET_SIZE_BLOCKS:
>>    		if (check_shl_overflow(arg, config->blksize_bits, &bytesize))
>>    			return -EINVAL;
>> -		return nbd_set_size(nbd, bytesize, nbd_blksize(config));
>> +		return nbd_set_size(nbd, bytesize, nbd_blksize(config), true);
>>    	case NBD_SET_TIMEOUT:
>>    		nbd_set_cmd_timeout(nbd, arg);
>>    		return 0;
>> @@ -2122,7 +2129,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
>>    		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
>>    
>>    	if (bytes != config->bytesize || bsize != nbd_blksize(config))
>> -		return nbd_set_size(nbd, bytes, bsize);
>> +		return nbd_set_size(nbd, bytes, bsize, true);
> 
> This is still called from nbd_genl_connect().

nbd->pid check exist in nbd_set_size, and nbd_genl_connect call 
nbd_genl_size_set before nbd_start_device, which has not set nbd->pid, 
so path from nbd_genl_connect won't work. But for path from 
nbd_genl_reconnect, we need this protect...

> 
> Will it be much simpler to just check pid in nbd_set_size()?
> 
>>    	return 0;
>>    }
>>    
> 

