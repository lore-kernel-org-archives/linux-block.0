Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B98125D9
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670760; cv=none; b=mL0yMwRad3D1SLpgSbatIXQJ0ny7WPaFQjwAkG01jgx2gXgTQR1mLCdx82v7sRCccSPlObA7/vQDU9IG5ZYS2/PK5FWB4Gtj1q7AyGtEq5z27nInz2jYb1ecH5f2Mxprau+E1UPvIXCGDrGtSOCNjkHnRudcjFSulCGa6UqW7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670760; c=relaxed/simple;
	bh=qEeCnqgQ/FeBkljpcyWHJ35PZJcD1nvGGc+VVWRBU7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z03f9r2hHXk9RzGPSSSnTnFijKVxmdg0VaNNzIZidG9CjMurEb5I/CYChL2TT2eZFh6LREXipfz3/Mcwx6AsP8MTH7X9NrYHwI19xQ4HZmoqpIc9LnwbrGldP4fmT5ApY2YO1w26ME38/lSPSNJyVSnoaJpqz6ITCrDwvTuMEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Th0lG1SVTz1FKWW;
	Fri, 23 Feb 2024 14:40:58 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B27140485;
	Fri, 23 Feb 2024 14:45:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:45:51 +0800
Message-ID: <ccd9a812-306a-4f47-be30-66b540cb0c07@huawei.com>
Date: Fri, 23 Feb 2024 14:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mm: unify default compressor algorithm for zram/zswap
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>,
	<linux-mm@kvack.org>, <linux-block@vger.kernel.org>
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
 <20240223045132.GL11472@google.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240223045132.GL11472@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/23 12:51, Sergey Senozhatsky wrote:
> On (24/02/23 11:55), Kefeng Wang wrote:
>>
>> Both zram and zswap are used to reduce memory usage by compressing cold
>> page, a default compressor algorithm is selected from kinds of compressor
>> algorithm as the default one from very similar Kconfig, also both of
>> them could change the algorithm by sysfs interfaces, so unify the
>> default compressor algorithm to cleanup the default algorithm chosen.
>>
>> Kefeng Wang (5):
>>    zram: zcomp: remove zcomp_set_max_streams() declaration
> 
> I'm afraid this (1/5) is the only patch in the series that we can land.
> 
> The rest of the series doesn't look beneficial nor correct.  Sorry.

OK, please ignore the reset of patches, Andrew, could you only pick the 
first one, thanks.

> 
>>    zram: make zram depends on SWAP
>>    zram: support deflate compressor
>>    mm: zswap: default to lzo-rle instead of lzo
>>    mm: unify default compressor algorithm for zswap and zram
