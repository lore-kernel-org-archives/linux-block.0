Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDA58234
	for <linux-block@vger.kernel.org>; Sat, 27 Jan 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373203; cv=none; b=Jj518fWNdGaO5Gph+AAa7yeNzwcOYioj/oI3h4DfO+QW1fnGMSd2ZgsbdZhzyx8OUvkni5sUpBj7xnlGtMX4WAQ8Sttr1aii1mFWSqG3OqbA2WxD/h8LIl8Ell5I8wgiwZJfHyiZ25Hqb1pmnYxs7fJw+ow4n5cdgcQvMKTjti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373203; c=relaxed/simple;
	bh=rH+U8ulfu0b94bLtRkNZgQ9K3uCiK+iHG5E/iAEfEjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbZNfOt2IjNDW2ydZDe17vSF27Au9bJsBwxr2yM6RVO7lZ3x3dsP9Y5uYPYWawelqOCtcjjaius44BcaRJvSADYgbTn7ALxgy6xsfG5DEkQpJ7RVtKVNUyFeowb7hZfmcro9yNxfWbudcDrtH8y2gmIyJMBgx+uSgj1GhoOyb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8qfjDiH; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8qfjDiH"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc223463ee4so1701244276.2
        for <linux-block@vger.kernel.org>; Sat, 27 Jan 2024 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706373201; x=1706978001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKRXDMTWaMbRdB3aDezqSYtFt406n6ZjmU9GbES20TY=;
        b=f8qfjDiHJxr2mmMAGeczrJSYzB7c5XTmewaPy55ihjoQIEyoqc1UdGqqD4tfBxh/Ro
         /PsLNPUeNO8JCpWgtg06iQXWoR06istMK41dBtqFf07ku+j286xJqIt6YGk9/d9pX+wW
         4xtKDYi0OD91jFFkkcPF5R8T2i7yMXFHBXLYmpuTl7rvR2cMnkQ1cpd8kx2fAv6q9f+F
         Zh97wxkXez66W+Qwzta/WEX2cx6hs8OKEZiwAFTumgoQQKs3bVAaYzoSboHulH3KT0sS
         CoQy4g4W9PVWwvzwCaWsn+UN5d8EzDgVKkJpVAQLCXp5SGRqDtsDoeOhMMLfwFAflA0T
         WTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706373201; x=1706978001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKRXDMTWaMbRdB3aDezqSYtFt406n6ZjmU9GbES20TY=;
        b=J3lG5cMUQSBBjd8DgUxn5PHsJL0Y6yuH+a5UTTds/HUTIkQkPn3wtALK8uDAX/q1F7
         XKOrDAIQpr2TTkN5VL/UU0NsUCdDotfX5MuW/aIn0UqToLP68RegzsbT5/c41idShfpK
         3a3xIrHPp4cJFWvwWARlULGM4ARXvzk/ZbNUnOybl9/toil40K5meNR9EEDnEieWX2Ih
         rVOqQs/81PPFAhAaZHR9N+/jRG8hn/S6bWBr/BrrYAL4F/T3quxH67Q+YPork3j3Pzrh
         uvtilmjGo2yaL24NnjgDw+0o0SYodnh90GgZHphXV+BP6oypTVzkHTV9LNoL54ZnYNiK
         qV5g==
X-Gm-Message-State: AOJu0YxNcJ+izi2Ir0G6iXq/vyrrlywpzYaqyCG0N3zKBFZaOOBZZike
	bPo8vq2+8TPkScO48XRly7791xqkU1o5hQCaD//RqwX7gsVpWyDsvC3KtepGSkHpmWFRBDGXG6Q
	TzUvkLElsM3j+AX7tbCgPJJ6t3e/ciQU2bitjpg==
X-Google-Smtp-Source: AGHT+IHGlAxiT3bLqtG3iaC8zI64NZ8sDdDFh3G47SdVCX2ok+2VDBwmvCiXVHhM77A4uaBLvzlfOjVx/TkMUTB2/CY=
X-Received: by 2002:a25:ad65:0:b0:dc2:297c:77 with SMTP id l37-20020a25ad65000000b00dc2297c0077mr1323719ybe.125.1706373201113;
 Sat, 27 Jan 2024 08:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
 <20240127-mmc-proper-kmap-v2-5-d8e732aa97d1@linaro.org> <qr2sr893-775p-9770-2441-4o02qqo105or@syhkavp.arg>
In-Reply-To: <qr2sr893-775p-9770-2441-4o02qqo105or@syhkavp.arg>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 17:33:09 +0100
Message-ID: <CACRpkdaXc98RkxRp3tO3yXYdGU3psnRQ-ZW0-hmMO0wzbBt+dg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mmc: mvsdio: Use sg_miter for PIO
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nico!

nice to mail with you as always!

On Sat, Jan 27, 2024 at 4:51=E2=80=AFAM Nicolas Pitre <nico@fluxnic.net> wr=
ote:
> On Sat, 27 Jan 2024, Linus Walleij wrote:
>
> > Use the scatterlist memory iterator instead of just
> > dereferencing virtual memory using sg_virt().
> > This make highmem references work properly.
> >
> > This driver also has a bug in the PIO sglist handling that
> > is fixed as part of the patch: it does not travers the
> > list of scatterbuffers: it will just process the first
> > item in the list. This is fixed by augmenting the logic
> > such that we do not process more than one sgitem
> > per IRQ instead of counting down potentially the whole
> > length of the request.
> >
> > We can suspect that the PIO path is quite untested.
>
> It was tested for sure ... at least by myself ... some 17 years ago !

Hm, on the DMA path the code is taking struct mmc_data .sg_len
into account but not on the polled I/O path.

But I think sg_len is very often 1, as long as the memory isn't very
fragmented so pieces of a file you read/write are all over the place.

It needs to be tested under high memory pressure to provoke errors
I think. I'm not sure, the block layer people may have some secret
testing trick! (I actually have this hardware in a Kirkwood NAS.)

> >               if (!nodma)
> > -                     dev_dbg(host->dev, "fallback to PIO for data at 0=
x%p size %d\n",
> > -                             host->pio_ptr, host->pio_size);
> > +                     dev_dbg(host->dev, "fallback to PIO for data\n");
>
> Given this message is about telling you why PIO is used despite not
> having asked for it, I think it would be nicer to preserve the
> equivalent info responsible for this infliction i.e. data->sg->offset
> and data->blksz.

OK I fix!

Yours,
Linus Walleij
