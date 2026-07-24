Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B193515D1
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906955; cv=none; b=JpV2Rq+LhLBu6ABmkylQ5xjyaEDi2CuTQ0vvtbUh/Fvt7UW8EAFIOHYEF5IKLXk7h4B2Pe7sRKN+TPVTJNPwjAGB7sPzJ5rT86Q8ITvj63XR9SPdSR3JflXp0c9obPqNmb3FKnuIFVJG54bXls+PnQtedXt6zsSgI/7EpMTAYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906955; c=relaxed/simple;
	bh=8eXstunJjp9wFZn2BLZZ9khvqN5k5vD5vcvJoVgeYSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm33Cd7Zu/gg3cr0xww0LxiRH1PGvCsGKNhrrVIXYdSReumMSh0ZF2Cr/ClP81d4lfQ8+1q1FonjB0hX9sKqFdeiQ8RRcCF7UX2eM2k8Eek0RPGmaUhjUwOMyLGV3TOachpaqnH7O96TFfsDzio1pZJX2AVdIK9hZyudtVIJoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ewCezjJx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ewCezjJx"
Message-ID: <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784906950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nuOP4jxO16NLocZBZK4AZLVxWBdOiKE7BUbgb7/Hes=;
	b=ewCezjJxZxHKTLJcNu3qWDk6XBcK2Q1TLojeyfPWR8VzZo9OZUNSIr3HGxDLJ59AQr8wRK
	IZ05ayaRiWY8ZOxcW7+FSwjxPzAv7NDzrOu8jYl41KqnRXlQxOg+5K/TUlzLUMqcvzXZ7o
	iI+MEXRWdN9270MdvnTga9goe6/ijg4=
Date: Fri, 24 Jul 2026 16:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <amNegPEvRX99EvPN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/26 13:45, Keith Busch wrote:
> On Fri, Jul 24, 2026 at 08:09:51AM +0100, John Garry wrote:
>> On 24/07/2026 06:01, Christoph Hellwig wrote:
>>> On Tue, Jul 21, 2026 at 11: 45: 53AM +0000, John Garry wrote: > Setting as an
>>> RFC as adding this extra bio field is not acceptable, but I > can't see how to
>>> lookup the original partition. In general it is not, but you should mark this a
>>>
>>>
>>> On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
>>>> Setting as an RFC as adding this extra bio field is not acceptable, but I
>>>> can't see how to lookup the original partition.
>>>
>>> In general it is not, but you should mark this a block patch so that
>>> Jens can better cream at you :)
>>>
>>> I'm also not sure that supporting per-partition diskstats on a multipath
>>> device makes too much sense, but then again there's a lot of setups
>>> that are crazy and actually used..
>>>
>>
>> It just seems to me that we should have same behaviour as if it were not
>> multipath.
>>
>> So we can't use bi_private as that can be set by original bio submitter. I
>> was thinking that this bdev pointer could be temp stashed in bi_next (as it
>> should be originally NULL), but that it dodgy and maybe won't even work.
> 
> Failover is corner case to consider here. We always reset the bio bdev
> to the part0, so your stats will be incorrect when that happens. I think
> you can quickly fix that in your proposal with the "bi_orig", though.
> 
> Can we just thread through partitions for the bio's block_device instead
> of assuming part0? I know the hidden path devices skip partition
> scanning, but maybe if we let it happen, then those will have the same
> partition setup as the head gendisk. Then we can go right to the
> disk->part_tbl for what we provide to bio_set_dev() for both submission
> and failover, and everything should work out from there.

I guess that we would just scan through the per-path gendisk->part_tbl 
and match somehow to lookup the partition. Maybe vs start address of 
bio->bi_bdev. Or is there a simpler (and quicker) way?

