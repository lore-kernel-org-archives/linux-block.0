Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95A4315C
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732274; cv=none; b=MoT/4wuYkA8l7g1WdShseoLlOuxiduNycklaXRZcyg/60hoccH33Kd5YOPkaFgtm66BtzNXiM+G4U4ytukJQaYe629k7ciMitXG0zX8HknPi1zFVQajZxCv9w0fo9AJgS1V6pucVNDCAeis3pp0WXFuezUj1VMIXhN6ZJIAPBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732274; c=relaxed/simple;
	bh=3fzBTfTwjyZ+0qp4ymuaE3JWLAJcd+GHkEEr84eu1jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XcL2Ry6GI4j7VXx1JMia5LsZ17RLCdgRven+ZxYql1cBpLcYUFgp/nFEXOfrwrgYHq78rK0QF2IreuUq/R4DxgX6lbveFEBeNgWFzzwj6VXb8QkFMw9L1gNpAAsqEEQdO3t+4JNKx1HBei98hWFpN+Nrpr5nyrANer7MHF3nTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IbbTMfs3; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IbbTMfs3"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZcTCV024fzlssnF;
	Tue, 15 Apr 2025 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1744732261; x=1747324262; bh=qBWHN53wvY+3Uz7F19f/d2MS
	F+Cw6qgdxa6QoSSwrSU=; b=IbbTMfs3GnRTtuoy6h39LD0JtmkrFOGwp+CTKaaY
	/pv0Kyh7gUVSu85Av1K/Drll4HRZqSoNEwUUgHXh0BgS8wiq5fNYKlthkkh9o6Y2
	IqE6VXy/EA9WfhrDKfnn7d2UeGm6aZ21HUFs7SDJeuHuPJ7cTyomFlDH7sVCXNZe
	v4OmqRnxH5IUE5vc5PLy3mwC+F06zbeYS7OoZRnWeXGa70s5IJyLus6+p1JHN5dr
	q7qlKja2nUpJsxNlgzxt7eFrxaFwM6cGpzdxyieNEeFC4qQQRBmjqlXYKSFu3Rd3
	BDCDeczmsRJWwout+QPmjPKhhLrn3AYxvqD+/3WZvCFlWA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kfTkRxcSdCVl; Tue, 15 Apr 2025 15:51:01 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZcTCS1qf3zlrnRv;
	Tue, 15 Apr 2025 15:50:58 +0000 (UTC)
Message-ID: <a8074c72-e258-4b34-a629-c253997dfab9@acm.org>
Date: Tue, 15 Apr 2025 08:50:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 7:51 AM, Jens Axboe wrote:
> On x86, rep stos will be emitted to clear the the blk_mq_alloc_data
> struct, as not all members are being initialied.

"Partial initialization" never happens in the C language when
initializing a data structure. If a data structure is initialized,
members that have not been specified are initialized to zero (the 
compiler is not required to initialize padding bytes). In other words,
the description of this patch needs to be improved.

Thanks,

Bart.
