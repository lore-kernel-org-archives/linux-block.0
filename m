Received: from mail.ehvag.de (arnold.ehvag.de [157.180.54.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9A3E3165
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.54.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567166; cv=none; b=b7SoudhrATOpj/eWtM+hyOu9d1VThJ1FkCuKDB0/xEtBMQ5EKEChXF36t2IVie8EjgHBxgZyv3uqLMmJmEcmZysZ4LhIUVtrHR2n/VT34LhJNDXknHeZQoyggoaIc3Kr1WNvzv/TpLovOZqICoDYs1o49q8gPXOiKw1H6l10osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567166; c=relaxed/simple;
	bh=ZPO+kyxo2fugQmtEktw/8O7zRu3nvn37XOBML4AGGFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=eXzySDH7BPVjV5KxvBP++UEAi5clVIeOZ1S25+2ErDoZdLbhi/aGJYGabZu52FvFB4tR0GSbe7VsqtKQXMyNDrULW9EGvWLGQmVjVhIuhz3t+5mc8cCkaYUORfjh2doZnWqf7CXNyuV4Kp/LB5DZYOvgFSk/PhjOMaS2zBD+8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de; spf=pass smtp.mailfrom=ehvag.de; dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=NKTmWCjm; dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=KNyfwgjU; arc=none smtp.client-ip=157.180.54.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehvag.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="NKTmWCjm";
	dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="KNyfwgjU"
DKIM-Signature: v=1; a=ed25519-sha256; s=202603e; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1787567161; bh=t2dkM9cZVLMYhtmdgf463Pq
	bJWpLkARydUQj0wf92d4=; b=NKTmWCjmRI6Ryq2feWZOWwcCOwVnlcKP/aQmn9Ro5KrVLLcwou
	bG3e5Z8d2vneOIqCDAoj+U20wj4OSfBql2Aw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202603r; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1787567161; bh=t2dkM9cZVLMYhtmdgf463Pq
	bJWpLkARydUQj0wf92d4=; b=KNyfwgjU4KgvBFJ1RuJw/6Tv7Y1S2cCy1hXSNB/GGWnfe/0Qij
	lRHYbd9IivEOzKFqQCQvV84GvbDe2fnOri/H+zfq0prhJBbMz2LcKfnb/zQOPyHcwhqEAG0fid8
	ySeR9U2fWBYSdvvZcU30vSXurKaaULDhUKcWJ44L5pGtYO6Ot9jmE47At0kUeBAR+1Sohc7awIk
	3xo8KtvyUxuDz50u3zlHAo6B8QAWLHeQatBWGrQsVy1nrHhUgq2ULuDJHOYsaSwwkiPt3kYdzae
	457/JOaOlythu6a7BOMvMuueoho/k16W8dcHzDPuQqCj9OJC4kiXEM5YmT2Wd2/LdHA==;
Message-ID: <51d780f2-1037-45f5-a348-361f3399d74f@ehvag.de>
Date: Mon, 24 Aug 2026 12:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seagate Flex SMR
To: Damien Le Moal <dlemoal@kernel.org>
References: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
 <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
 <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>
 <3cfe7ce2-ed79-41fe-b73f-d4d416169a8d@kernel.org>
Content-Language: en-US, de-DE
From: Noah Bergbauer <noah@ehvag.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3cfe7ce2-ed79-41fe-b73f-d4d416169a8d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> The specification can be found in T10/18-007r0. It's not exactly ZD/ZR as it
>> seems to predate those standards, but it's close.
> 
> This document is a proposal, not a standard. Some aspects of it are likely
> integrated in ZAC-2, but if the drives you are talking about do not follow this
> standard, we cannot support them.

The drives I am talking about (ST12000NM0558 to name a specific example) 
appear to follow this exact proposal. Obviously I am aware of the 
difference between a proposal and a standard.

For the purposes of the kernel block layer they implement ZAC-2. As I 
said before, the majority of this work is applicable to any 
standard-compliant ZD/ZR drive.

The only exception would be the Zone Activation Capabilities field, 
which is all zero here (because it didn't exist yet). Instead, the 
domains are discovered through a vendor specific log page. Is this not 
an acceptable quirk?

>> To be clear, what I have implemented is all about running a filesystem in
>> domain 1. And I want to push back a little on your claim that this is extremely
>> hard, because in a handful of small patches totaling around 500 lines of code I
>> have found solutions for all of these challenges. I am running btrfs on the
>> sequential zones and it passes every test I have thrown at it. I can show you
>> the code if you like.
> 
> You are looking at this very narrowly. The simple fact that you now have a
> drive that reports a capacity that is nearly twice what the drive can actually
> store will likely cause lots of problems. Also, you may have patched BTRFS, but
> what about XFS, zonefs, and device mapper (dm-zoned, dm-crypt, dm-linear,
> dm-flakey, dm-error) ? All of these work with pure host-managed zoned drives,
> and without patching will likely break with ZD/ZR disks. Hence my point that
> supporting these drives correctly is absolutely not trivial.
$ df -B GB /dev/sda
Filesystem     1GB-blocks    Used Available Use% Mounted on
/dev/sda          13694GB 13688GB       3GB 100% /mnt/a

This was btrfs running on the above-mentioned 12TB drive. It works and 
the capacity is correct. What am I missing?

I'm hacking on this in my spare time, so please, cut me some slack here. 
The current situation is that domain 1 is completely unusable for the 
kernel. I would like to make some small and incremental improvements, 
starting with zonefs and then btrfs (XFS didn't support zones at all 
when I originally wrote this!). Does it really make sense to block those 
just because it doesn't yet have all the bells and whistles that one 
might eventually wish for?

Best,
Noah Bergbauer

