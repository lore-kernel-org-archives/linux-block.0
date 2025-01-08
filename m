Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD619DFA7
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313116; cv=none; b=M6MS4y0sV1DIoUCZpNwThwousqi6JIRH5KTAvI9J5qG5VfQUa54E/oW7TfMdr29RiveSjP0RaDyAJcYlBvSV0NVG6CF7Knp7YlX0BNwUlB89LFXiHmB1muJ69RqK3DOXP/MOQgYKzmQJNMfBk2e9/xDZh8Ld4MtA8wXtndY/HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313116; c=relaxed/simple;
	bh=5KpxhkySZiULlW13tJLNtzMCheiSh8i7gl8Q9s5OMYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqSpS/O+crgKNNR95pLvFuHsFUvJEwxTTdWFFTN5ecbiNX5P23RAVrCXc9zXzPmpJfxXz3CIcImsPQ4Xa5GoW+UYPkagdyQruEfwOYR1dN25FW7EVXCKP5VMJxVMakX4ZeoQNgir6+OjabPBjoIify0eUFTbN7FTBLsPxD2unZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4mIATOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4mIATOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62339C4CED0;
	Wed,  8 Jan 2025 05:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736313116;
	bh=5KpxhkySZiULlW13tJLNtzMCheiSh8i7gl8Q9s5OMYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V4mIATOi3XvARuoSXS/jJ/R48zjerfKB6kYlF62KobXWeHrNxvQ8rLdki9mbk86em
	 80Pe/e1ghLQaC68uqrHeUB84OIYSHIbZw/1PFJntvXCsG4ZFk3kVJpv6JuJAPQ1u0r
	 Sxy9z8qsfoJqgzPkq4p70W0Rg3FR1o9NtD2SSDQj7bLxXXvpKkCrMwtSDNckiRwSPn
	 F6U91un84D9HzcqR3Au+jbDBMExtWCStsg8ukkOdRM3tFXZTj4IQ6d5hE8ipp3mgLQ
	 q5/TT83de2/G3AOUuaVOIu1UM0sva6cI/TlZvrnokPDSjvOGD7dXsXfmltQQ2As4dH
	 s8ZsHu0PWdgHg==
Message-ID: <3635a8f9-e4fa-434b-aeee-95477ed4f6e8@kernel.org>
Date: Wed, 8 Jan 2025 14:11:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
 <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
 <606367a7-9bb5-48e5-a7ef-466eefd833fb@kernel.org>
 <3a1314db-ed44-4c22-8fc1-0cf672003026@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3a1314db-ed44-4c22-8fc1-0cf672003026@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 6:08 AM, Jens Axboe wrote:
>> A kernel-based implementation is simpler and the configuration
>> interface literally needs only a single echo bash command to add or
>> remove devices. This allows minimal VM configurations with no
>> dependencies on user tools/libraries to run these zoned devices, which
>> is what we wanted.
>>
>> I completely agree about the user-space vs kernel tradeoff you
>> mentioned. I did consider it but the code simplicity and ease of use
>> in practice won for us and I chose to stick with the kernel driver
>> approach.
>>
>> Note that if you are OK with this, I need to send a V2 to correct the
>> Kconfig description which currently shows an invalid configuration
>> command example.
> 
> Sure, I'm not totally against it, even if I think the arguments are
> very weak, and in some places also just wrong. It's not like it's a
> huge driver.

I am not going to try contesting that our arguments are somewhat weak. Yes, if
we spend enough time on it, we could eventually get something workable with ublk.

But with that said, when you spend your days developing and testing stuff for
zoned storage, having a super easy to use emulation setup for VMs without any
userspace dependencies does a world of good for productivity. That is a strong
argument for those involved, I think.

So may I send V2 for getting it queued up ?

-- 
Damien Le Moal
Western Digital Research
