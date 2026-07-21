Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E65434E3E;
	Tue, 21 Jul 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620099; cv=none; b=DzcED+4lJU6ovhw/RhRG6Fwyb3kKhtiSyxmi4I0TntapqebqimA7HfJXt4dWmMiDlqj76xLxTRilc6IEfX7MpOkQfIUjMbbI342Mv9GDuDgJqIFzp8AYn0eXezEdwxX3yHbxZTUDfj4aZdKPiI5/mUH+OvEa3tMnPURMw4Ru+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620099; c=relaxed/simple;
	bh=YNcD2Q66VAPG8yQ8uoCnJquI+JoNjajtqZEP8E0U21c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXWnpYs+2dtT0gWsooaxUlWiLA3Iq7bcbIgPpVA1fJ7voc9b4RT/zodapn5HHftooP+07tnOFflmfv/wx6xj2BwWwskpbWWo47ivHkqxWvawq6zr4w/RmeyEzScPyqGqqOF26uA74+LC5qpgR/4TgIGiZMgK4qQQabxLc/YIGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=Uz2CMVtX; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="Uz2CMVtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784620093; x=1785224893; i=laurent@vivier.eu;
	bh=YNcD2Q66VAPG8yQ8uoCnJquI+JoNjajtqZEP8E0U21c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uz2CMVtXM1tgWE22sjgGYsEMjpNpTyR2SaqdacjcXyJ18bOvkbe3sTg90xbQuf3o
	 26iQvfHkJSR8P/OvBfpWEfF4flY+Tk2B8Na5862RS+KOQoXFEJU5Uqv5tkHWnURdG
	 E+5E6p9vcYJDJV97PoQ+h786dauWizeJ+9He9H6h3+Fd5l79MFDTEqqHUf1LHA9uq
	 yP5HHUt5KLj2ItcsF1XM2gAYr2usf0dK4I/u5WN91AuiwMHphouR9fyKOEKd2z1qx
	 x54o+pN4qqReK7HA0Z+AKvh2IhWq4iTN5OrkjSxxYPpMaOC4egFZCuaylLHfTCZM4
	 5P2G+uqvTPaq8INOhg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M8yoa-1wg33r2902-00ErRv; Tue, 21
 Jul 2026 09:48:13 +0200
Message-ID: <3d55de4a-3390-442e-8b19-0687f881d62d@vivier.eu>
Date: Tue, 21 Jul 2026 09:48:12 +0200
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
 <e4544f42-df6d-49b7-96ab-f0235ff67f7c@vivier.eu>
 <d4e1e9c9-5649-d27a-8893-87a22c4f81e1@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <d4e1e9c9-5649-d27a-8893-87a22c4f81e1@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WzGpiCwBsMZnBvZcgFd1pCHkA8lI38cjYjHvwIKyG9WLDuc2OC6
 pDRoYbw0Qgvt1mgqwO0stzPPPNzTWVnJv2jXkohev+DCI5naLfGsBVBVSeUfw3HdwaLqHLi
 i2rkdc4/uLlFfWOcmXMC+MIeEsDLyS6A06KmfPreCWRTku9RjsKTSneSxwQtGORMt43Rl7I
 uKCvOyWWWEn6Gl6MszDqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jQhmmnF9dRc=;UGFvitVvTQE38BtunBfUkX6VcRp
 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
 F1tSay5doEllEDUK6x76wejNzxStU=

Le 21/07/2026 =C3=A0 09:37, Finn Thain a =C3=A9crit=C2=A0:
>=20
> On Tue, 21 Jul 2026, Laurent Vivier wrote:
>=20
>> Le 21/07/2026 =C3=A0 07:41, Finn Thain a =C3=A9crit=C2=A0:
>>>
>>> On Mon, 20 Jul 2026, Laurent Vivier wrote:
>>>
>>>> Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
>>>>
>>>>> Keep the four phase pin directions set to output and hold their leve=
ls
>>>>> constant during LSTRB signalling.
>>>>
>>>> Perhaps you can also add a short comment to describe the changes you
>>>> made to the defines.
>>>>
>>>
>>> Can you clarify please? I think what you're asking is, shouldn't the P=
H3
>>> pin be an input when it's not being used for LSTRB signalling?
>>
>> My question is simpler:
>> You added the directions bits in the defines and it's not clear in the =
commit
>> message.
>> For instance, I can see you update all the defines, but at first glance=
 I
>> didn't understand why.
>>
>=20
> OK -- I see what you mean. It might be more idiomatic and more readable =
if
> the the pin direction nybble were defined in a separate macro rather tha=
n
> baked into every macro definition. E.g. #define PHASE_PIN_DIRECTION 0xF0
> The writes to the phase register would then get a bitwise OR with this n=
ew
> macro. Would that work for you?

Yes, perfectly.

Thanks,
Laurent
