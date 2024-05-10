Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14181E502;
	Fri, 10 May 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358072; cv=none; b=MBKleKfZrNIlgmnnD4WqTrb9KCpKdo7dq549Y63WfZe/jc+UMTO3FLX0cO2PXaToR1XaFySjOSL2W9XXlH8+BwqyKCEC/vv971jVyt/MqLFjiD1F4zJRXrxjuAodC+u9R2xbzImSOOhEQPpGcwg7ioq90XHZGiqFUYaWCiyQeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358072; c=relaxed/simple;
	bh=9eVFeI4MVw3d17iTqq4yVn7+uRkW7sAAFJQNg15myGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXo1YSGQuzBGkIL/f9n9N/o3bikuwX5QaaeIm/625sX6tHGzSly7Zj8/l2MOPink+UlqMzMemcVXTQf2oEl206DZ3VIrx95bL9Kf7V0wpuQeMcyJ8FIkOEi9PQUgCtNYD2K0rO1NX8ylxdk6GdF1zWhQKIn9l0CH3v8OGu/qPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=n18lc6a2; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="n18lc6a2"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbYz43zB0z6Cnk8y;
	Fri, 10 May 2024 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715358062; x=1717950063; bh=QOddt5IKXRCkImqqK6vka+M2
	kOA6v8rGcyELCFfSJJc=; b=n18lc6a2Ps6drLfgczpjOnaevfy+D88JeI39N2ox
	QBRLMO/rQ2SwBx61cyyY5IP6wC5INT6BNaGFgVEzyZH3af3BQ10jnH7orkfoYvUM
	0vbMiKZtBqKk/2RrRuki24FzIdJR+aVrmvLinHcZFwtvHVRtfWnVHesK3H+kQVoE
	UnXTgfZzs/jP0Z8PTzFklx2q/xCRH1FrdsINOULe370AVemgXBQE5PeokfJTlYWt
	cv4tORr9LR9NbX7UTC4dDzTjwaxXkQCdGyeWmoNWbmjsyrOe9CWfyVcX7d0saUOO
	GEYNPbmB7LP9CBfuwfmNBcnYIk7TNWUAKgqNUbwVBnPR7Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id A3-vK-S9u8rf; Fri, 10 May 2024 16:21:02 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbYz05VYwz6Cnk8s;
	Fri, 10 May 2024 16:21:00 +0000 (UTC)
Message-ID: <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
Date: Fri, 10 May 2024 09:20:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/10/24 8:41 AM, Paul E. McKenney wrote:
> On Fri, May 10, 2024 at 07:28:41AM -0700, Bart Van Assche wrote:
>> On 5/10/24 07:19, Breno Leitao wrote:
>>> diff --git a/block/blk.h b/block/blk.h
>>> index d9f584984bc4..57a1d73a0718 100644
>>> --- a/block/blk.h
>>> +++ b/block/blk.h
>>> @@ -353,7 +353,8 @@ int blk_dev_init(void);
>>>     */
>>>    static inline bool blk_do_io_stat(struct request *rq)
>>>    {
>>> -	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
>>> +	/* Disk stats reading isn=E2=80=99t critical, let it race */
>>> +	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passth=
rough(rq);
>>>    }
>>>    void update_io_ticks(struct block_device *part, unsigned long now,=
 bool end);
>>
>> Why to annotate this race with data_race() instead of READ_ONCE()? Are
>> there any cases in which it is better to use data_race() than
>> READ_ONCE()?
>=20
> We use this pattern quite a bit in RCU.  For example, suppose that we
> have a variable that is accessed only under a given lock, except that i=
t
> is also locklessly accessed for diagnostics or statistics.  Then having
> unmarked (normal C language) accesses under the lock and data_race()
> for that statistics enables KCSAN to flag other (buggy) lockless access=
es.

Can using data_race() instead of READ_ONCE() result in incorrect code
generation, e.g. the compiler emitting a read twice and reading two
different values?

Thanks,

Bart.

