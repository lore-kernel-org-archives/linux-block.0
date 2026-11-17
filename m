Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958188;
	b=fxkWkYboyWtqqG0FjqN7tAjj6kSvcGumG0Vcr2z03P+RWEJaCLy986OUl/Sxxr82oKR0
	 XYTACXetMIU+0nrsL0F80u1KxPU+GPB6jwSCYWPwlCCAbx2oPqgCKehQEl4jzqtr8ECoG
	 D8f5A/KysD7NRi660bZMNNrvqajRtPUOA7At56YVCuIbEU4APLUozxV6UfqWVvW/Y6xrX
	 GebiOzUxvu/xGXJJ1XsbaALNjbWsJk+NCBDeB6HOdWHGKyvW8P/hMmj8s0MsTz0wJlRI6
	 l31ATyXnzSxdezqcn/eL2hA18mvR1MZ6eRtXWBj1xEl+UooJZodnGDzG6YjCMtL01cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LP7vGr2MeK1vmYQsn8vF/AHsz4Kn5UxPP9rt3vXau7s=;
	b=Hhrw7HGN4iNed4eEuExXL6rnTmxWTQp/x8MYPsdp08SKDulHE5NI+ADvOxV5Z54Z8vqp
	 k1my05Px6ATG5OyMCDa5gTB0H8tMo0k06KZfZCxnz3d72EfuNESm2uGYubyeyZITpxNT3
	 3qvCLgqDoBOr6Skwfg/OuR1BdG1vfmjFhI7DpTKWBq7/u5SqqBxrKEQmT3twMVEwJXAgf
	 1U119PQGV5W1l6XtvfhMItDj7OVZozxqnyv/bPo/bn9LZBDR33P3m6EWMDrOwGfqObyhI
	 gnk8zGAPkKeGsNOIzJ7069641AxUzagP4V3uQVoWY/YS9ODIIoT05wb8vtwoaFenRcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=J4mfRzpz;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=J4mfRzpz
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jTgtg6rHTzlpHwv;
	Tue, 17 Nov 2026 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794958186; x=1797550187; bh=LP7vGr2MeK1vmYQsn8vF/AHs
	z4Kn5UxPP9rt3vXau7s=; b=J4mfRzpzVWl9uY3gWXf1veiK10xPetBDtJXJijQz
	Ek90MYPCdkCe/UMzqf9RZrfyqZOmnBZfbPh5Q8QEoWfZrszHp90Ui9XP6StouvnE
	r8zTujW8vexsS3nXr1BEd/wnR1k/a7XME80v6zYg5VyMAQ1hMhREtqRxUb1CwQyB
	71NAo+a0OIU3E2dUtiaSbgw4UcZ/HhjJFUTWAejOOUE7riSn06UZI0+aCmjxmBsk
	3em3LhAHAXBoH4KjBe34642hDdNj0FoVzew5m5mpfux+idkgcobZ31VEJpIN3oAQ
	lo5d1B9IzOCzNcm9nrXuHJaLHnxcwthV545DDrWLYYkXkw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7yKSyq3CD1JW; Tue, 17 Nov 2026 23:29:46 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jTgtf0mppzlgyG0;
	Tue, 17 Nov 2026 23:29:46 +0000 (UTC)
Message-ID: <87756f6e-4104-4b31-804f-aab3b376cd7a@acm.org>
Date: Tue, 17 Nov 2026 15:29:45 -0800
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
Subject: Re: [PATCH 0/8] nbd: Defer request transmission to a workqueue
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Eric Dumazet <edumazet@kernel.org>,
 Aibing Chen <chenaibing@cmss.chinamobile.com>
References: <cover.1794865298.git.bvanassche@acm.org>
 <3868f992-20ee-4b04-9416-40a5a333cc27@kernel.dk>
 <8de875b7-e7e7-47b8-8cf9-6d07c791a53c@acm.org>
 <cfbce18c-2a13-48ca-b2ac-938ad40ae892@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cfbce18c-2a13-48ca-b2ac-938ad40ae892@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 3:09 PM, Jens Axboe wrote:
> OK, so I take that as -5% at high queue depth, what about qd=1 type of
> results? Agree that nbd isn't the end all of networked performance, but
> it's still nice to know what kind of performance hits we're talking
> about. And either you didn't/don't know, or you're holding back on us a
> bit here... Because I suspect the qd=1 results will look considerably
> worse than the 5% drop.

Hi Jens,

I hadn't measured QD=1 performance yet. What I see on my test setup is
about 13 K write IOPS for a single connection and QD=1 without this
patch series and about 11 K IOPS with this patch series applied. That's
about 18% less.

Bart.

