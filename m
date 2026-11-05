Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916494;
	b=LY0ER0Izncb91gIj4jkRFuTpT2LKEiEdOMGEc8u9CUDZJj/N7U/kJ4Aozd9PxlMJ2zBh
	 z2O5p4TI1nESd2R5Pagkr7K2DfVGD7awez2jBb5hvUrLmN5NQNKg1KuazSor78UAMzuLq
	 5msJsG+YuHy7lzOg5DR5J7o5msFhKpVw8JQb3fupqQnMF6FoppU323qslizwxpDE9tCzS
	 Q0VUD2K6RU+JTTX0XB9f6Cu8VQZFmZ0kWDlFUu5wxbHtfZttUVEptHbH3QwdtqGk3hbap
	 xVDdzv6EE2v94O/s922DVdS7Ym0YJxZTr/irFbkZdU/KDo1opUEznFP8fadf5xuf73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916494;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XYA3g2+HtqFAIS8I2EWomiFCDvHSGWyaU3MTisxAOLE=;
	b=DO0kO/x45TK99iq0v2ZUQMvfrAHA3ibDmO0h+6NOfBSgxU4ag7HYn+fhlaP4C6F4ydy5
	 pb2TWe00uK7Fvo/n4JBfVBgM6ienna92Q6gbFjHw7kAvriurH5COmqXQRomX2gkarNWcb
	 gn0fieukw7mo/msCsmahdSV/MAF4sbMjuoZdni+LfoT05oeOJcj+DEY2eowuo8u/XzOFl
	 IO273r7rVVcK8LEJR3GDJ4ABb1++3+aJQ560KfWv/l1duYxi+HkV/x1BwX18xbkjs1UEL
	 qQXgiHqDuFvvD8Y6YGb7FjNqjlMfq+QeK4oZUkgA3k3G2wMQ+CrCt5EnCdkO48akyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="QH/HVW0h";
	arc=none smtp.remote-ip=91.218.175.208
Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A590606A326
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 22:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A590606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QH/HVW0h
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PnYyaVx64MD1jaWFrbHNWMnyMKuFQYL/DiizwVaVslY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793916491; v=1; x=1794521291;
 b=QH/HVW0hpgJm35wNbRGzmwvZ10g2LybOwDKUHZ4P8dJuTSEKQcDDwh6PVWgxSY68jXhqxkcP
 M8WOED8XfgbQpgQqWrPt9BItzVObZ+TNhsEUU/L5wJimcNDwhBDdF3leBgbl95nIA+hR41Y7wko
 NmIsiCHV1EwF6neowfmol7n0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id faa4b71d0d8cf75d;
	Thu, 05 Nov 2026 22:08:11 +0000
X-Mizu-Trace-ID: faa4b71d0d8cf75d
X-Migadu-Flow: FLOW_OUT
Message-ID: <c043f698-176d-43c5-9086-2973d4ca0833@linux.dev>
Date: Thu, 5 Nov 2026 23:08:06 +0100
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
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <20260928221634.43239-2-haris.iqbal@linux.dev> <20261005084917.GA9160@lst.de>
 <20261020223402.GA1582237-mkhalfella@purestorage.com>
 <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>
 <20261105201827.GB2439-mkhalfella@purestorage.com>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20261105201827.GB2439-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 21:18, Mohamed Khalfella wrote:
> On Thu 2026-11-05 21:00:27 +0100, Haris Iqbal wrote:
>>
>>
>> On 10/21/26 00:34, Mohamed Khalfella wrote:
>>> On Mon 2026-10-05 10:49:17 +0200, Christoph Hellwig wrote:
>>>> On Tue, Sep 29, 2026 at 12:16:32AM +0200, Md Haris Iqbal wrote:
>>>>> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
>>>>> tag it does not recognize, so a caller cannot tell the two apart. The
>>>>> block error injection code (which is the sole user of this function
>>>>> currently) relies on error_inject_add() later to reject adding a rule with
>>>>> status=BLK_STS_OK. This is okay for the current state of error injection.
>>>>>
>>>>> The delay option added in the next commit makes the rule with status=OK
>>>>> valid, meaning the function tag_to_blk_status() now needs to explicitly
>>>>> match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
>>>>> make tag_to_blk_status() take a second param to update the matched status,
>>>>> and return true in case of a successful match. If a match is not found,
>>>>> the function tag_to_blk_status() returns false and *status remains
>>>>> unchanged.
>>>>>
>>>>> A repeated status= where an invalid tag comes first is now rejected
>>>>> instead of being overridden by the later one.
>>>>>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Assisted-by: Claude:claude-opus-5
>>>>> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
>>>>> ---
>>>>>    block/blk-core.c        | 14 ++++++--------
>>>>>    block/blk.h             |  2 +-
>>>>>    block/error-injection.c |  7 ++++---
>>>>>    3 files changed, 11 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>> index 13dc70e8f55d..c45846b9c50d 100644
>>>>> --- a/block/blk-core.c
>>>>> +++ b/block/blk-core.c
>>>>> @@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
>>>>>    	return blk_errors[idx].tag;
>>>>>    }
>>>>>    
>>>>> -blk_status_t tag_to_blk_status(const char *tag)
>>>>> +bool tag_to_blk_status(const char *tag, blk_status_t *status)
>>>>>    {
>>>>>    	int i;
>>>>>    
>>>>>    	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
>>>>>    		if (blk_errors[i].tag &&
>>>>> -		    !strcmp(blk_errors[i].tag, tag))
>>>>> -			return (__force blk_status_t)i;
>>>>> +		    !strcmp(blk_errors[i].tag, tag)) {
>>>>> +			*status = (__force blk_status_t)i;
>>>>> +			return true;
>>>>> +		}
>>>>>    	}
>>>>>    
>>>>> -	/*
>>>>> -	 * Return BLK_STS_OK for mismatches as this function is intended to
>>>>> -	 * parse error status values.
>>>>> -	 */
>>>>> -	return BLK_STS_OK;
>>>>> +	return false;
>>>>>    }
>>>>>    
>>>>>    /**
>>>>> diff --git a/block/blk.h b/block/blk.h
>>>>> index 2cc03aa54c53..5fa54162c686 100644
>>>>> --- a/block/blk.h
>>>>> +++ b/block/blk.h
>>>>> @@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
>>>>>    
>>>>>    const char *blk_status_to_str(blk_status_t status);
>>>>>    const char *blk_status_to_tag(blk_status_t status);
>>>>> -blk_status_t tag_to_blk_status(const char *tag);
>>>>> +bool tag_to_blk_status(const char *tag, blk_status_t *status);
>>>>>    enum req_op str_to_blk_op(const char *op);
>>>>>    
>>>>>    bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
>>>>> diff --git a/block/error-injection.c b/block/error-injection.c
>>>>> index e14bc4b723ef..db543fe27630 100644
>>>>> --- a/block/error-injection.c
>>>>> +++ b/block/error-injection.c
>>>>> @@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
>>>>>    static int match_status(substring_t *args, blk_status_t *status)
>>>>>    {
>>>>>    	const char *tag;
>>>>> +	bool found;
>>>>>    
>>>>>    	tag = match_strdup(args);
>>>>>    	if (!tag)
>>>>>    		return -ENOMEM;
>>>>> -	*status = tag_to_blk_status(tag);
>>>>> -	if (!*status)
>>>>> +	found = tag_to_blk_status(tag, status);
>>>>> +	if (!found)
>>>>>    		pr_warn("invalid status '%s'\n", tag);
>>>>>    	kfree(tag);
>>>>> -	return 0;
>>>>> +	return found ? 0 : -EINVAL;
>>>>
>>>> 	if (!found) {
>>>>     		pr_warn("invalid status '%s'\n", tag);
>>>> 		return -EINVAL;
>>>> 	}
>>>> 	return 0;
>>
>> As Mohamed mentioned below, "tag" would leak then.
>>
>>>
>>> Doing it this way will result in use-after-free. "tag" has already been
>>> freed above.
>>>
>>> Maybe change tag_to_blk_status() to return an int (0 on success and
>>> -EINVAL on failure) and use its return value without mapping it?
>>
>> I am not sure I get your suggestion completely. Even if we change the
>> return type of tag_to_blk_status(), we would have to free the "tag"
>> before returning.
> 
> Changing tag_to_blk_status() to return an int will not have an effect or
> "tag" like you mentioned. But you will not need to map the return from
> that function.
> 
> return found ? 0 : -EINVAL;
> 
> The line above just returns what tag_to_blk_status() returned.

I would prefer to keep tag_to_blk_status() as a bool lookup. It's the 
reverse of blk_status_to_tag(), and which errno to return is 
match_status()'s call.

> 
>>
>> What can make it simpler is allocating "tag" on stack, and then use
>> match_strlcpy() instead of match_strdup().
> 
> That can work too. Just make sure we limit the string size somehow.

This I can do in v4. It should effectively remove the ternary operator too.

