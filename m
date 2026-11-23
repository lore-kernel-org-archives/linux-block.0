Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450499;
	b=FDqfZ57BN6HIp5hUWh+pSMl8bNRTWFMCNj8B1va9AHrbxJ1KzwMjdcvNTtriHTuCtEGG
	 40K9daPGf4XEpDU1nuIizOJkrk8Ht544vHXAiYa2cPqQ4JlN39b0pPVu0k1u6E+UaLnek
	 rNMwnSkqI6l+I7lNQWFzDmZYQ3Lu5sjMBS3ViJ2J9Bss3ax28ZLuOl05Zkhr7v+/Fcccz
	 25EQzqL2qe4bpEggmpnDrf3J36X6p6dISpsAifdp1YCB4OCaRKMc2ab5fBQ1j7Yv0Q0qo
	 XW+jAPWn921ribjSNI8p5xbUNDEikFIE1BREp+g4qyEVyB3ZmYQaVuCw2wKxONIOTUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tL1jl09/wD2r0AUVPR2uNsPqb8HB+xJhrdsmnnw5yC0=;
	b=nfDRpeBke6v5CFbA33wsmjanCZRSpP39moJ6qTt/9EwPOf3Q72fEY+h3IiwOw3k+O6hg
	 vuCjFMx1Q5YL1Ju7Fzrms+EAudIpC7tAVyWlKgDypjIulEjlP8ktl4t3R6n2n0Id6XHRe
	 CRHo4YwD1dw0WolXIdXySVUPAE57eolJVf+28HvuycGT+Mt5p7c6lDGia4kjgzGy7VipG
	 /pCP9oqzm/a3rxhC9i8HNiTTl76cEyszR1DExb0Hl7Xr8RMr4lB/2Qa2ElB8f1+Mo2+GS
	 ugyi2rnRnqOiYe6MlI9Ddu4RoY40muvU70KP1lRFzFkPe558WGOM8oYl3iCITNZXXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=jlAk3eCL;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BB606A31A
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 16:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=jlAk3eCL
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jY9yB4RHTz1XM6Hx;
	Mon, 23 Nov 2026 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795450497; x=1798042498; bh=tL1jl09/wD2r0AUVPR2uNsPq
	b8HB+xJhrdsmnnw5yC0=; b=jlAk3eCLFs2W2gl79qOBQzr6oy4bvbFDByd5h4hp
	GD8RZlo+JhUDdDbuNz8YYp1M6eFj/nXXAvvDJ3mNKtI42LiJI+m1/5YVQX69Tjx1
	H4aIF/k0I1khznRtgysXGjz4rl7mHKb3AnexetZoofNfzz8uBJ8GTUCLZMZWMKEs
	XNbhmQ3UXzqbi4yQtuIT4GSqVwGl1Dr5mO/dYArm2pL7pJxZEUtyW8lAUSP3Ohj7
	2kfgrRAvn/ImHrvvKKPBNms9OZf/yNREtjTXA7PEy5t9uYtrwNwFXOJMB0Nu5wq4
	zZzF7Sn/47si8ksghOngk4jftkXqLWfBwneVNX49FsNl2g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KMps1G-8GXEL; Mon, 23 Nov 2026 16:14:57 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jY9y93dHCz1XM4Tn;
	Mon, 23 Nov 2026 16:14:57 +0000 (UTC)
Message-ID: <f251a666-ea13-4dec-882b-85af5e964b9d@acm.org>
Date: Mon, 23 Nov 2026 08:14:55 -0800
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
Subject: Re: [PATCH blktests v2 2/2] nbd/006: Measure NBD IOPS with a null_blk
 backing device
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20261120213434.2945873-1-bvanassche@acm.org>
 <20261120213434.2945873-3-bvanassche@acm.org> <awQaJh_NFpD2_-PK@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <awQaJh_NFpD2_-PK@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 4:11 AM, Shin'ichiro Kawasaki wrote:
> Just for curiosity, I wonder how performance regressions can be caputured with
> this test case. The performance numbers are reported as described above, but the
> test case does not report failure even when the performance numbers get worse
> than previous runs. How do we catch such regressions in automated way?
> 
> Does this test case have other value than the performance regression check? For
> example, the test case uses Unix domain socket, so I guess that this test case
> extends nbd driver code coverage.

Detecting performance regressions falls outside the scope of this test.
However, anyone who wants to use this test as the basis for automating
detection of NBD performance regressions is welcome to do so.

Thanks,

Bart.
