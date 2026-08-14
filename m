Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FC40B392
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695937; cv=none; b=lU1eq0m49G9LhQE2+cNiLvAzrRH0wGtBdZJfJW/38y8AjpFVMsb8PooBFR08yfByjjIH54Bv+39BnAJaHn9kzyXqbbfBYQyjPK3Wr9zzBRPXEFnyo/FIjof44dV/aQlmxGwRWN5/OXk+Ea1/pGVm/aJgX2LXW15xqOP/4eY0fhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695937; c=relaxed/simple;
	bh=F1EFw00Y+eNeMB1mtVfgi0PZvqp65DW2EjYnhBHiFic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=draUglfei3qVlB/BPeMYAXlRPrq8dd51h4YbAHb3vV/STJr42+kfvTsQxyPimM6G4m6FTuv/oRiFSF2mf1jMraTsSFRigIO5g+P0oFYy8tmc6RrhaM0ACrGHUBiW2sqWu/9akoO1MFKw3OZfhv+QavF0gcH3hEO03LM25FnbJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VguX06X9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VguX06X9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EB31F000E9;
	Fri, 14 Aug 2026 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786695930;
	bh=sclt1yjfHHQkKoAbO/+/T7vgrnadrJ4JaWZLTVSPipM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VguX06X9c0JU00J0njnWtMudm9o51QB3Jh6EozRVJWUg759OtqH+SQdl7gCOeq3XD
	 8dFNv5dvlMo17XQdmlZMCt5V1YbEIbzhidD4DXlKEKAI20VPAjM+PUdyRstIBdyLNC
	 I1GJ6JXCCWpwSkmlP08meO8R02lI+xptTlE6grJTrG58CYCaxGWoJ12rChTNE2sfba
	 QmXZZv9jAFJUOeJ1N/b1u3hLu2Mb1vDVlMyy4UVRMgRv6dEJIc6+Mbt+/GjCoE5NeI
	 VlGv3akf9TAdcVOkGK4EOrrl2Jit31/e66zZklsEPvGV7esEuvQMLG9JBzJjQdPdBe
	 0ZTkux6orEJZQ==
Message-ID: <7295448b-6636-4b61-b93c-94e4b1880663@kernel.org>
Date: Fri, 14 Aug 2026 17:25:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] block: fail zone management operations to
 read-only and offline zones
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260814063201.1762743-1-dlemoal@kernel.org>
 <20260814063201.1762743-11-dlemoal@kernel.org>
 <20260814080801.GE12566@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260814080801.GE12566@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 17:08, Christoph Hellwig wrote:
> On Fri, Aug 14, 2026 at 03:31:58PM +0900, Damien Le Moal wrote:
>> +		if (!bdev_check_zone_mgmt(bdev, bio->bi_iter.bi_sector))
> 
> bdev_check_zone_mgmt fails like a bit of an odd name.  Why not something
> like bdev_zone_mgmt_allowed?

Indeed, that's better. Will change to that.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


-- 
Damien Le Moal
Western Digital Research
