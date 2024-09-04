Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B8BA3F
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412725; cv=none; b=qC+OiFj4nl7drxKghOsIWCt66ejmRuxcJ2MI50GgNNEisZAmxNPpSgimPvMw5cSDnoYViNB+POo37H3WPGBZUFMOhx8K2oWMxwzIS2C0oMD14Ku44nA+ZEtNsiNHdLb1wno8efxiblk0X2K7+YaxzA0tYcwbFzImsjzxZhHsy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412725; c=relaxed/simple;
	bh=CodqKaitCiazl2n/OVRwrkt2VzNGET3VrDuAb6iT7j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l07VlotCIoJ9X46HEtykMCHoF63LIzgzWaQ2uALxQ8DUhqjKeWsn0PQVRGlnJ7/cMfRxCJBP9wYaWxi1MCU4OkT4IcvKgLB8+PWWMnY1smb2DQ89Nzm97u6JXEhskqc+UmRc33zK7Js1R/8wOmaIzsOw1wgZiyau1QvJ5yZ+1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wz4J8166hz20n9R;
	Wed,  4 Sep 2024 09:13:44 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id C33251A016C;
	Wed,  4 Sep 2024 09:18:40 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 4 Sep 2024 09:18:40 +0800
Message-ID: <7dc27d37-552e-4b55-b69b-43a93c7d9f57@huawei.com>
Date: Wed, 4 Sep 2024 09:18:39 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtip32xx: Remove redundant null pointer checks in
 mtip_hw_debugfs_init()
To: Jens Axboe <axboe@kernel.dk>, <hare@suse.de>, <dlemoal@kernel.org>,
	<john.g.garry@oracle.com>, <martin.petersen@oracle.com>
CC: <linux-block@vger.kernel.org>
References: <20240903144354.2005690-1-lizetao1@huawei.com>
 <3abb351b-64b5-4a11-a2c6-5dbb43ee98b9@kernel.dk>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <3abb351b-64b5-4a11-a2c6-5dbb43ee98b9@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100007.china.huawei.com (7.185.36.28) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/9/3 22:47, Jens Axboe 写道:
> On 9/3/24 8:43 AM, Li Zetao wrote:
>> Since the debugfs_create_dir() never returns a null pointer, checking
>> the return value for a null pointer is redundant, and using IS_ERR is
>> safe enough.
> 
> Sigh, why are we seeing so many odd variants of this recently. If you'd
> do a bit of searching upfront, you'd find that these should not be
> checked at all rather than changing it from err+null to just an error
> pointer check.
> 
> So no to this one, please do at least a tiny bit of research first
> before blindly making a change based on what some static analyzer told
> you.
> 
I have researched in the community before making the modification. 
debugfs_create_file can handle illegal dentry, but my understanding is 
that verifying debugfs_create_dir when it fails can avoid invalid calls 
to debugfs_create_file.

Greg suggested that I remove this check, maybe I can modify it in v2?

Thanks,
Li Zetao.
