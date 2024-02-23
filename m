Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54937191
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670647; cv=none; b=um6QfOex+T94LCDShEUBQ7mVPsR/dvDsSw9jrug4uu4J/x6aFwYXloBUDEcR0743sjBU47OBmMaRk/zKsqIdmwSuZfAL9PGScIZXdx86jF+yQsyO21UACVetggHIp7qgY+sfU+cRFV92GgMcYD0IblnICVcj9mHRdWxf7mAU1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670647; c=relaxed/simple;
	bh=8gmXfmnL44Z0hyAvQ1KhvXrDtXRPPuaM3rlT1FNWTQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CzBjYWnEoDI68n+38+KV1NZCrWSyjxSWnmXuedDngEl7Y44V82j1jzt3zaLiTnTWcARahz9FGEXU2rn/lCunpc2jpbeRVmtnI2UwsQr3RuuUflx1e1VwwoRKXa0wzyoe/zdzVLnGZIg4Z/DXHZo4zi83/a08oxkPcuo65JVPHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Th0mN1KqhzvVnK;
	Fri, 23 Feb 2024 14:41:56 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 91CEF140447;
	Fri, 23 Feb 2024 14:44:00 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:43:59 +0800
Message-ID: <0ebca914-87b8-4aca-a60c-e6da82836082@huawei.com>
Date: Fri, 23 Feb 2024 14:43:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mm: unify default compressor algorithm for zram/zswap
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, Minchan Kim
	<minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	<linux-mm@kvack.org>, <linux-block@vger.kernel.org>
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
 <CAJD7tkb0E9pJ=9xMTg4aNcXEscwJwOo--kDfau9YfkwCbcJL1g@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAJD7tkb0E9pJ=9xMTg4aNcXEscwJwOo--kDfau9YfkwCbcJL1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/23 12:46, Yosry Ahmed wrote:
> On Thu, Feb 22, 2024 at 7:56 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> Both zram and zswap are used to reduce memory usage by compressing cold
>> page, a default compressor algorithm is selected from kinds of compressor
>> algorithm as the default one from very similar Kconfig, also both of
>> them could change the algorithm by sysfs interfaces, so unify the
>> default compressor algorithm to cleanup the default algorithm chosen.
> 
> Both zswap and zram *can* be used for compressed swap, but zram is a
> generic block device that has other use cases, see
> https://docs.kernel.org/admin-guide/blockdev/zram.html.
> 
> For starters, making zram depend on SWAP may break some of those use cases.
> 
> Otherwise, I don't immediately see the benefit of unifying the config
> options for two independent subsystems just because they both use
> "compression". The reduction of the config options is nice, but in
> this case I am not sure it's doing more good than harm. Also, most
> people use either zswap or zram in my experience, so they don't really
> have to configure both anyway.
Fair enough, then, please ignore the patches, thanks.
> 
>>
>> Kefeng Wang (5):
>>    zram: zcomp: remove zcomp_set_max_streams() declaration
>>    zram: make zram depends on SWAP
>>    zram: support deflate compressor
>>    mm: zswap: default to lzo-rle instead of lzo
>>    mm: unify default compressor algorithm for zswap and zram
>>
>>   Documentation/admin-guide/mm/zswap.rst     |   2 +-
>>   arch/loongarch/configs/loongson3_defconfig |   2 +-
>>   drivers/block/zram/Kconfig                 |  44 +------
>>   drivers/block/zram/zcomp.c                 |   3 +
>>   drivers/block/zram/zcomp.h                 |   1 -
>>   drivers/block/zram/zram_drv.c              |   2 +-
>>   mm/Kconfig                                 | 134 +++++++++++----------
>>   mm/zswap.c                                 |   8 +-
>>   8 files changed, 83 insertions(+), 113 deletions(-)
>>
>> --
>> 2.27.0
>>
