Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908850;
	b=YPYHw5VpTxbIG6M/LKXvtCb76JP5Bg1RhMMg1CfAqIafffURP/Nd3qfPdx2KMNOQXWWj
	 gbShXdp5RsmotcEPSJ0HzzVpi9pjbdeEBqLIgv1zziTabQCHHEIXL0vNpCtulQ9IMO9Mf
	 wO+5vFar79wAn94XfHValLB/ZpKvcXdEyt2vZJ80ridNprfQJzZuftgePtM1s4MKgeQS1
	 VVuhfBb/5mfwnL1KayTk8edB3jRKzhCX4vTnxO5v4dsNJgjii16PYJJk1cEzEH83+96bC
	 Cxwy98r/PxOodTci1rrSeQ2kJi9SVWbFAnJGHNOOiAeNrIJHqqcH/GlSSL7CAh+EMCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908850;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SgY78uwqrS4EsUYLLkILtWxPMLctMC4kPiWZSKB2PMQ=;
	b=GIqERm6pr/zUSIghxcj0ZrUoWdLNa5OkO55ddSko+m4GsccQvXLSmusGNmaPSTlN/335
	 AK1xUyM88R7C302+Nt0PYHvgD+e/+4WRQoOP7uCV6c9b0HkUrvCZbWimi52ivb/hFi0BZ
	 5PVa9Mgwh72YsaRngc8JyFyLPHpV0CZTRaoHiVIz5brGBNcJ7KxeSGnzarUkbBOMitIkz
	 6h77dmlelSvznGozjqyrNYS66bbtGc/HFIYUlyudfUMuWLY7DZiO4OyJ0nCZ2HAJx0sHb
	 kEdKSg8yv4p2qbMW8b1PaOR4rf6cksG/60Cpev5h21Xk0VtJneBYrO7NZeAzK5JoBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="filnGHn/";
	arc=none smtp.remote-ip=95.215.58.155
Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440D606A32F
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 20:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5440D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=filnGHn/
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=twfyUPAmdfk3qnqxVC0Wt+Mi04r75IwvyEQqrmIURMQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793908846; v=1; x=1794513646;
 b=filnGHn/I8QFJBHnT7pj9KItFE+4BpANMruJYHksrOMppVAZAEHZL5CAaxXFVCu4OUffnojF
 xDnTJmWQOiZV6YF7ejoVNFoc3N/PKfHfZmybIG0Yu2xGWDvewHWOQy4JEaJmIUntjsTKl+YduM6
 o7+cb6pJt6NJJKhNrkiaVY68=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 23876777463ec8d0;
	Thu, 05 Nov 2026 20:00:37 +0000
X-Mizu-Trace-ID: 23876777463ec8d0
X-Migadu-Flow: FLOW_OUT
Message-ID: <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>
Date: Thu, 5 Nov 2026 21:00:27 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 for-next 1/3] block: Reject unknown status tags in error
 injection rules
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <20260928221634.43239-2-haris.iqbal@linux.dev> <20261005084917.GA9160@lst.de>
 <20261020223402.GA1582237-mkhalfella@purestorage.com>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20261020223402.GA1582237-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/26 00:34, Mohamed Khalfella wrote:
> On Mon 2026-10-05 10:49:17 +0200, Christoph Hellwig wrote:
>> On Tue, Sep 29, 2026 at 12:16:32AM +0200, Md Haris Iqbal wrote:
>>> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
>>> tag it does not recognize, so a caller cannot tell the two apart. The
>>> block error injection code (which is the sole user of this function
>>> currently) relies on error_inject_add() later to reject adding a rule with
>>> status=BLK_STS_OK. This is okay for the current state of error injection.
>>>
>>> The delay option added in the next commit makes the rule with status=OK
>>> valid, meaning the function tag_to_blk_status() now needs to explicitly
>>> match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
>>> make tag_to_blk_status() take a second param to update the matched status,
>>> and return true in case of a successful match. If a match is not found,
>>> the function tag_to_blk_status() returns false and *status remains
>>> unchanged.
>>>
>>> A repeated status= where an invalid tag comes first is now rejected
>>> instead of being overridden by the later one.
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Assisted-by: Claude:claude-opus-5
>>> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
>>> ---
>>>   block/blk-core.c        | 14 ++++++--------
>>>   block/blk.h             |  2 +-
>>>   block/error-injection.c |  7 ++++---
>>>   3 files changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 13dc70e8f55d..c45846b9c50d 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
>>>   	return blk_errors[idx].tag;
>>>   }
>>>   
>>> -blk_status_t tag_to_blk_status(const char *tag)
>>> +bool tag_to_blk_status(const char *tag, blk_status_t *status)
>>>   {
>>>   	int i;
>>>   
>>>   	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
>>>   		if (blk_errors[i].tag &&
>>> -		    !strcmp(blk_errors[i].tag, tag))
>>> -			return (__force blk_status_t)i;
>>> +		    !strcmp(blk_errors[i].tag, tag)) {
>>> +			*status = (__force blk_status_t)i;
>>> +			return true;
>>> +		}
>>>   	}
>>>   
>>> -	/*
>>> -	 * Return BLK_STS_OK for mismatches as this function is intended to
>>> -	 * parse error status values.
>>> -	 */
>>> -	return BLK_STS_OK;
>>> +	return false;
>>>   }
>>>   
>>>   /**
>>> diff --git a/block/blk.h b/block/blk.h
>>> index 2cc03aa54c53..5fa54162c686 100644
>>> --- a/block/blk.h
>>> +++ b/block/blk.h
>>> @@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
>>>   
>>>   const char *blk_status_to_str(blk_status_t status);
>>>   const char *blk_status_to_tag(blk_status_t status);
>>> -blk_status_t tag_to_blk_status(const char *tag);
>>> +bool tag_to_blk_status(const char *tag, blk_status_t *status);
>>>   enum req_op str_to_blk_op(const char *op);
>>>   
>>>   bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
>>> diff --git a/block/error-injection.c b/block/error-injection.c
>>> index e14bc4b723ef..db543fe27630 100644
>>> --- a/block/error-injection.c
>>> +++ b/block/error-injection.c
>>> @@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
>>>   static int match_status(substring_t *args, blk_status_t *status)
>>>   {
>>>   	const char *tag;
>>> +	bool found;
>>>   
>>>   	tag = match_strdup(args);
>>>   	if (!tag)
>>>   		return -ENOMEM;
>>> -	*status = tag_to_blk_status(tag);
>>> -	if (!*status)
>>> +	found = tag_to_blk_status(tag, status);
>>> +	if (!found)
>>>   		pr_warn("invalid status '%s'\n", tag);
>>>   	kfree(tag);
>>> -	return 0;
>>> +	return found ? 0 : -EINVAL;
>>
>> 	if (!found) {
>>    		pr_warn("invalid status '%s'\n", tag);
>> 		return -EINVAL;
>> 	}
>> 	return 0;

As Mohamed mentioned below, "tag" would leak then.

> 
> Doing it this way will result in use-after-free. "tag" has already been
> freed above.
> 
> Maybe change tag_to_blk_status() to return an int (0 on success and
> -EINVAL on failure) and use its return value without mapping it?

I am not sure I get your suggestion completely. Even if we change the 
return type of tag_to_blk_status(), we would have to free the "tag" 
before returning.

What can make it simpler is allocating "tag" on stack, and then use 
match_strlcpy() instead of match_strdup().

> 
>>
>> to keep the code a bit more readable.
>>
>> Otherwise looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>

