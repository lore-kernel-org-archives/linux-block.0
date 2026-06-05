Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A183A1687
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675832; cv=none; b=fkZhU38V5KmYLXSB2bWkImq13qEPCMdJDYVq+2x3a9LfpTYg96xJRhCHwwjMJaL03cCZaQuOj5mmS7vPvokgJSEkn/rViEi81esVPQTvpp3e5iIIqAjKUb/asTfuAr4Zsn78xeAW2BTENi1grKEQhNkjrlqpi2vthntihuESCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675832; c=relaxed/simple;
	bh=g/veyeW02saFT8Ib0I8nEpXHIh0KLyCMFWPpy1/30hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxibrtKg9wd4LoRcBM/GIGSIsha1oUGqlHp+/eKzix65xy692D6pOLfWMvRcSacXNwGQyp+kSXT+A2jAY4gWjz3S5HjOSIGIEdv58t+Gx9n66nmEYGC86RFEOG0Wr3YQCHyHQ1st7NNyiN5r1d9xRSBhz9MIoLykm7oAYkDLEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RX791Z/s; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RX791Z/s"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gX5xz08c7zlfl5x;
	Fri,  5 Jun 2026 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780675827; x=1783267828; bh=HSMbV8ZGEKwMmgnD2myb/fZR
	5zDHSN+tYHxEJ5PyYLA=; b=RX791Z/sDztpR+fk+wqWDdth8YgmS9Amc6a8hoFw
	DxnB9+Di0QQst/ll6sfKSHT1Hjem4kTNw32pCRudTAn6H9ymvE03uf82vOdQHYJx
	TwBqNzPCoLPrl+x24CsqdfvNDF7EHHtthPX4HaFz523GvZn8aoG176mmK7P8316l
	iSgPqbGiQIjwyPPVieIw8RhQSGY1LOOyjUKXR9/tgjk3DkjPcHvL/emhPlWjLB7X
	e8ZIiN3n8SEzY52sNJ5Sx84XSl5hV9D40aNnPiT4n9yqpaokfyusE2UmMFwqVwei
	3oaw/YL7IjT3LgHSKtU3cY7IBmPv5dGe1coz234OFCCKEw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OxI5PDNa2znL; Fri,  5 Jun 2026 16:10:27 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gX5xs5my8zlgyGG;
	Fri,  5 Jun 2026 16:10:25 +0000 (UTC)
Message-ID: <7832c371-e005-4da6-974b-2a1eeae5d117@acm.org>
Date: Fri, 5 Jun 2026 09:10:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] Enable lock context analysis for the block layer
 core
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <cover.1780419600.git.bvanassche@acm.org>
 <013ee998-7b98-4870-950b-806eef46cf9c@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <013ee998-7b98-4870-950b-806eef46cf9c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 5:45 AM, Nilay Shroff wrote:
> I have reviewed this series and it looks good to me.

Thanks!

> One question: I still see a few block-layer functions that document locking
> requirements with lockdep assertions. Should we also consider adding the
> corresponding Clang context annotations for these where practical?

Compile-time checking is always better than run-time checking so I think
that would be useful. My goal with this patch series is to do the
minimum necessary to enable context analysis support for the block layer
core.

> For example, blkg_create() requires q->queue_lock must be held by its 
> caller, so
> it could be annotated with __must_hold(&disk->queue->queue_lock). 
> Similarly,
> blk_report_disk_dead() asserts that disk->open_mutex must not be held, 
> so it could
> be annotated with __must_not_hold(&disk->open_mutex).

There are more lockdep_assert_held() calls for which the __must_hold()
annotation can be added, e.g. for the functions in block/blk-iocost.c.
However, adding these __must_hold() annotations without adding new
lockdep_assert_held() or __assume_ctx_lock() calls is not possible
without adding more arguments to the functions in that source file.
That's one of the reasons I'd like to keep such changes out of this
patch series and for a future patch series.

Thanks,

Bart.
