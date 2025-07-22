Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AB4A28
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151895; cv=none; b=ESHXgqsn8GKithmRA29fWhElpPI5yBXtbiJvTUxDKK8yoMrEbhOh5cEK8qQFzzS/ExHdgMlXAQHUHOwssvv4p4IIQqYLwDm2VJLPf4Ghh9TvZ3nj6gZItefgyLQSuODiTdD7G4TNDXxCmbLRtMybOuce3Vsu/pkKXAnMANOEjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151895; c=relaxed/simple;
	bh=4BSi+Pcst1Ua4Gm+pCi7UJWVBAa+zvA+esk+WgnVPuE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RWQebL+VI6sJgK7Hql+aI/PTTM9hi67Tr9bBGzFc/oEkDckhKTUi9TmnDVjGy1eVJ/pvLy4bAwnNjOEMVCt6Pv+Aefp1MO1MxUx4HZjq3FHXCY/NP5gg3OkCrWM1i0laNBGr7f3MrHyj4HK9DAtp5bL7WibkTMjNXgGSEJLpgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bmLzJ2JrWzYQtvS
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:38:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0EE451A018D
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:38:03 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERKJ+X5oLD9GBA--.33597S3;
	Tue, 22 Jul 2025 10:38:02 +0800 (CST)
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Damien Le Moal <dlemoal@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5e926df5-0a6f-6ebb-8078-98f21dd10eef@huaweicloud.com>
Date: Tue, 22 Jul 2025 10:38:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERKJ+X5oLD9GBA--.33597S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17WFWDWrW8Zw15Xr48tFb_yoW5GF4xpF
	W2ga1Ikry8tF47X39Fyw45WFy3t3WUAFW8WF4Iy34Fv3y5ZryxZrsrtFW5XF18Ka1DAw4S
	vFsrZFW5Xa4DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/22 9:07, Damien Le Moal 写道:
> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>> When setting up a null block device, we initialize a tagset that
>> includes a driver_data field—typically used by block drivers to
>> store a pointer to driver-specific data. In the case of null_blk,
>> this should point to the struct nullb instance.
>>
>> However, due to recent tagset refactoring in the null_blk driver, we
>> missed initializing driver_data when creating a shared tagset. As a
>> result, software queues (ctx) fail to map correctly to new hardware
>> queues (hctx). For example, increasing the number of submit queues
>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>> remap queues. Since set->driver_data is unset, null_map_queues()
>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>> effectively making the hardware queues unusable for I/O.

I don't get it, for the case shared tagset, g_submit_queues and
g_poll_queues should be used, how can you increasing submit_queues?
>>
>> This patch fixes the issue by ensuring that set->driver_data is properly
>> initialized to point to the struct nullb during tagset setup.
>>
>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/block/null_blk/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index aa163ae9b2aa..fbae0427263d 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>   {
>>   	if (nullb->dev->shared_tags) {
>>   		nullb->tag_set = &tag_set;
>> +		nullb->tag_set->driver_data = nullb;
> 
> This looks better, but in the end, why is this even needed ? Since this is a
> shared tagset, multiple nullb devices can use that same tagset, so setting the
> driver_data pointer to this device only seems incorrect.

Yes this looks incorrect, if there are multiple null_dev shared one
tag_set and blk_mq_update_nr_hw_queues() is triggered, all null_dev will
end up accesing the same null_dev in the map_queues callback.
> 
> Checking the code, the only function that makes use of this pointer is
> null_map_queues(), which correctly test for private_data being NULL.
> 
> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?

Same question :)

Thanks,
Kuai

> 
>>   		return null_init_global_tag_set();
>>   	}
>>   
> 
> 

