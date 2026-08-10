Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32722BE656
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323583; cv=none; b=J+Z82rAR38/NQuzm3BebsVN6qNnZqAXcf28YU53ZH/vxnIFWaLeUvgvdfbsICbXD5phS2Eric9MLT8p6QFeABKdVUJTUdvnDsNPytsVubFFSIi240H6U5DmS49noyLy8JuWG37JwwqK+d+Tk/gMS6oRulw+wrnirifasZJq0Ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323583; c=relaxed/simple;
	bh=r4K7MYVDb+I0wIU2lP3LART0OuSSHM/71Zuw070LEAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=kI5nDrrTJ4pFtoAia8osDm8Ec+CHbgwWRUFxa+an66LVmTF51TsPNid7WxTZDRXzFez0RD+Hm/ZJUOFx4thDXcz5wv7Tahpc8xYyy28qgCwJaTarGmiMxAgnoUBNMhPB2uKVl+VjkXb3Ndm2af4XctFGCkPKcNl5mG9ghdr6UO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hkr7ajdJ; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hkr7ajdJ; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hkr7ajdJ";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hkr7ajdJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Eqthy8UDZh8LD/1UY+iIPfs2A4uPDb2tYuWUWuoE3I=;
	b=hkr7ajdJduXv7pIcn35dVKhrzOV/t8fiH+ZVdIOaitpsuRiS3aJGtT7Bwbd82Mwc8dVu336xI
	Nl+vCYKUjAlhf2JbDCzzKynQWgkm8BMRlUGH2qHlhaS4YD0hXBZthFciypENv6o+qqvvjDFaOxf
	sYuQRQSx8VTqmckJdzd7Ves=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hJGFW5blKz126LsK
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 08:43:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Eqthy8UDZh8LD/1UY+iIPfs2A4uPDb2tYuWUWuoE3I=;
	b=hkr7ajdJduXv7pIcn35dVKhrzOV/t8fiH+ZVdIOaitpsuRiS3aJGtT7Bwbd82Mwc8dVu336xI
	Nl+vCYKUjAlhf2JbDCzzKynQWgkm8BMRlUGH2qHlhaS4YD0hXBZthFciypENv6o+qqvvjDFaOxf
	sYuQRQSx8VTqmckJdzd7Ves=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hJG1W5VNYz1cyT9;
	Mon, 10 Aug 2026 08:32:47 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 85E5E40588;
	Mon, 10 Aug 2026 08:43:22 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 10 Aug 2026 08:43:21 +0800
Message-ID: <015547d0-640e-4a55-86c5-3c094fdfcc8f@huawei.com>
Date: Mon, 10 Aug 2026 08:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] nbd: eliminate queue freeze/unfreeze overhead in
 connection setup
From: yangerkun <yangerkun@huawei.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>,
	<yukuai@kernel.org>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260805122930.57647-1-yangerkun@huawei.com>
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi Jens,

Would you be willing to consider applying this patchset?

Thanks,
Erkun.

在 2026/8/5 20:29, Yang Erkun 写道:
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
> v7->v8:
> 1. clean some code for patch 7
> 2. reject invalid pre_defined_connections for patch 8
> 
> v6->v7:
> 1. fix patch 3(sorry again for mistake in v6)
> 
> v5->v6:
> 1. patch 3, reset stale FEAT*, not only write cache
> 2. patch 5, using the way Kuai advise to skip freeze
> 3. patch 6, adopt kuai's suggestion
> 4. patch 8, rename nr_hw_queues and add some comments
> 
> v4->v5:
> 1. add patch 3 to reset write cache on disconnect
> 2. fix ("nbd: factor out a nbd_genl_foreach_sock")
> 
> v3->v4:
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
> Long Li (1):
>    nbd: simplify find_fallback() by removing redundant logic
> 
> Yang Erkun (7):
>    nbd: disallow NBD_SET_SOCK on an active device
>    nbd: clear queue limits on disconnect
>    nbd: remove queue freeze in nbd_add_socket
>    nbd: skip queue freeze when setting size at device startup
>    nbd: factor out a nbd_genl_foreach_sock
>    nbd: remove queue freeze for newly created nbd from netlink path
>    nbd: add pre_defined_connections module parameter for pre-created
>      devices
> 
>   drivers/block/nbd.c | 257 +++++++++++++++++++++++---------------------
>   1 file changed, 137 insertions(+), 120 deletions(-)
> 

