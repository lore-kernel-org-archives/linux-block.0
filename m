Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3C49620
	for <linux-block@vger.kernel.org>; Sat, 18 Jul 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399237; cv=pass; b=nXd8yG1uc4AoWL2XhJF9ZiR97R2b9sGQmf2FVurkZKaUjYewvC+Z/CHIM4zHH1qHY1sMDoPKYoSKPf/wt92h2xFxnpcok08SPotwdkvKw1OSL28I6AlN/jg8kwnJ8WqL05ei9jkuiandj8Mdk+rOLN/iOHdl+lEnUBIaqlL0SZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399237; c=relaxed/simple;
	bh=AP41tUx195ng9TgT6uzGyVV7lbuXENWF5xVRR8LXTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy5KLLz20IM7qGaSD9Z9PAQ5xcgB14BPtYfgLw3XkJBTrqIO1unSW+He9AE03tl7rr3vibZC3xpHnlJAgaFgAIK8CMGqIRmgynw+98v//PAwQPU2wYs4X1zZOJPYEu618orqC6ayMWGS4fVAvA/N/dHa19XLoUflpyo4O12svbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amMECZXx; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amMECZXx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so1394630a91.2
        for <linux-block@vger.kernel.org>; Sat, 18 Jul 2026 11:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784399235; cv=none;
        d=google.com; s=arc-20260327;
        b=ndMBFXIBQIeoiXFwuALppbYN7dG4znNHZXTuCGMzyc196sMTD4VKTkMTE5J1+Z6qev
         UrwIsyCQnntC5pL6Rk6YnGn7QiDDj4UblRV44qsk3iIjkhojaOi4Bx3vbLjsmd5Wc9cP
         Ki/kLDVA84rKreCT3xlL6LWUVuLTRQaXz5Aa9QkanGKUBH8gDia44K4BQKj9Hw3sn3tH
         nCVJ7/O3kqWkoIBKX5q3low0ODxK5gcB/BiOl0wiDjT4iM18lCEY2xNxnJqbbQEeAXNX
         mRkUyix3DovvLeVbe7AKaoXwOkh2Ex5INYbdkABzP3MSq25mZ0LuN8lys5s9gm1FQGQs
         MWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        fh=Av70Fy7LCMxJsJ0NKoXJJ0W6N9J1lIoITAo5k4Pfvfo=;
        b=K0WJ2GnumTLF4HOnz1fG9v3wNNMmqXnbg3vTTBM6/axTvDQNSefVvSR9HR9eLqNvPR
         dKBcNMaPSNpImYXlid1kBTZsJr1y1/wLhI/ZJ+pQbPa9TvdqOa593eEleRwj2SzdEEli
         D51Nbxrzqb03Lb0fPKc9DLP7ngegS1DbMPtv8lY0nh+nyMrGjRH3MJeV2SDeKjbuADSE
         PMcLxFF9SY9msCBNyIyJ5qWI1ZpZHzakJM97Bhq/P53nQ2IawfAEknIhHUuuziMTtPOI
         WrYC4TvRA27fZ2spcR1V+vLD6VRB9WEOZjlfNbJESluazEu0UvKiHHtnyPbC7N6rH/dS
         QIJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784399235; x=1785004035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        b=amMECZXxDcVI/tDclwfWEv91FERjCewoh7Xun9jiWjXpgvbeX1dsNB8a2RjP7RieJM
         ZQlHu2E1Ff95i2SPMjZPmsbICL2QdSTVeiEJexhYZjQ32QGUYbKi1k7fGDHGmECQtaW0
         9P56H3gCFeuxsNnpindCx45z6d770aIe4NQwOPVPUR5D1OeKXKOuy6CcD8NVUfn4t4Zb
         kg2fMhYVoCQjS7lwLfFEvDjeKWX5isCyxbdxsQprVQzk2c+1UcRs6xvoQke+9QkBM8kE
         JZlmtPYuZsXM0W+v7fvwdXoVKnrAmnCyEnSeGHdaIscl3SawQ8FwNh7347MWklrFJsb/
         pppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784399235; x=1785004035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF1UqndvD15BxTbg7z5vo4szg71VyV/aIRdaOO6x9SQ=;
        b=dkUpVrptdV25r826AKLurarQSvHJRaDj6m//jevgI+q+/vIAqkWypVFscc+nLfefrl
         PdjSjwZrlZKpkBWfzkMApVbkBwhgZA26j90EXfIsUU4XPIZjzJnYlw5FVrK5k2e5TCkn
         5vVOVYTkyobinUkxYO7CeYOWgvQd5++RrJhrwMIRbtV245GsRPeeLuDHtcpLuYdFWdUA
         6X0AHF9tDJSt1x13KSWaIZC1M4jQfqrlgzMcPtNlO74sCZ2sHiH2v41y9eZNS3wpozcZ
         HFnvv8oOFkaKxPJMzvNUmCJUNhlFBHMhSdeoVnEyqPqoJjckbWo9ij0+4GrSkINdukBb
         erPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/5ETi/y2+KR/T0MJLeHBOuS4XUFlcf4pCC8Eoyft+tsD/2tMZ647O9XUmsOozGBRc4Mrm8EarXDUJSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWZSI/+zkDmhHvklF/E3qQMmv6P7v5yGD6abK4Bo41nJzCeG2
	rrlydW4rrko/U8yDjHGqvdv6fi4TAhxxZI4/sQk4zvZnDu49+kG6oNY/RxNvSDWGH2ZFzX229vF
	JlQvW/Hh5J6JoECoYMENJg+hLfrrehRc=
X-Gm-Gg: AfdE7cmo7IbsWVFFQLq3uqSeEG57o9zR3RL/dXTadvQ87129kVrFslJ+NvZCp+3Bw+s
	d3QmEAbSQhvGF68q05KpEGiV+SfW3NIkT6Ij75qXDMwa3ZRtABxDJfqZqcRNgSYWiBclb+l/rlk
	ycPjUr8MIJBCKV2BXfvS6PgNiO3w8DhowlHzBE/gytEH7w+VX+393LK2G4moKSmIWBCTgXy5QkB
	DZT5WfaJzQQjfz3H2G0pI7K8GIleilEf9uvOuqO1CxTJGu81mQ6MajNKQsrwZOTc3S2jiIAJmdv
	3dktvvytt2OiV6OXbL/f55oXtWfw/6c1dDJVsceycy7ToY2TptI9+DvBTU2jjoUr0dB3ffAhU0X
	C3g==
X-Received: by 2002:a17:90b:48cc:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38e4b45428bmr5637614a91.1.1784399235381; Sat, 18 Jul 2026
 11:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718182323.107565-1-ojeda@kernel.org>
In-Reply-To: <20260718182323.107565-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Jul 2026 20:27:02 +0200
X-Gm-Features: AUfX_mwJPjIV2cZCTnoVSTWE_fZLtIswk-O58QgDaLvdnhGdzF4gPg_mWdzIaoU
Message-ID: <CANiq72nLTuv2s71bNBVV85bTbWriiCdhG_O+-=t+1Ubv-sHFJw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: block: `allow(deprecated)` for
 `fetch_update` for Rust >= 1.99.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Boqun Feng <boqun@kernel.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 8:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.99.0 (expected 2026-10-01), the
> `Atomic*::fetch_update` method is deprecated, with the compiler suggestin=
g
> the `try_update` alias instead:
>
>     error: use of deprecated method `core::sync::atomic::Atomic::<u64>::f=
etch_update`: renamed to `try_update` for consistency
>        --> rust/kernel/block/mq/request.rs:206:22
>         |
>     206 |     let old =3D target.fetch_update(Ordering::Relaxed, Ordering=
::Relaxed, |x| Some(op(x)));
>         |                      ^^^^^^^^^^^^
>         |
>         =3D note: `-D deprecated` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(deprecated)]`
>     help: replace the use of the deprecated method
>         |
>     206 -     let old =3D target.fetch_update(Ordering::Relaxed, Ordering=
::Relaxed, |x| Some(op(x)));
>     206 +     let old =3D target.try_update(Ordering::Relaxed, Ordering::=
Relaxed, |x| Some(op(x)));
>         |
>
> The deprecation was added in Rust 1.95.0 [1], but only triggers starting
> with Rust 1.99.0.
>
> However, we cannot use the alias since our minimum in 6.12.y is Rust
> 1.78.0 -- `try_update` was added in Rust 1.86.0 [2].
>
> Thus just allow the lint.
>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Link: https://github.com/rust-lang/rust/pull/148590 [1]
> Link: https://github.com/rust-lang/rust/pull/133829 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Warning: this is a 6.12.y-only patch -- I assume you prefer something
> local like this instead of backporting the commit that made this go away
> later with the move to `Refcount`.

Cc'ing stable here in the reply.

Cheers,
Miguel
