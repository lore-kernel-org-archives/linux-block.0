Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FB3B895F
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220392; cv=none; b=HrRi7flV4MPjnsjq4CIkGmcK+3wZCXduRvoHA7K2sJjnFQBWbXr6HHb6u/USAi3rK06fp7GN/kNQqj1KVLn1Zy8lAnmNiU+s5aZ82aWwDIMWuph0A06ZzOJqFz+JtdHOn2h10+MKCz2DtgC/slIewKw2mlNGE87dGtSjEqu4WMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220392; c=relaxed/simple;
	bh=c+QanMDQWqnkKFxr8JFGZ51O71YLuYph1XqWpvERvmU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Bw+zuO4Ntwtf9BT0STNeFI1Ae/cD048htAHFG3Bk4bUwMiGSob01+DjL+qR6gWVvceSZZCGDR3I35PneQcrta0A3YcNRefFbvXZtS6hPkL9isz8Nw+XwlSSbce4LMWhMAescy5asxtXOiAtAPYPhkfB+TaWdVjnR/z9wRTbbZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I6ezBDKR; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I6ezBDKR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hp1m5/TUleZ8WC0xoVFFa3KhlylMd3xjMNoG3W1rIx0=;
	b=I6ezBDKRimWvm5PYqlG+TaviAZLCFNGvjMROBYHDYuEQ55bRjrPxV3byuvzdULMm9AELl6XHY
	lSK9kVZ7eZ8dIjymMmW2xXf0PFysDCnkpWk0qIUBqOU2c4S1MrPv/J571dugi4JqC+4isqGHXWJ
	kfz/wG1fw1QHS1h0A7s3rrE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8QQ51ybvz1T4Mc;
	Tue, 28 Jul 2026 14:23:25 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 308434056D;
	Tue, 28 Jul 2026 14:32:54 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 28 Jul 2026 14:32:53 +0800
Message-ID: <b6d12ad8-7f6a-4a18-9138-81e9d2470003@huawei.com>
Date: Tue, 28 Jul 2026 14:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] nbd: eliminate queue freeze/unfreeze overhead in
 connection setup
From: yangerkun <yangerkun@huawei.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>,
	<yukuai@kernel.org>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260727074718.414868-1-yangerkun@huawei.com>
In-Reply-To: <20260727074718.414868-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi,

https://sashiko.dev/#/patchset/20260727074718.414868-1-yangerkun%40huawei.com

Sashiko has identified some problems in this series. I will address them 
in the next version. Please disregard this version. Thank you!

Thanks,
Erkun.

在 2026/7/27 15:47, Yang Erkun 写道:
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
> v3->v4:
> 
> 1. factor out nbd_genl_foreach_sock to cleanup duplicated code
> 2. rewrite some commit message to make what's going more clearly
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
> Long Li (1):
>    nbd: simplify find_fallback() by removing redundant logic
> 
> Yang Erkun (6):
>    nbd: disallow NBD_SET_SOCK on an active device
>    nbd: remove queue freeze in nbd_add_socket
>    nbd: skip queue freeze when setting size at device startup
>    nbd: factor out a nbd_genl_foreach_sock
>    nbd: remove queue freeze for newly created nbd from netlink path
>    nbd: add nr_hw_queues module parameter for pre-created devices
> 
>   drivers/block/nbd.c | 228 +++++++++++++++++++++++---------------------
>   1 file changed, 121 insertions(+), 107 deletions(-)
> 

