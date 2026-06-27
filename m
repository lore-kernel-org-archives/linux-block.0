Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75211C695;
	Sat, 27 Jun 2026 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782545312; cv=none; b=LMPVHnAhlazrpD4/8TpYKpKThNzuXy1c1jRDsMof7rnN2n3hZ06Fg5KjR2++MjldP1pR78C6PJBRDaZ8RMNbsuLwt1iIoe6dTHrJIwyVTD8Ar3RqKFJFDPJjzfNtlozMNQiqBRmepdEGfGt/B4G44nq020ZkhqWT4Ez3s9sePo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782545312; c=relaxed/simple;
	bh=I9CGH7BmM4eJKGBqtd12JEtafc/O0FTVkqTYeIfSLb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J78oSgbyQsGf3+BGaNW96HaOWCTmrioryWafo2EqjPC/icHjhhu3cW6SP0xv2cip1AGxdc254NhjLDwxC5T02D95ya2Cy1HDx1f+hjkJRkOWUo+weu5ZdUSvtToCRak0r0EwL7k/FLq4vw1Yu4UhuiyYC54nlVABDbhBn3rX+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uwcdjHh6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uwcdjHh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782545301; x=1783150101; i=markus.elfring@web.de;
	bh=Op897IZ0SFwzWdxR9uM5W7otkPW2Ac+eD2Vjc0a89OI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uwcdjHh6/BY9Zu7/N5zLCfZBXvxErHh2rnBn05VgZGDuDPXyFn60xGc2mryvxFkd
	 dBvkdxLGsg+sgyi2uMWsLq9oDpA9bIutWZWMrdm5lGiCgLmPMjMs+U5JqMkwAvocJ
	 zoIGx95609wrWXR5p6z7xkXkxtuBACwFkAjhosJvOsSF8+n7CKqNr/T7dH6qwZIN+
	 8Ds//LP2w2jnBNiRWJeFg8M6lVcwatmVPAc6znZFhe/mk4Uer2B+qxTtNjv2Aiz5d
	 7BjkYy6XLRf6q5oemrukXY/Js0x81PPfJgIXkxXCjnlY64oBrlGviLq6V4l0DOf4U
	 5Y6xdHGkckuerJ6J+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1wWTZU12Gv-000j9F; Sat, 27
 Jun 2026 09:28:21 +0200
Message-ID: <0da09922-20bb-4185-bca7-d48133404e81@web.de>
Date: Sat, 27 Jun 2026 09:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: partitions: Use seq_buf_putc() in cmdline_partition()
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-block@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
 Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <196e07e8-aeb4-478d-bb05-1faaea976e08@web.de>
 <630e1d4c-3302-4d2c-a90c-5b3aedfe8f6b@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <630e1d4c-3302-4d2c-a90c-5b3aedfe8f6b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:80BegTtCddSNPUcjMGC59U8AuqoGcI+cwbsLlxHI0Q/tN738yd1
 4k9Wq+K2OFQ0XtCsSCVZcJQBFpgAaZygi6UU4XB/QeERT+dWFpPGKR+KpCWgp39M3lRdivi
 1Bl+btuVb8snYMY3DyxDwXbQlKAN1mB+jn2XleRoFiZVju44ovZdIrwDART6lXsn9vRgCrD
 bBBCmDq2xcctbW2mwAEeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9gr0ftmVgPk=;0j0/VKcnnNrANnH1oR+p2+P0p7d
 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
 IL9mqoBjByNdGcNm62he+09sz+A=

=E2=80=A6
>>> =C2=A0 block/partitions/cmdline.c | 4 +---
>>
>> Will development interests grow for remaining update candidates?
>=20
> These changes are pointless and already performed by the compiler.

I got other impressions.


>                                                                    See [=
1].
> So from my PoV, they only trash git blame output and make future backpor=
t harder.
>=20
> Just my 2c.
=E2=80=A6
> [1]: https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/seq_=
file.h#L127

Why do you refer to the sequence file programming interface
when I propose refinements for the application of sequence buffers?
https://elixir.bootlin.com/linux/v7.1.1/source/include/linux/seq_buf.h#L17=
6-L177

Regards,
Markus
