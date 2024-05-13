Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13259164
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606456; cv=none; b=pLLlfM7jbYqPomhsxYeqsjD/yWgy6hNfZBmtVCY/2BXTYYzxll9O7AU9UI7Rhlnl2/x/J0jh5Xsi+n4vRvPGI2jjKaWtRLcSSzzkQuKnlGnBFriIwL+1UVxBk47dWNG8fHNaP2N6l5aM6pEO2h6JPXs0ZTu4dBrB2yhq8IpxrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606456; c=relaxed/simple;
	bh=BtnenyGwdg4w4SjJchp+S5iHbnPU01REwzEGJnYh5Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roV7rdsDEHC6mn/HGnUBhi3AE769b2X+Alo19cbSlgQQfq1WML457we8T4IH4j+W2VahB93/f7TzqDNgSG6V43uG0POe27epVX+Y/DbzuVcjZcQhM2qbtLBQDMa/SRbNY9pGjTwz8OtVpxizfvw260DlaCt7hFQ3Lw82i8jHqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zol+a5kI; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zol+a5kI"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VdKqp6Knvz6Cnk90;
	Mon, 13 May 2024 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715606452; x=1718198453; bh=BtnenyGwdg4w4SjJchp+S5iH
	bnPU01REwzEGJnYh5Qs=; b=zol+a5kIy6db68/TborYLrGPM7l51ePChRpy0WFI
	1mShMlKNiZ0c4TiIfblp22KL/XXJI2B7O5Wibo9TbZch1HaMclhKQWepI7w9Ynjm
	INW2JPfYQEOvP3hYlptt8cDXfh920/OujAnIwGa2VbWdkNtHFjvop3X05k3Ej0b8
	ahKbxwcEpw+tB49NkyrbY2I51ba0FZhxuWdrUBd9b2RFITLQNsU6TzrBtQMigmfQ
	XNazSHWRq2qgCn/BgcAdm1hJnq9WbvNySAUtgFCZ93mT8S7t2izJvQUYTyl1F6OT
	lch0qZUtgtNZSJlO6S2RRl/0Sj1BEiICvKQloGEygH2b8Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CJ-XaVugca2i; Mon, 13 May 2024 13:20:52 +0000 (UTC)
Received: from [172.20.0.79] (unknown [8.9.45.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VdKqm0f26z6Cnk8s;
	Mon, 13 May 2024 13:20:51 +0000 (UTC)
Message-ID: <ad1026b0-ce01-4920-aec6-c4dfd0327c24@acm.org>
Date: Mon, 13 May 2024 07:20:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
To: Vincent Chen <vincent.chen@sifive.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
 <2786c4cb-86ad-42bb-8998-4d8fe6a537a4@acm.org>
 <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/12/24 18:59, Vincent Chen wrote:
> Thank you very much for providing the fixed patches. I applied them to=20
> my environment, but unfortunately, I still encountered similar issues.
>=20
> [ =C2=A0 96.784384] block nbd0: Double reply on req 00000000619eb9fb,=20
> cmd_cookie 51, handle cookie 49
> [ =C2=A0 96.847731] block nbd0: Dead connection, failed to find a fallb=
ack
> [ =C2=A0 96.848661] block nbd0: shutting down sockets

Hi Vincent,

Thank you for having tested my patches. I will try to reproduce your
test environment and take a closer look as soon as I have the time
(probably early next week).

Bart.

