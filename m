Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533741B2ECB;
	Wed, 21 Aug 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260945; cv=none; b=utcuq3z5KndaItPQiS/dWS8jk5+xDLaWRwe7SB2Yq08ZL7hWkS0itvsAkeQgLdYo+T3A1mu+gyVy9wVq66V50jYdYdJXMtKHrLbl2h7oHm0ptNYDOVN90XVvt0ddBghH5uEe/2AbiWa0xNSwg+mNRm/2n7rDEuD77vyju/la3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260945; c=relaxed/simple;
	bh=cPKhKjCfXw5NriblyHFI6LS7D3mSl5KBqmxtO7Riqlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thqIzZNCrzx123Vg8wHU9ymklp07MBCguKsC8qozLBERQQht3J1TDvapEYoFzzIyM58b55SmR68K1BvMrPC23gZxIy78ANuIQpfzq97+CXxqhkBCudRdKRBrE1oPfvpxU0FIZJjkrGPWlAIYIWUgiEL0q6uR+2f9F+N0VLL3GXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3vscH4WL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3vscH4WL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WptSH46wNz6ClY94;
	Wed, 21 Aug 2024 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724260936; x=1726852937; bh=LsLhp/nKl8LLQGr/s+FRk976
	QwSdFieNKd0jtpK3vaI=; b=3vscH4WLDGDKHIeivd1AC+s05PNMiX/pUuDYs8Lw
	7v1+n5KWCKQ6w+jbgdWCRlh5oJdJoCL4+oalMLK2v8e4Xkx9aoJ+ohR+CuU7PHjW
	/xRBSi8DDc2aMELWWNGtx8JowLL4yuzRECjKavx7PuANmqUKRxPixYWlYLQHaBvC
	aCNsKxrzSi8vH7MKocsz1F4jYgh0otmXauSy76W+BmpOOWu/yAjWSrcvCfxxLrA6
	mTqx83/usY6HE1w8wuJ4T0rJahDkjxDm1VikySSA0Md97LtlDe1XKtkmCkXYOWNF
	tfyAVYdwIqyamwqwMW68++6zmeNbqt7wD5XftjSNhMFK7w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DO6XEusydHF2; Wed, 21 Aug 2024 17:22:16 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WptS351dYz6CmLxT;
	Wed, 21 Aug 2024 17:22:11 +0000 (UTC)
Message-ID: <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
Date: Wed, 21 Aug 2024 10:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
 mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, bvanassche@google.com,
 quic_nitirawa@quicinc.com, quic_cang@quicinc.com, quic_rampraka@quicinc.com,
 quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/21/24 5:29 AM, MANISH PANDEY wrote:
> How about introducing a new rq_affinity ( may be rq_affinity =3D 3) for=
=20
> using cpus_equal_capacity() using new flag QUEUE_FLAG_SAME_CAPACITY.
>=20
> if (cpu =3D=3D rq->mq_ctx->cpu ||
>  =C2=A0=C2=A0=C2=A0=C2=A0(!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queu=
e_flags) &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpus_share_cache(cpu, rq->mq_ctx->cpu) =
&&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (test_bit(QUEUE_FLAG_CPU_CAPACITY, &rq-=
>q->queue_flags))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && cpus_equal_capacity(cpu, rq->m=
q_ctx->cpu)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>=20
> Could you please consider raising similar change, if this seems fine fo=
r=20
> all.

I'm not sure that a change like the above would be acceptable.

What is the performance impact of the above change? Redirecting
completion interrupts from a slow core to a fast core causes additional
cache misses if the I/O was submitted from a slow core. Are there
perhaps use cases for which the above change slows down I/O?

Thanks,

Bart.
