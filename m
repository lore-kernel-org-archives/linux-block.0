Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77537BE93;
	Wed, 19 Aug 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166618; cv=none; b=bVFmTQWE55EG6wOoWzzEgg6vMGjO9yoUGXdwS0tCndgZE5kkCKJE3XTpVYp+IwY9mKmvDK73a+LAL6E7nC2aqIg/YX2uRJ1i407Ccv3U8T2w+E0rQflOvYSBosA8wtaVO8OaWMP9I5s7zfmKWFOQ+HY3aw6nnmD/QTLcu3Hk42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166618; c=relaxed/simple;
	bh=LNQx4g9aWvpEYBJKLakRHpLku9vGnBbGURveUiT/i+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGueJTVL+vwDEfUJhMa4KmIGrwKVpD170t5Q/YoANDZAprnCPmMDsoF1sTSk36DKVbVLZRCUldz2ldnYgkyJWFrzH0OpSzCIYtPSO6Zx9zz/o058T5vjnp+hbrGAOhWYUaZXbol7wf5SijZw4XwtFvzY2RfNx71GZ47YkvZ4Qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hTXyPi5x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTXyPi5x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9FoIbo+HMXPEsyZ2YCQCyDcajDwiCU/Latc8LU4M7W4=; b=hTXyPi5xSDHQeoPyAmHXNu+wil
	jtpqqS86LfvBX6BfgfNdnVx5GofmCPu/7LjC6NSSwNXHCtjc1AoqeMYvpyV1ixjWePKAJeSMqcTX3
	nUrKbvL+oZ2Xss1+MZvsWkD64rYOiWbEEa28zNr8anhuINi0dLXGFX9ony02g4rhP9dpiz3/NrjJ5
	qOyozuWi5ELQwQH8vjWTGPf7gHK2ksD5bFvNACqexKRLwP89lm57J1ReD6gMQeCoPIxvLWnMN7fZn
	2yFWR2b/vzPKUlwuHLxJOEjuv8Qjmb/dpFpR8hYvvfqVEfMyz67Sb4jUr2tiRx2iXf+DU87myq6yS
	w2I2N9eQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwlfz-0000000AQhP-2Oga;
	Wed, 19 Aug 2026 19:10:15 +0000
Message-ID: <8807fa80-307f-4b3d-90c7-0f7bb0b6d37a@infradead.org>
Date: Wed, 19 Aug 2026 12:10:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Jenson Johnathon Reggentin <mail@jregg.de>,
 Haris Iqbal <haris.iqbal@linux.dev>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
 <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
 <08c89377-a6b8-4f9d-9f47-7c6faf99d535@infradead.org>
 <7a09f4f8-bf07-4117-b8b6-0ba683d60e86@jregg.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7a09f4f8-bf07-4117-b8b6-0ba683d60e86@jregg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/19/26 12:07 PM, Jenson Johnathon Reggentin wrote:
> 
> On 8/19/26 20:49, Randy Dunlap wrote:
>>
>> On 8/19/26 11:47 AM, Haris Iqbal wrote:
>>>
>>> On 8/19/26 20:25, Randy Dunlap wrote:
>>>>
>>>> On 8/19/26 10:46 AM, Jenson Johnathon Reggentin wrote:
>>>>> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
>>>>> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
>>>>>
>>>>> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
>>>>> ---
>>>>>    Documentation/block/blk-mq.rst | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
>>>>> index fc06761b6ea9..c2af39f14d6d 100644
>>>>> --- a/Documentation/block/blk-mq.rst
>>>>> +++ b/Documentation/block/blk-mq.rst
>>>>> @@ -139,7 +139,7 @@ completed.
>>>>>    Further reading
>>>>>    ---------------
>>>>>    -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
>>>>> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>>>>>      - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>>>>>    
>>>> I still get a 404 error message for the new link also.
>>>> As well, my browser and wget both report bad/invalid SSL certificate.
>>> Ah.
>>> I checked the link in the comment and that works.
>>> The one in the diff works, but with a warning about its certificate.
>>>
>>> Maybe its because of the missing "www." prefix?
>> Yes, adding "www." works for me. Thanks.
> For me too. Should I send in a correction as Patch v2?

IMO, yes.
Thanks.

-- 
~Randy

