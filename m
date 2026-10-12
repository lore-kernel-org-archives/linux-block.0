Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE6377007;
	Mon, 12 Oct 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810302; cv=none; b=mXIBU8b4cdrBCogNxzEHGoOUh2qVXqv6JVzeb1icJbeYAXwL/e8DyXgYxE8aDFcyACZrubRKYaMWBAbRT7am27I/8lB7X4gHiNdjRi5GwT9Omn2d+37RPS68oVfqeJMyQz8tosaadb14A6m1H4sYRsxRm5Lr9RhRRJb7rhRypuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810302; c=relaxed/simple;
	bh=bIBIk+yMNMKWRqG888oERixTGfjeoiLViHX+pMLzFpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpW8GvE8JWx9BlxzwsV9CaX9rGXRxD5jJMiw/mtmSGvBXEwERmtdasDh3WmAmf4alJrQ/DxCXMbzqEyo0dFzxAs1dz4S5DdHsS3udb8cqQ2Mg6o18CE+U9HIlQ1cLOyV4q4zmR9KAL+GRd3LxquDIOR2u70sRZlbafjexCixvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iytQJUtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iytQJUtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDAF1F0089B;
	Mon, 12 Oct 2026 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810301;
	bh=3epRn1tFgweJmoAuYCIm3IVBloN5uwGgfFLordS0eVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iytQJUtSx8uxNthArLgTHMR9clsDswMBIXToHRdMBIth6NWpEmLfNqcztaYQXTN2w
	 UcF3JzXaFFwmItuuwwplrLuFBtnsrQoZcBkQcB8KLDPVD9aK0Ok7YUdmx96YdgRv51
	 zQFwoSb0NvkbhKuh+THDLSuNUdbjWWhA70TmfjbIzwgQjF3LG0uM3Oj6Uv05Q1/kPc
	 AULMMXpHc7JFd9MpunfzyAvMHfYtfe3qaVMAVbscfwMuXpHYWgi2vvvS6s2dL+LQb9
	 0RIEbyHMAw5WAlzA3CdwW3CFIjUEbyeeB5FLW8fdGevefeJAsAKyBksAWOPbGPOrG4
	 FFdH7GPI/bZXQ==
Message-ID: <04251d5f-c251-49f7-8690-565c9b203690@kernel.org>
Date: Mon, 12 Oct 2026 15:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in
 blkdev_get_zone_info()
To: shashank Jain <jain.sm@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011051906.60397-1-jain.sm@gmail.com>
 <20261011051906.60397-3-jain.sm@gmail.com> <20261012122112.GA31242@lst.de>
 <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
 <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org>
 <CA+FWx=kgeR8tz46tijYE-s=v+PTJjGfM+3ucQOo0ZuDyqFdYQw@mail.gmail.com>
 <0da1bc26-b3ed-4bfa-b75d-2d1696cc0cfb@kernel.org>
 <CA+FWx=ko-dj3SORcHcvDpP7abWAmD1JH0o4COPsZc2U7kimTvw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CA+FWx=ko-dj3SORcHcvDpP7abWAmD1JH0o4COPsZc2U7kimTvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/10/12 14:53, shashank Jain wrote:
> On Mon, Oct 12, 2026, Damien Le Moal wrote:
>> I was thinking on adding a "--cached" option to control the use of
>> BLK_ZONE_REP_CACHED.
>> If you want to take on such patch, go ahead. CC me on it and I will review.
> 
> Thanks - yes, I will take it: a "--cached" option to "blkzone report"
> that selects BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED, leaving the
> default report via the device (BLKREPORTZONE) unchanged. I will post it
> to util-linux and CC you. The blktests reproducer will then use
> "blkzone report --cached" rather than a bundled helper.

Maybe add a prep patch that defaults to BLKREPORTZONEV2 (without
BLK_ZONE_REP_CACHED) if BLKREPORTZONEV2 is defined.

And a second patch that adds the --cached option for BLK_ZONE_REP_CACHED.

> 
> Thanks,
> Shashank
> 
> On Mon, Oct 12, 2026 at 6:15 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 2026/10/12 14:41, shashank Jain wrote:
>>> On Mon, Oct 12, 2026, Damien Le Moal wrote:
>>>> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report"
>>>> does not have that yet. I am planning to send a patch for it.
>>>
>>> Good point. Two options, and I am happy to follow your preference:
>>>
>>> - Use "blkzone report" with the cached flag once your util-linux patch
>>>   lands - that matches the existing zbd tests and avoids a bundled tool.
>>>   I would hold the blktests submission until it is available.
>>
>> We should leave "blkzone report" to get the device report as before, to avoid
>> breaking anything for user with the "active" condition being returned.
>> I was thinking on adding a "--cached" option to control the use of
>> BLK_ZONE_REP_CACHED.
>>
>> If you want to take on such patch, go ahead. CC me on it and I will review. The
>> patches I need to send to add depop support will take some more time.
>>
>>> - Or carry a small C helper in the blktests src/ directory that issues
>>>   BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED directly, so the test is
>>>   self-contained and does not depend on the util-linux version.
>>>
>>> I lean towards the first, to match the zbd conventions and your blkzone
>>> work; tell me which you prefer and I will align the test with it.
>>>
>>> Thanks,
>>> Shashank
>>>
>>> On Mon, Oct 12, 2026 at 6:07 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>>>
>>>> On 2026/10/12 14:29, shashank Jain wrote:
>>>>> On Mon, Oct 12, 2026, Christoph Hellwig wrote:
>>>>>> Can you add this to blktests as a reproducer?
>>>>>
>>>>> Will do. I'll send a blktests test under tests/zbd/ that sets up a zoned
>>>>> null_blk device with a smaller last zone and checks that BLKREPORTZONEV2
>>>>> without BLK_ZONE_REP_CACHED matches BLKREPORTZONE, and that the cached
>>>>> report's last-zone length does not extend past the device. I'll post it
>>>>> to the blktests project separately and reference this series.
>>>>
>>>> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report" does not
>>>> have that yet. I am planning to send a patch for it.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Shashank
>>>>>
>>>>> On Mon, Oct 12, 2026 at 5:51 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>>>
>>>>>> On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrote:
>>>>>>> blkdev_get_zone_info() sets the length of every zone to the zone size
>>>>>>> of the device. The last zone of a zoned block device may be smaller
>>>>>>> than the others: blk_revalidate_zone_cb() accepts that and remembers
>>>>>>> the capacity of that zone in disk->last_zone_capacity. For such a zone
>>>>>>> the length reported from the cached information is too large, and
>>>>>>> start + len is beyond the end of the device. A conventional last zone
>>>>>>> is also given the capacity of a full zone.
>>>>>>>
>>>>>>> Example with a zoned null_blk device of 10 MiB (20480 sectors) with
>>>>>>> 4 MiB zones, last zone:
>>>>>>>
>>>>>>>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
>>>>>>>   BLKREPORTZONEV2 with
>>>>>>>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
>>>>>>
>>>>>> Can you add this to blktests as a reproducer?
>>>>>>
>>>>>> The patch looks good:
>>>>>>
>>>>>>
>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>>
>>>> --
>>>> Damien Le Moal
>>>> Western Digital Research
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
