Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6A2FFDF8
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769679527; cv=none; b=LNAj9FGD4uPOaNr5wTHotjSHZkmyhDL8P4hR4f036ONyone0U8Q/KIcawX9oaOMIEAZzQWOtppZukKTa5W6OyUHvPAAnJLmdZlr2+R9grccpsau7nGCTU/SleGzzCkXZsbQMWaUVKHM56K5HhigvCgVBeJ7xmHXYPqWiG8+L3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769679527; c=relaxed/simple;
	bh=4nrhlaxpYbD331SCy7Jus+A7rJxtGa/xJE8QMn2pJRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhqCwZM+aSlCK+Hxq5GtWlQjZvpNLaMomZyCdKk0qSEgVpR04EfQwnhYjrY2K+9vNSSXGU9pN2kYYxU/efR5J6AOFOHTyaE5DddGYD/2z2RTHcnV2vujKs1mqYarCOaZnEq69PvXGy4TI3Ye3u9gdbhaF0S7YLbJVX3dAAcPP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfXNkFaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfXNkFaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02980C4CEF7;
	Thu, 29 Jan 2026 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769679526;
	bh=4nrhlaxpYbD331SCy7Jus+A7rJxtGa/xJE8QMn2pJRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MfXNkFaW6eE0yUNU/k45i6ypf4bioIjuulLIvgw6/zHsodna4xqnhow3daMVP3U0J
	 JvBakv1DL227rDdQMEv2sKWwD3kVhzbAaGYAa9BlfECzKK4ylOLzZs4g5zrI0Q/OPe
	 0VqZyYNXGqwPtKHnzj3CMeGSVYCZvh0IFz1QL/mY1azg6SmtD5GO9VnF8AKvwd4lPe
	 xkdYh5LqGdThD0P7gzg39u1+jlp/h7BI1N/Ef8BRgtqUyZYdui3WoVfUsKf+rpPa/E
	 J8jTGJQj8c24NKlLviBgrWXR27g+eKXC4FNa2opu9vN8FAW/E6isem9LK/M5CeLo2c
	 hzdlgpvQpzpBw==
Message-ID: <7a791d5d-cc74-45bb-a7c7-0d681d3601e0@kernel.org>
Date: Thu, 29 Jan 2026 18:38:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-3-dlemoal@kernel.org>
 <CGME20260129092258epcas5p1fb7fd90db827d982829475652b43786a@epcas5p1.samsung.com>
 <20260129091846.nx3crn6347gf6brv@green245.gost>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260129091846.nx3crn6347gf6brv@green245.gost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/26 18:18, Nitesh Shetty wrote:
> On 29/01/26 04:27PM, Damien Le Moal wrote:
>> To check if a request queue is for a rotational device, a double
>> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
>> this with the introduction of the helper blk_queue_rot() which tests
>> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
>> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
>> and blk_queue_nonrot() definition removed.
>>
>> No functional changes.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>> block/bfq-iosched.c    | 20 ++++++++++----------
>> block/blk-iocost.c     |  2 +-
>> block/blk-iolatency.c  |  5 +----
>> block/blk-wbt.c        |  5 ++---
>> include/linux/blkdev.h |  4 ++--
>> 5 files changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 6e54b1d3d8bc..3ebdec40e758 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -231,7 +231,7 @@ static struct kmem_cache *bfq_pool;
>> #define BFQ_RQ_SEEKY(bfqd, last_pos, rq) \
>> 	(get_sdist(last_pos, rq) >			\
>> 	 BFQQ_SEEK_THR &&				\
>> -	 (!blk_queue_nonrot(bfqd->queue) ||		\
>> +	 (blk_queue_rot(bfqd->queue) ||			\
>> 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
>> #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
>> #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
>> @@ -4165,7 +4165,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>>
>> 	/* don't use too short time intervals */
>> 	if (delta_usecs < 1000) {
>> -		if (blk_queue_nonrot(bfqd->queue))
>> +		if (!blk_queue_rot(bfqd->queue))
> blk_queue_rot looks fine to me in other places.
> Keeping blk_queue_nonrot would avoid the double negation here and few places.

There is no more double negation. blk_queue_rot() tests for a feature flag being
set. The !blk_queue_rot(q) tests the opposite.

> I see you made the changes for bdev_nonrot down, but missed to add here
> ?

Here where ? What did I miss ?


-- 
Damien Le Moal
Western Digital Research
