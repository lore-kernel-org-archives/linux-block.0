Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DA440636;
	Wed, 19 Aug 2026 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.152.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166475; cv=none; b=AzT1aEj4+Sw7S8rydDyuZguYUYTk7onjYw8CMmtiZ41OAC5UPZkQOBfZAaw/wMWnja35HviPcqLNVWHnAtM866LrU3Au5uK6ygQpazoTeobHx9gbgnIx1qd34wVUqkYr+bdk0Bk7p2ujYziqCQeJL+Mjp1ks1ObEhqGsUPh4mrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166475; c=relaxed/simple;
	bh=RlaHee74U0lH3knzX7AYGgTEtgOF8r5F5THRqjlIbPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQM+hJlOaGZh9lTASlX3uxMETeA6WjaReJ7AYHiikshteh4UwOhUC+pBYjgGdmp76VtzvA5zC4EU7dQGvzmNoE3JvzWSX2Zh0VfQqBWnRyOPMTnnJwQSJQvL1bGDjA258hmcI7IupMqnw8T2PQLmg//jjzEmk3/QOuZ2OKs1QxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de; spf=pass smtp.mailfrom=jregg.de; dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b=jsNtuAPY; arc=none smtp.client-ip=78.46.152.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b="jsNtuAPY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zDcw+TEjQ0TO0oXUNlRwmkSXBrVtksPMAI2dJMXGfrM=; b=jsNtuAPYgLcsKGwjW3qDoh48tR
	/1+kLTdhfp+7sn6MB5iL8WPN/X1y/kEFbzRLswQxWZRewUlWK1Z6gG62l7J6EIDuZju9hHVg2Wjvo
	1U18MLo6gfVLxfr+sdsoJfGRqTdAK5A8DZr5+NfAkXWxbJrQsyQ42fA8U34k6AWMEMteIOb8FV35n
	77bjDWDsXdpGpiapgtSdGADiByAwOGe1YvfnvP1IwodWWjioA/hQGDeoRVF4go4Atrmd08ur41FnA
	ZBOhhtvuYJiQvNElLDmbIrciJtRM7g3x61jSfqbMQp7DNAZ/a1vjYPqDF+qgYHBKSDyS915d7mjYo
	ssqJqohA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1wwldf-0003Q7-1A;
	Wed, 19 Aug 2026 21:07:51 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1wwldf-000M7T-0Y;
	Wed, 19 Aug 2026 21:07:50 +0200
Message-ID: <7a09f4f8-bf07-4117-b8b6-0ba683d60e86@jregg.de>
Date: Wed, 19 Aug 2026 21:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Randy Dunlap <rdunlap@infradead.org>, Haris Iqbal
 <haris.iqbal@linux.dev>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
 <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
 <08c89377-a6b8-4f9d-9f47-7c6faf99d535@infradead.org>
Content-Language: en-US
From: Jenson Johnathon Reggentin <mail@jregg.de>
In-Reply-To: <08c89377-a6b8-4f9d-9f47-7c6faf99d535@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28097/Wed Aug 19 08:24:38 2026)


On 8/19/26 20:49, Randy Dunlap wrote:
>
> On 8/19/26 11:47 AM, Haris Iqbal wrote:
>>
>> On 8/19/26 20:25, Randy Dunlap wrote:
>>>
>>> On 8/19/26 10:46 AM, Jenson Johnathon Reggentin wrote:
>>>> The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
>>>> https://www.kernel.dk/blk-mq.pdf leads to the correct document.
>>>>
>>>> Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
>>>> ---
>>>>    Documentation/block/blk-mq.rst | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
>>>> index fc06761b6ea9..c2af39f14d6d 100644
>>>> --- a/Documentation/block/blk-mq.rst
>>>> +++ b/Documentation/block/blk-mq.rst
>>>> @@ -139,7 +139,7 @@ completed.
>>>>    Further reading
>>>>    ---------------
>>>>    -- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
>>>> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
>>>>      - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
>>>>    
>>> I still get a 404 error message for the new link also.
>>> As well, my browser and wget both report bad/invalid SSL certificate.
>> Ah.
>> I checked the link in the comment and that works.
>> The one in the diff works, but with a warning about its certificate.
>>
>> Maybe its because of the missing "www." prefix?
> Yes, adding "www." works for me. Thanks.
For me too. Should I send in a correction as Patch v2?
