Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78548A2D1;
	Mon, 12 Oct 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809186; cv=none; b=gsVbN2u6YBUKJ59+S44iVxaoeCjTOk4FPR/qbdIvCFzzOKzThb9YhIFP88ddszvlpHTezr73ve+xR4eM6w5i9mwu0K150Vb6Y16SVYVi6NXJY6v4uxrgoAVEQNQbN8N8IpZ6fPfOeN9rfpwZ98A4zsEexFYZR1yGUGb7Cs+hREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809186; c=relaxed/simple;
	bh=nq42yptSw/RlcpiwDOE5kUYPRplLqvQjbJSAYj+oX3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tk9EXtpOKXNTiAFKJx/SXmHQME6aRDiX8vZy04IjyzK3FSwMmB7Yu1taxQi/IJQitUhXxGMTdfYU92jBONptqXfnEbVX3/M8+whZEzKqFG+WkBw00gs6SB5P8pwIFWW51uwBqHteUsQV9lZcmz9sJnue55EcJZPJuiKT9LukW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH7pDh6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH7pDh6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959B91F0089B;
	Mon, 12 Oct 2026 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791809185;
	bh=QiEZQ7DvZhE3m3MhQISynkWcztSVNF+s1I8gL37uXgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LH7pDh6Jhr2bo9Of+JFs0lD+77L+6IoaBBIagPkMHHr4p1pLXXMESTnjuHlpDBFMt
	 W0uI94kdjdme0JdIPl0fCPiJ9rMv/yW5ExhAUuPntNLCaEFknsr/EWRmE/A8qmCGRf
	 3xnNS5cDJZrFrWxptdveR1sjBTKszUrOxj4hyqyZw+szjDJk8hvlCMExApoDKUxOY2
	 DfeSwyudoPnK/tWP+e9kE5jPEITYwVk8ZeJtPP9kFkwQOXIi6gyKmTEnJpEfaXYstk
	 u+gPetdgaxvmmrO+wpqVKCON8EF/og3cQ2MmUlq2xUpoFQzazp7YRUw+aiQsmJo6tX
	 uiwmBcG45arzQ==
Message-ID: <cfd38ed0-4e3f-4276-97a7-e172922d4ef6@kernel.org>
Date: Mon, 12 Oct 2026 14:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in
 blkdev_get_zone_info()
To: shashank Jain <jain.sm@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011051906.60397-1-jain.sm@gmail.com>
 <20261011051906.60397-3-jain.sm@gmail.com> <20261012122112.GA31242@lst.de>
 <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
 <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org>
 <CA+FWx=kgeR8tz46tijYE-s=v+PTJjGfM+3ucQOo0ZuDyqFdYQw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CA+FWx=kgeR8tz46tijYE-s=v+PTJjGfM+3ucQOo0ZuDyqFdYQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/12 14:41, shashank Jain wrote:
> On Mon, Oct 12, 2026, Damien Le Moal wrote:
>> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report"
>> does not have that yet. I am planning to send a patch for it.
> 
> Good point. Two options, and I am happy to follow your preference:
> 
> - Use "blkzone report" with the cached flag once your util-linux patch
>   lands - that matches the existing zbd tests and avoids a bundled tool.
>   I would hold the blktests submission until it is available.
> - Or carry a small C helper in the blktests src/ directory that issues
>   BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED directly, so the test is
>   self-contained and does not depend on the util-linux version.
> 
> I lean towards the first, to match the zbd conventions and your blkzone
> work; tell me which you prefer and I will align the test with it.

Yes, let's avoid the small helper. Having access to the cached report with
blkzone will be useful for many things anyway, and the patch should be easy.

-- 
Damien Le Moal
Western Digital Research
