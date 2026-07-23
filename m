Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313C17A300
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769853; cv=none; b=cMsji+Y7dHUXalrowCFMmas3EN0M1Pl0r7YDnTzlaRqzS4l2Rc28z9cjXBegd+Ys90wyKy094Io19Jtk2aX6fKaszPkEOh7LG5PbmXpZC9lyI6V9FJCOBa5EibSIB35z+SDF6AxPjh/jIK0yDw0L15e73c6nqPq3/emBvVbjfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769853; c=relaxed/simple;
	bh=rH1Wsn71inUuK+5SZQRNnGRTJnf9ht5PVLOthcrA6zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5Who6ByYbzwqhKTVnx3JLl2IPh41oL+6384UKtNpDbA6MZ0lh7ONDXuqDymfWT9ZrBSvcNUXi9o07HDla/rFb6G/GbJ+QzOHxUhq8Oa/a6KNDCF/tlLDpSMNgp7rNf9lPdWCtGKUpawuD/0TxaC/ZU/xdrP81aDRZigNS/PFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EgzBmZm9; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EgzBmZm9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tI7jlf2gVhufqXJTBiWI992LoBfe5J6nfmLVFkrOcDg=;
	b=EgzBmZm96DW8DjprCUcns96A0qgQEyc5VDk91CR32PxulQHKzL7WnmErmPZt7IXUwpM28L+Vg
	DOVjgGHyyx1K/eW83Pm/tg337SFOK1LDFp7zfBgX3a/GF9xS1QlPNUM+oSlf0RNG6o8wd3Delih
	VbZE3/rCPF5mr7iCabfqYmw=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5Cp870yszKm5m;
	Thu, 23 Jul 2026 09:14:40 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A9024055B;
	Thu, 23 Jul 2026 09:24:06 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 09:24:05 +0800
Message-ID: <f4033527-5a7f-47f4-8431-7090d063ee34@huawei.com>
Date: Thu, 23 Jul 2026 09:24:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] nbd: add nr_hw_queues module parameter for
 pre-created devices
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-7-yangerkun@huawei.com>
 <cbcbe9e9-3700-4801-88b8-6b99f61a8936@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <cbcbe9e9-3700-4801-88b8-6b99f61a8936@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/22 11:53, yu kuai 写道:
> Hi,
> 
> 在 2026/7/13 14:56, Yang Erkun 写道:
>> Previous commit can help remove all freeze for netlink newly created nbd
>> device. But for the devices pre-created at module load(nbds_max default
>> as 16), the nr_hw_queues was setting default as 1, then ioctl/netlink
>> path will set the real connection count, and blk_mq_update_nr_hw_queues
>> in nbd_start_device will introduce freeze.
>>
>> Add an nr_hw_queues module parameter so that users who know their
>> expected connection count can pre-created devices with the right queue
>> count to avoid this freeze too.
> 
> I'm fine with this, but this is misleading. Please also add comment to
> emphasize this module parameter is just to avoid queue freeze if user configure
> the exact number of socks as this new module parameter. Otherwise, the real
> nr_hw_queues is still depend on the real number of user configured socks.

OK, will add this comment in next version! Thanks a lot for your careful 
review!

> 
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 8 +++++++-
>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 2c7b09c70da2..f918c9efa9b2 100644
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
>> @@ -2752,8 +2753,10 @@ static int __init nbd_init(void)
>>    	}
>>    	nbd_dbg_init();
>>    
>> +	if (nr_hw_queues < 1)
>> +		nr_hw_queues = 1;
>>    	for (i = 0; i < nbds_max; i++)
>> -		nbd_dev_add(i, 1, 1);
>> +		nbd_dev_add(i, 1, nr_hw_queues);
>>    	return 0;
>>    }
>>    
>> @@ -2814,3 +2817,6 @@ module_param(nbds_max, int, 0444);
>>    MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
>>    module_param(max_part, int, 0444);
>>    MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
>> +module_param(nr_hw_queues, int, 0444);
>> +MODULE_PARM_DESC(nr_hw_queues,
>> +"number of hardware queues for devices pre-created at module load (default: 1). ");
> 

