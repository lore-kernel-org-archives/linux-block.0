Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58C18FDDB
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526065; cv=none; b=SBw6I9SdLiVNgEyEviD0NlHmky22LxqGTjIi5J57O/PZrUjX/pxWlTd66R0r1ltcHQWyug6zJd1JzU8aZC/vsrtglnChRR7mI/gZlYJopBVaq3+KoCTRypL4yIfSNh9O2PNM2c9qONRN7mwSKCdsSwlAN/76FlMFNnlr0ZiZjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526065; c=relaxed/simple;
	bh=uSsPtNnVteIM2BzthXpkxL9YoGLmPqhmZKg37rTE7Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyRfxOoetEaYCOnBZgx4iv0pT3Vh7FLzZzXvkj0MeDx+I2Y1mZLe7B3UXaQiIpyUbPInOCdWjRSc5BUMgTXu/d3PnspGyur5lMwYdq5Yo6obtjctMEJdIbIgOm4UbgaQ5TJt+fkzM3Ht0/jSnki8d9aaSiCd/elEBvOCPJBJo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rddv+XPM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rddv+XPM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382423f4082so2959368f8f.3
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526061; x=1733130861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrdMiDJt5vduIxa0PY5GoA+617/ZMEzbh2yCH7ixs2Q=;
        b=rddv+XPMAIXrLkGAPOpX+Lxk/dHpmmSxHz+copGp430O29dLB3W1ClZdOX+PFwLS//
         83AS6KyGKm80EEsweut4Hrt31pFzll/QEVyrT/2MXtevBUUhLol+Sa+TM7CLxorntGe/
         GvY/4a9NlXFbw1y1DoxxSMKIPiKBp1l5PjZGcJH3krTV7wfnD/gJ6AoMbQUxUb3I4NAR
         DQ57y1qXaoISH4PPTihcIm4sbfQdzYYL7PUJUIRF531mWo0SAnJ74Jsm415Ge+MxLKST
         KvqXJkrkEupqKZSCSh2vHNPiuLVlNd2SIXcVgmReAXtwv8N7r0+EaBe1adauWWHXXXix
         ghfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526061; x=1733130861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrdMiDJt5vduIxa0PY5GoA+617/ZMEzbh2yCH7ixs2Q=;
        b=gFA2Gtz4ir4Aj0Hh7NTDdUUMB+UoJgNZ9ndsI7BS0LZaKZbvzIzu2Z4n2aoDizXVAg
         KKcB3gzaP3iripFimocPcQ6JDTN4NL+tZ1/BloePRVh7A+6UR1/w1JsiJ+2INU50Elvl
         O/b6//6uO4n8bOmMC8WAudugAV211piuJlbNYHEO3+Ue4fXbLlc5iVSo0vT272xkq0u+
         uEAeml/GFVAyIVJ8TF+Hf+LUzT5ApQnmvEF27XSUUGQW+dyA062xyS3WcocSyaro9UCD
         4Oen4cvZ69EJt76ZqhICk24LRf0rvDX68pf41/mbGE3LL5CZB6s8CopAVkIQcyHvii1q
         50xg==
X-Forwarded-Encrypted: i=1; AJvYcCWwnZ2Vhcb86N4uk1GToWaocOrOLgpuQZo2BW/yKluP4am0D9h+mFMP2+bk+PHx3Gv2NEiRMs4bDrO8EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFuZ3WKPVN5aa6oEwQ4/mNpL5pxgJNABrkTJhwvM21Fw83PDF
	Ox6Ynx1UN6J/08hccuWgMm6grmz0YWtxM6b358pbmdi+Om+PuKFcuKZuQIv+j0k5Smgkai1J0mA
	lobZBzpkIqdlOnZs9wHgpj7uLZ80fT1sAiozc
X-Gm-Gg: ASbGncvYPSYPKmAoi3FoJTWHJmJDQCbsTznuPM3wzO7WuImEnPZlvm9gj52goya/IgO
	lb7o6rwLrxsQ1w9J9+aMxjxwINm2k6bPDF9Pi7MA3ECGEfClLWz1x78ghQED2RQ==
X-Google-Smtp-Source: AGHT+IEOwMk3vapdbNHpELN0oZ6s3oro3YnZRn8GCOYxBikHFeMCXOFfPD4cUTzyUloMpcTHt84sQUv4Gf+wLfw8W4o=
X-Received: by 2002:a05:6000:23c5:b0:382:3e51:4b1d with SMTP id
 ffacd0b85a97d-38260b59530mr6868816f8f.20.1732526061276; Mon, 25 Nov 2024
 01:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-2-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:14:09 +0100
Message-ID: <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: move `build_error` hidden function to
 prevent mistakes
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Users were using the hidden exported `kernel::build_error` function
> instead of the intended `kernel::build_error!` macro, e.g. see the
> previous commit.
>
> To force to use the macro, move it into the `build_assert` module,
> thus making it a compilation error and avoiding a collision in the same
> "namespace". Using the function now would require typing the module name
> (which is hidden), not just a single character.
>
> Now attempting to use the function will trigger this error with the
> right suggestion by the compiler:
>
>       error[E0423]: expected function, found macro `kernel::build_error`
>       --> samples/rust/rust_minimal.rs:29:9
>          |
>       29 |         kernel::build_error();
>          |         ^^^^^^^^^^^^^^^^^^^ not a function
>          |
>       help: use `!` to invoke the macro
>          |
>       29 |         kernel::build_error!();
>          |                            +
>
> An alternative would be using an alias, but it would be more complex
> and moving it into the module seems right since it belongs there and
> reduces the amount of code at the crate root.
>
> Keep the `#[doc(hidden)]` inside `build_assert` in case the module is
> not hidden in the future.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index bf8d7f841f94..73e33a41ea04 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -32,7 +32,8 @@
>  pub mod alloc;
>  #[cfg(CONFIG_BLOCK)]
>  pub mod block;
> -mod build_assert;
> +#[doc(hidden)]
> +pub mod build_assert;

You could also put #![doc(hidden)] at the top of build_assert.rs to
simplify the lib.rs list. Not sure what is best.

Alice
