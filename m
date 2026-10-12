Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E448C3E4;
	Mon, 12 Oct 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808669; cv=none; b=kGoyTRCcEOYg1ww5+FEQkED2mamjWHifV0zndwXsbQJxOAI0Q9/AYu0v2Wal3jtUp3oqfX+CEsgJAZ41xHB0WcT3SCm+Yf24HYJ/cUXRMUl4Q2YikQTUGat+K5WIkF+sOCtB59H6hDHG37Ath4gmFMKi1ES2ST0MnAjd49A5/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808669; c=relaxed/simple;
	bh=rfPZU24Fziz4Rn+Vxpu1Nwgz3d0kf2vcujuc4PGiWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhQAYSp0j6tq8XWsXnlExCeyLjoAXszx9BBXQcNiLfz1vmeEeRWJtqmRyYdy7W7X96PPgK0+W2Ft9bdSHLAKwmEhbOsqn+UKd30kqHbvFvCQrfxnfz0EeTnKWdwZbkkO3eQidbKZhccyl5aRrzuzTa5I8B5PTw0VPgwNWgw4Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STrSN/f7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STrSN/f7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479C01F0089C;
	Mon, 12 Oct 2026 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791808668;
	bh=4IaUZt4lrPscc9GvnmihC4Wj6E2yNrEFFtll5KwiMnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=STrSN/f7mNERDldfUOpVZzAlHAvah30Ie1cOTCT7LfXFSUiXG5gtohFHvjjulJ4Ib
	 UfxFpjhnsdTY7ddUF7tHhVT0pWvxmBj8BY3DmpjQIwzL3MxCILMYKoNvn0LQvuendt
	 L1uP9pOiOfee7MNKRMy1jhuhE8wljDpk/itbPmQFOdumisppP44klo0+mPUudbbkV9
	 N1xPMazQQvgTbTwZpltpI0YiEJhi0pjXfr+3ljuU2VPnc/MZ/1jc2tuxhOv697O2VB
	 kA7FNeR49TMFjUYL0woVm1PsJWEaeAtZ+VSxG5lSquGDDnRVEQzGfiRTQ8MyKZg/Dr
	 BHlo/Bv1/AQQQ==
Message-ID: <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org>
Date: Mon, 12 Oct 2026 14:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in
 blkdev_get_zone_info()
To: shashank Jain <jain.sm@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011051906.60397-1-jain.sm@gmail.com>
 <20261011051906.60397-3-jain.sm@gmail.com> <20261012122112.GA31242@lst.de>
 <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/10/12 14:29, shashank Jain wrote:
> On Mon, Oct 12, 2026, Christoph Hellwig wrote:
>> Can you add this to blktests as a reproducer?
> 
> Will do. I'll send a blktests test under tests/zbd/ that sets up a zoned
> null_blk device with a smaller last zone and checks that BLKREPORTZONEV2
> without BLK_ZONE_REP_CACHED matches BLKREPORTZONE, and that the cached
> report's last-zone length does not extend past the device. I'll post it
> to the blktests project separately and reference this series.

How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report" does not
have that yet. I am planning to send a patch for it.

> 
> Thanks,
> Shashank
> 
> On Mon, Oct 12, 2026 at 5:51 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrote:
>>> blkdev_get_zone_info() sets the length of every zone to the zone size
>>> of the device. The last zone of a zoned block device may be smaller
>>> than the others: blk_revalidate_zone_cb() accepts that and remembers
>>> the capacity of that zone in disk->last_zone_capacity. For such a zone
>>> the length reported from the cached information is too large, and
>>> start + len is beyond the end of the device. A conventional last zone
>>> is also given the capacity of a full zone.
>>>
>>> Example with a zoned null_blk device of 10 MiB (20480 sectors) with
>>> 4 MiB zones, last zone:
>>>
>>>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
>>>   BLKREPORTZONEV2 with
>>>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
>>
>> Can you add this to blktests as a reproducer?
>>
>> The patch looks good:
>>
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>


-- 
Damien Le Moal
Western Digital Research
