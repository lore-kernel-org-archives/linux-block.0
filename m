Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1D26B74A
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887957; cv=none; b=AC3P8uH0S/HIc5V5sJj5ecpWE0dTiB0QlYhaqM9xTz6YooKrxPRwbTnjyvxKwNUq6UBCIqMqdHHtImhugnufDuTEeZPkCIFuIlgYVvCNGihCczvjJbWfXXULMuVCwhgjRlxwpjq5ANcP+QtHjC0JoCY7v2yyPAogx72S8A9j5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887957; c=relaxed/simple;
	bh=UNbjnRSF8ltesLQ0/4+poJWy3R1TAZVzpwIUx4iYc6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5LegS96mSOkaxtBVI6csigIB0WCipYsW8Pr03yp85QqSjIHQLh/ILbOL0TeBV5Y78oOS/VEHhHBPI7XIXNlhd7M/PEnMogsS2Qag/WKhOZIePSV41j2pR3bYpZ867cPLYHEs348nJR0FT85quwuyyyUplbudNIWD790EiKRG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FOXVPjIK; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FOXVPjIK"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fkxSg66syz1XM6J9;
	Mon, 30 Mar 2026 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774887947; x=1777479948; bh=CMge7B02r5DRm2ZyrAanwcbu
	udLqdHgzeYaWm1jwYzo=; b=FOXVPjIKGIkLGKOHJb1yCgAGFv1TDM416FuKPtKS
	LVTqPkh8AdwuF055r2M8dYIFxwkNHX38EJv3bIbxsA5EsBtDyfTImAEA2kXw0BBV
	4Y/Gt/UY+EyP8iA2wCejbE0ydcHixHvkyREzweDtW3d3lVYAIRtGid7KDefKVL9n
	ycyEmoLfBpjcdJiKpDhVNLTX16FN1t3EnBZKjcvMpTcSOxsunlTAtpfAGzr7F5St
	r4YM7u7pYu3cPqiH2ymUo5XuZnTcXyI7NplZiuMmV3BiaVnzbGQ7pMqKC7EP6F8r
	BtujSbw83sMWPF0XFyuuak0/vOOJ/tXN22imBgLVrJCmdg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cC5t8NQVLYvf; Mon, 30 Mar 2026 16:25:47 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fkxSS0Mdzz1XM5kt;
	Mon, 30 Mar 2026 16:25:43 +0000 (UTC)
Message-ID: <3820ca93-bcdc-419e-92a9-251b8d430cec@acm.org>
Date: Mon, 30 Mar 2026 09:25:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/26] null_blk: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Kees Cook
 <kees@kernel.org>, Genjian Zhang <zhanggenjian@kylinos.cn>,
 Marco Elver <elver@google.com>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-21-bvanassche@acm.org>
 <b9cbbd2b-4c2a-497a-84f8-f1bda0e7c40f@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b9cbbd2b-4c2a-497a-84f8-f1bda0e7c40f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

(+Marco)

On 3/30/26 3:23 AM, Nilay Shroff wrote:
> On 3/26/26 3:15 AM, Bart Van Assche wrote:
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/=20
>> main.c
>> index f8c0fd57e041..677ac829ef80 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1004,8 +1004,7 @@ static struct nullb_page=20
>> *null_lookup_page(struct nullb *nullb,
>> =C2=A0 static struct nullb_page *null_insert_page(struct nullb *nullb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sector_t sector, bool ignore_cache)
>> -=C2=A0=C2=A0=C2=A0 __releases(&nullb->lock)
>> -=C2=A0=C2=A0=C2=A0 __acquires(&nullb->lock)
>> +=C2=A0=C2=A0=C2=A0 __must_hold(&nullb->lock)
>=20
> This function temporarily drops the &nullb->lock and requires it.
> So why do we need to replace __releases/__acquires with __must_hold?
> This is not clear.

__must_hold() has the same meaning as __releases() + __acquires(). The
only difference between these two annotations is that __must_hold() is
more compact. I can leave out this change if this change is considered
confusing.

>> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/=20
>> zoned.c
>> index 384bdce6a9b7..a7f94e76034f 100644
>> --- a/drivers/block/null_blk/zoned.c
>> +++ b/drivers/block/null_blk/zoned.c
>> @@ -32,6 +32,7 @@ static inline void null_init_zone_lock(struct=20
>> nullb_device *dev,
>> =C2=A0 static inline void null_lock_zone(struct nullb_device *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nullb_zone *zone)
>> +=C2=A0=C2=A0=C2=A0 __no_context_analysis /* conditional locking */
>=20
> I see we already have __context_unsafe(comment) macro defined
> which may be used instead for inline comment.

context_unsafe() suppresses warnings triggered by __guarded_by() and
__guarded_by_ptr() but does not suppress analysis of functions in the
function body annotated with __releases() and __acquired(). If I remove
the __no_context_analysis annotation and surround the function body with
context_unsafe(), the following appears:

drivers/block/null_blk/zoned.c:37:2: error: spinlock 'zone->.spinlock'=20
is not held on every path through here [-Werror,-Wthread-safety-analysis]
    37 |         context_unsafe(
       |         ^
./include/linux/compiler-context-analysis.h:201:30: note: expanded from=20
macro 'context_unsafe'
   201 | #define context_unsafe(...)             \
       |                                         ^
drivers/block/null_blk/zoned.c:39:3: note: spinlock acquired here
    39 |                 spin_lock_irq(&zone->spinlock);
       |                 ^

drivers/block/null_blk/zoned.c:37:2: error: mutex 'zone->.mutex' is not=20
held on every path through here [-Werror,-Wthread-safety-analysis]
    37 |         context_unsafe(
       |         ^
./include/linux/compiler-context-analysis.h:201:30: note: expanded from=20
macro 'context_unsafe'
   201 | #define context_unsafe(...)             \
       |                                         ^
drivers/block/null_blk/zoned.c:41:3: note: mutex acquired here
    41 |                 mutex_lock(&zone->mutex);
       |                 ^
2 errors generated.

Thanks,

Bart.
