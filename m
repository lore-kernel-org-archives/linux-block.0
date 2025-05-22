Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94003223719
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913245; cv=none; b=piXwXHXo/ekh9I/fwfPncmRXy6lo1Gn7EeSJYnxnEyjS87iB67xJzPQktRmDSWAd+j7+zNXkfLfPDl1L+3qtJzU0Mp9G5UhS1HnP/3rNSLZ7EJaIFRtiExisJhMZceJ2ApBmNEc2EB+c4SkBM6qRoICMuVqDKYMnIzPjoDIKw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913245; c=relaxed/simple;
	bh=X0gDfC2RpQaOH7vFWiLfH26Febwgm0KRoHS70UEF6HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e6GzAksQXF1tszv5RAd6LmzZdHT4puUUOuggGSzeN5wndu5BnesCTUDSEdVPQNgamS6Y3YAqXPatJoIYCao3M+5RyJtX/jQT4LL0j/xsJTWcU320cMXAVaKMqYg9TzA6y6IJOdTwmEBRsoBDE/M0OPywRKexjnqWRGgBNSTlNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MjoXuL+o; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MjoXuL+o"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250522111848euoutp013c989bfc029f1e93171dd83acdfa38bd~B1V2KPDgw3273232732euoutp01L
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 11:18:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250522111848euoutp013c989bfc029f1e93171dd83acdfa38bd~B1V2KPDgw3273232732euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747912728;
	bh=l+s24eypaDf7zjnOtGnIIv8VVeCv04V5DPbZIB0SWqk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MjoXuL+oSC1HCFEkH9EzENTH3LmWtGrMFMcbuH78r6DID8Sbz7z+CX6wgMStFpKN5
	 SJwn+5vtQiy1wFYloybYNmvNf9WYhOGT6VA+FS2MD+iLbWTssNQszOv07n9/jTcRp0
	 EoOkaG6y73vHK+OiEGddgeT5GZdigTn1DObLlusI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250522111846eucas1p123f862c088dd45caeb35de462acf06ad~B1V0j_zXP1449514495eucas1p1p;
	Thu, 22 May 2025 11:18:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250522111845eusmtip2ba127771859f6b7f1ee7e3def26a1760~B1Vz7nag01517115171eusmtip2W;
	Thu, 22 May 2025 11:18:45 +0000 (GMT)
Message-ID: <fe97e7ba-85d1-44c7-9de8-2082146f335d@samsung.com>
Date: Thu, 22 May 2025 13:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
To: Luis Chamberlain <mcgrof@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Cc: vkoul@kernel.org, chenxiang66@hisilicon.com, leon@kernel.org,
	jgg@nvidia.com, alex.williamson@redhat.com, joel.granados@kernel.org,
	iommu@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aC4IRTo_HBxv9dVN@bombadil.infradead.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250522111846eucas1p123f862c088dd45caeb35de462acf06ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250521170724eucas1p28e65ef0ade407ce9e2cfe0b72da26d7a
X-EPHeader: CA
X-CMS-RootMailID: 20250521170724eucas1p28e65ef0ade407ce9e2cfe0b72da26d7a
References: <20250520223913.3407136-1-mcgrof@kernel.org>
	<20250520223913.3407136-2-mcgrof@kernel.org>
	<e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>
	<CGME20250521170724eucas1p28e65ef0ade407ce9e2cfe0b72da26d7a@eucas1p2.samsung.com>
	<aC4IRTo_HBxv9dVN@bombadil.infradead.org>

On 21.05.2025 19:07, Luis Chamberlain wrote:
> On Wed, May 21, 2025 at 03:20:11PM +0100, Robin Murphy wrote:
>> On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
>>> Today on x86_64 q35 guests we can't easily test some of the DMA API
>>> with the dmatest out of the box because we lack a DMA engine as the
>>> current qemu intel IOT patches are out of tree. This implements a basic
>>> dma engine to let us use the dmatest API to expand on it and leverage
>>> it on q35 guests.
>> What does doing so ultimately achieve though?
> What do you do to test for regressions automatically today for the DMA API?
>
> This patch series didn't just add a fake-dma engine though but let's
> first address that as its what you raised a question for:
>
> Although I didn't add them, with this we can easily enable kernel
> selftests to now allow any q35 guest to easily run basic API tests for the
> DMA API. It's actually how I found the dma benchmark code, as its the only
> selftest we have for DMA. However that benchmark test is not easy to
> configure or enable. With kernel selftests you can test for things
> outside of the scope of performance.

IMHO adding a fake driver just to use some of its side-effects that are 
related with dma-mapping without the obvious information what would 
actually be tested, is not the right approach. Maybe the dma benchmark 
code can be extended with similar functionality as the selftests for 
dma-engine, I didn't check yet. It would be better to have such 
self-test in the proper layer. If adding the needed functionality to dma 
benchmark is not possible, then maybe create another self-test, which 
will do similar calls to the dma-mapping api as those dma-engine 
self-tests do, but without the whole dma-engine related part.


> You can test for expected
> correctness of the APIs and to ensure no regressions exist with extected
> behavior, otherwise you learn about possible regressions reactively. We
> have many selftests that do just that without a focus on performance for
> many things, xarray, maple tree, sysctl, firmware loader, module
> loading, etc. And yes, they find bugs proactively.
>
> With this then, we should be able to easily add a CI to run these tests
> based on linux-next or linus' tags, even if its virtual. Who would run
> these? We can get this going daily on kdevops easily, if we want them, we
> already have a series of tests automated for different subsystems.
>
> Benchmarking can be done separatley with real hardware -- agreed.
> But it does not negate the need for simple virtual kernel selftests.
>
>    Luis
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

