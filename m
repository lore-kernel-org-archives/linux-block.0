Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D4BA53
	for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKZT7sGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E870AC433C7;
	Wed, 20 Dec 2023 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703035719;
	bh=yfqTM0qgQuItPD8p3e7yeE5dpNEtM832ACGpf0PCeOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lKZT7sGyBSNiBGk5xBSZbJgww+DfxUh9RNUQ7k+XZSKANsLjlR40ihi3uU+FVVzdZ
	 eU9VTlZU44yUhjiemNzldjw2reRXzClAGgRjyZiFrpiRfQScLmGXF7/asc5iYmILgV
	 X+tgSf2h4WOjuYHz7knshrD5HhnTrpuV4bXbhOgyip8h9MYw9rMawTVsGQeR0mE5i/
	 XFghnxqTah5l6/KWOWF0/px7ClLcsyFp9eea5VY8dSwjtk62EPxh/taXjyIOciiFYx
	 ma0q82xWWlEAwwLBWWly6eLoIDmpST1qjk9NugkFzu+M5EuvLhmou5stBj36sG2lcB
	 D6qWXncsqzZUA==
Message-ID: <995e1ae3-5d03-453a-8a97-a435bfa3e2c4@kernel.org>
Date: Wed, 20 Dec 2023 10:28:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write reordering
 due to I/O prioritization
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20231218211342.2179689-1-bvanassche@acm.org>
 <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de>
 <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
 <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org>
 <2e475db5-fd09-483c-9c34-d9bf9e64d273@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2e475db5-fd09-483c-9c34-d9bf9e64d273@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 09:48, Bart Van Assche wrote:
> On 12/19/23 16:05, Damien Le Moal wrote:
>> On 12/20/23 02:42, Bart Van Assche wrote:
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index c11c97afa0bc..668888103a47 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2922,6 +2922,13 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
>>>
>>>    static void bio_set_ioprio(struct bio *bio)
>>>    {
>>> +	/*
>>> +	 * Do not set the I/O priority of sequential zoned write bios because
>>> +	 * this could lead to reordering and hence to unaligned write errors.
>>> +	 */
>>> +	if (blk_bio_is_seq_zoned_write(bio))
>>> +		return;
>>
>> That is not acceptable as that will ignore priorities passed for async direct
>> IOs through aio->aio_reqprio. That one is a perfectly acceptable use case and we
>> should not ignore it.
> 
> Hi Damien,
> 
> What you wrote is wrong. bio_set_ioprio() applies the I/O priority set
> by ionice or by the blk-ioprio cgroup policy. The above patch does not
> affect the priorities set via aio_reqprio. aio_reqprio is still copied
> in ki_ioprio and ki_ioprio is still copied into bi_ioprio by the direct
> I/O code.

OK. But your patch will still endup with IO priorities being ignored for
legitimate use cases that do not lead to mixed-priorities. E.g. applications
using directly the raw device and doing writes to a zone without mixing
priorities, either with AIO, ionice or cgroups.

The issue is when a user mixes different IO priorities for writes to the same
zone, and as I said before, since doing that is nonsensical, getting the IOs to
fail is fine by me. The user will then be aware that this should not be done.

f2fs has a problem with that though as that leads to write errors and FS going
read-only (I guess). btrfs will not have this issue because it uses zone append.
Need to check dm-zoned as their may be an issue there.

So what about what I proposed in an earlier email: introduce a bio flag "ignore
ioprio" that causes bio_set_ioprio() to not set any IO priority and have f2fs
set that flag for any zone write BIO it issues ? That will solve your f2fs issue
without messing up good use cases.

-- 
Damien Le Moal
Western Digital Research

