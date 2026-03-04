Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E12D7BF
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657987; cv=none; b=TtrZctPJ75L9jwWZBQ/ABS2MN2DUaeGs0zASFnVuz593cpByUCIrxzGGrAnKvDQvHTj+TSZVV3TunzHh5QqiaubvSvfb0FGlo/Whn2mpsawKjTP4P/z5+B60iyeBe467H5Cgp6IjLPmGVSnhS/FT1Cr79+eb1osSpkQ+xWnhJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657987; c=relaxed/simple;
	bh=jMpmleXudboY1yvKWboZGCzLF8AGlgKVR/2k+BjP8QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWcaLRsRV7CCteLONJZ/s/DxC8yUntbRsAa1vSJhcZF/lhdMC1J259ZivV9ccBPBfWRwAmS6PoziwwQyv2cenhC+SflWHzCQoLq7dEOL84h+2GvLIc2COWugGt4GpBP0K/xN+u2HlMfR1qmlIaNTyi4hqqEBxjsPTcL2gkQpXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YLWUqX6K; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YLWUqX6K"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR4md47dNz1XM0p0;
	Wed,  4 Mar 2026 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772657980; x=1775249981; bh=jMpmleXudboY1yvKWboZGCzL
	F8AGlgKVR/2k+BjP8QI=; b=YLWUqX6KsxvsDTS5woqBtI2xiEJBSEMuG43NJRO2
	+MjAVVwUmb2aBM/cloLDtvvvdQBWiMFnZmbnDfj9u4hzEEz+RD0UYt42WyjsmopI
	BSe3aK3ljpNrmRsp8DgZ6ZtFORDxNJ4xR0A1BQLRDmqZyShMImca2tPSSdbmBGz+
	FU63ckM7wq+Ergi6rnRFUqFH6pA0r+bbuFc5hANQObszRlYg3tUIzoGxcYxTNnu/
	f9u9dawsvIodHBpJvqJSrKA3NVIB4wii4x4GttS1hUDLP1mONXOv+1mY1JEmnu/j
	So9FOi8SNFccrtKAdM/CKTVYZQIPTDJyDZZNICjz9KBanA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SNO1XRW9QlH7; Wed,  4 Mar 2026 20:59:40 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR4mT5p77z1XM5kt;
	Wed,  4 Mar 2026 20:59:37 +0000 (UTC)
Message-ID: <2b6ecfa7-0784-4735-9175-82c4cf347a50@acm.org>
Date: Wed, 4 Mar 2026 14:59:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drbd: Balance RCU calls in drbd_adm_dump_devices()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Andreas Gruenbacher <agruen@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-2-bvanassche@acm.org>
 <8650044e-595d-4058-9b67-25cc545bc302@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8650044e-595d-4058-9b67-25cc545bc302@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/4/26 2:25 PM, Damien Le Moal wrote:
> On 3/5/26 04:48, Bart Van Assche wrote:
>> Make drbd_adm_dump_devices() call rcu_read_lock() before
>> rcu_read_unlock() is called. This has been detected by the Clang
>> thread-safety analyzer. Compile-tested only.
>>
>> Tested-by: Christoph B=C3=B6hmwalder <christoph.boehmwalder@linbit.com=
>
>> Cc: Andreas Gruenbacher <agruen@linbit.com>
>> Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>=20
> This probably should be sent independently of this series and immediate=
ly as
> this look like a serious bug.

Hi Damien,

If my analysis is correct this patch fixes a bug introduced in August
2014 or almost 12 years ago. Since the bug hasn't been fixed yet I don't
think that it is super urgent to fix this bug.

Thanks,

Bart.



