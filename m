Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437813;
	b=wXVP8hAX5NfSreRX0yndtMvmfKx/e0AIMl3kAEuwU81ByEZv6YIRyye+Z/4VzeecI/ng
	 PrK9O7XplZp++UZK7XYSadbHmFoPunirQXR715X2/ajSgu5oSASxki3RVYLjp6DPaRzFz
	 deSynTQonHM1/2bAjoYYCGfceWbF27hm/wb8ar4MTr3R2aK7dGl0zPhrSRD5JRXxsAvga
	 VCygJ/yu4Vrm1CcpI/CgcycVV0/gYXWiyN4DcfSc8RIGVGkUOFFn6JmATtXXwQ/AH9T9L
	 6VVrFaW9jiVH9Yqx4wGK6bo+7wcwMSdDwGykur3jd9i0Xu0SKLFzb7oWwJBrx/D2JAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YnOy9jm2+WLZG5dMyh/MU4OYfkrbLhsS50Wo3dw2pNo=;
	b=Kc/2av7b6bVfuo/tzF/jhvx4PKHPB0QKiLzMAUcDPcKydstaaX82ptB/ZKxVJT28BG/F
	 ZIecW6Ng1CEtk7WCGWxGmBGGQ6Av3q3r1VvDhY4nZu9sybWGw2RqLCd3WQQEeI9wAAMz1
	 rTrAUSC+nzmc3tEkjkxPy3ZFjeyXl1WjaBAGmxo2Kk72F3xe4lJVtDlSLZ94Fs+oIZatQ
	 7DKmrG3e4E0rjpGxx/SMLhseA4diwe2odcvpBnvkfxBmNcj/gatD3sho7Jxwn4riS/IVH
	 vPmh2gMm8ctHkXqXPhfwbemFbaI5JpxE/iGzDxE1YdYMbHg2+tU47YSamJVArHjLNXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nEBFMyDD;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA01606A323
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 19:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA01606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nEBFMyDD
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7lnw48Fjz1XM4Tn;
	Mon, 19 Oct 2026 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792437810; x=1795029811; bh=YnOy9jm2+WLZG5dMyh/MU4OY
	fkrbLhsS50Wo3dw2pNo=; b=nEBFMyDDqNqsfxkPrZK1GZcJapRasPu+4bNVgkxL
	jSJDoUt1s0KPkFpWZzRGJxXPCSDvc42f2ql6njPJDsFdOWzo2cXBuJ1ujlvrziZC
	Kum4IIx/+Oj13wG0LHcWP6VGMuEgTnLcvNzM2Z7YPPaeBKWhCIkyNv+4pK3ekkV/
	WodniOIdKGX0lmZNE1GRhcznnEp2POvRcZCwaGx60sGcA/Vo5YAt3n4rUar85aOF
	3DHQ2ZVBKHzLZ4VLfe5wfzhJDyGa5bUAEzXRNJSn2dY45jQaGuHPKKfW2jf5B6qX
	PC9Nm2OToURD1zwbR5GRfpzn9QIgkEfMHEi2mbvTtsYlGQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id snVYBkRlici4; Mon, 19 Oct 2026 19:23:30 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7lnt4rnMz1XM4Tl;
	Mon, 19 Oct 2026 19:23:30 +0000 (UTC)
Message-ID: <51568a73-77a8-49cf-8a49-71f15cb6e5e7@acm.org>
Date: Mon, 19 Oct 2026 12:23:27 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] loop: missing BLK_OPEN_WRITE check on LOOP_SET_STATUS in
 lo_compat_ioctl()
To: Dominik Maier <dmnk@google.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
References: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAE7N4Sq6_M610g6gOUJCkkoBH06Kqbndb7KhGGLk=WCHOqHbtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 3:16 AM, Dominik Maier wrote:
> Fixes: 604f275f9670 ("loop:Check for read-write open mode before
> setting status")
> Assisted-by: ARTIST LLM

I can't find commit ID 604f275f9670 anywhere. Additionally, I can't find
any commit with the subject "loop:Check for read-write open mode before
setting status". Did I perhaps overlook something?

Linux kernel patches must be signed. I don't see a Signed-off-by tag?

Thanks,

Bart.
