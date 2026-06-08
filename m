Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42094285CAD;
	Mon,  8 Jun 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933856; cv=none; b=VtHqWTQfKaxiKQHCVEcUO6AjQry9d7OJthVUKf1q1T5vsJ3smBn5H7A6yzQHEB8qd9IhEhnM1SuYDZ9demh/U54EYE1KjR7rlwjG5fR7EsQDsd2/z524VQ6ds2+T8YiA1+TbyEOaK7BbXZNOJ22eUDLBBh2dmo+I4tHsM60OZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933856; c=relaxed/simple;
	bh=Pu2YAEDcMH/maHI/Lle/4AyF4oPuDsyUwWoKR2PyomQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXKq5FGieiiyUKFGR2oFFmiPVHZoRNXJBXTLa4rJ/iOeOfflhlzOPCMAUJeKFH+ta+yAdJMGdnncYdfSCafz6DcCsDRwI4BKO7MbJoca6MwgxtKQ3KvFIAfRZ/aU34kpNJIk7l9DCgJf1sH0TtmbA99dozDyCZ7gsrIGtn9QF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZOcR/PIY; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZOcR/PIY"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gYxMy54Ssz1XM0nn;
	Mon,  8 Jun 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780933852; x=1783525853; bh=Pu2YAEDcMH/maHI/Lle/4AyF
	4oPuDsyUwWoKR2PyomQ=; b=ZOcR/PIYcOcHG/hOWapJam/z2TWCfMfmOWP6Dvtf
	+U4+LyG4HQn9H39oUzOEArFdRkH1QJEK3XLFezEqlEfCa+d6x27F8urrvEd0SKZA
	RC2mtK5F5qtDQWEa4pWLO1JxoCc2Ey0kbkZcBmaG5HcnyaR1FrflemsLQqO7r8fI
	pnnLqvVP1D0SMEajzB8I5Vu1zk3UMrLyPo0bs0/EyVi573V9AFAMSY55uWIgSA4h
	Qs/2qcWSMf/8ikBHjZ9l7nHRvfREaqg92X/hduOz0vY3lxRufLMOFfZc2JsKoXi5
	WTN2w7QLj0bN446AkePdOB8NrqCCc/7nBEaD5+6tfq5NLw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E0W8_l2zcB0l; Mon,  8 Jun 2026 15:50:52 +0000 (UTC)
Received: from [172.20.20.20] (unknown [73.15.154.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gYxMv3Hjkz1XM0ty;
	Mon,  8 Jun 2026 15:50:51 +0000 (UTC)
Message-ID: <5353c4b0-fc3b-4fa7-bcd6-c8cc490699ea@acm.org>
Date: Mon, 8 Jun 2026 08:50:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix arg type in `blk_mq_update_nr_hw_queues`
To: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608-update-hw-nodes-arg-v1-1-19aba440b32e@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260608-update-hw-nodes-arg-v1-1-19aba440b32e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 1:39 AM, Andreas Hindborg wrote:
> The type of the argument `nr_hw_queues` in the function
> `blk_mq_update_nr_hw_queues` is a signed integer. This is wrong,
> considering the field `nr_hw_queues` of `struct blk_mq_tag_set` is
> unsigned. Thus, change the type of the parameter to unsigned.

Will there ever be storage devices that support more than 2**31 hardware
queues? If not, I think the word "wrong" in the commit message is too
strong.

If this patch does not change the behavior of the code for any practical
use case that would be good to mention.

Thanks,

Bart.
