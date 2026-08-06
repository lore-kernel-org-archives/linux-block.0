Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC8389116
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015400; cv=none; b=IVgh/w0qta3QUztz4g7vBVb1KY2G6LpFuHLzux6xYzphmFL/xQvTOPa19gyh7yQMwGgpbxxMrkyDrDg3jl+EHoahwb09+KPEGMLzo7t20bPvAVLdZY+9y+h85SmBW849b7IEuni512SLI4WpkXFsqp91wYcZFX1qB6eROpMN0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015400; c=relaxed/simple;
	bh=tUau9zLaFGcMETtx4tvcFGr3xsttVDYt4gsO9//I/nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iIibCDkXcOPiRhCKVbaN0s2Ckb8TSNIsScIhRi29zUMdxFLlor2G+u+AaNdZgr8nphA0PhFmcpQuqqVC4dKhR2nY5eqyniyQVFnogxi0jYIRMEpuLwxKHMm+X2Jps9TBDdD3R8q80gkBqX/KaMYeNQokxfCrYiMjkQIQVHTMe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hkJU9qRC; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hkJU9qRC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xowRjgjVD/YwKVvxtgaeuKeraYLluwgjfyKEiKbHvds=;
	b=hkJU9qRCmwib9O4D8TBFQl/N99wtknDcme8N4sXSXm2KNRPYjdS+95vp81qRRSGvWl7CDHnho
	r2KeZF9XBOHSfMXt1yi/+boqE9UtbJmByZGDwjhy4sY5ISttdizU8B93MpTwIf4zSeIHNJsRqk4
	gO2fZ1ewefIykSRuUz3ailM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hG4Pc5NXSzRhQt;
	Thu,  6 Aug 2026 19:12:36 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E47140537;
	Thu,  6 Aug 2026 19:23:08 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 6 Aug 2026 19:23:07 +0800
Message-ID: <ac98320c-fa54-42d9-b792-ed0c8841920f@huawei.com>
Date: Thu, 6 Aug 2026 19:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] nbd: add pre_defined_connections module parameter
 for pre-created devices
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260805122930.57647-1-yangerkun@huawei.com>
 <20260805122930.57647-9-yangerkun@huawei.com>
 <22a4c13f-517a-42c3-9079-15dd20940424@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <22a4c13f-517a-42c3-9079-15dd20940424@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/6 17:26, yu kuai 写道:
> Hi,
> 
> 在 2026/8/5 20:29, Yang Erkun 写道:
>> blk_mq_update_nr_hw_queues() in nbd_start_device() may cause a queue
>> freeze.  The previous commit addressed this for newly created nbd
>> devices by setting the expected nr_hw_queues in nbd_dev_add().  However,
>> when reusing an old inactive nbd device, the queue freeze can still
>> occur if the old nbd->tag_set->nr_hw_queues does not match the new
>> socket connection count.  Inactive nbd devices can originate from two
>> sources: loading the nbd module with nbds_max, which sets the default
>> nr_hw_queues to 1, and the netlink method, which sets nr_hw_queues
>> according to the expected number of socket connections.  For the first
>> case, add a module parameter so the default nr_hw_queues can be
>> changed.  Users who know their expected number of connections can then
>> prevent queue freezes on pre-created devices via nbds_max.
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
>>    drivers/block/nbd.c | 16 +++++++++++++++-
>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 6c4aa19ea11a..ffce519bf008 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
>>    
>>    static unsigned int nbds_max = 16;
>>    static int max_part = 16;
>> +static int pre_defined_connections = 1;
>>    static int part_shift;
>>    
>>    static int nbd_dev_dbg_init(struct nbd_device *nbd);
>> @@ -2712,6 +2713,12 @@ static int __init nbd_init(void)
>>    	if (nbds_max > 1UL << (MINORBITS - part_shift))
>>    		return -EINVAL;
>>    
>> +	/* An excessively large value will be adjusted in blk_mq_alloc_tag_set */
>> +	if (pre_defined_connections < 1) {
>> +		pr_err("pre_defined_connections must be >= 1\n");
> 
> It's also better to add NR_CPUS checking for upper bound, because the nr_hw_queues is passed
> directly to __blk_mq_realloc_hw_ctxs() for memory allocation.

Hi,

Like the comment above said, nbd_dev_add->blk_mq_alloc_tag_set

4876         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
4877                 set->nr_hw_queues = nr_cpu_ids;

this will help do the same thing. So I does not the check here.

Thanks,
Erkun.

> 
>> +		return -EINVAL;
>> +	}
>> +
>>    	if (register_blkdev(NBD_MAJOR, "nbd"))
>>    		return -EIO;
>>    
>> @@ -2728,8 +2735,12 @@ static int __init nbd_init(void)
>>    	}
>>    	nbd_dbg_init();
>>    
>> +	/*
>> +	 * Set to the intended connection count so nbd_start_device() can skip
>> +	 * the queue-freezing blk_mq_update_nr_hw_queues() call.
>> +	 */
>>    	for (i = 0; i < nbds_max; i++)
>> -		nbd_dev_add(i, 1, 1);
>> +		nbd_dev_add(i, 1, pre_defined_connections);
>>    	return 0;
>>    }
>>    
>> @@ -2790,3 +2801,6 @@ module_param(nbds_max, int, 0444);
>>    MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
>>    module_param(max_part, int, 0444);
>>    MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
>> +module_param(pre_defined_connections, int, 0444);
>> +MODULE_PARM_DESC(pre_defined_connections,
>> +"number of connections for devices pre-created at module load (default: 1)");
> 

