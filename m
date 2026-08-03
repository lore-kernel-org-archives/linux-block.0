Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E430D407
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723048; cv=none; b=VoCiRVUdN9yY1Ymo7Ht51zc9LC61HzLrQ+xHBWTZWAKjlChbYrQVNA4WL9TRjbMialFO8pncr3RBciQT9hfiblPMmgS+lzDwevmukHkaroFpDhDfOpfYS28rvS51b1E3D9iB//PlDFNO5qoX9Ve3E8Mcd4zMyDSfqZIWam9gAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723048; c=relaxed/simple;
	bh=MBAKRjy0EJ23J6v1pZ6X9kN46ODS0V5RUhfLZ0nOVwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W1HZ0SBMZyDmaGoS3FJ8pDx3Vk4ZUP9Go//5dOwM3mESgs9obPd/FESkMB98iVVbmCrVtIOimA1WnbkiXcfP+joe0s1KbcNGy+//MU6hOzzJqzOa9Kgo413yBdfGV1f0QHNhshcIn5sodiFOAxQvTI62AFdqQPyuIJfjdYLkJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=h2B7TD3j; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="h2B7TD3j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=idHZeYe/YFbhiuymuAbfBqWrpjNQH2tdE7hxsAABQTo=;
	b=h2B7TD3jdN8lZ/AD2zpQqq0UmJGM5py8WYUFfuvmloa4cH+mYhDOIYpH/b2SUcq0siMsihdmg
	0qWJo4LUCKk8sx5eMnWBdxXXmkQYi755k8fCq00tDbyvXhYq0DdLoUiuwusizjCbpAoRuYq9B32
	MAv1iNmKni6hMwRRx3Rj67E=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hD0Jf3Qctz1cyPG;
	Mon,  3 Aug 2026 10:01:06 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD9C4056C;
	Mon,  3 Aug 2026 10:10:34 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 10:10:33 +0800
Message-ID: <a23ba675-60fe-4f5a-83e9-be3e0b5224f7@huawei.com>
Date: Mon, 3 Aug 2026 10:10:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] nbd: add nr_hw_queues module parameter for
 pre-created devices
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
 <20260730082046.3459239-9-yangerkun@huawei.com>
 <94c6ad4a-af3d-4a85-bc02-6cf8bcee10ce@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <94c6ad4a-af3d-4a85-bc02-6cf8bcee10ce@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/2 20:21, yu kuai 写道:
> Hi,
> 
> 在 2026/7/30 16:20, Yang Erkun 写道:
>> The function blk_mq_update_nr_hw_queues in nbd_start_device may causes a
>> queue freeze. The previous commit addressed this issue for newly created
>> nbd device via setting the expected nr_hw_queues in nbd_dev_add.
>> However, when reusing an old inactive nbd device, the queue freeze can
>> still occur when old nbd->tag_set->nr_hw_queues not match the new socket
>> connection count. Inactive nbd devices can originate from two sources:
>> loading the nbd module with nbds_max, which sets the default nr_hw_queues
>> to 1, and the netlink method, which sets nr_hw_queues according to the
>> expected number of socket connections. For the first case, we can add a
>> module parameter to allow changing the default nr_hw_queues. This way,
>> users who know their expected number of connections can prevent queue
>> freezes on pre-created devices via nbds_max.
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
>>    drivers/block/nbd.c | 8 +++++++-
>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 6369a409e10c..2194c7d7b2ea 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
>>    
>>    static unsigned int nbds_max = 16;
>>    static int max_part = 16;
>> +static int nr_hw_queues = 1;
>>    static int part_shift;
>>    
>>    static int nbd_dev_dbg_init(struct nbd_device *nbd);
>> @@ -2740,8 +2741,10 @@ static int __init nbd_init(void)
>>    	}
>>    	nbd_dbg_init();
>>    
>> +	if (nr_hw_queues < 1)
>> +		nr_hw_queues = 1;
>>    	for (i = 0; i < nbds_max; i++)
>> -		nbd_dev_add(i, 1, 1);
>> +		nbd_dev_add(i, 1, nr_hw_queues);
> 
> I still feel the module param name nr_hw_queues really confusing. How about rename it like
> pre_defined_connections? And add comments here that user should config the exact number of
> connections to avoid queue freeze from nbd_start_device().

OK, will do it next version. Thanks a lot for your review for this series!

> 
>>    	return 0;
>>    }
>>    
>> @@ -2802,3 +2805,6 @@ module_param(nbds_max, int, 0444);
>>    MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
>>    module_param(max_part, int, 0444);
>>    MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
>> +module_param(nr_hw_queues, int, 0444);
>> +MODULE_PARM_DESC(nr_hw_queues,
>> +"number of hardware queues for devices pre-created at module load (default: 1). ");
> 

