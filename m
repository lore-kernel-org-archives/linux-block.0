Received: from mail.ehvag.de (arnold.ehvag.de [157.180.54.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870801A681C
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.54.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503565; cv=none; b=ZQbtxYIQj3KHm6orA72vtCRDcTdwwRFo8We6ZptQIi4QxWplmmPhPz7DE6hujjBWWCSJbbw8DtJ7ovyCtdyfNrC+3ytHmHk2Q+H9AWNFDz5yG4gZZqnoOTwTHy/Ez3lnc3pjy56qQ0VE61LNk5/trImZ1gq1THATrmsfHAuZU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503565; c=relaxed/simple;
	bh=1DX6sL0xUSoV0rkWiPs2ibPMcdHWtKuY9IWC8GXFexI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Osfu7DUHygWHNQkfp8g0JBOOmRlxybNm2mDuM7qhAixNF9Dk0g0XnNgo7uJ3Af0MabFcY9ACUHe2Z9aPmN5nAOIxPNAMdVXBBPEld5EuLGQgwP1IYkdjOvFyDWA3Cf1uqQM/NcEvJ+iGWvQtTdRa3yTf2JoDXCTLOQxl3kN9APQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de; spf=pass smtp.mailfrom=ehvag.de; dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=6buF+EwH; dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=A87IZTYJ; arc=none smtp.client-ip=157.180.54.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehvag.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="6buF+EwH";
	dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="A87IZTYJ"
DKIM-Signature: v=1; a=ed25519-sha256; s=202603e; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1787503550; bh=JEyd249+EOHs1uy06zRQrW5
	wJQY66q401ZcT5Pwchj0=; b=6buF+EwHpfPcIYBCMZd7L+mdMwZXp4/pGxTExqgplLUtNfd8wq
	p8jrvym7E/NZ8xa7SNhYbzSjdfPCCNAhszAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202603r; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1787503550; bh=JEyd249+EOHs1uy06zRQrW5
	wJQY66q401ZcT5Pwchj0=; b=A87IZTYJZrZxBf2g0y6AbayTgZBqXdpkLWpGPf/22voGRXCzLa
	mmyQp4IuXNKiBRA6EENkvCPSjqNGq8a3baXzMKY1V9lrMq5qRxq6dHiDlpVsIhaplzbCZP3IpoI
	DXbRRZ+cB99aTrFmIIo/qBSNlbadGRJB3j5XRUWW1R3pJWwey4iOnIdboex5wQzaZ0NQEvptbxS
	dlkwh2JcXZhScUwHJrl6Tq+6xNt1XeA0kKaWhoIHSTIl22GXoTsKg2ZlN0axnr7czfHrhMr6Ng9
	rU8G3KSrrcEL8cxI22ooX5vL3O5dRu0WlbC/febg8diC1JLLz5oE7A57zGLdY3hcHlw==;
Message-ID: <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>
Date: Sun, 23 Aug 2026 18:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seagate Flex SMR
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
 <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
Content-Language: en-US, de-DE
From: Noah Bergbauer <noah@ehvag.de>
In-Reply-To: <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> "Flex SMR" is not referring to any standard feature. So it is hard to see what
> you are talking about. In Linux, we support only drives that follow a standard,
> so for HDDs, that is SPC/SBC/ZBC for SAS drives and ACS/ZAC for SATA.

The specification can be found in T10/18-007r0. It's not exactly ZD/ZR 
as it seems to predate those standards, but it's close.

> Abbreviations do not make for an easy reading... I am assuming here that
> SEQ_OR_BEFORE refers to the SOBR == "Sequential or before" zone type that is
> defined as part of the ZBC/ZAC Zone Domains (ZD)/Zone Realms (ZR) feature set.
> Right ?

Right.

>> 3. The zone configuration works by reporting both SEQ_OR_BEFORE and
>> SEQWRITE_REQ zones each for the entire disk, and then for each pair of
>> overlapping zones only one of them can be active while the other one
>> will be in the offline condition. Right now some parts of the kernel
>> (e.g. btrfs) don't play well with offline zones.
> 
> No. That is not how it works, at least not without patches to the SCSI & ATA
> layers. The reason is that ZD/ZR drives are backward compatible with regular
> disks. So the READ CAPACITY command reports the size of domain 0 only (the SOBR
> zones). The sequential zones are in domain 1, which is unreachable without
> ignoring the capacity returned by the READ CAPACITY command, because domain 1 is
> in the LBA space beyond the capacity of domain 0.

You are correct of course. What I mean is that after activating some 
zones in domain 1 the resulting holes in domain 0 need to be handled, 
and one can not simply assume that the full capacity range is always 
usable. Naturally, the capacity also needs to be increased to cover both 
domains.

>> I implemented all of this last year and in the end everything was
>> working fine under btrfs. Now I would like to attempt to get this into
>> the kernel. This would involve rewriting most of my patches from
>> scratch. So before I invest a lot of time and effort into doing so, my
>> question is: would you as the maintainer even be willing to accept these
>> changes into the kernel?
> 
> Unless you have a strong production/use case for this, it is a hard no for me.
> 
> The reason is that properly supporting the zone domains/zone realms feature is
> *extremely hard*. This is full of gotcha and plenty of things will not be
> backward compatible with pure SMR support that we have. E.g. SOBR and
> conventional zones are very different before the SOBR zone is fully written.
> 
> If you want to run a file system in domain 0 only, simply activate all the SOBR
> zones in domain 0, make sure the SOBR zones are all initialized (written) and
> you are done: the drive in that state is equivalent to a regular disk and
> everything will just work fine.
To be clear, what I have implemented is all about running a filesystem 
in domain 1. And I want to push back a little on your claim that this is 
extremely hard, because in a handful of small patches totaling around 
500 lines of code I have found solutions for all of these challenges. I 
am running btrfs on the sequential zones and it passes every test I have 
thrown at it. I can show you the code if you like.

For example, SOBR zone support specifically turned out to be quite easy 
to implement in a backward compatible manner. I simply return true from 
bdev_zone_is_seq() because treating a SOBR zone as sequential is always 
safe. A SOBR-enabled filesystem can then query bdev_zone_is_sobr() to 
take advantage of random writes.

The use case is that these drives exist, they're out there, and with a 
little bit of kernel work we could squeeze a few extra terabytes out of 
each and every one of them by leveraging their SMR capabilities. That's 
a clear win to me. Yes, they don't entirely follow the latest standards, 
but to me this is no different than the many device-specific quirks 
already supported by the kernel. And apart from the Flex-specific 
discovery procedure, all of this work should be usable for supporting 
other ZR/ZD drives in the future.

Best,
Noah Bergbauer

