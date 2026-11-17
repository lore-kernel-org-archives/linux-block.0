Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794890178;
	b=sZZV257n8uSN3xu758uAPuLVvvQa5CamNQPqg8mQyjam8kiWQNE8EZtuO3+z+66B0ziw
	 71IIgY0HxHVjDjHa8p9hhG6rvk+Ri8Uyahj6Kz5t7MRRuo90yJKXIl89/MzZyRIILI5Vf
	 P6A8Wg07EaFTauZNb8U9BATL6p9olaSmH7n0k5C55ScfIAne3KlQhQpAICTFGi1qriAhy
	 uVKfTDMaRR4E3RtfggDROSDfRSDFa8DE8nqBB9Ip2dAJk2+6HEdyvioliq2+npdHwbO42
	 MCOqZ2jiWrXAd04e/ZR+L6IeJctcY+OQwD0esT+TKjL3gNJkMrmwvCv4Q2hEMVTuo9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794890178;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=LilhKczkd0dur/+qff39W333MEH9dyOUhpuT4fAnPH4=;
	b=atZss/09FVQ6tv0ZkLISv7/Ax03ZRriIf+ESBrKYHNr4v/RPVggKkoSd16g351GNp5Ef
	 gyUMtU+WZRaAca9yG7oj5cp+CZPWf/e14FFLe1IijqWMTnoG8F6WVECRsIRP1aN4/lHvQ
	 u5lSsrIuDgOytJN12Zcz7yER/flqzhKS3NuLgwNW8b2GTE6uaW2S0RHNbZWjdZ9kR+q7A
	 8jGhrohHTOFk0dVnhlRWj8Aaq0IRT4nPb0O9FSYJhQ18VJQDjxA4ny7wRa+rT5OvKM/uT
	 xlTunOdWM2KA4R+vSWKT9MFyQm8FMc55wH5wAHF0Jcw5T8XhdiLuGpLwb9GmZ3RSkxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="IQL/B5Wv";
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AB606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 04:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 770AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IQL/B5Wv
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LilhKczkd0dur/+qff39W333MEH9dyOUhpuT4fAnPH4=;
	b=IQL/B5WvLX6fSrfF3TAeaJYWbZ7vMdIZVxlCBCkMy5S8E2m/GUEQHr6ZF7mDjDgCh6jtdF5je
	VFwhGPS38NkTdg6JAjv0dJB7y6lLPBGrCJWaao64eKYyAc6P0zFM3jh9wHMGiFcW3lm66EHaqAG
	htRkTfazws8nLtsGK8VvPD8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jTBjf1V3HznTWP;
	Tue, 17 Nov 2026 12:35:18 +0800 (CST)
Received: from dggpemr100015.china.huawei.com (unknown [7.185.36.123])
	by mail.maildlp.com (Postfix) with ESMTPS id 08FC740572;
	Tue, 17 Nov 2026 12:36:12 +0800 (CST)
Received: from kwepemq500005.china.huawei.com (7.202.195.208) by
 dggpemr100015.china.huawei.com (7.185.36.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 17 Nov 2026 12:36:11 +0800
Received: from [10.174.178.131] (10.174.178.131) by
 kwepemq500005.china.huawei.com (7.202.195.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 12:36:10 +0800
Message-ID: <b756494d-f665-4edf-8b6c-7ed8f6a01ed5@huawei.com>
Date: Tue, 17 Nov 2026 12:36:09 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] nbd: allow parallel genetlink operations
To: <axboe@kernel.dk>, <josef@toxicpanda.com>, <xiubli@redhat.com>,
	<prasanna.kalever@redhat.com>, <ming.lei@redhat.com>, <yukuai@fygo.io>,
	<nilay@linux.ibm.com>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
	<wangkefeng.wang@huawei.com>, <leijitang@huawei.com>, <yi.zhang@huawei.com>,
	<chengzhihao1@huawei.com>, <houtao1@huawei.com>, <wozizhi@huawei.com>,
	<xiujianfeng@huawei.com>, <echo.chenlin@huawei.com>
References: <20261107064629.4093489-1-yangerkun@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20261107064629.4093489-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500005.china.huawei.com (7.202.195.208)

Hi all,

Any advise for this series?

Thanks,
Erkun.

在 2026/11/7 14:46, Yang Erkun 写道:
> Each nbd doit only touches the state of one device; the only global
> state is nbd_index_idr, accessed briefly under nbd_index_mutex.
> genl_mutex nevertheless serializes the whole genetlink doit path, and
> nbd_disconnect_and_put() sleeps in flush_workqueue() while holding it,
> so one device's teardown blocks every other device.  This series
> enables parallel_ops for nbd.
> 
> Patches 1, 2 and 4 fix bugs that are reachable without parallel_ops;
> patch 3 makes device publication and the status walk consistent for
> concurrent genl handlers.  Patch 5 enables parallel_ops.
> 
> A minimal netlink client on an 8-vCPU KVM guest, 32 devices x 10
> connect/disconnect cycles, median of 3 runs: 390 ms -> 25 ms.
> Connect-only and status do not change.
> 
> Yang Erkun (5):
>    nbd: validate the backend identifier under config_lock
>    nbd: decrement nbd_total_devices when a device is removed
>    nbd: publish devices atomically
>    nbd: hold config_lock while updating nr_hw_queues
>    nbd: allow genetlink operations to run in parallel
> 
>   drivers/block/nbd.c | 95 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 65 insertions(+), 30 deletions(-)
> 

