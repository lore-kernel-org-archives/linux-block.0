Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357B1741E0;
	Wed, 28 Aug 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847229; cv=none; b=vCWRRTOjySmGSvnDq2kCzhP7cvGf/Xcw59psNNjAfAtw/sjp7nFyBSeur8iPN5V+HR2TISWfV2AxcaaMi9qfUi9sNa8+7yFTIbI7MFl3q93IDkcq/UtIP8uVUqQftPSeHNn/039r/0xaPCRnQYpysy/z+IR8fUdkzI5TgSSY5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847229; c=relaxed/simple;
	bh=3GRVOC7U2U+JdayHua+VDalrMyTkQlCANflMHPNxBBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdIoo4ezmdcikhla+oqR0G6M5SbUlFeJ0p5ZPFSRwpTgqOMin6pgxQOYMekQx9fuhivsuDpll70gHYDvlRyLC9gmND+zTj31dwGpldLDoqLSlZMH+SeReCodOVHksosJPgj3wOov/gHJuxdqQ6bhHPYPFDp/0/aX2/LWa1oK3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u/eemwDy; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u/eemwDy"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wv3Gz1hjnz6ClY93;
	Wed, 28 Aug 2024 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724847222; x=1727439223; bh=3/6gicRqsnGlfYA1K7didg38
	HjP7HIqfIiR6f1HgZ2k=; b=u/eemwDyTuvK05NYcaNznNoE9xJW7CgNQUvxRU+4
	9YzwaImhwEPy/gGcA/O4Ft0tamYVH4QvvJyl+S51eqgcDmxWIofcfNx8m2uvJbOA
	ZoO4N208F3xM5xGR2+zGv61vZu5DzMvcpn/Bf4ZLhgVsooWnt2UA1UHM7Z7kq55f
	cA+y67IoUZES1O7uAoFl3NrSW9lXDRDw/o+O71Lkr0EzoK9q0HNb8o14DPrNnSVZ
	GkpZUkebnEkgIflKY2BPJiI7nNYpwQMGy6sBRRHFm1GyjnhMIs5wFsPMS7x/9mG1
	2m5wWQn193SJ6ErPTDOhxoEwVVhGiiot8k1Xu7prG3G2cg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 67gNZ1Ecy9xD; Wed, 28 Aug 2024 12:13:42 +0000 (UTC)
Received: from [172.16.58.82] (modemcable170.180-37-24.static.videotron.ca [24.37.180.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wv3Gq6M4Pz6ClY92;
	Wed, 28 Aug 2024 12:13:39 +0000 (UTC)
Message-ID: <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
Date: Wed, 28 Aug 2024 08:13:38 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Allow complete locally if capacities are
 different
To: Manish Pandey <quic_mapa@quicinc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
 quic_narepall@quicinc.com, quic_rampraka@quicinc.com, quic_cang@quicinc.com,
 quic_nguyenb@quicinc.com, Qais Yousef <qyousef@layalina.io>
References: <20240828114958.29422-1-quic_mapa@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240828114958.29422-1-quic_mapa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 7:49 AM, Manish Pandey wrote:
> 'Commit af550e4c9682 ("block/blk-mq: Don't complete locally if
> capacities are different")' enforces to complete the request locally
> only if the submission and completion CPUs have same capacity.
> 
> To have optimal IO load balancing or to avoid contention b/w submission
> path and completion path, user may need to complete IO request of large
> capacity CPU(s) on Small Capacity CPU(s) or vice versa.
> 
> Hence introduce a QUEUE_FLAG_ALLOW_DIFF_CAPACITY blk queue flag to let
> user decide if it wants to complete the request locally or need an IPI
> even if the capacity of the requesting and completion queue is different.
> This gives flexibility to user to choose best CPU for their completion
> to give best performance for their system.

I think that the following is missing from the above description:
- Mentioning that this is for an unusual interrupt routing technology
   (SoC sends the interrupt to another CPU core than what has been
    specified in the smp_affinity mask).
- An explanation why the desired effect cannot be achieved by changing
   rq_affinity into 0.

>   block/blk-mq-debugfs.c |  1 +
>   block/blk-mq.c         |  3 ++-
>   block/blk-sysfs.c      | 12 ++++++++++--
>   include/linux/blkdev.h |  1 +
>   4 files changed, 14 insertions(+), 3 deletions(-)

Since the semantics of a sysfs attribute are modified,
Documentation/ABI/stable/sysfs-block should be updated.

Thanks,

Bart.
