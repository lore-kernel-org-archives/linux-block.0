Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A2147C74
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894877; cv=none; b=XTs6B9atuBB8/jTNWcy/SOXfVVuAvDaljotv6LYyKyZcBWHPPcxn6jyJwFxyWNhI+0HXI+a6IuzNBBAaXARzYl/8g+t5zM0Un3oY4raGZ7MlIHboJy2ay9wzmcMql3Y/cHVa50jatSp6yzUbeSWvBPAh1laNcnAL3UJt1ofSzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894877; c=relaxed/simple;
	bh=V2VUTRPHZqjhLyS1RLLhvLv3QvXMOZXMu/LbidV8TBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfVRrgoE/ywG+eb0hOdfgXejTtZDPyC2NY7J4dYLFRwQqO241GalxNkUL1rbSpojNGcqizoKEdxVZZ+vJoXkCQlUc7SoV/OrupvQ/3T/OYLSkPE/kXdI5YGVIYvODyzsI+RyegdhfS9We4t4NUWClchkCKGK8sggD9oW9FSK+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OqCowDSO; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OqCowDSO"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VgNVM1t2YzlgT1K;
	Thu, 16 May 2024 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715894873; x=1718486874; bh=V2VUTRPHZqjhLyS1RLLhvLv3
	QvXMOZXMu/LbidV8TBI=; b=OqCowDSOlaUADJSwIaBqp/iLkYmUR1u3jJO2pGJT
	yZrdob8T3cjtIkHjEX1ErKHaYPUxwPhW/kH5QNxTMpGA9WMSd+zQcFEsxWaMJWAH
	BhAKE9+BXpwHcVCrKHZZ/zID7MQfTwhk7jIP8J0wfENRg/iIcEr/GaBr3iywzuMu
	qm32za5KcAiqruIV0uX2tRJ420QXXsuwGj3TH1lOejqIb2wSM/P+xvu52LycaNaU
	yvoBYtH47JqUz9eppphr5Zllg1AYTplc2zXjMRvDgsjtZi3ajKF5KlkEL04ShH0a
	aWprvylTJfCafSVdKsKydhiS7NaSGDtRxK7X3sKPwA3G8g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GRZVblASXQCq; Thu, 16 May 2024 21:27:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VgNVH31XSzlgMVL;
	Thu, 16 May 2024 21:27:51 +0000 (UTC)
Message-ID: <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
Date: Thu, 16 May 2024 15:27:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
To: YangYang <yang.yang@vivo.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/16/24 02:14, YangYang wrote:
>> @@ -513,9 +527,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx=20
>> *hctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct deadline_data *dd =3D q->elevato=
r->elevator_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct blk_mq_tags *tags =3D hctx->sche=
d_tags;
>> -=C2=A0=C2=A0=C2=A0 dd->async_depth =3D max(1UL, 3 * q->nr_requests / =
4);
>> +=C2=A0=C2=A0=C2=A0 dd->async_depth =3D q->nr_requests;
>> -=C2=A0=C2=A0=C2=A0 sbitmap_queue_min_shallow_depth(&tags->bitmap_tags=
,=20
>> dd->async_depth);
>> +=C2=A0=C2=A0=C2=A0 sbitmap_queue_min_shallow_depth(&tags->bitmap_tags=
, 1);
>=20
> If sbq->min_shallow_depth is set to 1, sbq->wake_batch will also be set
> to 1. I guess this may result in batch wakeup not working as expected.

The value of the sbq->min_shallow_depth parameter may affect performance
but does not affect correctness. See also the comment above the
sbitmap_queue_min_shallow_depth() declaration. Is this sufficient to
address your concern?

Thanks,

Bart.
