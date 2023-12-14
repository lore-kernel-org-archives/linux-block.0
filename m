Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4C389
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdikkb8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E49C433C8;
	Thu, 14 Dec 2023 00:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702514243;
	bh=paZ46FqOHcqf2MWjJz29qCsxdZx7eGwVCnxNDOGbeK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mdikkb8uxRmDuyDq7Z9OmL4vEo5AM81RvY1bhwzVAoeRkmuu5eYraKJgYkpIf8yDF
	 Ny8bJLUKrG0f1shcKoOl2DMmaDZ/aS9ytEAyb3+FolbwgZdqj6KHIruE+YghtQbUTV
	 Xtqdq9TmRc+IybqT3NNCXoIyS6KuSQw9/Ly6t/XwZWixpZdBi/ULEdA+tIVpI+YYeO
	 vGEtS1klM2PMgT4JGEEnzMDjJhdz2cQ4DTebGFOhPYXid+kC0ydCMevIPZmEx2ktgV
	 ZCiT/Ml1ExfIfVGOQgAIKXpQUJqlJgBhbmSv7IzU3DA4edea/qwLWSbH17M1t2+Q9a
	 NSrpvlKyZjWNA==
Message-ID: <abc13a22-74b4-4f72-b592-09781d0cfdd2@kernel.org>
Date: Thu, 14 Dec 2023 09:37:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
 <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
 <20231212154140.GB20933@lst.de>
 <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <697f5bc2-88ea-42f8-9175-fbc414271ea3@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <697f5bc2-88ea-42f8-9175-fbc414271ea3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 09:08, Bart Van Assche wrote:
> On 12/12/23 10:13, Christoph Hellwig wrote:
>> If you want zoned devices to work you need something
>> like zone append [ ... ]
> 
> If F2FS would submit REQ_OP_ZONE_APPEND operations, the only realistic
> approach in the short term would be that sd_zbc.c translates these
> operations into WRITE commands. Would it be acceptable to optimize
> sd_zbc.c such that it does not restrict the queue depth to one per zone
> if the storage device (UFS) preserves the command order per hardware
> queue?

Yes, that can be trivially done with the sd_zbc.c zone append emulation. If you
check the code, you'll see that sd_zbc_prepare_zone_append() returns
BLK_STS_ZONE_RESOURCE if the target zone is already locked. That causes a
requeue and the zone append to be resubmitted later. All you need to do for UFS
devices is tweak that to not requeue the zone append if the write command used
to emulate it can be issued. The completion path will also, of course, need some
tweaks to not attempt to unlock the target zone if it was not locked.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

