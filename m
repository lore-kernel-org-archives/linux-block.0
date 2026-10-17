Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220D33F8B2
	for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246756; cv=none; b=Lu4RZqGpk3HP+L4f5odf/qu8+8XP2nTJOPvSL+uehxAx19uHEyhhoX/VaaRuAx9UvZji8N0KFTCSvZXlffu6fObA4z5P/RaevCV/Ko78IyGGcezGld5EH8XCAdZtEuu9O0oiacts/hANi/hmBg9Fb6AExt9JceMhOcK86DQrWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246756; c=relaxed/simple;
	bh=FIRfgtN4366IFuixQQJHuLNkqBSm5Zxp99wdkFJOwY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqD8PCllpKIqwufvnBzR2T0C4R3zhstwKaDhPPdijuqXIryWZ5vJORY4j9CKHsItsM+8CS4MvuKv7uBT2ONezCG2Uwx3nQ+zxunO4uTic9UPCBRcYhlL+KhRbU+c0WBKB8Ww9pzkwgkTns6WmJ8BwcWaoOiJysn/Sfjd45CuMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d81B+Jq+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d81B+Jq+"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j6P7j5PC8z1XM5kD;
	Sat, 17 Oct 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792246750; x=1794838751; bh=1J8xxORMDOpKq9zDx6miIArz
	RFevLmLtuPQPmBey4E8=; b=d81B+Jq+BCDi65KEMmnCbCtHDOpm0sTyGLRcTmUO
	lRfktK2CW/1KskYCVpeEbqDXvKYXoySxB4tjsWSKjmvMxvuZdlSwDyYpkgM3M+dU
	9X/BkEAE0L7JOpbvhSSzFGgeWE5+oT7EAxQxIySvrZNq9YkOEpv0ybuNKOpwkX+6
	d4ZOojDytU4oT0Mzkqpj+867dIw0BAF8l9iYrWOaXwG8YBUFuTgKTLmPltCZ2Fz9
	bGK90dyBNtprxxHN0bmaahyjGCz+5M/I4MRmcdkoQd90ZHG4fhg4ta1eYyj4sgWf
	NO3ZcBbAt+55oLJFNEqN8TJJ/gQ7Rx1t91H23iyDoQWvkw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7c-BRB1f0sW4; Sat, 17 Oct 2026 14:19:10 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j6P7f0kDFz1XM4Tl;
	Sat, 17 Oct 2026 14:19:09 +0000 (UTC)
Message-ID: <307b05d7-16dd-493a-a10a-d5ac50ec219b@acm.org>
Date: Sat, 17 Oct 2026 07:19:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: add direct dispatch support for mq-deadline
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20261017105400.95967-1-kaitao.cheng@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261017105400.95967-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 3:54 AM, Kaitao Cheng wrote:
> Bandwidth in MiB/s:
> 
>    Workload        none    mq-deadline    my-patch
>    jobs1-4k        1209           1047        1174
>    jobs10-4k       2458            946        2349
>    jobs1-32k       2568           2565        2562

Can I conclude from the above numbers that "none" performs
better than "mq-deadline" and hence that it's better not to use
and I/O scheduler rather than to complicate the mq-deadline source
code?

I have removed the linux-doc and linux-kernel mailing lists from the
Cc-list. Block layer patches should be posted on the linux-block mailing
list only.

Thanks,

Bart.
