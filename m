Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A23CAE9F
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426142; cv=pass; b=W290iIirN4L23Xxee0GGPdpu4/TtT0V7gLzEiWY7Jb+ZRsf2cTWmCpd9TZoqpyKnoeFGRfUJ2ydnPy8A5qDE8a6tW/J0jlbx18T/kbB1yU4JuJ7hCNRF6QgKuSsDmVZVuP0q0JquY0KB7PGezjx76iifruSZ1kGta7487kV4gQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426142; c=relaxed/simple;
	bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSYkfdaOWKVT+1bs5EiQXa2rQrbSOu0Yfz01MlP1t8rMpZFWyiy0T1hg7RGvHwdZH65Rj3IM7WglBWyC9WX7TPgHSMk1twPFbA7cUN7+DyHYhbgYws2/4l9OMZ+Ve08bX6kYR3Tlkl8UFy5cfBKYbt3Rpa0rVCGfVEE7YQV6u1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vtv3gQ0z; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vtv3gQ0z"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-415d7461fa5so243280fac.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 11:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426139; cv=none;
        d=google.com; s=arc-20240605;
        b=gfihnu/ml2q6p4EV0VdHClZgoSiWEdHIgHV4mv/SX1NkXNU9WSXe5h8cKql5LQx7LB
         abC/HDHVlOueUsie82t3+e9cAKb1YfcafXXlE0KtqppZflnF40zixP+Gv2BTnCPlW3zu
         41wc5yBqe/a2sQ1J932D3wlxDjHv1T5Y5/D4yi7tzr90vzOI4veuIzCj45QLbQCFgxus
         xibniOQqstwNJfVZ32iTjN9ku6YhTMAxvkT7tfVKVss0rkd/CS9xKikR9pokFeZEsjHU
         EahAPSIygNbdH1s+n/1AfP3DRA34U2tpkaubnjHoumj0q4zy+jnoHrIEaM6GDpMRy4jU
         +rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        fh=1oIXcRZEe+yWC33rHngaziiyYmF2EB7s7+/mp3jUx4U=;
        b=VCwDY/q80sgKjampEKGpS0ixjM0GDKzn4pS5OhVySswezSnGQnamn2Ot2Dr2tttJbI
         JUO6cY09hsZNrZz7+mKrehuorGLDPpj5QLKdIWRHJgBBzW2XOGPkqMCKo98fkY8drZ4Z
         X7JhsqcbYOftBtGAOVHNEZpdfPuuNGKtvJuYfA/h4jiqEuovK2Ql9m5W7mHCu6P4A9/Z
         khTXaqmGfkBnFPTn5XNA/3NVioJmuism4f1YPRKPpMvB+Bg8Mm9pStDsc3KVzD2WJGRG
         +9i4IiAXzcNcLhSQuO2MOvR3RWJbYNBQ7Xf1Ub7Edk1nvTPU4pM1fYsRktOWhlsoSZAf
         tSyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773426139; x=1774030939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        b=Vtv3gQ0zvcqdKYIwr/6c6pP+UcxA4f/9aUMqDN2FAq+PHizsdaWLu9Iair8h1pHBrU
         NjAcvgBOmB45cIfsYF/00yJokd1n4dGu2RN/E1wV9+d8v3Y4wuoeQ35c40wutrOSpyzb
         EUfLlPsU+Lrt0QAwRhcWXK0DxwRPPK0EEjqwqU8PenIp0R3XbX+wIwZBLVvc55RLU4d9
         P+Zzv8DU5ezZX9dw7t+tKC2RwKfLh5V9Lk3jYsIMw/k+I4hMFC3u3hOAy3FlgLPPkGje
         f+6FvKGv83wB2AFq69fNZSlK6cVA5N3CXrkqggm+jOlKOQHanBJrnq8gaDVhUBWFomrA
         Aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426139; x=1774030939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        b=XiGnuBo3KGug+jNB9GhJQ3MdfZbCkbGBFDNnqQD0B0VrYKFS/W2puJoU/vt0YDVWwl
         NYMVXfTx38R5g0J/+f142LfC7zrEvLrnmmMMOdGx1Z79gOAYS3Id38JGCK025X/umUpm
         7KeM+pid7nZVPGe95i6We1nqFYcP5/prssPAKTsn5s8LKVULCJWOkkjqmWafiNPMmxPo
         2rRKSrt9u+8SzXI0aRJT2N8buQk5fla3lXl9Y8S+V305uCRGjlPtnI9YEi70HCgo8Ned
         IeI4g17w2fgft69goPh23V2A5qBoNe/GtHQ3EkYyYfGzMOV9TdZpov/5csYBi2uwY5cO
         uYxg==
X-Forwarded-Encrypted: i=1; AJvYcCWyT5itQJB89Dp337WCA8/RaYujmHYZuQgCkB1wPqMCWA/PUZQdN/XRck8iTFWrkxl/nJJ+v8B3fD7HBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vyIG45yGuTsUiWSgn9FUevI1R4zyn27Nxpo4rfq3Jezs4dpj
	FXB6GT3nSAgVe15LhUhaoI1A3xjS6/HLH6+mBDjTRj3KP0UXL1CcXCLg1MrXkpOosV5QjKVEGh+
	rgwQM0ZioHkgvcqkhhiQpjd5n9PKGYXCbefUDP/kmXZxizv3o6a0v3Gg=
X-Gm-Gg: ATEYQzzcJa0lvDQq2Mij9JUp/8hx+ieycMDCGV6BLjA7DgsajLcXzgOV0f4I1Ez1IWO
	iVcYh5Z6Ar8epWaK44tgfOXOs/KO86SoQgJuCOX+0Thj03p0kwCDOAb6Lm7YFFUFXx8ZUUq7wSq
	boWYNA93tUTl7iFvIHARTMC6tzs29EfW4YwVaFobR+otPPCfBBH+My43FtIfSkVNSh6g3H9gB11
	Gw2vBGNdDDZtXKrheVzJCPmzdNGgnfcY3V35T6akuHMs00Or5gR+6oz/8YOcQqr9cHPxi+vNHDH
	Rd83MCOtl7ZQiMkyy/w=
X-Received: by 2002:a05:6870:212:b0:417:1a62:17df with SMTP id
 586e51a60fabf-417b938ab11mr1856263fac.3.1773426138746; Fri, 13 Mar 2026
 11:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313181038.30018-1-objecting@objecting.org>
 <20260313181038.30018-2-objecting@objecting.org> <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
 <90C824E0-8930-4D34-8615-B9B31D6C867D@objecting.org>
In-Reply-To: <90C824E0-8930-4D34-8615-B9B31D6C867D@objecting.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 13 Mar 2026 11:22:07 -0700
X-Gm-Features: AaiRm52kpITTsI-Z0ptaxKiv_35njfM8mw9op21OEr6w7NRxh0wbj_PElsIBnRc
Message-ID: <CADUfDZpe1M1f4MFtM-imqw=L4P+rfyC264ASS+5z4SvO7AL5fQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] lib/iov_iter: fix missing allocation failure check in iov_iter_extract_bvec_pages()
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:20=E2=80=AFAM Josh Law <objecting@objecting.org>=
 wrote:
>
>
>
> >> Signed-off-by: Josh Law <objecting@objecting.org>
> >
> >Don't think you can object to the Developer=E2=80=99s Certificate of Ori=
gin if
> >you want your patches in the kernel.
> >
> >Best,
> >Caleb
>
>
> Hello Caleb, I have to ask, is this a joke? Or did I genuinely do somethi=
ng wrong

Is that your actual email address? objecting.org doesn't look like a
real website, so I assumed you were indicating that you objected to
the DCO.

Best,
Caleb
