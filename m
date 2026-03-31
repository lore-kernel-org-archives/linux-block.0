Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B4330662
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987352; cv=none; b=qyivknqfAAbiYF/YKDp85wpVuFMCVMn0wLC6xCsfgkg+zQY7k18NTNKIAU32xLzAvAGJ1730b3QA6nARwyUMW9zUBAcwKWqzSUmQHu8Mh+fVE08RzXwj+L593h7822OOzrijAIpKJDD4OUTIjrw1NMaig/LFr84D/emNa4UhoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987352; c=relaxed/simple;
	bh=e9j3dzmi7UPbHfv9pA4xPU4AGSCe/lr7LhZZ5+DOOWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyCMcYVtcv1Va+2az3SSOHxEzpOc9cLgcBwnQl3vDsIgm68ei6n/5ocWAF7GXWLynnYz/EPnSu8WPU4+7seBbMWhyBYp0WhFgaay/bqhHgj0wo/jM8rFbAFb1WXjD8TAR+ShAy9Nd4cmOGAgpitkCMDuSE6dhT+i1FrCb0nL0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LiaFRFci; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LiaFRFci"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4flfD64NjXz1XM5jn;
	Tue, 31 Mar 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774987340; x=1777579341; bh=e9j3dzmi7UPbHfv9pA4xPU4A
	GSCe/lr7LhZZ5+DOOWQ=; b=LiaFRFcigH/7l1kl9vkaS6L7+/jp9MO/EKC+vbX3
	62UXIwPNJBQqBYiBlyZbowC3LuOUW7pFLhjk+uDMURwo01A0BZ8YZz+oRPEbZ10a
	Ee7Bf9CIM6RLYuIHqlZTiEysXRIjklXwy4xVbcb4gkavu63vmClFd8NNKCDM0gtF
	8tFC12WJxbFaPDzLKQCBzOVUbcsnIsNUv8Dw18YpZieG6qD42rcJeeVwz1ClVYsS
	9pxDPD8UXAF4NYyYVIZJYPBgILedBQV9Ji9XFHYlSVDKZwQwfa1K+2g1ahoengYd
	QdUxdH8pKGGJ39aKn5qVngsThaRoyFMBryQvewFhiVfJHQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cwqWf4QOgsey; Tue, 31 Mar 2026 20:02:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4flfCq3Y8zz1XLwX9;
	Tue, 31 Mar 2026 20:02:15 +0000 (UTC)
Message-ID: <b2160b6a-8857-4496-9453-2fcf394e9e4d@acm.org>
Date: Tue, 31 Mar 2026 13:02:14 -0700
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
 <3820ca93-bcdc-419e-92a9-251b8d430cec@acm.org>
 <746b98bb-d56b-468b-a59e-6de6ea5282f1@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <746b98bb-d56b-468b-a59e-6de6ea5282f1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 3/30/26 10:37 PM, Nilay Shroff wrote:
> On 3/30/26 9:55 PM, Bart Van Assche wrote:
>> (+Marco)
>>
>> On 3/30/26 3:23 AM, Nilay Shroff wrote:
>>> On 3/26/26 3:15 AM, Bart Van Assche wrote:
>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/=
=20
>>>> main.c
>>>> index f8c0fd57e041..677ac829ef80 100644
>>>> --- a/drivers/block/null_blk/main.c
>>>> +++ b/drivers/block/null_blk/main.c
>>>> @@ -1004,8 +1004,7 @@ static struct nullb_page=20
>>>> *null_lookup_page(struct nullb *nullb,
>>>> =C2=A0 static struct nullb_page *null_insert_page(struct nullb *null=
b,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 sector_t sector, bool ignore_cache)
>>>> -=C2=A0=C2=A0=C2=A0 __releases(&nullb->lock)
>>>> -=C2=A0=C2=A0=C2=A0 __acquires(&nullb->lock)
>>>> +=C2=A0=C2=A0=C2=A0 __must_hold(&nullb->lock)
>>>
>>> This function temporarily drops the &nullb->lock and requires it.
>>> So why do we need to replace __releases/__acquires with __must_hold?
>>> This is not clear.
>>
>> __must_hold() has the same meaning as __releases() + __acquires(). The
>> only difference between these two annotations is that __must_hold() is
>> more compact. I can leave out this change if this change is considered
>> confusing.
>>
> Hmm, but per the documentation of __must_hold() it seems that this=20
> attribute signifies the caller of the function must hold the=20
> exclusive context lock. On contrary, __releases() attribute is meant=20
> to be used when function releases a context lock exclusively and=20
> __acquires() should be used when function acquires context lock=20
> exclusively. From the above rational, it seems that
> null_insert_page() should have all the above three attributes
> applicable, isn't it?

__must_hold() is defined as __attribute__((requires_capability(...)))
In the Clang documentation this capability is called REQUIRES(). From
https://clang.llvm.org/docs/ThreadSafetyAnalysis.html: "REQUIRES is an=20
attribute on functions, methods or function parameters of reference to
SCOPED_CAPABILITY-annotated type, which declares that the calling thread
must have exclusive access to the given capabilities. More than one
capability may be specified. The capabilities must be held on entry to
the function, and must still be held on exit."

To me the above text means that the __must_hold() annotation is sufficien=
t.

> I am not sure why did compiler generate the above errors? If I look at =
the
> macro definition then it seems __context_unsafe(/* comment */) should=20
> simply
> expand to __no_context_analysis.
>=20
> // From include/linux/compiler-context-analysis.h:
>=20
> #define __context_unsafe(comment) __no_context_analysis

I misread your previous comment. The output I shared is produced when=20
the function body is surrounded with context_unsafe() (no leading
underscores). Your request was to annotate the function with
__context_unsafe() (with two leading underscores).

I will consider to use __context_unsafe() instead of=20
__no_context_analysis and a comment.

Thanks,

Bart.
