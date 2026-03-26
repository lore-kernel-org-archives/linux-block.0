Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738002F290A
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540320; cv=none; b=e7SWeD6COHjJFeBSJfM5Q988CO5lsPI7ggR7ZaJYUODjDFl+yKB0RKDSrjmNr2FUonSH1D9DTvqNxVZgJbydpq1JUUH/qqGRG49+KbuoLZ8JXzxTL3fiU2XzJHy4/4OJEVQPMGIIJcYYgxNUfY2osxtWABNLUHAmweHV3zrhtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540320; c=relaxed/simple;
	bh=0oMsGx19fUPRmBKMpHNQbPrku64xP60kWNJeMWEAy6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oy6wkDQ3Cfb3DuJuZfuRcL/9DSkKKm8i+bP6jAx+r2zL3HbOErrt8tgAkcSsqwZM6Xg/V03FVW671+0kSX6Ts4Wg4VM2hmpgN6jfPmOQqU93yZfP4G22aYNWspd++ijZw80T+eZWr2mcPidd0pzzWdu3LY04yhTcPjaIfxT/q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aO17NuoW; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aO17NuoW"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhSvF1PZDz1XM0nj;
	Thu, 26 Mar 2026 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774540309; x=1777132310; bh=NwCmLgF63+F5yAD4MrsCRt3S
	I8ykUij0cV5m80cmAW4=; b=aO17NuoWHI+jIhiT2IyxfO4BOB5L06N179oK7kFc
	mGL/DWVGNpVfbUXpbGBRYgi88Iynqa/oMb6Zku0ZK42uxSHCYvRgiWblCbtUr/du
	4Z5gw59PZIRn4xAVVEns56O3cWJqY4BEoWPmVg087XzfvWXsq6QFzZgnwv7m3r4j
	epukJasfztl57fZCi07ZRcX7L+GfzBB/HOV/zcbGV9Bx9ZgAepIlW95+s1IXMw6r
	xAVNeY3zzEJcbC1vDeOJkUMcm2e1WnzGinw3qmP3i69FkavHto/29M65+Zm71tBm
	jwfggvum6Z/Zo5eGptkz4srhjNxoVxzTwqu/Liscy1rvUA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id I6tc3AZdztJB; Thu, 26 Mar 2026 15:51:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhSv74qj6z1XM5kt;
	Thu, 26 Mar 2026 15:51:47 +0000 (UTC)
Message-ID: <8c956003-e652-4dd0-a4d1-438d82cb543e@acm.org>
Date: Thu, 26 Mar 2026 08:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] block: Remove a DMA segment boundary mask check
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-4-bvanassche@acm.org> <acVIDQp5WWerx3lA@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <acVIDQp5WWerx3lA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 7:51 AM, Ming Lei wrote:
> On Wed, Mar 25, 2026 at 02:37:13PM -0700, Bart Van Assche wrote:
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 13f5457f9f4e..8538e50afe2c 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -447,15 +447,9 @@ int blk_validate_limits(struct queue_limits *lim)
>>   	if (!lim->max_discard_segments)
>>   		lim->max_discard_segments = 1;
>>   
>> -	/*
>> -	 * By default there is no limit on the segment boundary alignment,
>> -	 * but if there is one it can't be smaller than the page size as
>> -	 * that would break all the normal I/O patterns.
>> -	 */
>> +	/* By default there is no limit on the segment boundary alignment. */
>>   	if (!lim->seg_boundary_mask)
>>   		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
>> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>> -		return -EINVAL;
> 
> Please fold this change into the real code for reducing
> BLK_MIN_SEGMENT_SIZE, then it provides consistent handling/view about
> ->seg_boundary_mask and BLK_MIN_SEGMENT_SIZE.

Hmm ... wouldn't combining these two patches into a single patch violate
the "one change per patch" rule?

Thanks,

Bart.
