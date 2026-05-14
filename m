Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721318A6CF
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718694; cv=none; b=NFqm4ThuGdBr2vQopm9La4jjSBExeN2cAUihBAoYl8/ZkRM2/Ns3ccmxstErCrUsUvgdsmFMDAZkt4Nk7lfcUM00bhq/FbjBTXwv5a5Q0KJ56UG7ZgvYVC/p+T8fisWyOvQFziiOwFu0zUqPWtsTgriXEW0Mpw0bnFzejfmdoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718694; c=relaxed/simple;
	bh=hJC+GhUSYjT0XqmROGLDajj+FQdOs/UpxTmfe0atcNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHmnvrZDIIiJpzklAeYr3jf9EarnHuQ1+3qMizgA9+8/WCIytT2ZMJmsT12GdbGs1JEva9qk1DkdQ8sjpqSsxD2g/B8afGoWkzPKFsIG1tZuxGD2oTqZ3fe+dkWC3B/oSZ6fVfMaJsgwWxnVy76ib11CFByBPSXPWShFl6DHlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=al9GpZDS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="al9GpZDS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gGB8h0k9HzlfvpK;
	Thu, 14 May 2026 00:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778718689; x=1781310690; bh=XqH3oxYpuqMVKSAoDZL0Jcv7
	xlXrsrX+iZLAGy4ofH8=; b=al9GpZDS2GuPdS+V1tfv2Re2f9ZYTmuA4JyKrEq8
	3NLxGtp+HjP9/pBbqjEjvA2t7HLxpeqle55LgDkAlJlEL3NK5VNLe3fGyVeFyeZx
	rOUWnsKBy18PSMZWE5SUFdgvQyE76Iwuu76pSGSLFwTqh8X/OIDd9UiYitRf29fp
	KAp8wRVMojeq9ycqKYQNnNdhimBUKO/ZvCfQye73byiqSHU3pt9nvkRJhHGppqEF
	tI05RxTmtgshxcOAqcjfmjo7gopcF6OzVI6Ls9oEOqdoAsGzJtqNmQgGf/qGrHv9
	sZ33yuwyb6yorXDb/O+7LxCWLDrnQEP1tMxqNmrpvyeQ1Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kl4zeMoOADR5; Thu, 14 May 2026 00:31:29 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gGB8b46kQzlfwJB;
	Thu, 14 May 2026 00:31:27 +0000 (UTC)
Message-ID: <e2c43df5-aca5-4214-b7e6-0dd8f3f8b076@acm.org>
Date: Wed, 13 May 2026 17:31:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback
 functions
To: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260511163100.1887263-1-bvanassche@acm.org>
 <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
 <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
 <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>
 <20260513133614.GA703152@ax162>
 <e6dbe36b-7bd3-4848-91e1-9c84d421e1ee@acm.org>
 <CANpmjNP7JQq5X6bheX58bi2A5XaChkGSXs6+uQK2kiwQeXBvdg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNP7JQq5X6bheX58bi2A5XaChkGSXs6+uQK2kiwQeXBvdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 4:06 PM, Marco Elver wrote:
> My patch which is more complete is still floating around:
> https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/
> 
> Peter is probably still waiting for Debian to upgrade the clang dev version.

How about reposting that patch? I hope that Peter won't wait with
queuing that patch until Debian has upgraded Clang.

Thanks,

Bart.
