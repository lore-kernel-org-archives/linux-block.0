Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4092F4A07;
	Wed, 16 Jul 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669544; cv=none; b=JZKn4uICy4VIM+RvFM2nCtk0f0ykSKmcSyUAQlZLlidTA1Lc7pVDveAEFDQmCF9EggbdAtR/y260itVig3iV1qDucj/6sc+w0mp9Zl0c1BTf89JPS7+DFxaOjoC9wPNFb7fiouYUKiKr6jRSD8asZP5haVemfsYregWTLDdSAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669544; c=relaxed/simple;
	bh=t7yMTiyIn5bVl5n5EJK+KgGqnp8cXTzAmhlo+kbDvd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npFxQ3WT3iMWyB0KQHB6BvO1CeImDk5B6zCZEpEurhmes2XUF4ywqaMWZNjPx7UpM3hMhDZtWbuFeRYLCljY1jfL4HzN8ba56h3v9v4RJq3SlVeuxoL4gkex6nPG3q0Xm28BdIT1dbe3dbC6o/JjjNGzWEzz4ubrWhu/cbKUqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdUFVIpH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdUFVIpH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235db423abdso4016075ad.1;
        Wed, 16 Jul 2025 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752669542; x=1753274342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7yMTiyIn5bVl5n5EJK+KgGqnp8cXTzAmhlo+kbDvd8=;
        b=AdUFVIpHDon3Sp45y0NUMvQdff67kaSYpbyY31Xz8GWLjWeO1RZcZiVkgQXW68idzA
         R2/MAH5QtCoEgqoYuaUFXH7gH8h+sCRhRlqbb8ltw6iIBekODfOnUHoxL7x3+hZSpelF
         aQ+37GgKbQhAR+nV9iZvU8FMPpYZVjJPHS6fB38NTcQoaR3s3mvA1mUIm7nnVh0SnIU7
         /khxAWPvLkWwfanEu3YmKyGTJKl924ybRKiKjojzwYydnuFTP7AtyJhM8eUCeNMmggTE
         k08TfPwAHKDO9jv/EeMjLEX+KhMsGGcsF5m+3iAFCwqnkEqAz+T1AHZQc8wchABeUnp9
         Elag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669542; x=1753274342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7yMTiyIn5bVl5n5EJK+KgGqnp8cXTzAmhlo+kbDvd8=;
        b=bnD6m2O1a+Odv14/Vnv2aa0yAtGwSp2799nGkCnVZ9ecne0B2tKxaKQ1miW6SEwS9/
         yHb5d1z9RNBB0O/qn4TDO7ujNMpBFkIEJYpuxUSEox/ma7nFzerUtDT4CIYSHeBbxSe2
         98OPEIJuOvhTzI09hMnFs9L/g4rSJRD277Yl7a+MZCHKN4vzWnWsbpyEFtG+Bo7LV1Zb
         ee6DNHdCDzo9LQfjmpDfaYj+pihyYJYI61c9vrpQPFxkcvjFIDouAmOvTRBL5JJ2Z6Jy
         57bI5WoNdlc3JHcojHFSRUPoRLI1Cct4tVEoLGVbueSzLjuo11HnRyLyJaFZYennkHFA
         kgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaG+yuNhNMJ3RK4tFMeOfrprYevableQIYRXraD0EeuskucUyqag9/TBxDpp2xn+scSXu8EFV2glpDuUqM@vger.kernel.org, AJvYcCW0GtTnJd6Uc8sSMGqwdED5Y13IU6KhNz+O8neqyviHc6yClCWt1PfwlcsWalEI0HwkdEXlbBj9kLLR2A==@vger.kernel.org, AJvYcCWBdl3pS0RQtfuelwe8r5aua+xEjcY/70LqWwLFlmux1Pr0E1e+NIzAOyKbwaQD07A6u52ZmM4WDwSI9pTPbJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJxY9lQFsyANen/C4IFQicq4pjI0SbZFHMtLv/sugAk0iWwWN
	6YnI7Sz7CGt0EqctGQKmv1bZfPPtxHtBvZnGTUNZQxZnLEQ1/iKa2pnuxpv+xJXUVe5dtzLPbH7
	TJ+hvNWNEOjtgSQM+wBluxiPDse8VVQ0=
X-Gm-Gg: ASbGncs+bqVL3YPGF8liHCak9p5d6ACkF7RJHGVc1k1MVguqDtSCNSt1RFeI5eI05kR
	tXYK/295rz+avHcSR/gY3FtrJ5chbpb3Mdr2l6fURdccFPG/1ZgVVguC/69BB3zlRaXGSYBSMNR
	xSW4J9o32Y5a6C/nAyxyuUytZ1JpQIQkCg28MrrGmhMwiN9aY7bbYIdIc4TM5mEtOtfOM66SEoi
	X0laFpLxnj/sTlE
X-Google-Smtp-Source: AGHT+IHb7twDbZS717sooFnpEeuTv8foFpUNdQt/t+N7nFBUSXSl8rv6EaBwPEQgIjJO6rxn22+uDFocPFtD3HxmqoA=
X-Received: by 2002:a17:902:d4cb:b0:236:7165:6ed3 with SMTP id
 d9443c01a7336-23e24f4c2edmr15175785ad.10.1752669542136; Wed, 16 Jul 2025
 05:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716090712.809750-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250716090712.809750-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Jul 2025 14:38:49 +0200
X-Gm-Features: Ac12FXyBbubE7ZsrFEb4VKL5PU_-XhTL2cDJ2Apjzdi3F4Mbeg7nmMtrlhi_wVI
Message-ID: <CANiq72k1ENBFw7eNc5Kb5cFagysqfsHt9a=Tr4NxuVcV2TD=nQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:07=E2=80=AFAM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here:
> https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.a=
k0208@gmail.com/
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.

Thanks for splitting it Shankari, that should help get this landed.

Cheers,
Miguel
