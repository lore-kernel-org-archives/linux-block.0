Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB01135A53
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730260; cv=none; b=Whz+jmSLJOasOGlZC6tWH2XfItHpPEjoWTiYpb3p5HqRRYlYM6IvWs/ggUpptkwZxNODfmkfiLzTYjLKMmLYv+T9lha0RvnMRVmGvdtK80MCelj85dDO6IWHBiG8vW1yuMCSHhJ06I97p2DaKToPTeG8JXpgLK6Gdt3I9/h4jQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730260; c=relaxed/simple;
	bh=Axfrr0aXqPxUQ6jYyD1Wf2MEZpP1zVXhNVYqtLy/mos=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WLVT+NoK2ctiN9jkSc84wBqGbsHyHAd+4RiCaRU+RGH53gyundG0oOIQ1WcH67NG1xZvc9uBDr7tK/l44GI8eNRRsQcQJI8XM4d4oxQmlG+BiLDvzJqgs9EtFBLUTiPFDWBIZCrN2+c4YcNZvMsDFlNDxaKOLrVkI/4a+bvAGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=J84lw8fp; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="J84lw8fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749730260; x=1781266260;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=bvlvF4gFIy9Jl6a4i0g++a3bfkzufh8J+DkgLaTweow=;
  b=J84lw8fpspA3+23JhrdVNbtHSMQbHPr5lGkqcxGGUq6gOKxxZSXWmz++
   ku+wsxGajXwymCtr7hsYFQ1kLghB16jaIirKRlpgQRLcEOE4BsT4juplb
   ufuM8Uqq7gjpn8oae08HMKUM5TvbQsbGoVLLxUZgUxfEYQmCC6WrDmeyR
   oT5T6Oh5bPzlJP78+byY+VMnZzvkJcFdWy+kbSouf3Xv0z66PJ+taqEvi
   Mg2tDU1Kog//EYMkEp6K/AfBHst+eB/TFkuJ/R41DXKT7fe6mQzBh6S1C
   D7neMjro1A1jNngtVI4G3xXVBCwRFFTUnVwCNyb4lN95GWkenyrK5dzj+
   A==;
X-IronPort-AV: E=Sophos;i="6.16,230,1744070400"; 
   d="scan'208";a="103430363"
Subject: Re: [PATCH, RFC] block: always use a list_head for requests
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:10:56 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:48232]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.148:2525] with esmtp (Farcaster)
 id 841b79f1-9273-4b1b-9c1d-b425628bbc17; Thu, 12 Jun 2025 12:10:54 +0000 (UTC)
X-Farcaster-Flow-ID: 841b79f1-9273-4b1b-9c1d-b425628bbc17
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 12:10:53 +0000
Received: from [10.95.108.147] (10.95.108.147) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 12:10:53 +0000
Message-ID: <bd131ac3-df20-4a60-8e3d-926b8509ab85@amazon.com>
Date: Thu, 12 Jun 2025 13:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC: <linux-block@vger.kernel.org>, <ming.lei@redhat.com>
References: <20250612074245.2718371-1-hch@lst.de>
 <ab5bd614-a873-4228-968f-e9086ad1ba38@kernel.dk>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <ab5bd614-a873-4228-968f-e9086ad1ba38@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D003EUA002.ant.amazon.com (10.252.50.206) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 12/06/2025 12:53, Jens Axboe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 6/12/25 1:42 AM, Christoph Hellwig wrote:
>> Turn the remaining lists of requests into the standard doubly linked
>> list.  This removes a lot of hairy list manipulation code and allows
>> east reverse walking of the lists, which will be needed to improve
>> merging.
>>
>> XXX: the ublk queue_rqs code is pretty much broken here, because
>> it's so different from the other drivers and I don't understand it.

For me this looks like reverting bc490f81731 ("block: change plugging to 
use a singly linked list") which was mainly to save space and avoid the 
manipulation overhead for next & prev pointers during list modification.

> 
> First of all, we're definitely not doing this for 6.16-rc, and secondly
> it'd need to be properly tested in terms of performance implications as
> well.
> 
> I'm somewhat annoyed that ordered plug lists turned into this, which I
> already strongly suspected would be the case back then. And doubly so
> that a really basic performance regression was also caused by that, and
> then the proposed "fix" is to go further into the "let's slow down the
> fast path" of code. Yes deleting some code is nice, but let's not
> pretend that it's free.
> 
> --
> Jens Axboe

I agree this requires some testing to make sure the benefit of having 
list iteration flexibility actually overcomes the overhead of list 
manipulation.

Hazem
