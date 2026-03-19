Received: from smtp.tiscali.it (michael-notr.mail.tiscali.it [213.205.33.216])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4118FDBD
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922072; cv=none; b=YCVumU9UzgiCSC2J7be2fHMJDQxu4nimt/8EhnClWqTsyl2leSazoqz6z124OROEEj6u5R4iL0CJ8MVJxTyNaC5T0kTNO/cohTg2w3quBIwB7v+4LTjAG+66yKDFVb4Ox+yvETw8tP7yrCvD9DbYyBPhS2BQESxPxG3YbGxdzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922072; c=relaxed/simple;
	bh=AbnH461tN+VvUN2H1mfumBlYMAKhFdsqTsm3ap2f8yQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=W34b9aepPEfYP+wcicaIWy4J6AiyK/1/sC902xvY0g6BBeUouCEYs2ZfgisX/MG9lLoTiHnPwqsWfwBoNRvai/edZHVnrCO8ZGG4OAbzARgHybMOJWYCqHnkU5eFaBVcgcQSEq6RLZxOgxBzyG3k+aKXxR7s4vXrUpoWKfP7shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=wzzxZY84; arc=none smtp.client-ip=213.205.33.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="wzzxZY84"
Received: from [192.168.178.50] ([80.180.186.238])
	by michael.mail.tiscali.it with 
	id sc6C2G02B592fEQ01c6FA7; Thu, 19 Mar 2026 12:06:24 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <5459ee8c-075f-453f-8999-19219f9a6fdc@tiscali.it>
Date: Thu, 19 Mar 2026 13:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: fantonifabio@tiscali.it
Content-Language: it
To: linux-block@vger.kernel.org, axboe@kernel.dk,
 Christoph Hellwig <hch@infradead.org>,
 Sergei Shtepa <sergei.shtepa@veeam.com>
From: Fabio Fantoni <fantonifabio@tiscali.it>
Subject: blksnap: no feedback received on latest patchset - any concerns?
Autocrypt: addr=fantonifabio@tiscali.it; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 260319-0, 19/3/2026), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1773921984; bh=Bk+G6eHJ5bAhi0Z80HpJ7nAUPS2Zdc+kO67gSvMpuhs=;
	h=Date:Reply-To:To:From:Subject;
	b=wzzxZY84hgBy8W36fHlTWE9kFgo2M7+ehcnaYE8FSueVjZp27z5j2+CCSsnHbQqBU
	 2L1wPyNSwOQyLaDT1YOvVNiVvPjiKG438A3ufWjbjd+gxovMGU5FdMTfiIrQucZ9qs
	 rAmOrU/UHsNOfaJOcAOKUbUYZaD37ekt3uyvEZbU=

Hi Jens, hi all,

The blksnap v7 patchset was posted in February 2024 and has received no 
response so far. As someone who has followed this project closely, I 
wanted to ask directly: is there a reason this patchset is not being 
considered?

This is a module for non-persistent block device snapshots, useful for 
backup on filesystems like ext4 that don't have their own snapshot 
mechanism. It went through 7 revision cycles with review of some people 
and substantial contributions from Christoph Hellwig. The amount of work 
that Sergei Shtepa and Christoph put into this has been remarkable.

The silence after v7 seems to have led the developer to abandon the 
upstream effort entirely, which is unfortunate because seems to me 
there's still a need for a block-level snapshot capabilities module 
integrated upstream, or am I wrong?

I fully understand if there are technical objections, but could you 
please share what they are? Even a definitive rejection, accompanied by 
clear reasoning, would help the community understand whether it’s better 
to take a different approach or address specific concerns in similar cases.

Thank you for your time.

