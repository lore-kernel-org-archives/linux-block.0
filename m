Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BAE351C22
	for <linux-block@vger.kernel.org>; Mon,  6 Jul 2026 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306374; cv=none; b=q9iiGdlx1EEwO2NmQY5mzBMROK0N3wKdT3YawEHvdFtWCWRScUHouz6c4Map83m5o5itqicD4KtaBuvfnJxj8vMmGXHXJA3UKhvIUQKYvjPIzUgKWhEYwcB13tTrq78mSayhhhNWl0wD5MI3k+Tc5d0FRoc4itn62gyn6VX5iyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306374; c=relaxed/simple;
	bh=+J1zsp9AsIYHpxJiTcN+h/u1boGv2FWFgtHOEwoVdXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L61VtygGKKlHdooLmub1+5BUIoXBjscOgnm35tOhNrKwvR4o2s77nvQN95GU8Wt/Cz9E56mrNeX7SqmzcvrOO/wDbef9gSpfnfzWpqnzRi7wUQvI7rFQgMBfUXJw9VhvgQXyRAofSqKE7gEmDgsKM7DRIuV9S+3BzUTUTqINtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A43vFO46; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A43vFO46"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LZQUYh6PUVtEJYKAfkZ1pxp5ssa4uHVmRk1UcW+yKbQ=;
	b=A43vFO46q1/PaD0m9rYfhsHSJPUMyx+efIPkI+15bNft4QICONlhFnM+qZUAVE0iL+QXgR0zn
	RzLnvE4iQ0AK2BavYCZhc71/64iYDjjo+/52PCVlTFkjN5mO3X9/Z82Q3GJvrvvrPO8foh/SZC7
	Q+WIZDVhUxLO5x29djKbRE0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gtpZT6kpdz1cyPR;
	Mon,  6 Jul 2026 10:43:29 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 2272240578;
	Mon,  6 Jul 2026 10:52:41 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 10:52:40 +0800
Message-ID: <f84f8508-3752-4874-8222-04739d8c9568@huawei.com>
Date: Mon, 6 Jul 2026 10:52:39 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nbd: replace socks pointer array with xarray
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260625084458.4171890-1-yangerkun@huawei.com>
 <20260625084458.4171890-3-yangerkun@huawei.com>
 <913d11fc-0fb8-4111-b995-7fe7e893025e@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <913d11fc-0fb8-4111-b995-7fe7e893025e@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/5 18:02, yu kuai 写道:
> Hi,
> 
> 在 2026/6/25 16:44, Yang Erkun 写道:
>> Replace the krealloc-based struct nbd_sock **socks array with struct
>> xarray socks. Each nbd sock is fully initialized before being stored
>> into the xarray via xa_store(), ensuring concurrent readers calling
>> xa_load() never observe a partially initialized socket.
>>
>> Convert all array index accesses to xa_load() and open-coded for-loops
>> to xa_for_each().
>>
>> Signed-off-by: Long Li<leo.lilong@huawei.com>
> 
> xarray may not be good idea for IO hot path because of the overhead.
> 
> https://lore.kernel.org/all/60f9a88b-b750-3579-bdfd-5421f2040406@huaweicloud.com/
> 

Hi,

Thanks for your review! Yeah, this may lead a little overhead for io hot 
path, I will try to find another way.

Thanks,
Erkun.

