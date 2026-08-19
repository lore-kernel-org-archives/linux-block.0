Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470743BF67A;
	Wed, 19 Aug 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165377; cv=none; b=ja0wu4D7hjGDHbuMzgHP8yHyRICKBZaxBsyCRvg0BBv3QvMzwGETly0PDJ3ovqrylzIoODNKEIe1Z13M0NZJKuwfNh17P8TdLtGKBsTZ2Fn8A2/eP2SjClDk5rg1hdcy0geADWMG+6fgePKrYQfYfi0EhURmoqLivnfHGjA5/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165377; c=relaxed/simple;
	bh=a9VSoUFNHenGXO8CJeYE178hsjPw0FIovvBNSpHMNTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1igrZx4bzKCBaOzSEkqcK2EZdW5FGDusLI1RpAQ6ycf6axRkOonUIhMVsLHNMs5zDA5ERIzG3cfYYZmH8n0Qj09yOO/V1bWOu/JZENfCoNdicaX7DQ3aidqrK6O+PXqDEn6OIg2o1evVVIu/q9r6QlwSTCaIIoJBemoQHgv1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sy/e8srf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sy/e8srf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yx31ObDxbxT5V+cgnXZsoSV9+Y8xD9+qXHI34lRUFmA=; b=sy/e8srf28jhFGCSY1usNRx564
	YBplWAfpfec0t+wxRpn3v6J9TaAAanwMkwg1Zni0yhfA8kNMT9/sLJtp2A5haLWjCUT7EDb7UIcT5
	0ukJc2/dZ6zDMi9ZWDMSkuphVheylKYySalm9jjcqCNYAg7c78hnWSCCk3yKjp4A/wlt+1XBRRMAL
	AYlTGL4UPvI0JgQ63u+W2rIOvI6CEvEfgTjuFgHrf+eG0Bu7BbgUXdlkZUrnRxQdmtkItGkj2wkfn
	rBDgnqgUB5uGokNX+YT/uVAmBk6ALVD6WmvCY2Io+06zetmw+76P/8orYLSvRqZGN0pT2Q7Bk/U2C
	adrBV2RQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwlLx-0000000AOxv-08W0;
	Wed, 19 Aug 2026 18:49:33 +0000
Message-ID: <08c89377-a6b8-4f9d-9f47-7c6faf99d535@infradead.org>
Date: Wed, 19 Aug 2026 11:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Haris Iqbal <haris.iqbal@linux.dev>,
 Jenson Johnathon Reggentin <mail@jregg.de>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
 <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/19/26 11:47 AM, Haris Iqbal wrote:
> 
> 
> On 8/19/26 20:25, Randy Dunlap wrote:
>>
>>
>> On 8/19/26 10:46 AM, Jenson Johnathon Reggentin wrote:
>>> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
>>> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
>>>
>>> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
>>> ---
>>>   Documentation/block/blk-mq.rst | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
>>> index fc06761b6ea9..c2af39f14d6d 100644
>>> --- a/Documentation/block/blk-mq.rst
>>> +++ b/Documentation/block/blk-mq.rst
>>> @@ -139,7 +139,7 @@ completed.
>>>   Further reading
>>>   ---------------
>>>   -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
>>> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>>>     - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>>>   
>>
>> I still get a 404 error message for the new link also.
>> As well, my browser and wget both report bad/invalid SSL certificate.
> 
> Ah.
> I checked the link in the comment and that works.
> The one in the diff works, but with a warning about its certificate.
> 
> Maybe its because of the missing "www." prefix?

Yes, adding "www." works for me. Thanks.

-- 
~Randy

