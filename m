Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B119C578
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649847; cv=none; b=JhmsGisoG+gEIgQPym9zm+9yprqEPM2LCf6dmmkIRCP+rT3R0tMa8rBfQ7IsIX6HkVQZTLf5z/jTY1AZ0687h3QiS1nvh5ICRU1m03m9/41PnPzV2BwuJ9O5lWdCj3fl2ACfAF8gEuAQXrJ9ejD4Y1hz/nYVbbPNAT/cQo0nuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649847; c=relaxed/simple;
	bh=pQqQvubciYcR3SyCwmy0jpV7cPdY+Q5Wg78vfe6Qups=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO1qmbu04Q/Os1tM4OhEoP4RcRGE0t1yafLj+nBMo6iKY/2jLNG06/mwhTJODGE0rXGRzt3EpXzoEAH5niyPZcxu+bXuyeKwMkC/4BPdzCO0D3Xg6C29uooGr4VYWVMB5cFxjWDO9pKq61ERjWPD2pOjrVMS3c1olsbddRTbpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0FroJQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0FroJQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A96CC4CECE;
	Thu, 19 Dec 2024 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734649846;
	bh=pQqQvubciYcR3SyCwmy0jpV7cPdY+Q5Wg78vfe6Qups=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C0FroJQENR6tRU/VhS2eDyjOTGULrlWO0ONRXefBa8gaWxVvkK2jG0zwZapWqC+Mp
	 e0GVuh31lmf9p3I24uUVe8L6MBVPY9AHn/UKLObjOfztdQkN0KQwbCcAxrh1Piqyc1
	 MvwJ57hIxk6DCs4ulif9fS/q6NwSv+IaxHjXlFLEUc4+sdNOSRwSMfYOFl3lZWeDMN
	 OfOMtHcS+kSrAWclvZc9mbpCQtMCSHv5UdsdwnrSUB8H9i4KWbZJ4lTBKnWaz6N7Yt
	 aaRrxHrjgHGhFfoX1pfJtGICTd68gsBWSkux5eQz1D6ZI/DfgQlkam8WqSHA5q7njZ
	 +JlKW2lCA2t0w==
Message-ID: <741838c3-63d8-4b1d-9639-edf1b0bc024d@kernel.org>
Date: Fri, 20 Dec 2024 08:10:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <20241219060029.GB19133@lst.de>
 <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 02:12, Bart Van Assche wrote:
> On 12/18/24 10:00 PM, Christoph Hellwig wrote:
>> If you rely on order.  If you are doing O_APPEND-style I/O on  zonefs or
>> using a real file systems it's perfectly fine.
> 
> Using zone append operations defeats two of the advantages of zoned
> storage. One of the advantages of zoned storage is that filesystems have
> control over the layout of files on flash memory with regular writes.

Zone append still allows that: you can still chose the zone you write to.

> That advantage is lost when using zone append operations because it is 
> allowed to reorder these operations. Another advantage that is lost is
> the reduction in size of the FTL translation table. When using zone

FTL ? Ar you talking about the device side FTL ? Zone append does not makes
things worse in any way compared to regular writes. That completely depends on
the device design and if (or not) zones are exactly mapped to erase blocks.

> append operations, the filesystem has to store the offsets returned by
> zone append operations somewhere. With regular writes this is not
> necessary.

That is a very misleading statement. The FS *always* records the write location
of data, be it done with regular writes or with zone append. The difference is
that given that zone appendd operations may be reordered, you may need a little
more metadata to record the location of data if your writes endup not being
processed in the same order as issued. But in my opinion, that is a slight
disadvantage that can be completely ignored given the code simplification and
performance advantage that zone append brings.

-- 
Damien Le Moal
Western Digital Research
