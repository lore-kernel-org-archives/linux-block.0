Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68852EA17A
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266794; cv=none; b=KMyWrOjQqTLx2qPnmAlP9kemLuUJ7kMcA2zLSbVwxU0AnP+H/bfE0Fj2cPsiAQTyyIOXmmlnWtLoi31royzxVID70cCSQBjkFxU/5VaPRZce7cxOKDW7eaI+1cU9t+6P/+kFdsLWoAOdXOjm2SViEVBnvRPEddHwhuTRQ/ZMk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266794; c=relaxed/simple;
	bh=80RGYMtJ9pJ7/pqMBxc639ufIgWZsA951un+f3QN1QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1BI5uJQQ1XP4sfQKknQ/pM6InVlTCNOBhB6VU05kgLXJ2Cs7iDwA/pPtQlNiBuxERt/0xpio8x8aoLUTA0zbYN1lwgfDpEPveRNHQlF5IQC9hZWwdotqEBRbOizIfX0wJlf4ZVlFBj8Yp5DybRzB8h7uf2UQBvWMj6oSs+QHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L+PvqixK; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L+PvqixK"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bMr0k4q4Czm0Hrc;
	Wed, 18 Jun 2025 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750266789; x=1752858790; bh=Gef2FoWNE9uyBCT7hSD49QnX
	1w+qctymEnWcbT4xyVA=; b=L+PvqixKLjko9Oi9MEM7mODFdTg9kQg4N9My5nEn
	PosXmxuGZeVHADQNtBUxuiQzk9A/eja9HAG+eZ8rjxtNQNttPuHSPOxqM1riJutu
	hkZnQC4STlDddnm86J9NcNPX82UH3WO228dwbjkWhBVoMoFpMFh9FSegQxtdDY0C
	LpldUgEhSN+af9kuhzNjTmA6dX2cTBPOD3QLGqAx13f1gect2QUJhe+e1V2/+5n1
	g93GJTfowltDAJGCc7P147Os10gMYIyBKeRpG8LfEUvxldFkLcBF6ZZqssAPVkLs
	VwZydVSokHkTBg4Ycpnd4TUbyNCecE4vbvP58D0HiYJGcw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zsfhQt6_L-1q; Wed, 18 Jun 2025 17:13:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bMr0g07RTzm0gcK;
	Wed, 18 Jun 2025 17:13:05 +0000 (UTC)
Message-ID: <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
Date: Wed, 18 Jun 2025 10:13:04 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/17/25 10:56 PM, Damien Le Moal wrote:
> Can you check exactly the path that is being followed ? (your
 > backtrace does not seem to have everything)

Hmm ... it is not clear to me why this information is required? My 
understanding is that the root cause is the same as for the deadlock
fixed by Christoph:
1. A bio is queued onto zwplug->bio_list. Before this happens, the
    queue reference count is increased by one.
2. A value is written into a block device sysfs attribute and queue
    freezing starts. The queue freezing code waits for completion of
    all bios on zwplug->bio_list because the reference count owned by
    these bios is only released when these bios complete.
3. blk_zone_wplug_bio_work() dequeues a bio from zwplug->bio_list,
    calls dm_submit_bio() through a function pointer, dm_submit_bio()
    calls submit_bio_noacct() indirectly and submit_bio_noacct() calls
    bio_queue_enter() indirectly. bio_queue_enter() sees that queue
    freezing has started and waits until the queue is unfrozen.
4. A deadlock occurs because (2) and (3) wait for each other
    indefinitely.

Thanks,

Bart.
