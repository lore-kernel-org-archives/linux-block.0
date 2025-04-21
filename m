Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87528320F
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239998; cv=none; b=mu/zEeU2lGixkBpupgwjuhE1RpAk8ZVwDgNcCqQ1uFFh5LSo/xRF366j4WQGJJ6h4LUbs+7WElgOKcmFTFeYkxOGnhyWvb00d+ODKw2hmnu/JigtAz602t6WMJRxnDFJYbto9o0Zkj+2+to3SO4s9xMKSyC0XnEZjOYhn2vfRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239998; c=relaxed/simple;
	bh=GE0g5l4u3RPiIdwT08/xHaPdmvBdfKIJOHTlakeLdAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XRMCXfiDMM3eldL3n8px1OYn5ZyPG+kXi+T7lIIdH29eNLtNdx6UYlUWmEdvx82oXTv63jChv9X9biF8GOSOipwPTSgmeMy4mhkeY9ygCNDHVD69INSslyUpiahWWxTVmqrGhsAOwkshfe0Y6xY3XM5V5KrDCHNec9qlJfyPSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zh4yR4VDrz1d0KS;
	Mon, 21 Apr 2025 20:52:15 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 10B211402DA;
	Mon, 21 Apr 2025 20:53:12 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 20:53:11 +0800
Message-ID: <a5d1f436-9d31-407a-9653-5fd48f3dc80f@huawei.com>
Date: Mon, 21 Apr 2025 20:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
To: Christoph Hellwig <hch@infradead.org>
CC: Zizhi Wo <wozizhi@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
 <aAY0GNzcJH28OEtA@infradead.org>
 <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
 <aAY9jhJr1VOh0sMm@infradead.org>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <aAY9jhJr1VOh0sMm@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/21 20:43, Christoph Hellwig 写道:
> On Mon, Apr 21, 2025 at 08:22:53PM +0800, Zizhi Wo wrote:
>>>
>>> But I also don't understand what "level" even means here.
>>>
>>
>> The first "level" refers to the granularity of the tg; this flag needs
>> to be cleared when bio moving up to the upper-level tg, for example:
>> tg_dispatch_one_bio->throtl_add_bio_tg.
>>
>> The second "level" refers to the fact that throttle and rq_qos are not
>> on the same layer, so reuse this flag.
> 
> So the flag is only set while the bio is queued up in the throttling
> lists, and it can't be in rq_qos lists at the same time?
> 

Yes, otherwise they will interfere with each other. We can currently
ensure that this flag is cleared in the throttle process.

Thanks,
Zizhi Wo
