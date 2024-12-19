Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151001AAA34;
	Thu, 19 Dec 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636340; cv=none; b=TpZOSxJjdwrn9UNcil9xJZ9M3Dx7I0+5pv3JwxYYA75jWqnAnCxjmw+RpsCdQ9xBH7y5GTfwpPD6X/2N/Z9MK6Sb4hdU5rEAlfNA0HsrMpQRwa5EcV7/jPJXHSEoxUaMu0i/I5CIIUNUUWUT950ewDKfh1RXWmLB2Fxsb7bz+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636340; c=relaxed/simple;
	bh=lyfzYjWqqOgkK+XHQ0XrooQgsqqe8JdytUDAWXOTvD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfmVEHR8XZeOR3GznSUptvY8O14E3/fTn6Gu2oWufHHokVNYpU6q60FVLVhbrxileMit7xBdguFs98qWvsFl72fYLQJdAgIShC0LiGqVw3XjYrg5Qxcm3uJoOG+hrrqKgr2RQNRt5AoXeUSPyqn0sMcj/Wl2fcfUumGysPC0o1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XID5obDn; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XID5obDn"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YDgW62wfwz6CmM6N;
	Thu, 19 Dec 2024 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734636332; x=1737228333; bh=ON1gERJAFf9jXKBC2NpvIkoC
	znCWK4rj8lYHpIV5Cuk=; b=XID5obDn2rrwAl/WD6w/rkXSKfDeX3jodmxi/md5
	e+xBQFz4wZM1Gc2KTnbb0d9QspGUbTmo1AR4wqQUjdcO8nGVw3W2NXz3nR9hbpFN
	46WmLxI4700ShUobDh3JsbnoqNWMixoSan2hJ9UtpC3rHe5k+cwr0QB+bvN34ONI
	C/C7L18MLdIs0gzeXevEanuYGq4yfPVfgdyikb8cZIEoBv8VpCZz89NCMifnG9aM
	10uu22dBlkr6Ym7vgko5v5kCU6CosZv3qQOQqzzBBu2BF4JOAu7/O/kK7giNpWrT
	JW27S0AXRQuCWEcuHOA8qmjR3wwjjSg+2I0wdVKeF8ogzw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fuFP7cEyJa2x; Thu, 19 Dec 2024 19:25:32 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YDgVv3ngDz6CmM6M;
	Thu, 19 Dec 2024 19:25:27 +0000 (UTC)
Message-ID: <818ca8e9-d691-421f-9b66-f13c76f523f3@acm.org>
Date: Thu, 19 Dec 2024 11:25:25 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
 <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
 <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
 <96556f82-b511-b3ef-01b5-e9a32557db95@huaweicloud.com>
 <f2b95b70-f074-4f58-b03d-5e7fb20f4274@acm.org>
 <ff6b1360-2cc8-d700-df88-130fa15de1c7@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ff6b1360-2cc8-d700-df88-130fa15de1c7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12/18/24 5:21 PM, Yu Kuai wrote:
> Hi,
>=20
> =E5=9C=A8 2024/12/19 2:00, Bart Van Assche =E5=86=99=E9=81=93:
>> On 12/17/24 5:14 PM, Yu Kuai wrote:
>>> I can't make this read-write, because set lower value will cause
>>> problems for existing elevator, because wake_batch has to be
>>> updated as well.
>>
>> Should the request queue perhaps be frozen before wake_batch is update=
d?
>=20
> Yes, we should. The good thing is for now it's frozen already:
>  =C2=A0- update nr_requests context;
>  =C2=A0- switch elevator;
>=20
> However, if you mean do this while writing async_depth, freeze queue
> is not enough, we have to ping all the hctx as well by q->sysfs_lock,
> which is not possible.
>=20
> Or if you mean do this while write the new min_async_depth, then we hav=
e
> to update wat_batch for all the queues in the system, too crazy for
> me...

Should min_async_depth perhaps be a request queue attribute instead of
an mq-deadline I/O scheduler attribute?

Thanks,

Bart.


