Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830ED158DD1
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460750; cv=none; b=Lhu4R73jAsY/5tWOHvLuku1f57RqmixAfag/vDKKNP+vafz+ddXJ8HxtdcGlDUJPxxfhNP/K5D9QLmU+vmkZKJR5dXbk2x91ngWLUd84GptOEy9w2LXOXP/95hJtQ0TLXSY62Kri4t/yqNlfFT94PF7Rd5wAqq5efqUSf/l5jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460750; c=relaxed/simple;
	bh=JQHscseQBbHQQnhOAR2H7xIfOOxihelK2lbYNTZ16I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nir3FrL+grQXqsHOOwIGvO9GYNBwxvM8H3Yob2HnPuS58NBQImahHpOR7iqghIEmD6GC6YKKGtkIb/7P0j8lwad1H/B60WZvqc5i44hA8K0ECIvMKFkv6fva2NceYgeud2mF7/ba4eC8ZwAyNKvN2X44u839fkSoO+/n1C6jOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IBULp8z/; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IBULp8z/"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCQZG2lSWzlff0M;
	Tue, 17 Dec 2024 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734460740; x=1737052741; bh=pXz3jsV+/MlbXz5KyAtbEoMm
	B3nF1NuMMgw3l6s/oTc=; b=IBULp8z/69ns/LNh90sX70IlFNGqgXPgGFYxcJOC
	HNx9o0K5H/ndRPV8jz6Pd1czE6XSYNp0esNzI0WLAo70l39nuJR/hY5dcEN1NTn/
	Fn/oGHyxZ/sETbxV66Iqv+Y0CStGBPItLACWFQwJ9biy90WOzg52tOfwJdxuyHlw
	99VHIPuUVxeAJMIHctayMr/dUL4R69udWmGizVTiUupaKbfLIrVh1WrdsdGt4tsn
	CT+XRIFe4yvbERNqSje92OQWLFDGHsH7cIY9d2gxU7Hr2nPGeTsoV26WBWcvWvlz
	ufEBT+hXRXATcaLA7yfTejCrzn9b3cJlmM2ROk36ax+F0Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7FiZOU2eVJxX; Tue, 17 Dec 2024 18:39:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCQZC64RDzlff0K;
	Tue, 17 Dec 2024 18:38:59 +0000 (UTC)
Message-ID: <edd45063-f6ea-4315-8ae6-d9d8d73ff37d@acm.org>
Date: Tue, 17 Dec 2024 10:38:58 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 7:04 AM, Damien Le Moal wrote:
> On 2024/12/16 20:15, Christoph Hellwig wrote:
>> On Mon, Dec 16, 2024 at 11:24:24AM -0800, Bart Van Assche wrote:
>>>
>>> Hi Damien,
>>>
>>> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
>>> against all kernel versions I tried, including kernel version 6.9. Do
>>> you agree that this test should pass?
>>
>> That test case is not very well documented and you're not explaining
>> how it fails.
>>
>> As far as I can tell the test uses fio to write to a SCSI debug device
>> using the zbd randwrite mode and the io_uring I/O engine of fio.
> 
> Of note about io_uring: if writes are submitted from multiple jobs to multiple
> queues, then you will see unaligned write errors, but the same test with libaio
> will work just fine. The reason is that io_uring fio engine IO submission only
> adds write requests to the io rings, which will then be submitted by the kernel
> ring handling later. But at that time, the ordering information is lost and if
> the rings are processed in the wrong order, you'll get unaligned errors.
> 
> io_uring is thus unsafe for writes to zoned block devices. Trying to do
> something about it has been on my to-do list for a while. Been too busy to do
> anything yet. The best solution is of course zone append. If the user wants to
> use regular writes, then it better tightly control its write IO issuing to be
> QD=1 per zone itself as relying on zone write plugging will not be enough.
> 
>> We've ever guaranteed ordering of multiple outstanding asynchronous user
>> writes on zoned block devices, so from that point of view a "failure" due
>> to write pointer violations when changing the test to use QD=2 is
>> entirely expected.
> 
> Not for libaio since the io_submit() call goes down to submit_bio(). So if the
> issuer user application does the right synchronization (which fio does), libaio
> is safe as we are guaranteed that the writes are placed in order in the zone
> write plugs. As explained above, that is not the case with io_uring though.

Thanks Damien for having shared this information. After having switched
to libaio, the higher queue depth test cases pass with Jens'
block-for-next branch. See also 
https://github.com/osandov/blktests/pull/156.

Bart.


