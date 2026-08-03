Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842543AB0
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780562; cv=none; b=EjSZ8a4f2kxpTqDYdXdvyOSznKIZd4EO9U3wbtnnZnw7UwFlbIulWV5f7KhscTCP+WnDpkAfIzhj8ROzc58ZV9cy+fxmHv5UkY08lCEjwjNF24GfFph4FG9UbISdNs3LLDJ/gzsrGnNSeCVxvdPLFQgev++VkqpUfF1HpgiWoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780562; c=relaxed/simple;
	bh=9dvLnzOjQZbg+mVsckczOV1lMdALENcqIxZ3lkFIteg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtgaJV5LJwV0td6TuW64TdGnf9k9tn7rrABXgEtAaXL8T9JMp+STD2g8KTQtwCIH/jMu/v8SXR19Epotv2lUDA+wY0kQduf/z+LFX0FaDGRTrQe3nsSWTgv03AY/F8JHRDQPuzYAWIS6+7bZaPJXkoXRBKftjBZwurOWHU4JG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zTZSVI+j; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zTZSVI+j"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hDPnr2nsHzlfvq4;
	Mon,  3 Aug 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785780554; x=1788372555; bh=9dvLnzOjQZbg+mVsckczOV1l
	MdALENcqIxZ3lkFIteg=; b=zTZSVI+jknubFlxoIg/2zW+XiJaF47h6+/Zvqz3z
	Ur8y9lghQKWjocf3a+TKzCLLsLou4gmn3yS7uTekqGoyP5XTj/ujAI93QOMCGjHd
	3poNi8Jpg6ZWvYm+jAJmeM601pJpWtzPcfr5jkh9qMeEVcrxCV/EDXP0xaO9l2fM
	eqUmZXdfe3vB68NsW35TC9KhUiyR3yj5IXFzEuyAVKwuGe5MQj6JaFhs/xbpGTei
	+iSsCYM0YMwW+DSmhxUMgEmxSF+YBWjzZ/EytUSzM0kgyucpHp63IZFpCf5datGs
	gAeOIjQXjR1HWzx14aoWcwU/8QNPCqzILo7eAs89VhTpWQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rU1r8-aGyCPn; Mon,  3 Aug 2026 18:09:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hDPng15nVzlfvpM;
	Mon,  3 Aug 2026 18:09:10 +0000 (UTC)
Message-ID: <4fdcc4f4-819c-4878-96ee-9493ce4c5886@acm.org>
Date: Mon, 3 Aug 2026 11:09:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] null_blk: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hans Holmberg <hans.holmberg@wdc.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Kees Cook <kees@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <55886b395224068987cec253192ae6257e61c960.1785440858.git.bvanassche@acm.org>
 <42987b15-44e2-4a45-bbd8-b791bbb56b6c@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <42987b15-44e2-4a45-bbd8-b791bbb56b6c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 8/3/26 6:35 AM, Nilay Shroff wrote:
> On 7/31/26 1:28 AM, Bart Van Assche wrote:
>> +DEFINE_CLASS(null_zone, struct nullb_dev_and_zone, ({
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!_T.dev->memory_backed)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&_T.zone->spinlock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&_T.zone->mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }), ({
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!dev->memory_backed)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&zone->spinlock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&zone->mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (struct nullb_dev_and_zone){ dev, zone };
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nullb_device =
*dev, struct nullb_zone *zone)
>> +
>> +DEFINE_CLASS_IS_UNCONDITIONAL(null_zone)
>=20
> What do we gain by introducing a guard class here?

What we gain is that __context_unsafe() annotations are avoided
entirely. __context_unsafe() is a big hammer that shouldn't be used
unless absolutely necessary. Additionally, introducing this class makes
it possible to convert multiple goto statements into return statements.
I think that's a significant improvement.

> Since both the constructor and destructor are marked
> __context_unsafe, the lock context analysis still
> won't reason about the conditional locking.

Such reasoning is not needed when using guard() or scoped_guard() since
these macro's make it impossible to leave a scope without releasing the
acquired synchronization object.

> I'm not opposed to using a guard class here, but it does make the
> code a bit more complex to follow.

Hmm ... I think this means that you are not familiar yet with
DEFINE_CLASS(). The code that uses the null_zone class becomes simpler.

Thanks,

Bart.
