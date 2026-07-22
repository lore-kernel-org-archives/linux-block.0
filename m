Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C72DF701
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700739; cv=none; b=arxslLOaDULIjOGEpEvmzSYpwAzV796mBNiRvrh/rhtsUj4MVPZCoKELzS43QVOg17NL71vlQ4vw1M+n/PqA5DJkC6hdtGNeN9Hf5zZwj/VnIbEJ7TLiQY556+WFWaauEnbjUqKDf+8AVb4LpnhnnS/7cMbebAyWZiGv4Z9jFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700739; c=relaxed/simple;
	bh=PCII0VcyddlhIVm+gYADn4ekUKlyoEi6n7v+urLGWQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GrzZRF08o9Xno5OCXM/gYjZH/xeb5juVgipQVN5xc3PJGa4LVkeM39Ri2Kq4yqKpz3Q/Wqw3aBnbb+JwY3q8Kn341yQlA+o2TZ/xyf7zl2nrQzFrQxgQjjMTEIkxsZlWa4N9164BYA3anil39uc9j4EQV1IYutee9/Ji2V5Lkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ampft/+4; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ampft/+4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bO1QFtNGdIOROC3PtmhxYYlmfvCFVM/mFaSIFPFOhXc=;
	b=ampft/+4VQCQjMLGkY6Y7FAyYIZMURyMftKcvnXhZl8hxItUSj4Dy4ZYeNwPapm2bvt/iTgZ/
	LboRj+d1ToWrkOMcLz74Z7h6KFeoR0DXFyvALKo8wzJqkYSBHL24QTQQaXiPiNpL7Wb3/JvCLCH
	c66hTmgWa74ZqioCwQnYFW8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4kDw3h1rznTbJ;
	Wed, 22 Jul 2026 14:02:40 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id D490C4048B;
	Wed, 22 Jul 2026 14:12:11 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 22 Jul 2026 14:12:10 +0800
Message-ID: <7e8df66e-e6f6-4be4-acc2-58fce2403ad9@huawei.com>
Date: Wed, 22 Jul 2026 14:12:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] nbd: disallow NBD_SET_SOCK on an active device
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-3-yangerkun@huawei.com>
 <9210a679-21f9-4b57-9220-6a15955c5bcf@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <9210a679-21f9-4b57-9220-6a15955c5bcf@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/22 11:03, yu kuai 写道:
> Hi,
> 
> 在 2026/7/13 14:56, Yang Erkun 写道:
>> We cannot add a socket to an already running nbd device, the reconfigure
>> for netlink can only active dead socket. But for ioctl path, we can call
>> NBD_SET_SOCK after NBD_DO_IT, reject this using nbd->pid which has been
>> setted when NBD_DO_IT. Besides, it is the root cause for commit
>> b98e762e3d71 ("nbd: freeze the queue while we're adding connections").
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 7 +++++++
>>    1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b1a5acd57426..a15553ab4b97 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1302,6 +1302,13 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>>    		goto put_socket;
>>    	}
>>    
>> +	if (nbd->pid) {
>> +		dev_err(disk_to_dev(nbd->disk),
>> +			"Cannot add socket to a running device\n");
>> +		err = -EBUSY;
>> +		goto put_socket;
>> +	}
> 
> I think the checking if fine, but I'd like to add the checking before nbd_get_socket() and
> return -EBUSY directly.

OK.
> 
>> +
>>    	nsock = kzalloc_obj(*nsock);
>>    	if (!nsock) {
>>    		err = -ENOMEM;
> 

