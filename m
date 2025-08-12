Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA21B0437;
	Tue, 12 Aug 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986969; cv=none; b=YN9h2LGVJzDUY9DJ1hhm+DcziNwkQ89nBDqdODTRhxfQyQc1RCA5MdgDYbZLcNTqhoFtmg9Dgsn8hklngHNKxFTvoc5MMfko8aPIpcmUdaNLtrDC2Vsn8Q5sAQ3EDvOfv0p8wGEyra9mUj8GmJrI9a+Spm2504H4hSrWZFxdOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986969; c=relaxed/simple;
	bh=SOEUCvkrPLt2cHYTej/oN0PrHTSMKACUoX3UK91QOnc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kuCIpx0No9hITnMQwsi7lGAvi70TTDCnW1mY5kuFC/qVLGFkjLHmW3r+upERxR6UmsdEBKLKdNCV2b/bNCHardTuQzCj89DsHsVWpsh9bZyJtcJ6QVxndSRSSfIYXFUB5LvCtWm7KBf1+ky+IiJo2bEVCmaPSFkGfXyezURud0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmuKztNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmuKztNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B7BC4CEF0;
	Tue, 12 Aug 2025 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986969;
	bh=SOEUCvkrPLt2cHYTej/oN0PrHTSMKACUoX3UK91QOnc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DmuKztNSYXOf9162p+KgvmQJqJ7Lo2pii4ZU6f4YPV/QG3AgElpCsFbknaVQXDrgi
	 jBXA/1r1k2vKNTTYj4RyHwDBMLN/FV68Xzr5p13a7pZtXFhvnJeYMhrSNPKJE3Vzyv
	 DoxyxCPRfXoOIvpwrsjrHdytr2EFvVz07mqFe+K6FwvIadT5wxHkSnaPs9u4Cuc2GE
	 6mOcqTi4++iVqHu/KeNhZN3hOjqDdHIlle/vy8d+dbGc0+2YMpYGbJOVcECjAhFGg+
	 +P0C6dNHxCaP7gQu4C8VNM8Z2Z3U6pwurWGjnZUKTwguhA6pimV0t3vPVfrd17CzAj
	 5i2xWUqPfA1Eg==
Message-ID: <16753b65-326d-48ba-90d2-476380455199@kernel.org>
Date: Tue, 12 Aug 2025 16:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
To: Christoph Hellwig <hch@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
 <aJruCTOjcj1nEk-S@infradead.org>
 <dec5b832-53f1-4274-902c-418f01df9458@kernel.org>
 <aJr0Tk36ZNiCg8mQ@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJr0Tk36ZNiCg8mQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 15:59, Christoph Hellwig wrote:
> On Tue, Aug 12, 2025 at 03:53:54PM +0800, Chao Yu wrote:
>>> What did you use before?  At least for older qemu the default was
>>> buffered I/O, which can lead to very expensive fua or flush calls.
>>
>> Previously, I didn't use any cache= option, as manual described, it
>> should equal to cache=wrteback.
> 
> Modern qemu actually split the cache option.  You absolute want
> cache.direct=on.  If you don't do simulated power fail testing by

Yes,

> killing qemu (or run real workloads for the matter, but who does that
> :)) it might make sense to just ignore the flushes with cache.no-flush=on

Yes, I don't care whether data can be persisted to host devices or not,
nor killing qemu for test, so cache.no-flush=on looks good to me as well.

> as well, which is what I do for my test VMs on the laptop.

Thanks for sharing this, it helps. :)

Thanks,

