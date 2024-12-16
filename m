Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379641CDFD3
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389396; cv=none; b=PMwG1YEWVqKgdKYDflmms+7RP4Na4cX3ISjDy8Pe4xz3Yhykb+mapYWaJ+ij/8ovSPOik48cZKF2/fnyjkm6ZFNookiRgnlBsk1K7iL/LqWRsbY3SbdDypqpZP69hMS6UREqHMm9zKk3fV+852O4tPQ81ZDbhbGuINEBWe6V5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389396; c=relaxed/simple;
	bh=27dqV6+EdKdmGC3OctKBEZn2wyrvocivOLRr1NVRO2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+wuLX3SoF6mKZsUYwkC5BG1GI0ntEJ1Z2LsBj+pGGMo7SJePZ7mkM78IEaCuIkpWR8w48fKBoY71cdU1yYIDjXLDy3sQylYSMCJGZV+WRvZPTRc/Ua5SUGd8Bloke5PCQRmow0SMLWUOwInSQBddFPZBN3xp1hayxn5O9vuxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPBZ3OEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPBZ3OEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5299C4CED0;
	Mon, 16 Dec 2024 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734389395;
	bh=27dqV6+EdKdmGC3OctKBEZn2wyrvocivOLRr1NVRO2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPBZ3OEq7QuYOLA0HjitozJFqVYBx7164I4ROic6EI2WvbmKcSJ95gZjH24CRSJ1U
	 GjeQZbns0obTJ5gkt+5F6rtE0n+YEQon7BtBRr+Wari+07jIDeqxpzwYFLD8HWqqCi
	 HjODYWDdjBmuBgIzFBxeiEJWStlpdz1E6BkctKCdBzxsfX1JYbEuCr5t1jEXuXJ6I4
	 mAON+RhTClsXnMj/fLS/mhdrDHMJoShTTa6Ga7A/sjnYuoGxyzdpB+W0h/hiuwZb/5
	 b4IGYvT0Nm5M19IBIGtitpCydwbgAytGv1u/vvnUmJG8V4ZM19dzk2zsMQAQXjc7to
	 WNkrImZndJdtQ==
Message-ID: <f7aac753-3256-4b18-9212-79c2b043df2b@kernel.org>
Date: Mon, 16 Dec 2024 14:49:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
 <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
 <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
 <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:22, Bart Van Assche wrote:
> On 12/16/24 12:54 PM, Damien Le Moal wrote:
>> Yes. But I am still confused. Where is the problem ?
> 
> Here: 
> https://lore.kernel.org/linux-block/95ab028e-6cf7-474e-aa33-37ab3bccd078@kernel.org/. 
> In that message another approach is
> suggested than what I described in my previous message.
> 
> UFSHCI 3.0 controllers preserve the command order except if these are in
> a power-saving mode called auto-hibernation (AH8). When leaving that
> mode, commands are submitted in tag order (0..31). The approach
> described above provides an elegant solution for the unaligned write
> errors that can be caused by command reordering when leaving AH8 mode.
> I'm not aware of any other elegant approach to deal with the reordering
> that can be caused by leaving the UFSHCI AH8 mode.

Sorry, but I do not know enough about UFS to fully understand the issue, or
comment/propose a solution.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
