Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9318AED
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852103; cv=none; b=C0AKVpY2o8Lry1GFzHTxneG0CORzbSzmX0EpZVcAphipVE0PUzFPKpdbtQRj5dOBevh6fPtsuOAvFmpxO8u3CKgII1Aq4p9MIkY4nTo7vAjwlxwcT6uFM02JbyE3iKp+/R2YhwZw2jOgur6jbo51l0ZniPGlgdBurHkIEe6+v0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852103; c=relaxed/simple;
	bh=CuU11ieAy22HCD9BtYUicWtfKkaLW/oyXZx4htfustM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvkRm8GYDfkCCckKhIfyz/ygnvaJ9huoLb6hOsL97VISMMc5VxWb/K117qRspE2FChWNFwKfcWcqG+wPYfRwGwCcPlPbfh/iUwORuxDHoTAMSdK9sM7JForysAXhWPet3qoEQhC/A+mcdb4ImitFqGYxiGGbbYsi0wabQkfo7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbGLIw6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbGLIw6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732AC116B1;
	Tue, 23 Apr 2024 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713852103;
	bh=CuU11ieAy22HCD9BtYUicWtfKkaLW/oyXZx4htfustM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbGLIw6uifMTlZGS5XAH3dvqacPfVqIW/0Ne77bfBWEJusLuxD4t3Swz/eMBRyCdQ
	 WMc5tW+54Qqy9RNN97ZWAAUlgkev8Oi5h6JtuFppQt7IHFQw2L3kGLokdseI8Ln9kL
	 wv5oYhW/R2IkBBq1pyJg+n9WB2hSinqFJ/TaJBgOI2TvZdb797XnyPu5wR1Zz1TCIt
	 2stiq4UqCs+JgOMH36ABeVk7sH+bzL541zIVA6hE1IyWPBQJKd+r4yEHiGYsi9IsdH
	 b8UitJ8/GlwrDmJKuXTc9RlrMrimfA2vzbOHhDKIePRIsAiwjeQjJkzVfzdDJsMbis
	 ZBPBQ9rorsuxA==
Message-ID: <4b3a868a-3c79-42cd-96bb-3bf288ee786b@kernel.org>
Date: Tue, 23 Apr 2024 16:01:40 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: use a per disk workqueue for zone write
 plugging
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-3-dlemoal@kernel.org>
 <ZiYC6c100oNWFa0y@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZiYC6c100oNWFa0y@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/22 16:25, Christoph Hellwig wrote:
> On Sat, Apr 20, 2024 at 04:58:11PM +0900, Damien Le Moal wrote:
>> A zone write plug BIO work function blk_zone_wplug_bio_work() calls
>> submit_bio_noacct_nocheck() to execute the next unplugged BIO. This
>> function may block. So executing zone plugs BIO works using the block
>> layer global kblockd workqueue can potentially lead to preformance or
>> latency issues as the number of concurrent work for a workqueue is
>> limited to WQ_DFL_ACTIVE (256).
>> 1) For a system with a large number of zoned disks, issuing write
>>    requests to otherwise unused zones may be delayed wiating for a work
>>    thread to become available.
>> 2) Requeue operations which use kblockd but are independent of zone
>>    write plugging may alsoi end up being delayed.
>>
>> To avoid these potential performance issues, create a workqueue per
>> zoned device to execute zone plugs BIO work. The workqueue max active
>> parameter is set to the maximum number of zone write plugs allocated
>> with the zone write plug mempool. This limit is equal to the maximum
>> number of open zones of the disk and defaults to 128 for disks that do
>> not have a limit on the number of open zones.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Should the zone write plug submission do non-blocking submissions as well
> to avoid stalling in the workqueue thread all the time?

I do not think that the stalling actually happens that often. The 2 main cases I
see are:
1) Out of tag so we block on tag allocation when preparing the request in
submit_bio_noacct_nocheck(), or
2) The device has BLK_MQ_F_BLOCKING set for its tag set (e.g. nullblk with
memory backing).

For (1), we could use RQF_NOWAIT to prevent blocking, but then we would need to
retry later on with a timer to make forward progress for the plug. And I do not
think we can actually avoid (2). So in the end, I do not see a clean way to
completely avoid blocking in all cases.

-- 
Damien Le Moal
Western Digital Research

