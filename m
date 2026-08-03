Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C399253B73
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721711; cv=none; b=WmjtkiQtsFJTW/cTIaUiR4Hl1zWkOpamfQKpFY1uMMhflgrxKSNtfGSFQ7Uqjh6ldrpAK2nS4CidZ6hSMqczwfNGunaWnd9RHX9xQ64rQ3fK1lrnwYiboTFuNx/gzD9AuuFtHZkeZQ0D+vTvLG9J3fV8iRec8gjJ+RsNjHVZTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721711; c=relaxed/simple;
	bh=E2DzJZp0aCm65tSSQTQQiN8uw56Lu4TexyYMUNz0Wto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tMw60ZMcWa8Fn1YLxIpht59SuKiaF1ePJqK+vExoAgpmVkyfGzTUc6PTrtvO9BLiPZMGRhJi/3H0WkSkIJxczeeB7NgCgaXi34PVzgJfe0TNoBWel7KMi/iimm/H+OaBFV2WhPG93VNQMymuzSBqa8bcOe036TTm3f1YxaWtkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2U/zzGdN; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2U/zzGdN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uK86g8TYBAmGyyi9lNVOUbjU74cmwye+w4Dvmqke+1k=;
	b=2U/zzGdN9bGWPbn20lsgsih2CSLDAzJBx5cW5B1kuOauhV3zr7f0Mm/uyChNraVerARY3SP3M
	owYAm5IKHHL96ZII9ZhhQFjshJ7sL8KnxlgLM3HpdiozqJOoWZz7tuW5qmgiRQMG4OhzzGzWSyN
	6FC0vEOwOJUn1RTXq4pLMLY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hCzq13YkxzpT0q;
	Mon,  3 Aug 2026 09:38:53 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 1872D40537;
	Mon,  3 Aug 2026 09:48:19 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 09:48:18 +0800
Message-ID: <a80ba6f1-9f8d-40db-b048-827dddf5930b@huawei.com>
Date: Mon, 3 Aug 2026 09:48:17 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] nbd: skip queue freeze when setting size at device
 startup
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
 <20260730082046.3459239-6-yangerkun@huawei.com>
 <75ff5ace-a4bb-4960-a992-dddb235fd2ca@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <75ff5ace-a4bb-4960-a992-dddb235fd2ca@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/2 19:45, yu kuai 写道:
> Hi,
> 
> 在 2026/7/30 16:20, Yang Erkun 写道:
>> Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
>> added the freeze to keep in-flight commands from seeing torn
>> queue_limits.  But at startup the capacity is still 0
>> (invalidate_disk cleared it) and the write cache is off (the previous
>> patch cleared it on disconnect, and nbd_set_size sets it back only after
>> the commit), so submit_bio_noacct() rejects any bio before it reaches
>> the driver and no I/O is in flight.  Drop the freeze there.
>>
>> Split nbd_set_size() with a bool: nbd_start_device() passes false, the
>> runtime resize/reconfigure paths (ioctls and nbd_genl_size_set) keep
>> passing true.  nbd->pid is still 0 when nbd_genl_connect calls
>> nbd_genl_size_set, so the early return in nbd_set_size keeps that path
>> from applying limits before startup; the true covers the reconnect path
>> on a live device.
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 21 ++++++++++++++-------
>>    1 file changed, 14 insertions(+), 7 deletions(-)
> 
> Can you just checking if size is 0 and write cache is disabled first, and just
> skip freeze in this case. I think this is simpler and straightforward, as you
> don't have to modify all the callers.

OK, it seems simple and clear, I will try it next version!

> 
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index ce25c254e5fb..3b7363b11d0b 100644
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
>> @@ -1568,7 +1575,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>>    		args->index = i;
>>    		queue_work(nbd->recv_workq, &args->work);
>>    	}
>> -	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
>> +	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
>>    }
>>    
>>    static int nbd_start_device_ioctl(struct nbd_device *nbd)
>> @@ -1636,13 +1643,13 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
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
>> @@ -2097,7 +2104,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
>>    		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
>>    
>>    	if (bytes != config->bytesize || bsize != nbd_blksize(config))
>> -		return nbd_set_size(nbd, bytes, bsize);
>> +		return nbd_set_size(nbd, bytes, bsize, true);
>>    	return 0;
>>    }
>>    
> 

