Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0610A12;
	Wed,  4 Sep 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470553; cv=none; b=I7wlgb7vvcujzl/GLuM0qi22Oml5HNqqMz5BJ4haKjHmaVUpvbiQgjI9nweWDVbQdwTtd63UMzASi+L486T0FyUQ8M4QUaZKYcgxqJhReZ/ABxNpH357Nxrkz82bV5a+oGV7HUZFrzB4z3kFexx0jxY3JXKtxJJpzpnWugM5GWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470553; c=relaxed/simple;
	bh=1fWeK/wGUq+HO5lGmQDjSm4+RAeKtJe20MGbANPD+qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hce3HGsOPT4NyrymsCT2g5jBeHRBDzS2xJzu8omIntonkihyVHZ3h53kFX8o+hYOKfp1ZeiCdhsCc97ku3I9L/FC0XJDB4ItfrXzrxMo6pH3JT6dJI/xkDYhgXzmWIttJ7THD/xogyNXCdOshzUUeWcsJN1RL97iGAJoatXI5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qfa07UVT; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qfa07UVT"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WzTnz4PMxz6ClbFV;
	Wed,  4 Sep 2024 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725470550; x=1728062551; bh=cSCYVVMG1aNiK/Sl4MxkzGvm
	+M81ogG6FKFqwI8K710=; b=Qfa07UVTfrYn+lXgNP7c1pQpRKDHQoxWUPjRFz9f
	5lJbFd4MHfky35MnZsoLX2Iw5i7ufMsWYYoxBFGbt6REZRuRyWswKsqbF47JPvon
	LR7o1wm3hwELBN37hBs6qvCE9dUPp611gQkn9+J/mwJDyjodkW+m3QgGlFOlvcKn
	KCuXVUCrrfAVlEU96vw+ZPUHkSS2g1loqIcwgqhlTkiGZUp2MV2cJUgC1G7y0n6D
	Cs5d236fsZtJ+CNgnRhLjm3wwPipQ6zcVQXSUc9eeqcANAqESpF4t5U6oB8NFz1x
	daeSSbD8rZg5SUirCDf54f5IeHt9wDSyZMzz/Qj59jVFXQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d71_bAbxWk0v; Wed,  4 Sep 2024 17:22:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WzTnx0YcJz6CmM6d;
	Wed,  4 Sep 2024 17:22:28 +0000 (UTC)
Message-ID: <a2cb0302-b333-4cea-aaea-4a7bae7024a9@acm.org>
Date: Wed, 4 Sep 2024 10:22:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
To: =?UTF-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
 <f669709a-b8e6-4c76-a75c-f3e7828e09f2@xiaomi.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f669709a-b8e6-4c76-a75c-f3e7828e09f2@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/3/24 8:35 PM, =E7=AB=A0=E8=BE=89 wrote:
> Does set rq_affinity to 2 mean QUEUE_FLAG_SAME_COMP?

 From block/blk-sysfs.c:

	if (val =3D=3D 2) {
		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
	}

> This seems to determine on which core the current request is
> completed, rather than in the interrupt top or bottom half?

That's correct. I suggested this because I was wondering whether
spreading the I/O completion workload over more CPU cores would help?

Thanks,

Bart.

