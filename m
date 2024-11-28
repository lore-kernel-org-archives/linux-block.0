Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A21FAA
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732770480; cv=none; b=a01gDr9HWH/ECQp0vheaOsQMM72PW2MXt9vEEIYl3p5jfhtY276TcwZeUntADYpi2Lyf5+Uevqws0CQtI+ci21bdp+Wdvjl3oNoMh3UJm3oR2LytLhTrmApxSCV+FfMQgqwoVt5mLvi6GvN8A05A+ZUfWeXaIWjgmg9gR8hbyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732770480; c=relaxed/simple;
	bh=JRTRO+W24yMLxWig6oLukl1UGyK8/bswYVXlu93dAhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq2aS7nKKocR2NlXcifO7LzuSYg622JMIH8ohVJhT0grhFiwKOKvi8doN15AF43baBEp49LdRYqcU2TgN9FRI9WTLme0hl8+4qqhKCm7pmbCde9oVs3zsrlIPJGVj+Ocmj4uskuTX2XZOe6mfxTswA2HAum72echcd9luELyTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im3cQmSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im3cQmSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B6AC4CECE;
	Thu, 28 Nov 2024 05:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732770480;
	bh=JRTRO+W24yMLxWig6oLukl1UGyK8/bswYVXlu93dAhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=im3cQmSbIZIeg4fNTXxDoHLSn2N9urNLqBMmga9fMCKxRW3S5euZx6yyOl0DZQzK6
	 eQtwKfP0hoMLtf5fZf8ynqn/TVZgQJIj8oXyCI5syfkCqg4AsCtdm26upaJ64ffhWw
	 2JyK9qOm+ADq8zxh+CjOXJ5OUKz2ySQVKNoFf8bIHd+8wDf98W6mmKS5wE8e2ExzMB
	 9IsLdk5EOfN6l92TnvtzT9nRm7t9d/wwSmEptLU247cK/N6UwKGhFhGqe4lEpMrszd
	 Dp6XR3EAkfPtro4zvYXjT0YogQEr1GbvNnSZGi6PcbvE3mKmbIBYeqpRX/y8cKCI+u
	 F0Q0M3qubbMPg==
Message-ID: <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
Date: Thu, 28 Nov 2024 14:07:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
 <Z0f47wft_sVto7pM@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0f47wft_sVto7pM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 14:00, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 01:52:55PM +0900, Damien Le Moal wrote:
>> Same: the user must do a report zones to update the zone wp.
>> Otherwise, it is hard to guarantee that we can get a valid wp offset value after
>> an error. I looked into trying to get a valid value even in the case of a
>> partial request failure, but that is easily douable.

s/that is easily douable/that is NOT easily douable

> Well, we'll better document that.  Then again, what kinds of error types
> do we have where a write fails, but another write to the same zone later
> on will work again?

A bad sector that gets remapped when overwritten is probably the most common,
and maybe the only one. I need to check again, but I think that for this case,
the scsi stack retries the reminder of a torn write so we probably do not even
see it in practice, unless the sector/zone is really dead and cannot be
recovered. But in that case, no matter what we do, that zone would not be
writable anymore.

Still trying to see if I can have some sort of synchronization between incoming
writes and zone wp update to avoid relying on the user doing a report zones.
That would ensure that emulated zone append always work like the real command.


-- 
Damien Le Moal
Western Digital Research
