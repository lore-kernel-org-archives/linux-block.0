Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795743276;
	b=Dh0WlSX3vw+0OVq038ectWO/1YWXBHuO1W5MsEcX+d2uNxiPGUGlAQ1XCJUpDT6hX7bW
	 nqI0oT6te+t59cCwp+1AfW0MESAPgo30pJCuaZT7p2Ggy+w4bJ/QJpjGAjRSn+djNyCgD
	 Ns0VkkZvsnbjnEXaQ2yiBoMAmalohx+HSQrN6JNutAIFClHUiM87Mu7Esh03UN4qdI4E7
	 PkxynpVqvBGkliZpzspVnws4G+ubDCvv7ZxgP2w6KBQtBKnfQuPTGtaG1ZTPkqA+XxiRY
	 cWt74zGkasg93zR9vDdrL87Uuq7lU/wHChoCCJHzM8hIkgC1GznRuDA+Szho1dl1UUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hU2U5lk2837LuV+creZT1TNKTOC/1AOVTgldGOkkXaw=;
	b=GVv8bgf9G5j1+7v2sUcMq+tGWMxgCtYZAaopFUd52Qctnh9kX9shogJLgvzRK9eZLXzA
	 ckK+luo4uaDSXeYbvxUPYnzddV6+B7XpSOVzjkfcRM8kDPhTUCuQedSP0psjAag3JAiZN
	 TkNyvae9ZM6d6LWKcUOHDQgIxMcaN1nO7RY1qsqAyFW0vdZzBsIVD4mWhOO5/h7ZwQGop
	 3eqg3qqbDy/BlEUy7LP2V1CI996VE0XnPW1PGk6NaCivKCSHrRq3LtAAifMkkFSF7ma75
	 wG221mK8WjhVMRjU/AgppS2+5GGvQ1SISqGWs+KKUrxyXiOQvNB4IO6syv3wQKlc/nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9jPlAPf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E9606A324
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 01:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9jPlAPf
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9213f004a14so93985736d6.3
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 17:34:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795743275; cv=none;
        d=google.com; s=arc-20260327;
        b=DcDXPoE1wQuone76WIBO/1qEJiYeaTWcf6wJ5F16YYriESSZAxdKnsRO3NQtl+QxAR
         uLe5FIIT55F7VPtLdzB15jUktSl8NZibDU8YjeIsD0dUpLq8E3FigaE0Rwstn5YGY7aZ
         GEMTwo0CFQkK8S14d8WNHLeIHuZcZTngNLeg1gAUINvmlH+3AT3sNzcLt3GLrt4yaglP
         6myUb1q3vGiLOYKkRgHbM//6GskPGMjq+49gr7x7qu098WdvmcKqlRVJVPtgCWtfmFrn
         sO4s8DewTb5lj/yWTc/bAVJdycqkClHNhF8cZr4PQDucbSUFdhHrRonUSxhUlKP7gxV/
         JIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hU2U5lk2837LuV+creZT1TNKTOC/1AOVTgldGOkkXaw=;
        fh=Xh/6nyMYLF9k8fXH9Z0GOVRhvaq83LM6i0omeFFr7sk=;
        b=HRIuk8EOZnRmH4UwSR8uTJFSfv5kplipX99OXVMvLm8yxIVCmL6G6pFSmQyS8CsXiu
         Qzx/olKLq7VjCglUM9tGiV1ipf6lNp/J3EX7+AC3z2U0O2DLE35wvU3uSAUeXeM8tLb6
         P1k1SoHSF7xFCSqJOpJj+pPHk2Bq20i8gtH8nuGz9gqs0T01aLHEhno24iqMisYm0s0v
         KjrFCXNU9Xfdsfcuf6tbRZrfcaH67jPGCOqlhQ+y9KVSHeuyoStLJw+D0UWKUr1j64tf
         iFknvCgDp1RWkZDERT0fMvorzVnEZnEs1e128IYZs1kcuwTgEixDTs6lZSnBDTdb9JiC
         KnvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795743275; x=1796348075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hU2U5lk2837LuV+creZT1TNKTOC/1AOVTgldGOkkXaw=;
        b=Z9jPlAPfbk11RA9ZLquc0hQutA2zNbigq3YWXDATzqziE2qrm0/T2BCT8UE1dGGhZv
         Py7XYzq309HhSZvBcQ6Z3S/09YJH+SoNOa0amq9U86WBx0G1Q7bj+UZFv5+oVbvqHcdG
         91JJgW0Qc7j6CpnhiO7VlylYkVuWWUKRSJYN/IFA2jPIdpgsns3PpwYNKs1kHTm/KPwM
         Cv+AGWCnatJOXWoBwMes4DY3EgADioFGvE8nYqS8udCNcXaVnp1XFqJcCEBeorvGZmwH
         tL9onYYGc0c8U+bAgZay58nUbfOIz6/7h831VhX0qxuN7J6FQqpKw888dhyp+jQsfiIm
         sjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795743275; x=1796348075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hU2U5lk2837LuV+creZT1TNKTOC/1AOVTgldGOkkXaw=;
        b=nqBIpX61d3OI6d+en5fsO7ttDKZN67B5Jf8tV+HmlLWM6Ht0tsfiOgFMGy4+EQ3scT
         Gt1sWCwpaCbfeWwxBQNhsxs1R8MwaUL7yS4wJnES+CLPMy9gy2dlUyupf8CCEJdhwg8y
         HaffnjDU62LV/fuVAJWMz80MOPgAifGUPpbNQrZZeKuceFshOcsLIpNUoh3fBZC7NSPe
         Dp4addofNVdrh38uBBr/ws2P6ZPO5nf+ByfKKFjchTTaNiQ3UE2mRs87ts6FMynFdkkv
         sQDbKbFOd62MV3WIoIivKGBE4DvlS0FIRb3K52fYYpLTPn3MHD0NiFT361B34F61mn/m
         NBnQ==
X-Forwarded-Encrypted: i=1; AL+hErESCJt98m9aDdSccfKCuQ4kS77vgnyxMzfkXUPlErl29lxJ+tCZV9xUEKaZX6HL7QI0JGvoU8VWjbv8gg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9P+m1ylVPBqQtaUJK7MXNxXos6muzXTwdlk2/v/enk1lqD2nJg
	JUHkJMr9ES8uJiEk6wkO2Ux1C7h3gE8rrLjCNZ/JGgGD+G+XMl16XI1zY6Ows6lqlyiLXAzv0qz
	uZF1cVVq9dCPNjAvMogTClQ1Y6OfKxu0rDL1aZLCq3A==
X-Gm-Gg: AZFdTZdKixN0zc3T5LubIbY/yc4TFn0TF9FmcZL91RywWi1PVr5A1EslCTDDW2yLFZ9
	8ajvzeU1v6ongndXQaU5BoaDZVvUHnsrNFhQh7FI/ijboICNRBzfolxMtho1o/ENGnzMXSv73M/
	uPWSFohexAqpwPvQIuftCmW51vE0b5N33APQzC244PuB6bn9KF0XLpAm9bd0hn5mvDSu61S71GY
	KvY9q98p4pspbNCoSu0RZL7tIaQ+oiZpiZaSlFQodd/6jSt5EUXOD/UepsrR+OrtH7uIju9eXpH
	7Mh/U10urPls29qumgs3jvYVkab6A9rH6tU99N8J6YD6QlDMrQ7y0rNhXoMNENTBateskAXZKYw
	eSWtqOTIy0Dax5ZlD74y3GHZUchCGJCFAipFz
X-Received: by 2002:a05:6214:5f07:b0:921:3867:1bb0 with SMTP id
 6a1803df08f44-9214220c37amr376789406d6.24.1795743274810; Thu, 26 Nov 2026
 17:34:34 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127004411.109585-1-artem122novak@gmail.com> <awjaHB2ugCG_F3Io@google.com>
In-Reply-To: <awjaHB2ugCG_F3Io@google.com>
From: Artem Novak <artem122novak@gmail.com>
Date: Thu, 26 Nov 2026 19:34:23 -0600
X-Gm-Features: Aa3M54r2A9iEKs22yG_w3K42aATDwZjN-MFk4H_IHS7ixiYAkVkVNmajCvdJ7Gs
Message-ID: <CAPufuhb9txcosy48VXtfxwnC7Ct448J=_HbR00JnZR1QG-NfHg@mail.gmail.com>
Subject: Re: [PATCH] zram: validate decompressed page size
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Sergey,

On Thu, Nov 26, 2026 at 7:19=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
> Yeah, I don't think we should do this.  We only ever compress PAGE_SIZE
> buffers, if some backend decompresses it to a something that is not
> PAGE_SIZE and doesn't signal an error via "ret" then it's a bug in the
> backend and zram should not cover it up.

I see.

I thought it might be worth having a defensive check here,
since allowing an incorrectly sized result to propagate seems a bit sloppy.

Do you consider this useful, or should I rely completely on the
backend contract?

>
> On (26/11/26 18:44), Artem Novak wrote:
> [..]
> > @@ -185,6 +185,8 @@ int zcomp_decompress(struct zcomp *comp, struct zco=
mp_strm *zstrm,
> >       ret =3D comp->ops->decompress(comp->params, &zstrm->ctx, &req);
> >       if (src)
> >               kunmap_local(src);
> > +     if (!ret && req.dst_len !=3D PAGE_SIZE)
> > +             ret =3D -EINVAL;
> >       return ret;
> >  }
>
