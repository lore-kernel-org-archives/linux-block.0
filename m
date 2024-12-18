Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250B1F9A98
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546151; cv=none; b=U8PVKwjA8yJbMxXlwZbXmaroVrLPCQjzFyz0ABcmNFeYMzSNGJE65zkrzspnbvaobpmBzJ/GQb186LW2UZEyCIwLksprNYHXBZeqcrsmZAL79Si1RbrquPPnpupUmPQlzQ+fKs1LK2GHGR4EMFvKMg/S9sxGTRuj8VvvIjXkfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546151; c=relaxed/simple;
	bh=Y1BXgLYJuOuqQ1E1W4SdtUMJYOwc4pFewQyhKrAw7UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM5e2t62MDt55ZIKA8ZL5s1OGtRZtwJfiHNBnZI7b5eUQ1iSkS3HvtlY9ip3b6Nzm1j0Khn0hoqGvlRui87NRA49Er2IXWQzQSXSIuRw451kc+jNjh3vIqErqWzXQpVKoTsD7SMSIs7Of2Uytihy4KpM4uJ6QDEpCILYU0jUtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nddpkus1; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nddpkus1"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YD28j1FbXz6ClY9G;
	Wed, 18 Dec 2024 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734546146; x=1737138147; bh=Rvnb5mMmBSkIU1JiluoTx4wx
	lCG0kHa6+BshzhjBtJE=; b=nddpkus1R9gv+FJNdIe7TUGJGMZAAzOmhqJXsaqQ
	xogiv1kLnKbp+jNl1nl58o1bsZ08HGedgt72kzA05ZmnCfZCn3+daQIYCJC41Ymp
	ndsBruTM3/D+3+aUt8ExTKJf7wz6PSqPJK/R7liao9AaEeIrqBcONRInyaJz3/dQ
	O1MjNCqx0xpTA49ItreraTh8rkbq4tIw9RE/mJc8jeoaImH12B7Tyo4wjwe/5coC
	CFK5Joro0INjmvtHSsYkAk9uesbdt5PPyvSIWJI9SxXec1AVv0vqIniFalMCQcPd
	rZvFBajyCsyIuWxEbUyvmhH22JhYnw+H07g68kb11BRvDw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EuLhVgd1nr9W; Wed, 18 Dec 2024 18:22:26 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YD28f1T0Vz6ClY9D;
	Wed, 18 Dec 2024 18:22:25 +0000 (UTC)
Message-ID: <f56d6562-a9af-4bbc-a8b4-6b93e5ff721e@acm.org>
Date: Wed, 18 Dec 2024 10:22:25 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Optimize blk_mq_submit_bio() for the cache hit
 scenario
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20241216201901.2670237-1-bvanassche@acm.org>
 <20241216201901.2670237-2-bvanassche@acm.org> <20241217041647.GA15286@lst.de>
 <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
 <20241218065955.GB25215@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241218065955.GB25215@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:59 PM, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 11:22:47AM -0800, Bart Van Assche wrote:
>> For a single CPU core and with the brd driver and fio and the io_uring
>> I/O engine, I see the following performance in a VM (three test runs for
>> each test case):
>>
>> Without this patch:      1619K, 1641K, 1638K IOPS or 1633 K +/- 10 K.
>> With this patch applied: 1650K, 1633K, 1635K IOPS or 1639 K +/-  8 K.
>>
>> So there is a small performance improvement but the improvement is
>> smaller than the measurement error. Is this sufficient data to proceed
>> with this patch?
> 
> I think it's sufficient data that should not claim that it is an
> optimizations.  The resulting code still looks nicer to me, but
> arguing with optimizations feels like BS.

I will change the patch title.

Thanks,

Bart.


