Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097702222D2
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786533; cv=none; b=AhEe88kQ08uBH96d2+j8SCV8lBeSbXhfNLpKKqKakBKSvcJPAyAubM5OOc7P/4dzHIIe6BCWUK5jzl1E1Wwacut3WiBE2IX19wCSUZ0b2fEppy6YDwDajR5yQYDpx9Kezdp9o8ZHrXs+Bavp6GhlJfQ4rJ/TxhVTupeYTNkxoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786533; c=relaxed/simple;
	bh=/6QTamy8bf3WE2pwUs1F+UBwdJ5CaRi5N1K2xKSHEN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEoPZ64ivgdP6pt9ezQdBD6mZvkbbUb3a/NhkYZ2KlGXDVJbn46lT/1RFYCfHbqu7D78Fh1vjBMTn0L8YjXadhb0BXvSUhpYx9mt9DTffyNcd5axw0DD8UMosArFPVgErLHt+aVA2Mx96Ru4TvFYe/xAvrllx/2vvqyr+w64nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DXfKw00/; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DXfKw00/"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bRXCk6xWYzm0pL3;
	Tue, 24 Jun 2025 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750786529; x=1753378530; bh=KpLFufanvaTmZ7/HIU8J2UcY
	WDZJVMM2AgMzthHOR9c=; b=DXfKw00/+gQC5tXjMpwV4BaXwaruaEhr/8i/eq73
	OZtvDOGIhe0eEzHyDOGUf+/rdTDRZDiI+MmyqXfRx+2QstQILiAArX8krV1CQWSB
	eG17QNaDXqbwGjlgRYsgkp1TC/fwg0fau+7du8yOD+9QOfug8bdt/lIX8PQZaGCO
	MPmR6VL6vSs3Z1xzKxJ742fF0a4/RQsBDn6YLE/EX8xq5A6I7o0GvmSpF1QqeQZm
	wJdVULlR08UMnBMfwKiKeZZ+D4MyIUedE0AQ+A4/+LFIYR4gdr6/3zukGrf+vrWR
	+gyzLG7IVFcVKDCc56/EV9hROUT48ZiEihop3egx82NZnA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Xmc84wy2MYqa; Tue, 24 Jun 2025 17:35:29 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bRXCg4jhfzm0pKv;
	Tue, 24 Jun 2025 17:35:26 +0000 (UTC)
Message-ID: <2b6ec966-a88f-40e2-9093-42b27e7cc8d5@acm.org>
Date: Tue, 24 Jun 2025 10:35:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
 <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
 <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
 <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
 <ea9c6463-f602-4fcb-b343-dd1973304abf@kernel.org>
 <cb62c949-db47-4d09-9846-8e02476d6aa9@acm.org>
 <82c56da6-640d-4ead-b0fd-bbe564d4386f@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <82c56da6-640d-4ead-b0fd-bbe564d4386f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 6:18 PM, Damien Le Moal wrote:
> For a nicer solution, which is mostly DM-based, combine what I sent you to
> force write BIOs to be split early for zoned DM devices together with the patch
> [1], which I sent already but needs more work. This combination was tested by
> Shin'ichiro and he could not reproduce the hang with both patches applied.
> 
> [1] https://lore.kernel.org/dm-devel/20250611011340.92226-1-dlemoal@kernel.org/
> 
> As far as I can tell, dm-crypt is the only DM target driver supporting zones
> that splits write operations "under the hood". But I will check again.

Hi Damien,

With both patches applied on top of Jens' for-next branch (2d5a3220c1f5
("Merge branch 'block-6.16' into for-next"), I can't reproduce the
deadlock anymore. This is unexpected because the deadlock happens
between the queue freezing mechanism and zwplug->bio_list. No
matter how bios are split, if bios are queued faster than these are
processed, one or more bios end up on zwplug->bio_list and this deadlock
can happen.

Did I perhaps overlook or misunderstand something?

Thanks,

Bart.



