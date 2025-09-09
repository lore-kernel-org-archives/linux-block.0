Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F31D38E
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437767; cv=pass; b=og/eUycCY1x1yF3C3tB7NJeh4GTzch+/d4NPjLs3UN1I8PnQwoJhMbAsHddVtDu7VsS+1UR2iay98TPlqW/1PGMgu0GiYaRyFgLEzsW57VS9UcSYCsA8vxG5plTySqUPmlsqNM47O4lq2vegBuWHklrI8o6t6iCKY8MhDYP1OQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437767; c=relaxed/simple;
	bh=kmqUQgrZCWuj2L/qvkPpYKQ1uITSSTVZ/zBzOxnitaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCmtVh3WrWpj7JYZ2LaxA6Hj43stvawHaeLb6JisgI5Nfqh2lya22JbLoYXJDzD99EAnNM9gAnrZ1eHDw/fjDfNtX/stWIw0m0+uFrP4KDTmk6uQCPQyjb7WGOZttHUFJVg2Aznii4PQcIH+H/6vB3mTT39GSEs/zRdcZnf60+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=K10UL1Wq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="K10UL1Wq"
ARC-Seal: i=1; a=rsa-sha256; t=1757437752; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SUgPqRPn1klmOBx9hVg182J6V08u5uZCOV3Wz0RuRVQreBVlBuu+gC6PkBtdodxqkWG3UkLgHWkMEvsHpuBKQorWy1ukM8+WCX/Z/kK/B69yy9vtQAsNt2OjwXhMvXvsic2QmPryKoH/gO4lajmJwUzO7tGoVGdglD/Kx77VsJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757437752; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rjOVQsC1oQbcBwBkyjeMi20Ye7E+OhBdVCB+N2M3qto=; 
	b=RAnASLCI1gCN0v5tp5vpMfxbyaftuZ6RrVhGEkG0hl9WhLY/v2CJKlqmL8bDBEVGKoEh47QXfWzko6tlHLRLT3YwVxkf7e8MCi/Dfv+SRm7+fOKPztySgQkNHC4ArHqtva8NxzO2USNepP78ZSn79hnweWm6oz0sEIqGXRMvZN0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757437752;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rjOVQsC1oQbcBwBkyjeMi20Ye7E+OhBdVCB+N2M3qto=;
	b=K10UL1WqX1SismNStKYjFeIUsYeXao1NXlCA8d/lAzyvRkfW08OTpLIst7JodE+t
	/emPe1pIHtQKGawTVLBMXIBNykvWrLyHgzTvHQWw5JcGMtCXh+riD8LLYlOKKokHk+g
	lIG7DOod2qzmFnvdGDhyA+BGQChOISNtB8cs3j0k=
Received: by mx.zohomail.com with SMTPS id 1757437750475716.9676216369968;
	Tue, 9 Sep 2025 10:09:10 -0700 (PDT)
Message-ID: <8a9aa1af-9142-41d5-b229-7deddd624b0f@yukuai.org.cn>
Date: Wed, 10 Sep 2025 01:09:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250909
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <hailan@yukuai.org.cn>,
 Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
 <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
 <fdfcb000-916b-4599-b75c-1b4680accca7@yukuai.org.cn>
 <16a63a35-9a44-443a-8f59-e60afbfbfff3@kernel.dk>
 <af63883c-2cfb-4cc2-8b9d-979ecc5187f5@kernel.dk>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <af63883c-2cfb-4cc2-8b9d-979ecc5187f5@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/10 0:54, Jens Axboe 写道:
> On 9/9/25 10:51 AM, Jens Axboe wrote:
>> On 9/9/25 10:44 AM, Yu Kuai wrote:
>>> Hi,
>>>
>>> ? 2025/9/9 21:26, Jens Axboe ??:
>>>> On 9/9/25 2:20 AM, Yu Kuai wrote:
>>>>> Hi, Jens
>>>>>
>>>>> Please consider pulling following changes on your for-6.18/block branch,
>>>>> this pull request contains:
>>>>>
>>>>>    - add kconfig for internal bitmap;
>>>>>    - introduce new experimental feature lockless bitmap;
>>>> Can you write a bit of a better pull request letter? It'd be nice to get
>>>> an actual description of what the "lockless bitmap" is, and why it makes
>>>> sense to have it. This is pretty sparse...
>>> Of course, details in be found in the patch 0 of the thread. I'll send a v2.
>> Please always write a decent message on why any pull request needs
>> merging.
>>
>>>>>     https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
>>>>>
>>>> and this is a new source for you, is the above tag signed?
>>> I thought they are the same, I'll switch back in v2.
>> They are very much NOT the same. One is some random site, the other is
>> the official kernel infrastructure. If you don't use git.kernel.org,
>> I'm definitely not pulling anything that isn't signed by a key, and
>> that key in turn has been signed by other people I know.
> Oh and since I keep getting these, the last 5 pull requests you have
> sent me have CC'ed:
>
> inux-raid@vger.kernel.org
>
> which of course doesn't exist, and hence the md list doesn't get
> your PR emails, and I get failure notifications when I reply.
> I'm assuming this is in your scripts somewhere, and I keep
> thinking "it was a typo, hence a one time thing", but no, it keeps
> being there every time. Can you please fix your script to use the
> actually correct email?

Of course, lessons are learned. Sorry for the typo, I just checked and
I do get the failure notifications as well.

Thanks!
Kuai

