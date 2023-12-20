Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFFFBF9
	for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV1w4Amt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6EAC433C7;
	Wed, 20 Dec 2023 04:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703047221;
	bh=u/N54yNLbpUXZ1OOo/bAdksN+qc4HE7YDTIWrN47v0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VV1w4Amt6YFIa45hs5Evo1DOgvlGcE4w1g0JWb72g2As8PaicZpNE3Y9dElf9S2Y+
	 NakH7HgLB4vxzUp+8AuLefZ7h3QUE0vdjRXFPG5pwryY5LqdBRQ0N0g8cyOrMHewsv
	 g+Ez0ENZr449w/EPvysSYSCZsM5oI/r3XBsBbGK/MSysCftNw/9TeBojUduWFR2Fs9
	 4ar6ppWRLgYgVi19jGwzUwH45OFBGFcvgXh6hSmAOxI6pVdWTVY/7hJll0tMxnM1R5
	 xlphDdIIURrwcZxHpq/1IudTL8tIEeMyMVjqvv/PGvJHSA7+1vtWtTaDfe8fh3/Qp3
	 h+CsPZLP0QeFg==
Message-ID: <8b3315b9-da0b-4439-8886-fb16a50489e3@kernel.org>
Date: Wed, 20 Dec 2023 13:40:18 +0900
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
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20231218211342.2179689-1-bvanassche@acm.org>
 <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de>
 <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
 <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org>
 <2e475db5-fd09-483c-9c34-d9bf9e64d273@acm.org>
 <995e1ae3-5d03-453a-8a97-a435bfa3e2c4@kernel.org>
 <20231220035347.GA30894@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231220035347.GA30894@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 12:53, Christoph Hellwig wrote:
> On Wed, Dec 20, 2023 at 10:28:37AM +0900, Damien Le Moal wrote:
>> zone, and as I said before, since doing that is nonsensical, getting the IOs to
>> fail is fine by me. The user will then be aware that this should not be done.
>>
>> f2fs has a problem with that though as that leads to write errors and FS going
>> read-only (I guess). btrfs will not have this issue because it uses zone append.
>> Need to check dm-zoned as their may be an issue there.
>>
>> So what about what I proposed in an earlier email: introduce a bio flag "ignore
>> ioprio" that causes bio_set_ioprio() to not set any IO priority and have f2fs
>> set that flag for any zone write BIO it issues ? That will solve your f2fs issue
>> without messing up good use cases.
> 
> How can this even be a problem for f2f2 upsteam where f2fs must only
> have a single write per zone outstanding?  I really don't want crap
> in the block layer to work around a known broken model (multiple
> outstanding WRITE commands per zone) that because it's so known broken
> isn't even merged upstream.

The only constraint at the BIO level for writing to a zone is "issue the write
BIOs sequentially". So multiple write BIOs *can* be issued to a zone. The "one
write per zone in flight at any time" implemented with zone write locking
happens at the request level in the block IO scheduler, so underneath the file
system. So the issue can indeed happen.

But what you said could actually provide a solution: have the FS issue regular
writes one at a time if the writes have priorities.

-- 
Damien Le Moal
Western Digital Research

