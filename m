Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0213BED0F
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623297; cv=none; b=ruQFN/HvNGRgimEiYtnb03IdjcesK9XTOgadjCFC2gsdaekmvr6cvQD/b6wJZM25Cc7oZWa21YqXr0v8LiIAETmI0RnyAXFZEPUtOD+++Wafhm6GaM9XNpqkPGJ/+nCYG8IyyQov0M2IFVv8cB9XuQyYWQQx7WX2hAPDmvLM4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623297; c=relaxed/simple;
	bh=5meUdh/BYW/R0Hc1EoY6XPMsQzS/y9NLoP98kEibCew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EDU621TpkbSt26j6V56yRlS6+8zwPQ4X5tTqg80GYsAC1+l8IU9U3ybj8VxrpukZ9h30sLE6vgFL4jWtPmIIU2lP35YcpQGMlmPtSRhdzTHscqQwYod5nTd2jmV4qXIcfJtlIxROahNvf+VJcCXUe+HVNI1JHwHO+ExnRhYCAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5Grup+0J; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5Grup+0J"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YfZJx9uA4U++j5Tg2zU+anSUNLmXPFfqLpGhWKG6M9g=;
	b=5Grup+0JSeGaVD+ktVOOOKDaKbxt3+/POSs5fqb3phPStR1+nD63oIqZicj4pfa5Z3/4m2/XR
	vbqgdzT8vgOfZ0ah4L7TYbhG0txwlcBn4Nkg1pvUZyF/r231UMiJpIM1XL1BOVGhgCF0KfJJynB
	ArW3o56nanF9VjkGLAchQ0c=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h49bq2z1qzLlXh;
	Tue, 21 Jul 2026 16:32:07 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DF9740572;
	Tue, 21 Jul 2026 16:41:29 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 21 Jul 2026 16:41:28 +0800
Message-ID: <2e5ab8ad-144e-4da4-bb4a-00d4791230cb@huawei.com>
Date: Tue, 21 Jul 2026 16:41:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nbd: eliminate queue freeze/unfreeze overhead in
 connection setup
To: <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>,
	<yukuai@kernel.org>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20260713065644.1637594-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)

gently ping for this series...

在 2026/7/13 14:56, Yang Erkun 写道:
> This series eliminates the blk_mq_freeze_queue()/unfreeze_queue()
> overhead that currently occurs during nbd connection setup(nbd provide
> ondemand and was using in AI sandbox e2b[1] to mount and attach rootfs).
> Each freeze cycle will introduce a RCU grace which was significant
> with multi-core system.
> 
> time nbd-client --name myexport --connections 96 127.0.0.1 1234
> 
> After this patchset:
> real    0m0.090s
> user    0m0.004s
> sys     0m0.018s
> 
> Without this patchset:
> real    0m2.195s
> user    0m0.005s
> sys     0m0.022s
> 
> v2->v3:
> 1. Stop using xarray, and protect it by rejecting late NBD_SET_SOCKS
> 2. Eliminate freeze in nbd_set_size when device setup
> 3. Add module parameter to eliminate freeze for pre-created device
> 
> v1->v2:
> 1. Rewrite cover letter
> 2. Eliminate freeze call from blk_mq_update_nr_hw_queues in
>     nbd_start_device for netlink path
> 
> 
> [1]. https://github.com/e2b-dev/e2b
> 
> Long Li (1):
>    nbd: simplify find_fallback() by removing redundant logic
> 
> Yang Erkun (5):
>    nbd: disallow NBD_SET_SOCK on an active device
>    nbd: remove queue freeze in nbd_add_socket
>    nbd: set nr_hw_queues at device creation to skip queue freeze
>    nbd: skip queue freeze when setting size at device startup
>    nbd: add nr_hw_queues module parameter for pre-created devices
> 
>   drivers/block/nbd.c | 119 ++++++++++++++++++++++++++++----------------
>   1 file changed, 76 insertions(+), 43 deletions(-)
> 

