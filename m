Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC8481256
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031553; cv=none; b=EOySFaU3hKU7gEwDr5DEkZGvlcEaXVCdV+I1Y+DOzQoxvOWC/AF6q4n0k0D/xyA/12YlQoWZKGTbMndfszHSvdlJ29Oj5W02FabS+q1FwEfEqmVdO3xE7s2RHE7TMnZmzOR8u2zemUX6jNeqRJ8/GYASmpVyhRdsTCrBzH1atKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031553; c=relaxed/simple;
	bh=//0TJbPSe8fdHfEsGX6W/ac368YKeVkJ0roXD2waoZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaD0YupFeELBwS8nW5XPxAVNIRY0cdpt+x9jWgUxiOpr6QLaxFjEN0zsRK8/51DmIP+Ayj/BOf7uSxPmQNquDjZ9thRLc/tDzPxhyUD60jp4R1XEbIcPC2Cxzr7J3NWd93tciMic0C7p2NNOcr/IU34U5hmdsLQzhOh9420E6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilr0uXqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilr0uXqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6411F000E9;
	Thu,  6 Aug 2026 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031543;
	bh=Hf/8kBhtwGzCCGveFyhk9CQDb9pBRQxb/UX2tzDzX7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ilr0uXqhYY9gRUkIHRRdxOWje90vm3JSeDWGcy+AyIztmEXcKCd80IO3aYm0q6TX4
	 CDDjSaXRlWjKRGph3nP3PMIr323fG/h0vfpnY9V54mZ/TDVF6o6zh7UY8sxKIy5U43
	 /bAMc4L7mPP19kDkBBCGa83zPJTADDWr0g7zYgWS/o4mRvekc7V0tfsPl5FVTeScsX
	 MaeHBnEAjqmVjX3/kiRJCKfi/q5xJNjTz+fdSnJLsljp6v/9b0KxxBVBTvwHAIuf7g
	 hSBXpLCgNdBVlC3M4HQpb+9rsR8UKGXQyu+cZ82iKwn9+xbTGWiKydEMBEP8B6hDuR
	 /1r4l4Cn8/aPQ==
Message-ID: <32de7809-3ede-4ed5-ade5-cf81b6532a05@kernel.org>
Date: Thu, 6 Aug 2026 08:52:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] block: fail reads to offline zones early
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-15-dlemoal@kernel.org>
 <cd780cfa-068e-41d5-b7df-35558056a1f6@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <cd780cfa-068e-41d5-b7df-35558056a1f6@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/05 14:29, Bart Van Assche wrote:
> On 8/4/26 7:27 PM, Damien Le Moal wrote:
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 80a4e2bcc3f3..a5c4fcd210bb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -866,6 +866,11 @@ void submit_bio_noacct(struct bio *bio)
>>   
>>   	switch (bio_op(bio)) {
>>   	case REQ_OP_READ:
>> +		if (bdev_is_zoned(bdev) &&
>> +		    bdev_zone_is_offline(bdev, bio->bi_iter.bi_sector)) {
>> +			bio_set_flag(bio, BIO_QUIET);
>> +			goto end_io;
>> +		}
>>   		break;
>>   	case REQ_OP_WRITE:
>>   		if (bio->bi_opf & REQ_ATOMIC) {
> 
> This change might have a slight negative impact on the performance of 
> the hot path for all block devices. Is this change really necessary?

It is mostly intended to avoid command failures with SATA SMR drives, because
NCQ failures with SATA are costly for performance (queue drain and retries).
But given that this sort of invalid access should be rare, I can drop this for
now and revisit later if necessary.


-- 
Damien Le Moal
Western Digital Research
