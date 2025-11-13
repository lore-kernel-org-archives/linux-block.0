Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F611CBA
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001851; cv=none; b=rce/0ljB22kvTAS8J8ukTYKEWx603HJXrUVavoMiSYNSTHNezW8LDLsfTS+HYChkywplnWJwUALb5PG/VDO1ObgTox9/ymb2NFVRVLpWEGxeuW7gGE1VYork0w+pNkLkHtZPUlkCmZy7tKQxmJaGeoQLtziMmh5kRAjc7BbNJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001851; c=relaxed/simple;
	bh=TPqHat46NFXHmeHK6C3L1unAyrwmVTPumXjiBkcFu8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFmMe6hE4iHC578S7RmOMNobEDKmAdLK4L2pAY1R8CS4wHsffgABG/Cj/WSAO9qpg+zOGmBRdqEffvkpShR70TH+BsibDbkLxJoRRPEp5UZNC0/firyQJCrHbdFiPfo0unLTIpfnlR1HaFKTR9EUIpJRBCauPSxVNaK1mZr/naw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRm5Y6B/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRm5Y6B/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AE9C116B1;
	Thu, 13 Nov 2025 02:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763001851;
	bh=TPqHat46NFXHmeHK6C3L1unAyrwmVTPumXjiBkcFu8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRm5Y6B/i6UHKwZpu0KrtlXwH0lpo6u177GCaJiMhIJeAX2/8PmtTOgR7Gdx3GF0y
	 EGWX4xpLkBQsIWmEYOctf+APhR9+hdJE5OVMBfiY5WFFJ8mv8GGbx5KzsoK6xKJLB3
	 FU37Lrj81qBxaMcPGqTRrR+jOpgniwz6dVvaE27GJo/Aiy9lk3Gt+S2Ph0H4VLlDID
	 K47d6PEa+pJMuvaQkyJW9NCftRVlmLnS7YlSDXPO9Q1nLj9YxtVR0eVt6b3iYBr1Gx
	 4aSKax2KkU91mR1tkCdAsOB9V+eSFq5pGS+Gz1Li2MDYmE8kFRGd+OGZAyVtY7ec7G
	 S7zNfS/KssRWQ==
Message-ID: <91499f59-2144-449e-830c-2f839db4dded@kernel.org>
Date: Thu, 13 Nov 2025 11:44:08 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix zone read length beyond write pointer
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, bvanassche@acm.org, linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20251112164218.816774-1-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251112164218.816774-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 01:42, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Fix up the divisor calculating the number of zone sectors being read and
> handle a read that straddles the zone write pointer. The length is
> rounded up a sector boundary, so be sure to truncate any excess bytes
> off to avoid copying past the data segment.
> 
> Fixes: 3451cf34f51bb70 ("null_blk: allow byte aligned memory offsets")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
