Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD93EEC5
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735789612; cv=none; b=LD6L5aSwklksWeW2I14pUTCTtHqvCgUB4UgURXBu0t2PoQOdTxsNa4jCG3VThqnaR/eXwQxp1WzCbb2cmgGG7PEOWpRcUxkP1Z+sBS+bo8QHCCDTiQNNjZnc05De9v7fk6bx5WuWKsmwjMduPSDMtE/MsiPwCQgwCD6P3k02R68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735789612; c=relaxed/simple;
	bh=CZpro6u7cYh9vS+AVFakwjJwYA9Pl3znlDwHsHoZRtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqzzNPHTmCSh7X3ngi7K4Pj0C5M6mgd4OO0RrlyCKtvhJyL4u+1Va2wWBWSq/kbanqThDk3SYNZcXK0RA+uyUJMMVxt+volK10ZLKVoPbE+F8wdOtKqIQL1okMKC706wR3rOU1qBnAtgw86fnrPg/fEeDdmjgunzGg/IEWACEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sl0gvAaM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sl0gvAaM"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YNt1Q46B4z6ClbJB;
	Thu,  2 Jan 2025 03:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1735789607; x=1738381608; bh=IMZCg6UPNbSEgc7QJXczqauE
	kiHtn8uXZwp1gFILWi0=; b=sl0gvAaMLu843TOlwHX3xxHOcya2VhPE2DAAgTOT
	Lin6/4Qhc5JuUNIqfQEQ62LpATb2+dxpW+ntWW6HV3mlHckCpbB0N2D77/h+w0So
	HbAR/6XE0qBhJGOG11fQ8y9OJml3OB98ahGWwoF5SjTB6+RrPyH5kKPfO6f1fiuP
	aq9GTrgAtl6GaCd1ZWuvnv9FPgmRhli1fGKgvK/DVkVSDk8NHD5pP2+ZURq09KHI
	TE/9uMB2mNcn3M1eJfDcVUIUZxvdS45PHSoadxxRgIbfD1P/4UqgltiDZw8VXbTT
	n5Z4g7OmEHSbTU157ljoVso2nuiCOjlJAHvssj+PUOs5Yg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rvy0heKzexPN; Thu,  2 Jan 2025 03:46:47 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YNt1J2Wt6z6ClbJ9;
	Thu,  2 Jan 2025 03:46:43 +0000 (UTC)
Message-ID: <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
Date: Wed, 1 Jan 2025 19:46:41 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org> <Z3X-xMeMuF8j0RDA@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z3X-xMeMuF8j0RDA@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/25 6:49 PM, Ming Lei wrote:
> On Wed, Jan 01, 2025 at 06:30:30PM -0800, Bart Van Assche wrote:
>> Additionally, this patch looks wrong to me. There are good reasons why the
>> block layer requires that the DMA segment size is at least as large
>> as the page size.
> 
> Do you think 512byte sector can't be DMAed?

A clarification: I was referring to the maximum DMA segment size. The
512 byte number in your email refers to the actual DMA transfer size. My
statement does not apply to the actual DMA transfer size.

>> You may want to take a look at this rejected patch series:
>> Bart Van Assche, "PATCH v6 0/8] Support limits below the page size",
>> June 2023 (https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).
> 
> '502 Bad Gateway' is returned for the above link.

That link works fine here on multiple devices (laptop, workstation,
smartphone) so please check your setup.

Thanks,

Bart.
