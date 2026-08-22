Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83249363B
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380147; cv=none; b=rC7bWtSfegj+VPp1UXpxht+WQ8jEEP2nIv/yZnAGiyUSd3ljXndFTfMT+QY8O8JC91zClsnPg654dOsDzpYAbD04pnbrwfYJGkWPnrNRZh117jDiAgSQ/ymGgNpWBt5K1KHwls4kmJxqLVUvomNmmphkdCv+DhSbldvi6YVzjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380147; c=relaxed/simple;
	bh=X8CjxXC6AJ3FTlOsgI0cVsGSbwI3M9/HDTMbtMoAcc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPQyBYQ9VaJH4NqHCdmb9NR8xn7YvA5H1lttXfLgqmFMxcjx7to+erw8JZDivl+PM/ayKyiREulpg/jutpkgMrcwX5UMQsaJmXDEusnSVIT3s1AH2MggM8aCGHi6ivs4KIC49AZgZtS6A+qYpHnSjG8kGtOpQi/WwYUyjilSmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6dTAXhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6dTAXhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51841F000E9;
	Sat, 22 Aug 2026 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787380146;
	bh=+FF3rcg31FrsH+/fMI37hhHHNK8xS0FaThm+246Zer8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V6dTAXhR5fUk6nmYe0T9eEAW2SmMnGPzMZAnie/rcOs8Xf7Ol2OaDghwRfr/GRkrb
	 1ZHOYAEutNH5h/kv8AKQ9p8GXkf5J+Z9G0lqi4a7ilIPqL0J6rX54V8NsQPKHLY2CG
	 4pC17elqgpA3vKSmP3Z+rY9XJeMhxUVYgaoNGhGGspU4df6x3W6iXjLGE4her64eA3
	 lklxDIZm2ME8ilALN03OjJONkllCY2hE9C17FvWJMHYDcmjtM6cA4orI92BOMxop19
	 vsUH/+4iFskX0c1tJxjm3CSGB3BfdgfG2TpyL/8taKNj7sCFaSJyfyvTNPBao0MSGt
	 BYwS+bG2uWqIQ==
Message-ID: <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
Date: Sat, 22 Aug 2026 15:29:03 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 23:38, Noah Bergbauer wrote:
> Hello,
> 
> Seagate Flex SMR drives are an early generation of hybrid SMR (HSMR) 
> drives with a configurable zone layout. There are three main challenges 
> towards supporting this in the kernel:

"Flex SMR" is not referring to any standard feature. So it is hard to see what
you are talking about. In Linux, we support only drives that follow a standard,
so for HDDs, that is SPC/SBC/ZBC for SAS drives and ACS/ZAC for SATA.

> 1. Instead of CONV they use SEQ_OR_BEFORE (type 4) zones. These permit 
> random writes below the write pointer, so once full they behave exactly 
> like CONV.

Abbreviations do not make for an easy reading... I am assuming here that
SEQ_OR_BEFORE refers to the SOBR == "Sequential or before" zone type that is
defined as part of the ZBC/ZAC Zone Domains (ZD)/Zone Realms (ZR) feature set.
Right ?

> 2. In an (in my opinion rather questionable) attempt at backwards 
> compatibility the drives camouflage themselves as non-ZBC. Their ZAC 
> support can be detected from a special ATA log page but ZBC commands 
> must be emulated via ATA PASS-THROUGH as a SAT may refuse zone commands 
> on a non-ZBC drive.

This is not questionable. ZD/ZR drives advertise themselves as regular disks
with device type 0x0000 so that when they have all SOBR zones in Domain 0 (the
SOBR zones domain) active and written, they behave 100% like regular disks and
are backward compatible with regular disks.

For a ZD/ZR disk in such state, you can use any file system (BTRFS/XFS/ext4 or
whatever) as is without any patches. In the case of BTRFS and XFS, you can even
use them with the the zoned format enabled and setting the software zone size to
the actual device SOBR zone size to get things to align nively to zones (that is
not necessary really, but that will work without any patching).

> 3. The zone configuration works by reporting both SEQ_OR_BEFORE and 
> SEQWRITE_REQ zones each for the entire disk, and then for each pair of 
> overlapping zones only one of them can be active while the other one 
> will be in the offline condition. Right now some parts of the kernel 
> (e.g. btrfs) don't play well with offline zones.

No. That is not how it works, at least not without patches to the SCSI & ATA
layers. The reason is that ZD/ZR drives are backward compatible with regular
disks. So the READ CAPACITY command reports the size of domain 0 only (the SOBR
zones). The sequential zones are in domain 1, which is unreachable without
ignoring the capacity returned by the READ CAPACITY command, because domain 1 is
in the LBA space beyond the capacity of domain 0.

> I implemented all of this last year and in the end everything was 
> working fine under btrfs. Now I would like to attempt to get this into 
> the kernel. This would involve rewriting most of my patches from 
> scratch. So before I invest a lot of time and effort into doing so, my 
> question is: would you as the maintainer even be willing to accept these 
> changes into the kernel?

Unless you have a strong production/use case for this, it is a hard no for me.

The reason is that properly supporting the zone domains/zone realms feature is
*extremely hard*. This is full of gotcha and plenty of things will not be
backward compatible with pure SMR support that we have. E.g. SOBR and
conventional zones are very different before the SOBR zone is fully written.

If you want to run a file system in domain 0 only, simply activate all the SOBR
zones in domain 0, make sure the SOBR zones are all initialized (written) and
you are done: the drive in that state is equivalent to a regular disk and
everything will just work fine.

Best regards.

-- 
Damien Le Moal
Western Digital Research
