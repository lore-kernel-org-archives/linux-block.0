Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A954DAF9F;
	Fri, 25 Sep 2026 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353337; cv=none; b=s7Qf8Aazfljiv9JcPF9nEPH/Lq4081wmddEct+9z+wM2QFWQjVDqB38qGUsFqn2HXv71PTKgZ6N2buqolWj+C2K43i5OJ/DhZZ6L3arwvOun5mUs7fOCNAyEo+K6nw/IovE042dPy6GNH09DvYB8ukaALzScxe9RBOKG/yLpRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353337; c=relaxed/simple;
	bh=vskCXTteMG5BnClAB8a8zIU9vbabzfcXbednzkouD9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyoHRakZmzgkji+JU9ds4QJ4dLiIuv8Iy2YpFt5+lDgNDbz9yxgvg1CfPsGGToDHjqBcf1Lje4wou5mKz3bHRdzVfKmMvRodEfNsMzbo/kBkeVRSvJUwOG8DU7NpUd2wue71WezTXiQNmqQkgKcc1vdndrZYNp6RtMPMjyGaR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0iyaDkXx; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0iyaDkXx"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hrwvh12BKzlfvpN;
	Fri, 25 Sep 2026 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790353323; x=1792945324; bh=JM+Dl14pB+8Rl3g0jAiaDVlm
	xdrD8PrEGsDVhTCDyuo=; b=0iyaDkXx2KjYuwryqoS7SH4KsBxqottHaJev+NKg
	H24+4VbRC7gg4clCx3IBjmtZG6ttDHTbUcX5K69KvnE4jX01uI/eYfxUBLPl4RIp
	H0HrOR4zDiDonbIp/qP3ifx1idc5KikE1VNR7wK4kOqYOuq65YDGCQXIQoSkF2Ll
	9wHaaZxRRTS2RQ1Qkwn5i4hZUmGs9StaluYsW5hCWTMK0KooKA4gxEgDKxqbNtij
	3tXB32BIS6fShaf+5/LgiudJCf0zjB3hb3IBk2mEgvo3n4gxTXBEVJPe2A/Ju9Os
	37c0wMjUBoO8a2GFVJSxf28PKl4IKnLOj8nGzoqoYZSm7w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DzIpX-92UDzp; Fri, 25 Sep 2026 16:22:03 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hrwvY5rTSzlfvpK;
	Fri, 25 Sep 2026 16:22:01 +0000 (UTC)
Message-ID: <bcf71ef1-427f-47ff-9880-c87ef0654259@acm.org>
Date: Fri, 25 Sep 2026 09:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924102027.2307044-1-cui.tao@linux.dev>
 <b6e08595-50f5-494b-ae5e-726513d8dae2@acm.org>
 <2df087b0-2a00-4e30-8e6c-d2f76e3ebd79@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2df087b0-2a00-4e30-8e6c-d2f76e3ebd79@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/24/26 6:29 PM, Tao Cui wrote:
> =E5=9C=A8 2026/9/25 02:01, Bart Van Assche =E5=86=99=E9=81=93:
>> On 9/24/26 3:20 AM, Tao Cui wrote:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_limits_commit_update(lo->lo_que=
ue, &lim);
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&lo->clear_limits_lock);
>>
>> Since the mutex_lock(&lo->clear_limits_lock) call occurs after
>> queue_limits_start_update(), please move the
>> mutex_unlock(&lo->clear_limits_lock) call above the
>> queue_limits_commit_update() call. This has no impact on
>> correctness nor on the lock nesting order but makes the code
>> easier to follow.
>>
>=20
> On moving mutex_unlock() above queue_limits_commit_update(): with
> the generation counters removed, the mutex is what keeps consuming
> clear_limits_mode and committing the resulting queue limits atomic
> with respect to a rebind. blk_mq_freeze_queue() is
> reference-counted, so the workfn and loop_change_fd() can both hold
> a freeze concurrently. If the workfn drops the mutex after consuming
> a non-zero mode but before queue_limits_commit_update(),
> loop_change_fd() could install a new backing file in that window,
> and the pending clear would then be committed to the new file. Since
> loop_change_fd() does not recompute the queue limits afterward, the
> incorrectly cleared discard limits would persist until the next
> reconfiguration.
>=20
> For that reason, I'd prefer to keep the mutex held until after
> queue_limits_commit_update(). I can add a comment explaining this if
> that would help.

This seems fragile to me. Can this race be solved by calling
cancel_work_sync(&lo->clear_limits_work) before the backing file is
changed?

Thanks,

Bart.
