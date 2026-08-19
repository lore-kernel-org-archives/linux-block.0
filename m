Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4C3D25C2
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165262; cv=none; b=Y9PvFKMU8bVakPe1eBDyrTTMfg/DN+xYG8CnbmBwmMRm/Q9LKJtvmowmMRwwUFRRnWEX0sYFtfGzzQ1W/PKe7UXW6YP6X+VEzzx9bvyAUwLoEuSVnT+qaW/wrd26anXuQ7s8353PYhyiK969w/dLWRUA2ey8lUhzKiCNvT6B1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165262; c=relaxed/simple;
	bh=W95LRG3UmVcVx6qZJa9TdBzLxBdwHKhaJABG6h+6pN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHLhiG7+6PqtQsEGOCWrMclHvHUkQt1tBUYnX0NL1x807NCCa/UIUESJH8WVPJlQlK/pdQzmFg98Ax/TWpiK3jK7dp+xk14+zr9ntBmAOy2PXJ7y1jxoxfi1wexh6EhjZVHS4pIx9GUsaGgTYBM5Vj3IoySGrU40Wf0lB/eQeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AC+3tuc4; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AC+3tuc4"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W95LRG3UmVcVx6qZJa9TdBzLxBdwHKhaJABG6h+6pN8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787165257; v=1; x=1787770057;
 b=AC+3tuc4V36uhml8Rl5BZa/b+cpCGj17TNn/7Bl8P9K+y0oKDXNQKrVRv1/EXGxIyU+cw8mz
 grSGRlMNL6JOwZAYZIMoaUG9o1+xKlldai3EaiurRdYxy7NZGwAPMH9TYf+nYyj92k+69+tZ6RI
 SArIkjf2fKGjoYsMtVQQwUmg=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [IPV6:2003:fc:df23:7a77:61d8:f7b3:6a7f:2b45] (2003:fc:df23:7a77:61d8:f7b3:6a7f:2b45)
	by smtp.migadu.com with ESMTPS id bbf897522459da81;
	Wed, 19 Aug 2026 18:47:27 +0000
X-Mizu-Trace-ID: bbf897522459da81
X-Migadu-Flow: FLOW_OUT
Message-ID: <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
Date: Wed, 19 Aug 2026 20:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Randy Dunlap <rdunlap@infradead.org>,
 Jenson Johnathon Reggentin <mail@jregg.de>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 20:25, Randy Dunlap wrote:
> 
> 
> On 8/19/26 10:46 AM, Jenson Johnathon Reggentin wrote:
>> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
>> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
>>
>> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
>> ---
>>   Documentation/block/blk-mq.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
>> index fc06761b6ea9..c2af39f14d6d 100644
>> --- a/Documentation/block/blk-mq.rst
>> +++ b/Documentation/block/blk-mq.rst
>> @@ -139,7 +139,7 @@ completed.
>>   Further reading
>>   ---------------
>>   
>> -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
>> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>>   
>>   - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>>   
> 
> I still get a 404 error message for the new link also.
> As well, my browser and wget both report bad/invalid SSL certificate.

Ah.
I checked the link in the comment and that works.
The one in the diff works, but with a warning about its certificate.

Maybe its because of the missing "www." prefix?

> 
> 

