Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AD2FF657
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721500; cv=none; b=HlDqJUSQEDT39rhdvg3QK9aKwv9sPw/9wjYYOodfGffVPIuR8V9SS4KGfCavTtfWF46+Pnm2lzROAZ81+8cc9rJkLq3Tk+EPr5eaiRluKCxE/zZOfmzK8ah+ExtBaamHte6/EQt9yLdAWlzimbzVO5bjhRwPlYxZ9mTCrdCdbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721500; c=relaxed/simple;
	bh=jxjj0Jp9egSpsiPW3ESFrJ/9IP6xveQgN1WZn9IJQ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P4UoyicdiHDDqo62oYWDXW723ikSnDAwj2GyKhKxCCTrZAZ8wIxzKO4Q98oOPAzxMwdng2r+omdI+ReoVieqGnI+pP5/Dh9kQKCPicnxryaULHqA/eKTdHI+9WqMHT98a9Uw7YZ+btD7ZVSd32yXN/5mNevDq1mBOrjRA4jGzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1j8Wt4U7; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1j8Wt4U7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C1CzZZ5gUW41aSGWA4/ZHVA4An0FayxB/vOtVCa5NfQ=;
	b=1j8Wt4U7H1xtpiognj0RLBQl+bylakyvOyENn145yD5i4wDG8AzUSUK03wFQ3mCnVMVDNpCeN
	EhQV7uXwZY0/c5pQyXASUJoByUoflR4Egkkk3N9bAh/qAuYOyb0ewV0hUleLUoSD/GeMLiOokVU
	9SKQfIh6AEeghyK6h1N07s4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hCzkR4jTyzcb0T;
	Mon,  3 Aug 2026 09:34:55 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id C2FE940538;
	Mon,  3 Aug 2026 09:44:45 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 09:44:44 +0800
Message-ID: <b5f86cf3-93e4-4d7d-8f38-eb32c0813f27@huawei.com>
Date: Mon, 3 Aug 2026 09:44:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] nbd: reset write cache on disconnect
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
 <20260730082046.3459239-4-yangerkun@huawei.com>
 <9525c07b-f9ee-4a06-9857-0b6c9942ffaf@fygo.io>
 <4695b270-3f94-440c-a174-91b6fb5b94d1@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <4695b270-3f94-440c-a174-91b6fb5b94d1@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/2 20:02, yu kuai 写道:
> Hi,
> 
> 在 2026/8/2 19:51, yu kuai 写道:
>> Hi,
>>
>> 在 2026/7/30 16:20, Yang Erkun 写道:
>>> An inactive nbd device may refuse any I/O operations. The nbd_config_put
>>> function calls invalidate_disk, which sets the device capacity to zero
>>> to reject all read and write I/O. For zero-sector flush I/O requests
>>> from blkdev_issue_flush, if the write cache is disabled, the zero-sector
>>> flush I/O immediately returns 0 in submit_bio_noacct. However, since
>>> nbd_config_put does not clear the write cache state, an inactive nbd
>>> device might still have the write cache enabled. In this situation,
>>> zero-sector flush I/O will return -EIO because there is no active socket.
>>> Although this does not cause any bugs, resetting the write cache state
>>> would make the behavior consistent.
>> I don't think this make sense, at this point nbd->config_refs is 0, which means
>> there is no opener for the device, so how can there still be outstanding read/write
>> or flush IO?
> 
> I see what you want to do after checking the next patch. However, since a disconnected
> nbd device can be reused later, the stale BLK_FEAT flags from the last connection looks
> like a real problem. So, I think it's better to reset queue_limits to default, the same
> as add_disk().

Yeah, I prefer this way! Thanks for your advise.

> 
>>
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>     drivers/block/nbd.c | 5 +++++
>>>     1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index 7ec85f94f742..da4b48ef3c79 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -1469,8 +1469,13 @@ static void nbd_config_put(struct nbd_device *nbd)
>>>     	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
>>>     					&nbd->config_lock)) {
>>>     		struct nbd_config *config = nbd->config;
>>> +		struct queue_limits lim;
>>>     		nbd_dev_dbg_close(nbd);
>>>     		invalidate_disk(nbd->disk);
>>> +		/* reset write cache */
>>> +		lim = queue_limits_start_update(nbd->disk->queue);
>>> +		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
>>> +		queue_limits_commit_update(nbd->disk->queue, &lim);
>>>     		if (nbd->config->bytesize)
>>>     			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
>>>     		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
> 

