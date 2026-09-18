Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264C3A873C
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742095; cv=none; b=MwdxxvFEved4JSLMiAHwdnMHU3scqo8oVj1+qVOIszrLCqHMeNfownv3k5fNpOyQjJcKIX+pjwgDqupqL9prYP4t/anSRdtwgsgB6K4QZfndcmgNdMemWgrv/cy0+Bhrry+FWL0y6Wrxy04+SIUZcz1qyIJlv1Ii+wPZA2FfF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742095; c=relaxed/simple;
	bh=FIyL0V1zpQH8p/Sz45dg7zZ0mpjRtmtojr9K9dAvEWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMiSI9BzLNqAkEydxExsczVdu0dISAiiiDjqORS3BgvkSanBuFvfavBWnCpgzyyWAE6d6UKVi55laHf8OczcWePV5MIMzbTsVI6JGk7Zr8L9iyMyUsW3P3+AjTTwDJd9SM7n5l5MBRZi4ygUh2qv7IH1FBPMONJMH7qIPBPIprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GvgZixu7; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GvgZixu7"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FIyL0V1zpQH8p/Sz45dg7zZ0mpjRtmtojr9K9dAvEWM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789742091; v=1; x=1790346891;
 b=GvgZixu7RasTfBwF+FbB+u8tP9RSVlhISJEZV8D+eId90xE6flIdvBaE0ikMlSvx29hd3SAJ
 k1ZBgEDLe38wAOKrkODQ72XO2s8X7KvBy1MVuo2eKbWJkpA9LnXt0hA9kLbtA2c7BbgFqYDot4i
 OlakaJmqoIjt20nZIfO+aw+Q=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e0e653696ac175e;
	Fri, 18 Sep 2026 14:34:50 +0000
X-Mizu-Trace-ID: 2e0e653696ac175e
X-Migadu-Flow: FLOW_OUT
Message-ID: <aaaee8c5-3a81-4aff-ae02-6084aad9bbe8@linux.dev>
Date: Fri, 18 Sep 2026 16:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 for-next 2/3] block: allow error injection rules to delay
 bios
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
 <20260830012002.80275-3-haris.iqbal@linux.dev>
 <20260915091146.GC15715@lst.de>
 <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
 <20260918142222.GA19288@lst.de>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260918142222.GA19288@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 16:22, Christoph Hellwig wrote:
> On Tue, Sep 15, 2026 at 11:24:47PM +0200, Haris Iqbal wrote:
>> We can do that, but that's only half of the feature, and the weaker half
>> IMHO. Only delay with a successful completion covers a more useful scenario
>> for testing in the upper layers.
>>
>> I am thinking about how else we can do this, but did not find a nice
>> approach.
>>
>> Maybe we can #ifdef the new flag on CONFIG_BLK_ERROR_INJECTION?
> 
> At least I'm not worried about the well-predicted flag, but about
> using up the very limited flag space.  But if this is so important
> we'll somehow have to live with it.  I'll take another closer look
> to see if I can come up with a better idea.

Thanks.

I can send a clean v3, with the flag, the changes to 
submit_bio_noacct_nocheck() removed, and the corrections according to 
your comments. I also found the Documentation changes in this version 
were big and explanatory, which I have shortened for v3.

