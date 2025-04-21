Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9FC1C2437
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238182; cv=none; b=CoUrdZ+m5fnzBctXi0qjFRwv78d/FIv7vgGMKWQ1pQZWHO6RwpzyggANOPWOIvVCP3d5DIf9jCSBfTyFVs4ViP+AC54Mf2gf8fgkbuoc80hoKwyaLb/PSJKroXDEnsYtYnHyHj4rX7PpBr2eWUM+39i+1seLqC96wImfZsIQqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238182; c=relaxed/simple;
	bh=834HEAXvyZFLAnYOsM9aNuC6lAbdlAH0Gw2LghTp4t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=amn9/ZTEOFy0cd7HK+ZUncntbrJH/wxIxIdWFg4K7AlukqjWAAj6nTo9gDSnHdHY0ahi2CLDAmZ0K4ABFnwQtna6g72Ob39HTMiAnUKpD216OVZbChC9mmKs5OyCjSnCalWzEetZEEiX437aQBjOVkPJ2OoLEJ97080VoF5Er8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zh4HW0Sk7z13LF1;
	Mon, 21 Apr 2025 20:21:59 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 93DDC140121;
	Mon, 21 Apr 2025 20:22:55 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 20:22:54 +0800
Message-ID: <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
Date: Mon, 21 Apr 2025 20:22:53 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
To: Christoph Hellwig <hch@infradead.org>, Zizhi Wo <wozizhi@huaweicloud.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <yangerkun@huawei.com>,
	<yukuai3@huawei.com>, <ming.lei@redhat.com>, <tj@kernel.org>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
 <aAY0GNzcJH28OEtA@infradead.org>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <aAY0GNzcJH28OEtA@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/21 20:03, Christoph Hellwig 写道:
> On Fri, Apr 18, 2025 at 12:09:21PM +0800, Zizhi Wo wrote:
>> +	/*
>> +	 * This bio has undergone rate limiting at the single throtl_grp level bps
>> +	 * queue. Since throttle and QoS are not at the same level, reuse the value.
>> +	 */
> 
> Please limit your comments to 80 characters to keep them readable.

Sorry, I didn't notice that earlier — I'll make sure to stick to the
80-character limit.

> 
> But I also don't understand what "level" even means here.
> 

The first "level" refers to the granularity of the tg; this flag needs
to be cleared when bio moving up to the upper-level tg, for example:
tg_dispatch_one_bio->throtl_add_bio_tg.

The second "level" refers to the fact that throttle and rq_qos are not
on the same layer, so reuse this flag.

Thanks,
Zizhi Wo

> 
