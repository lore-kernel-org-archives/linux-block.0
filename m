Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4321DC744;
	Tue,  3 Sep 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395489; cv=none; b=lunR1GFplovDrPUiBjs2SfIbRzwsNJB5I1SKV5afV40T9OqpJ1+v/M4klSm1EkQnmYY6AlVtbTGGX92g8e+mlX4SYdsPCLuOaQT1O2t5ICjGhI89IweyBHUQlg47UUQ1N6S1+Kw4zSvjJrdsBakneLdMADhhcMN8oT/lUkTnevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395489; c=relaxed/simple;
	bh=GnnY1kSjgK2j0YgiooDhM3c2rc+AIMjI09O9p4swkYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e01KXTKMTMXnDxip7zUAWVf3XFqkoMvr6/GLMYgOGF32T/JcRwAL4nTFw1wUNBv9H89uXZljDDJ6KlAZX4wO+fp/ZKfTXvI4DRUJKsJzrEsZnlrrcFIkqs6SagS0ut/WvPG9O7t+uN18mUAF2CsH9C/KSLKRKmrtmCDMuMliJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e03q5/UR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e03q5/UR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-715e8d7b998so337346b3a.3;
        Tue, 03 Sep 2024 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725395488; x=1726000288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnY1kSjgK2j0YgiooDhM3c2rc+AIMjI09O9p4swkYY=;
        b=e03q5/URDayji91CBQjUcxyDrUUou0H4AaKOmpfG9rg55K/lQrPys35g78qK3Ag5hT
         OQ98mbceptB+Ll2qYfTTUhXt87nCkrMDDZUeGqwxHmrdyYRATRLJXPBGDuCUQysWApu9
         89u+vL4n7vj86GqVSBrZf4Fui19MUysFhky24inxYJDUFzfEcwhTw6JJ+KruV+JpVLlb
         vL+tPkai/EzT/rnSMFjNrh+mk1LldU8UDGMR2gRQrCJizqO4g4MOSGTLkljJ8LymsYSS
         gN/qGWgL1FNH9UWd7wyVu4k/BoVmHd+c9jAtJG7qNPVpXsKFMa6yvFPwrj/e4VPO2+UL
         bF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395488; x=1726000288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnnY1kSjgK2j0YgiooDhM3c2rc+AIMjI09O9p4swkYY=;
        b=B0I/Ht315o552I2XHfOldokM9r1YE7wkfonxwWurD/k8D+i6dhQU26Y6Tq221Wy+xm
         QVOg6c27SfRPDHQMLesObgh5Yb9WitQ5ngRukK2XSGTGcpXx4Iagt6i0W7S93s8adH2S
         4GWl+qKd2Nkheq1BoQGo80XSrhE8jFOfKdknZqslbqpCCi+ty/El89J+KcUcY6c3tSPn
         o0/gRu2tFo07WMsafKcba6/x3wlfmMAPNyBYQYqIIzWljF9qQKnJg694FkNbzZJQBFM5
         3fRCIqOPIVrJgpSQQQDyLly9YaJGaW59QGH5YrxGjRi2n2uW8UONvK6Zl8uTBEW/4FGz
         pPaA==
X-Forwarded-Encrypted: i=1; AJvYcCVA2puKPLvS2BfhWhWtBcaJYbmqOdppa0pEVtWjcxtBW41PECKayDy1unRHEZsNeRDtZwP+C1z8DAx0UQ==@vger.kernel.org, AJvYcCXXbdWq3U8Cj7v3CaqkcM8Uo7ff8ioLRWwBD9VIQMGMiKe3hbsJaz+0BAp4CLzWfD4hnrCL+yNYmx5JLaUzyUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VWh9ApNypg14nF3Dis4Tm5mgapQyF5uwANIpQi9raT+Wrrvo
	DaZMo/2ylCr+/iYnotR58fomRSEEnX5D9kk980mIPa5DyrIEwxF0Jbitwr9tD95qhghgGGyzQP0
	DDUlqW5W0u8O3QRN87/voK9X/z1c=
X-Google-Smtp-Source: AGHT+IEIbxFPf0SLExVqwnqKemHBfSlGnFP8DbH5+OFVd4WZYC3NOwLLgkaTIhlALkUnZt0Pjfa/6KuwWAAe6tMNbYQ=
X-Received: by 2002:a05:6a00:1a8e:b0:714:21c2:efb5 with SMTP id
 d2e1a72fcca58-717305d65acmr8908273b3a.1.1725395487724; Tue, 03 Sep 2024
 13:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qwaxtsd.fsf@metaspace.dk> <Ztdctd0mbsJOBtJV@google.com>
 <CANiq72=GRbxY=3-NP6RutcJjCqRxRftafVZqDD73tureOh20Ew@mail.gmail.com> <ZtdnuH9lWtsPCg-X@google.com>
In-Reply-To: <ZtdnuH9lWtsPCg-X@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 22:31:15 +0200
Message-ID: <CANiq72n8-Q04P69uLCan_zuNVy9pib-GXBbQt8d+NWBoPjacyQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:47=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I was talking in general, not about this exact case, sorry if I was
> unclear. But in general I personally have this issue with Rust and to
> extent also with C++ where I constantly wonder if my code is "idiomatic
> enough" or if it looks obsolete because it is "only" C++14 and not 17
> or 20.
>
> With C usually have no such concerns which allows me to concentrate on
> different things.

Yeah, I see the concern, and I agree that C++ later standards can be
quite daunting to keep up with (and especially to learn new pitfalls
around UB in new features, e.g. C++ ranges).

With Rust, I think it is not that bad, at least so far and especially
for minor features -- generally they are well thought-out and fairly
regular, and at least for safe code the UB worry is not there, so it
is easier to feel confident in using them.

There are some major features, like `async`, that we may need to
carefully consider indeed though.

> I think exposing documentation for private function that can change at
> any time and is not callable from outside has little value. That does
> not mean that comments annotating such function have no value. But they
> need to be taken together with the function code, and in this case
> Alexey's concern about comments like "this increments that by 1"
> becomes quite valid.

To be clear, we are not exposing the documentation in the rendered
form for private items. It is possible to do so though, but we don't
enable that at the time being. Although I think it would be valuable
to have a "toggle" to show it.

I mean, sure, for private trivial functions, it may make not much
sense to add due to the burden of writing and maintaining it. That is
why we don't require documentation on private items so far, but we may
want to nevertheless in the future for particular core APIs (so we
could enable it in certain crates, for instance).

Thanks for taking a look, by the way.

Cheers,
Miguel
