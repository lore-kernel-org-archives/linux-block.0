Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93D40861E;
	Tue, 21 Jul 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615035; cv=none; b=bKGIchXpoMY5e7pnRJNN9w630oqn9L7v54ezgedLZXCE5yhe4JaSZF8LZfcwnCG4rS7SlPkM1NRmWpMfxblC3+Rci+ZHMsF+hnyf1c69hxe/sLgELor1B8U9CfxvjTUvpyQnLVEJRJT+aoCduYhGtDa0TnQv4Dp3IDuk8K07iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615035; c=relaxed/simple;
	bh=I0oOUGx29KqvQ3e1WFYBDgKPo6BQsbw4m0mHpB01rPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1sfYcuD+0su6oSXPJiDNp/KNZZwZKlNeMUb1Ihi586AmLxsLq2tQBM6ylinf0pkxiNtKK5B3A9nvxBp88sawa8fTPW/DKh9aLzfehRkCHc6fV364QscoHrMvAAYJj0ThMoHW7hNbPawLdE4BIy1bgszLA15sW7ZR/WIC4/7I+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=ccdEpHbo; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="ccdEpHbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784615031; x=1785219831; i=laurent@vivier.eu;
	bh=I0oOUGx29KqvQ3e1WFYBDgKPo6BQsbw4m0mHpB01rPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ccdEpHbo8QRThg/id4mauka0MqCyEOSUnF7UnPSf6ttr0IAedDCbfBUt63X3Cp3/
	 G16KmF9owBXot/C6PGwLOGgnMdBqeI3UREyABTYayx/grh+mr+TBxduyNLLpgJmgC
	 f4s8BzxTdynYKk/bhUpErJtAbDFpUMjpkCrbSYVLOqpMj+bkGv/ddRcV6ennyzdwj
	 O3vLE2aiVbOkZq0k8oYi3OfTnWxcwDAh28Ye+VamsqUXNOuN5auBVQiv/WcnRciyG
	 yrWSv3G068DpjMmO0uoBkjGRI2i3BHnr52wo3Br1iWOzsFQzAS0jkJ/I8/TJidB3K
	 ZBkwU0ulOajuJgopgQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MNso2-1wNvId0X7Y-00X4Bp; Tue, 21
 Jul 2026 08:23:51 +0200
Message-ID: <e4544f42-df6d-49b7-96ab-f0235ff67f7c@vivier.eu>
Date: Tue, 21 Jul 2026 08:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/31] swim: Assert strobe with stable outputs
To: Finn Thain <fthain@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <998aeb6ae4536503516df34ae38709835c61c8cb.1784196135.git.fthain@linux-m68k.org>
 <c71fd9de-6379-4d45-9443-b3036aab889b@vivier.eu>
 <cd820359-cdd4-de54-d397-54094f6571ca@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <cd820359-cdd4-de54-d397-54094f6571ca@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZQd8IcCYdulDstkdoQkdKgj7bfo4Zuf+OnSq4Bax4oJuM27TjJ
 cBFA7pV0d2tLaXKPkbMDGtFLfjaEwCw20BJvtcst3JpKmx67YsBuipOqZqTTWGypf8842yE
 UXxiC4ysXZ352ZFdA3uOwn5y8Ur4NSpNiGih3jNJ30NZAMSO//v7J6djxNiZye7Mir8iDdU
 OxQb4ind8bJuUaPidJpGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+TsHAN/X5j4=;Bj0BuxBtEjA12amtFw1y2xDWuMj
 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
 =

Le 21/07/2026 =C3=A0 07:41, Finn Thain a =C3=A9crit=C2=A0:
>=20
> On Mon, 20 Jul 2026, Laurent Vivier wrote:
>=20
>> Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
>>
>>> Keep the four phase pin directions set to output and hold their levels
>>> constant during LSTRB signalling.
>>
>> Perhaps you can also add a short comment to describe the changes you
>> made to the defines.
>>
>=20
> Can you clarify please? I think what you're asking is, shouldn't the PH3
> pin be an input when it's not being used for LSTRB signalling?

My question is simpler:
You added the directions bits in the defines and it's not clear in the com=
mit message.
For instance, I can see you update all the defines, but at first glance I =
didn't understand why.

Thanks,
Laurent

>=20
> It would be nice if we had specs for the relevant FDD models, to show th=
at
> no FDD ever drives the phase lines. Then I could write something more
> authoritative. I don't have that information but I do have the chip spec=
s.
>=20
> The swim3.c driver never sets phase pin direction because the SWIM3 chip
> doesn't implement that i.e. the four phase pins are permanently outputs.
> Similary, the programming model for the IWM chip offers no way to use
> phase lines as inputs, AFAICT. Same for the uPD72070 FDC chip.
>=20
> I will add some of these observations to the commit log or the commentar=
y
> in the source code if you think it would help.
>=20
> Thanks for your review.

