Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29243CF680;
	Wed, 19 Aug 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.152.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165261; cv=none; b=V96uosE0MEbFPUqkQyg+VsMiqvOdl/wVBr0tr4MJfCnET6UzifxL6PX4Obzdc6Jsf33FIKq/W+De7r7+TlplRg2t47ZtplYhLkM/sDV2F2q5UKmZRj+M3PIJmBJwO9eBg0cPHdpTyzu06CMMRRiWQjTkXx5f8SJwqg8KdkTnE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165261; c=relaxed/simple;
	bh=RUfZtsEEmKjCKOH0YMivR5TSWYFJzq/MByXNy/rVVOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+g1nZgnFzULzqA3UQNA74diEtYP7KID+O4lcR9Td8hhrFIfNVnWEZ4NBZzx0wUOQPGXGr8pCvtvp2KQ9gehqOWrZZUmJ9t/PMcn2O/Kw63/rXCTwSBOfUz1aEsUWnOgIFRbIqf+hfXNl5WXnx0YlwFXlfA/Ce2Y3EthL7J2bhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de; spf=pass smtp.mailfrom=jregg.de; dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b=fmrWXjzU; arc=none smtp.client-ip=78.46.152.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b="fmrWXjzU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ij5GeJJwLJ1DE0bqrc2QUYtrPbdtmbSj8RCYMSlHz5I=; b=fmrWXjzUzSgoF8bX0lzpsFyKbS
	ysgn1Cm1wRlmubbt5gquw/8lFxkGDvMAmH31405+8RF8tkDK0BaC4fQvUeBtjWcfW2QW8BG7T37U5
	8aW79KfIPkFRfBwRibJPl16bng0ocOa9n8IWgKL9b1VMGTkOt8zMzEyXFAMouv8RslP7+fJaKzHsa
	qRfJYc7/Y96zkYqStQ10vLov7ds56z1Ym8hw4GXUqRAdyApgxC8NUqAF+1EQzmIXEKqMBSC9r5NO5
	ViXAFRFz/bGr4c+1b46hvuqWoKkTK5wcj70dfqc9sFzJAGMY52iRZ7B+kwVTwjeWTPOMAwsLzDkzM
	ee5SeHMw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1wwlK3-000MRa-0M;
	Wed, 19 Aug 2026 20:47:34 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1wwlK1-000Dli-20;
	Wed, 19 Aug 2026 20:47:34 +0200
Message-ID: <97e47744-38ba-4fb9-9045-7f480bc7d086@jregg.de>
Date: Wed, 19 Aug 2026 20:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
To: Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
Content-Language: en-US
From: Jenson Johnathon Reggentin <mail@jregg.de>
In-Reply-To: <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28097/Wed Aug 19 08:24:38 2026)


On 8/19/26 20:25, Randy Dunlap wrote:
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
> I still get a 404 error message for the new link also.
> As well, my browser and wget both report bad/invalid SSL certificate.
>
Now I get a 404 on both links too.
When I made the change the https link worked though.
