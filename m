Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F98193419
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522764; cv=none; b=BYEF2tq+ArHaXs+zt/fJsvfESqtYOalhlUniURKny+J1YoG+gIiV3Gho35hXskZkzeLGsc44B9yORimm3nnbtgk5S+xFLiUtqDLmWjWVEHxv52tGKCZQMqhSPl0pEU8j7DHcTgO8ymUKaVH5VjhTPUMlVzXahns+8nBbe0Fk8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522764; c=relaxed/simple;
	bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKKYEYeM9+bBlvKu7pHdJ+GZz2oxTlxIBdR0MI2uFTxrWPP0pe9i0BOAhX3RJNRIEPpnV7dxDnEqDnpfy0gV0Kd+ib6hfRAxYV/PnQHI9R97prP31Lfv2kxhl5V8MQD4YcKgmZcFHquX7T1I4dxGa7llp7Hn0LotIRDbc12tp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqlqSlxM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqlqSlxM"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c180d123so212079f8f.3
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725522760; x=1726127560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=LqlqSlxMetbqgCeOuKJUUaWRw+brrRsqjEv2VyCniz+CpWYugqZy0C4VQRrwmysfYX
         lNdv48eduzzsSrwUxDrHovViv5gO3y4S+zQnezEe/jMXnIPFvF5yCUWqULvbJyAzRqnC
         e8szkRZQEcqFbbjsqLkKKf3+I5eRhqcKbDBpQowHaXR/nXq2fxazuUTfY8h/4d75AxPL
         A1PQXnRXQe08K44rczz6/uxq9gm6jvV3bin+fdHBdv7a3uGi9gZT77gRpc5/n1jeM1bG
         69tqZvtmizGWrrt4FMb3zAARFb5E18x7JQEXGofQs0GuRpFP5QlB16mc0mbEgh7AjbYn
         7IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522760; x=1726127560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=SraZ/9q6DLSOSx5U8cAltYsvH2BmjXszGOy7q3A3Dnd8nZviilaaOqIszbDV8e4IAc
         TqzhIPSU1vyI83ifznEIJN59Rw7HBgjFD1j+C/wj4Y1RPdbsRzpbaj0tpbAsN3FgduYb
         dsVazgqr2+NRh0Zvml540OCC6QP8S8Z8rqj9LQ79VOE6SJf1YeQpxYJfUZxWurIn33IA
         ERB+ORjdPFsj/JZGH1iS2KZumKJlOIre1rdWD9yDaIegOvxPA9aD81VtmOJowX1tFOUE
         oHmIT8IncA0GI/cWnbg3eQnIMQmOFect96L3YOIIOleMuGFtHE0UT9YEmNELAzE7ioVu
         swlA==
X-Forwarded-Encrypted: i=1; AJvYcCXiIECbYfU3taYAL8MCcgGHmVMdLs7zaS+fLMgtco965YSVG0uFGnfFWHh2nT4HEWJU/HC9LlksUaICLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBhS2/b3Pa7q9bJVQ7pB8F8U8JBQjgdpODvS9FVsjUw3jfGcN
	bnlD4+hZRh8YVIjCxkHbqDiEiSn9OI6BzSdjq30aEbJO9pM+uAun4R1YMMdDywkCOKQyOj2sr3m
	xJ2IQ5dnh3e4hbRKryU/aEj0kqRXU52AR13me
X-Google-Smtp-Source: AGHT+IFK43pFnPLGUXRCs6+/ppb+2QpfbK6ADGGjBpmf0Lo7PhrrA57wrAnEXXwtIovQ4N0HLObZaRzV3HTp0jsNSrg=
X-Received: by 2002:adf:a351:0:b0:374:baeb:2fb with SMTP id
 ffacd0b85a97d-374baeb0c2amr10826925f8f.35.1725522759687; Thu, 05 Sep 2024
 00:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905061214.3954271-1-davidgow@google.com>
In-Reply-To: <20240905061214.3954271-1-davidgow@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:52:27 +0200
Message-ID: <CAH5fLgjqdchRvVGTMLYPTZ6erakKg3sNhbSA4dLq0kLAXLWxQA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: block: Use 32-bit atomics
To: David Gow <davidgow@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:12=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Not all architectures have core::sync::atomic::AtomicU64 available. In
> particular, 32-bit x86 doesn't support it. AtomicU32 is available
> everywhere, so use that instead.
>
> Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
> won't be an issue, but it's not supported in core from upstream Rust:
> https://doc.rust-lang.org/std/sync/atomic/#portability
>
> This can be tested on 32-bit x86 UML via:
> ./tools/testing/kunit/kunit.py run --make_options LLVM=3D1 --kconfig_add =
CONFIG_RUST=3Dy --kconfig_add CONFIG_64BIT=3Dn --kconfig_add CONFIG_FORTIFY=
_SOURCE=3Dn
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Hi all,
>
> I encountered this build error with Rust/UML since the kernel::block::mq
> stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
> is correct -- please correct me if not -- but this does at least get the
> Rust/UML/x86-32 builds here compiling and running again.
>
> (And gives me more encouragement to go to the Rust atomics talk at
> Plumbers.)

I would probably go with AtomicUsize over AtomicU32 in this case.

Alice
