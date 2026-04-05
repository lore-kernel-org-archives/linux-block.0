Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFB38236D
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430955; cv=pass; b=ZHyUrExCslXVRYYeMNQkuKTj3cpODg/kyrBEphYAOOMhBibZf4s7V9a5/3nqIhf+4bFpjWFgRpzLjWba9CtmqQ2M4NQVoTRb/6OFY15RzZlZHo9xKdY79me5MeWeSLuTHaclpyRq2FXWA6F0R+rdUhCbyVRv8gZ4AzYvuG4fhsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430955; c=relaxed/simple;
	bh=DuXfeYCW4QOQ/5cD3aG7nz3kn7r2sbXuLr+omP2BF5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsNUqP7tGJfkuA//WlRcVJQo3w+1QxEE8fmtQHm0JNOXKwwFZl44rmTQUtc0rM0TFqe8CE4/Ssv5qgNmzULLNumcGNHoPJ4/7Pfm4ToW72c4IT9vp1Y/q/djmy4pVIkBcJssatqJfqVzWfHkWoEvw/sRRrFbO1RIYpj9aRzjxo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgPU9FAH; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgPU9FAH"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bda3b4318dso224418eec.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 16:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775430953; cv=none;
        d=google.com; s=arc-20240605;
        b=iPDlqjSa/Y5uLbJvjd+JfxPoOkWDDMBPaoIb1cnoGFi6wiq9l00MI9aqcHtPYKZqOC
         O8uUGskmLbYq2vI7HH0inNoWeEK3us/iPdGNEZivSsVk+H1B1AOubCOtD9164h1p8dlY
         DnXvuckKEdLGOzn0EGVmPQG5mYUQEPtsGFW6igKNaEGM6faG1wSCAL+zavgDev3MC8bP
         vMaoWbv2HbwYtVI/wwfjvaHh7bF97nBcaXSdZN4cJaofJqu7F2F0NV83fOKjF6aL8EkH
         tojbTorfPnB3CivAic98wwi9ubtBTzhsIxwyG9bz0xPTOxb9QvSbXt9WkZjOrcTyA84f
         dx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
        fh=Pe/+wXuPsmrEMijfn/9aRGYb7k/PXZTNYjKP87So3aY=;
        b=imWlNU4S7nAj4pafx0ox5NTNOB9GRIctE0LevOdJ8GrmCOVrAns5X6bdfQxkVn9pJk
         bZK5YQHAxKBO0gwYN1rUfNin1i7/T2OzfqiqrE0hcXt/7wB1WcRzyGVs1DF26chUUCwo
         t/dWl+x6soba9Sg8o8x16KaOxu/v/ANxP0kZNIM0sfysw9Y07ZiYAnFrcWkEt7Whudb6
         jwUAk7tKgBB8khXmxD5pOyRyRyfI30Af/fi2YDF+CqCmxRafl3l4FidsvlOupXupfX2w
         M3gC4D+GFG9KtvbTI37lgvn4TVVDd+s4cXS+luDr5o/8RDZ8ojBu7hLA4KgfyFtlJF9o
         DN4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775430953; x=1776035753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
        b=BgPU9FAHd/0DkGlhrPlq+mpFnKR9NanttH63t5+ukkWgo5r8RO95uUTtwGBZKHEQwJ
         mStErKJb4FphO/b2ZSD/0WR/O+KkKxVJfDy3UeE2b1QtAHU8qWLxLd++b2mF7gvkf7Gz
         DWf7Xp/HFWYCIyuoLxxY7GaKfMM+x85lbUvItA2qG2SZXcaBwfimoBTBmCjGa41gMQfv
         9TFfzhiMWnVPAME2Go4HRHwQW+gUMJGk9H5LQGFHtyqTybD8Gss9bCdr7Mvt2zUQ08EA
         tseXLLJRLPrBlYCL0huRsKFFMe8T9ArJ8+fxn9217jpGlIoeoBdUX5p8aq5X8rQuLDfs
         j2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775430953; x=1776035753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
        b=dUE5O0rPQP7snalbWt0GZp4OZGD75uExQlvjM7yFjae4efXn2i7SxPgSg/ek2k5Z/g
         FX7noFb4ADrmq5aDJacWKXlr/ly60yagiVaWOexFdPlTypzy3uqE5kwNEoG2rhw1tKN3
         S4CxyKduDji1mV6+MGcIxjiS50fcAG9bsDUIxkNDmpoez+J/Xli/xREKtOVvNQocUNUD
         Yu424H0ArjDrRfG/reNok9TN8c/Mfd9UxOBWHIgh2fwpallZYWS6NooZPFafCqX7BbKK
         N1b31n/M0nIB3d/2t23um0kPDFewlKRfgV4ICgcNngWaQ67T8bIVz/Nw/MEDVl8+p0IN
         HX7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXUI3RyWGYRbAxfBqCOgk3QhMVJ34VxCwtQDB6xpOWHT36TtXx+ixYIxNo6gM1pR09ft8sKqdMFp/t8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7LLXH/m3C0rlKsfrAU4+3+DtCRgb/GFOKFnULclYJTbC6dHyW
	0TRKrdVSX+UaOug9PhQufAzpOk1iLYizLuhjCCYRc8Tt3Wfz8rk8FRfKZ1qkoEMNmhf0/+DzMOU
	U5NC8SL9P1Z1ChA1KV8Bddho5fZIbynU=
X-Gm-Gg: AeBDiesZIemq5u9h/Dj+BieHcLv35sPeW7YiEDzIYRdV2J/G41akJMv7xFPzLEHETut
	pmMfOw8ZEC26Ck9WfHKFFQa+MzISCG91VjWMg806fGMNCFxYw3FG3SFEoyxwXtr4kp7tueUrkrB
	sawSngdPl9cQOBraM+IWnVTxyBouDIm2kEP/N+zVi5jL9HU0DxokWexmqQMDmI7qiiywlx5185X
	o/IRxMDQNN1X7MMJgPxfCurSL+uITz473IMbpgpTDuYku6z+24eHvgku4EPxn1JrPMY7nTvm+m0
	TI+ffWU9gtZyU+2lWfv2vmLhxxUOCidFvhoyWZlenSQErPTzmmR3s4mNCjD+xEFsgFU6AC2GymC
	+nUN3e5DndR7qM2UrLRx1u/k=
X-Received: by 2002:a05:7300:fb8a:b0:2c7:3a7:c795 with SMTP id
 5a478bee46e88-2cbf669b785mr2053063eec.0.1775430952689; Sun, 05 Apr 2026
 16:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-33-ojeda@kernel.org>
 <DHHX9O7V06VZ.G0N1CQ7BUKFO@garyguo.net>
In-Reply-To: <DHHX9O7V06VZ.G0N1CQ7BUKFO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 01:15:39 +0200
X-Gm-Features: AQROBzBr0aNQIDV47zgxZ35JmTq7j6zQBNm1bxMAs_nutxdLV5rErBhW_SWV5gw
Message-ID: <CANiq72mTaA2tjhkLKf0-2hrrrt9rxWPgy6SfNSbponbGOegQvA@mail.gmail.com>
Subject: Re: [PATCH 32/33] rust: kbuild: support global per-version flags
To: Gary Guo <gary@garyguo.net>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I think I would prefer moving these down.
>
> The current approach append the flags to all variables, which will cause =
the
> following equivalence to stop holding after the flag update.
>
> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
>                         -Zallow-features=3D $(HOSTRUSTFLAGS)
>
> (Per version flags doesn't go before -O anymore, it comes after HOSTRUSTF=
LAGS).

[ For context for others, Sashiko reported the same and we also talked
about it in a Rust for Linux call. ]

I have been thinking about this, and about potential other ways to
achieve the same thing. I think the best at the moment is to move just
the `$(HOSTRUSTFLAGS)` below, but not the rest.

The reason is that it is closer to what we do with other user (kernel)
flags (e.g. arch flags come after the general ones). But I am
wondering if we should/could set all the user variables later in the
`Makefile` in general `HOST*FLAGS` later in the `Makefile`.

In fact, there is already a limitation with the host flags: `-Werror`,
i.e. that one gets appended later, and so users cannot override it.

This may be considered a bug, because commit 7ded7d37e5f5
("scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=3De for
hostprogs") says:

    While it is
    possible to avoid this behavior by passing HOSTCFLAGS=3D-w or
    HOSTCFLAGS=3D-Wno-error, it may not be the most intuitive for regular
    users not intimately familiar with Kbuild.

But passing `HOSTCFLAGS=3D-Wno-error` doesn't work, since it comes
earlier (`-w` does work, but because it turns off everything).

I am also a bit confused with:

    While this means there is a small portion of
    the build that does not have -Werror enabled (namely scripts/kconfig/*
    and scripts/basic/fixdep)

because it gets enabled in the build (I think it is referring to other
targets like the config ones).

Anyway, for now I moved the expansion of `HOSTRUSTFLAGS` in v2. If
Kbuild (Nathan, Nicolas) think it is a good idea to do one of the
bigger changes (e.g. for more `HOST*` flags, appending it even later),
then we can do it afterwards.

Cheers,
Miguel
