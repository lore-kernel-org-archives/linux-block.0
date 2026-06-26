Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7F3C555B
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452452; cv=none; b=jzHaTd0JwlN1rzG7a71/QoHqJCtoBj1+w9ajjQ1ysug8LpCrrkru/lDMkF8e79ebq6hu96ljf1cnyIuc058pRAHS7J5E9FnPp14v1aMfoqXOaaNTJ2jJxalsdNuDK0p7nd1f2Bpopdi2TOv/OFXu8Y8zzKV8h7BRKkGAra5SnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452452; c=relaxed/simple;
	bh=KHTyagwvEuBlGDoQ1xV8y1FFb1CzN4gezK/0F1/akls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQxlSZfOSkSW0p1bfsE+5wP9K5v8BsINynwzo84xltzD5kwy+nNDsKABk9ysM2rITRs2kQkiPpOde6ohtmx1AQ63Qm+Ob2ehvYY3SkiVqAhuluk3oGc662TZTLlUNxDRv2y582JNS0NQM+mMLF4gB3HKQFOlIxA4q/SbicxJU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncby5n+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncby5n+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792ED1F000E9;
	Fri, 26 Jun 2026 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782452450;
	bh=xJHuxYaA249Mh8+LDL/12MchBFlVDwyuQfkM0SVgZaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ncby5n+OwZ7A540gaYDXuYUdMIZBf87ilkLeK0x199uadLTTxQAsZ/INNaMikEWWA
	 0ztSYvYFUf4+subb3vDa51uX7qIolzYhYNLd0fSZujcOhobNT7+NmN+vru3JoWclL3
	 AW6cVT69N+RCYnjLuTf1g87dS89yIv/TFZp0dnVxe61dBFl4ySDD3mHvK2WptQN07B
	 shPGdR+TP4nHnDukexvL5K6j422tuzDpW//eYV8pX8/3Jqp+FqRz6LHGBOMY9FzVUg
	 Bm73E11MDl5ak2byXr2UDPKZtKtkoyTNm2Q3KmN9X4s5pnPAoNAFC1PaM4MNzPvLE4
	 XFF9yGD/md95g==
Message-ID: <254e6964-d9bf-467b-a045-e3907de5b226@kernel.org>
Date: Fri, 26 Jun 2026 14:40:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: avoid potential deadlock on zone revalidation
 failure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260625062824.2013244-1-dlemoal@kernel.org>
 <20260625115232.GC18076@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260625115232.GC18076@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 8:52 PM, Christoph Hellwig wrote:
> On Thu, Jun 25, 2026 at 03:28:24PM +0900, Damien Le Moal wrote:
> 
> [very long lockdep trace]
> 
>> +	/*
>> +	 * We may already have a zone write plug workqueue as this function may
>> +	 * be called after disk_free_zone_resources(), which does not destroy
>> +	 * the workqueue (the zone write plugs workqueue is destroyed at
>> +	 * disk_release() time).
>> +	 */
>> +	if (!disk->zone_wplugs_wq) {
> 
> Can't we just allocate this at add_disk time instead of the magic NULL
> check here to mirror the freeing side?

Just tried and yes, that is fine to do. A bit more code reshuffling that I
wanted for a fix, but in the end, a lot cleaner and simpler.
Will send V2 after some more tests.

-- 
Damien Le Moal
Western Digital Research
