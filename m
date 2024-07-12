Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FF16F8F5;
	Fri, 12 Jul 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806823; cv=none; b=hsO7e1PEqY5ZDHK8DP4KVTkhyq0KZtyJwzhKIrXGwS+Xyg3XhOKkELyqGLxK8++FAovKlhWUeegXxU7Z3vL3Cg1+j1ugE6zZZu8qKQmCi1hL+wqIDx31P/rFKZbf3r0jFyKb90b52txqsdyLPVj95uMBetAignq9KKynPE/rTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806823; c=relaxed/simple;
	bh=6XXrmX7z0sJhUPuzc/d7CRMR71UcuWhAgefjKvfTRpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm+nb+ySiIH+F8dveMQ69kBJxk4X5m65auLC2yh419zbJiu3fxUwCVnLnVPbwGaqiGCAzaDrRSyj02FMHUuJwZLtGiiQKr2OYfmKcf0PPv8YQSr6gCt9ru65b1qj1prPsTlxMMLJeuNWTIGXIUH4OC4+loaEt0CzmPFWXAdGws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=U+4CyYIX; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="U+4CyYIX"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WLK2k6zNPz6CmM5x;
	Fri, 12 Jul 2024 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720806812; x=1723398813; bh=Ui5K+5Z74KfkcStMuHfzuZ36
	85TuJxJZarO60+eBfz0=; b=U+4CyYIXoyVhY/dnhefBF2YqA1u8h8IbgtysjcnP
	Fku+K+aS0zkEjzPidqFUvZembJVs/UFSO2SfxW4vTgRMw8CrqqJlgmFnchNM5zvH
	5T1IV6oxL0evslAppERQTmFxQAcXaOBxJiZDayeusHz4kiDEhwxxLDs51fkO10yP
	T9Qlhd3PQz8re5eyyrqRD+nO6UCBZZ84Yc7hCfrE6ykikBJs9mT1UK8/710By/Bc
	j9OB2wnprIgWk/H+beIB0g2J59mYG2MImJrvA2DftY6SFXdr8ndpVp04G+gHuO13
	Flmh9RFaLF6RT/RkoGREVv9DND7z9oGRsk3mMW2fPGbV7Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ghXhushBKFiw; Fri, 12 Jul 2024 17:53:32 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WLK2d6rm3z6CmQvG;
	Fri, 12 Jul 2024 17:53:29 +0000 (UTC)
Message-ID: <293dff44-8ae2-431b-a002-b31a09ddd34e@acm.org>
Date: Fri, 12 Jul 2024 10:53:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Ming Lei <ming.lei@redhat.com>
Cc: YangYang <yang.yang@vivo.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240710065616.1060803-1-yang.yang@vivo.com>
 <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
 <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com> <Zo/gevNqftePGvic@fedora>
 <6acb93c3-f11b-40a4-bec0-b17fb77ad0c9@acm.org>
 <CAFj5m9L2qin-h1qfPbhotSr-2Xh+mnQbsWhpzeK3dA_YTQ=JpA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFj5m9L2qin-h1qfPbhotSr-2Xh+mnQbsWhpzeK3dA_YTQ=JpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/11/24 6:01 PM, Ming Lei wrote:
> On Fri, Jul 12, 2024 at 12:33=E2=80=AFAM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>> The comment above 'swap_lock' in this patch is as follows:
>>
>>          /**
>>           * @swap_lock: Held while swapping word <-> cleared
>>           */
>>
>> In other words, 'swap_lock' is used to serialize *code*. Using
>> synchronization objects to serialize code is known as an anti-pattern,
>> something that shouldn't be done.
>=20
>> Synchronization objects should be used
>> to serialize access to data.
>=20
> It can be thought of serializing UPDATE on both ->word and ->cleared,
> instead of code.

It would be appreciated if the comment above swap_lock would be modified
such that it reflects that it serializes simultaneous updates of ->word
and ->cleared.

Thanks,

Bart.

