Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE003F412D
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094792; cv=none; b=fcX1iwFk93s3EGFrUpBv/4Ljydk5eBT1fdXT8fdzTa7i6nhUeMaVTr/sqsLnk5nDyX1PxgtGA3iKSD0oZvyDDB7XJyA30XiBL+pxcZfNXCJqzTcb+ZqLrRRkyOZRwtXMn40VK8w4uCcXt0fkc4xnO+OwMpA7FpG99kWR3p2HO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094792; c=relaxed/simple;
	bh=W6NZZ9+v1N/E1QSdaBcSvg0Af45mHed1rDFoBAs0DfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hIQDnkCYj5uH8bY2be/OnpFIy3zDQhIwuOIfWXvfx2e+oTOJggoiEA+jUvkHZ1pZQtS3leos0acJbyjGdOGnniCpQKkKQG0bJvbD0+73tLWDOta5CcQ/d+RtGVmD72qnIwEuVSyg+JbaETweXutN/IFMTQUaTn5v1i7710NVx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uEEeBrV2; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uEEeBrV2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g9iKnuecN/NtaoB1lQqDY13zZMgdLkNjIVcEYDXHkLM=;
	b=uEEeBrV25m96IzaWWL/7FiQEdt3r9xGl2Sbes4JTe2KGMONGoDq2yXvFq8fOaY8uy7xkgkOHy
	kJJ4MB1pq91FTJNCYlVhKF6rWx+y6aKL5oGqgUmbC6hAz2GvtyujCA9baod8q8iYFQNDpIExKzG
	139CR1FTAB5XCAiXs4LDgYA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hGdn45nyNzcb0T;
	Fri,  7 Aug 2026 17:16:24 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id D03D14057F;
	Fri,  7 Aug 2026 17:26:22 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 7 Aug 2026 17:26:21 +0800
Message-ID: <6931071e-544a-463a-b90c-cd063be340a6@huawei.com>
Date: Fri, 7 Aug 2026 17:26:21 +0800
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
 <b75f1941-1083-424d-9bf9-29f1fa63f88b@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <b75f1941-1083-424d-9bf9-29f1fa63f88b@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi Kuai,

Thanks for your careful review during this period.

Thanks,
Erkun.

在 2026/8/7 16:12, yu kuai 写道:
> 在 2026/8/5 20:29, Yang Erkun 写道:
> 
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
>> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 16 +++++++++++++++-
>>    1 file changed, 15 insertions(+), 1 deletion(-)
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> 

