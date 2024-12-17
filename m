Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F01F8EED
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463373; cv=none; b=d5ICXxrTwnye2m+hGy/dKLqecexH3HEs8y+iCsaXQOfMH6SO/cRPWU5aWmV6ldRGmakO7AXosS9e44HUuNxVYdxPBSCOq0rDIs4TOhXvGKlTCOwSJ/sG+wjFlVV1gIx55ciHFdgGwhVEsJgjsOBxVe0pVXX00s63Y4iBS0ipLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463373; c=relaxed/simple;
	bh=CLFuq/nlRq01UQsE6qLFi0QZQN8a5QaQk7DJGb9zdhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhE9VtbMkoopryycdbEiqJdVf8Vwpu2s4729bHGIh1/hQOH0vvZE1OKEN6BIfCu2Nw9we+oxs23PR94dro9DiL/HjqA06ZEbIC4azNUO2uHm8lGaTbEUkaCssSa0yF2j3jt9n5ujk0DgzYTv4lN/Stv1hZl0D2VKLoHsYcTRz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d03tnq2/; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d03tnq2/"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCRXq4TnYzlff0M;
	Tue, 17 Dec 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734463369; x=1737055370; bh=dEwKEx2tG7+1TCzKnZgOqZHR
	Tp7Bw8qb6XDKb5vr+xM=; b=d03tnq2/zI6Dx5mmjPOsAqmuouRbfm0oyBSuX2tX
	019AcsRzfI8s4YoWBLNodgyZDIZJHPLrFVSpjxtGN3TxrednJCFoK8CDEVGDNrg1
	TEDG0qixb+DmjN7CVrThsO4yJRrA9EPAq821or3klGi7qQ0HuGc/GNudmZNrLJKv
	iTywq+4UY3kP/ab91ZJDF9QSolWkIfKpbNfp6nfGkOPz6z9c+I3/ieCjAYX/atWl
	QmgndFqNvqgp1M5GZPBX8vL2JVi70t36uR0uyCEdtAvvOEIKkE51d+FYbcHLIXgt
	y1hESna9+zoRDsIWtn6EeuUqw0nQHegjViyCPp3QJMOlKQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 71d9ba3vIlmf; Tue, 17 Dec 2024 19:22:49 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCRXm6hCwzlff02;
	Tue, 17 Dec 2024 19:22:48 +0000 (UTC)
Message-ID: <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
Date: Tue, 17 Dec 2024 11:22:47 -0800
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217041647.GA15286@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 8:16 PM, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 12:19:00PM -0800, Bart Van Assche wrote:
>> Help the CPU branch predictor in case of a cache hit by handling the cache
>> hit scenario first.
> 
> Numbers, please.

For a single CPU core and with the brd driver and fio and the io_uring
I/O engine, I see the following performance in a VM (three test runs for
each test case):

Without this patch:      1619K, 1641K, 1638K IOPS or 1633 K +/- 10 K.
With this patch applied: 1650K, 1633K, 1635K IOPS or 1639 K +/-  8 K.

So there is a small performance improvement but the improvement is
smaller than the measurement error. Is this sufficient data to proceed
with this patch?

Thanks,

Bart.

