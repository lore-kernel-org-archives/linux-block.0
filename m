Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0126ED41
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535385; cv=none; b=ihw0CEpfFfDYdWUhxYyqeYifCpXIQbhoB/bmlCRo8IFx8eSn0Nla04evdxSDvDmuGJtjhfnMZqb6U50vDpnhqG6BPG3h9VT9/+2WbMiBgLJXaHcaxEncbpOR3Qj6onDfIt/q0OSv8fpQFfe9rxJa8jcwtTyn/qAhHLcwbUkg1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535385; c=relaxed/simple;
	bh=mPAq5+asJ7o2U0fOuz39BSU5/wGN4leDAbVwSYeuIJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HW6g9Eo/9l5niI2ub7ehJSNtDZ5eBluyrShwhgEHDhja1GTzYoYz2eEC4ov9IpziECU5zuYd4RL7kPhSSkyfjzr97UJGSPrsh6mhhortZk8msoMPJd7dYx9pmY/kO6nXPpuT1bTi1f3iRCOi6sogOhD5NiUwydSrMz+d4gta0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym3acyri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym3acyri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28561F000E9;
	Mon, 24 Aug 2026 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787535384;
	bh=GmYsoaplFsPAbaWpmFJY6zU/YMFFnddk3vuCiUQA0YI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ym3acyriao+14NfJx2m15FPCVk4E5MAESmv2ztRTWmUvE8fXF5G3BAwwWMKC601Cb
	 YToBpZdHPQ4oxPfR11gZzSibbshlm6qjdj1xLKN7+iMUzHhWcWVELVZy4KjrAsyhWp
	 dbv3TSUc1spXeZgaXrKeKXA210ugwrsv3pCplZ3ZyePTubXHkX0HjHXLq1mrwMyDav
	 +rUaBHq+S6YAXvxqO7iWrdvp6ijyG759LRO+PhWfogsozPhYddExF8WgWwVQ/u49O2
	 DmxGre+MFvBB7QZU4DMZmQgQOeVuqtMyScmUV9idC977aB+1fpXnb0UBHYmvr4J4l0
	 TdHdD5UnXYD0A==
Message-ID: <3cfe7ce2-ed79-41fe-b73f-d4d416169a8d@kernel.org>
Date: Mon, 24 Aug 2026 10:36:12 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seagate Flex SMR
To: Noah Bergbauer <noah@ehvag.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
 <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
 <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 01:45, Noah Bergbauer wrote:
>> "Flex SMR" is not referring to any standard feature. So it is hard to see what
>> you are talking about. In Linux, we support only drives that follow a standard,
>> so for HDDs, that is SPC/SBC/ZBC for SAS drives and ACS/ZAC for SATA.
> 
> The specification can be found in T10/18-007r0. It's not exactly ZD/ZR as it
> seems to predate those standards, but it's close.

This document is a proposal, not a standard. Some aspects of it are likely
integrated in ZAC-2, but if the drives you are talking about do not follow this
standard, we cannot support them.

>> If you want to run a file system in domain 0 only, simply activate all the SOBR
>> zones in domain 0, make sure the SOBR zones are all initialized (written) and
>> you are done: the drive in that state is equivalent to a regular disk and
>> everything will just work fine.
> To be clear, what I have implemented is all about running a filesystem in
> domain 1. And I want to push back a little on your claim that this is extremely
> hard, because in a handful of small patches totaling around 500 lines of code I
> have found solutions for all of these challenges. I am running btrfs on the
> sequential zones and it passes every test I have thrown at it. I can show you
> the code if you like.

You are looking at this very narrowly. The simple fact that you now have a
drive that reports a capacity that is nearly twice what the drive can actually
store will likely cause lots of problems. Also, you may have patched BTRFS, but
what about XFS, zonefs, and device mapper (dm-zoned, dm-crypt, dm-linear,
dm-flakey, dm-error) ? All of these work with pure host-managed zoned drives,
and without patching will likely break with ZD/ZR disks. Hence my point that
supporting these drives correctly is absolutely not trivial.

-- 
Damien Le Moal
Western Digital Research
