Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF046AF34
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065000; cv=pass; b=KxcdNpwtzXtOMqhxH2PNDDmboRY+1RFPUp3kdCGmfn7vUoWv+zkQpXraS2vGjn0L5AH2CoBtUkJdrEBDPK90CJ/un2bsNv9j/ZVLpiQqJ4TrNCCQHXnYpTaR4kEDdHelYvGyN+AebQ5JxJEBHXRPKeZR8tHwAvr2CZHLcBq2uxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065000; c=relaxed/simple;
	bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWZC0YERdfOJ13u4gPXlFLbijEK7ujvnCzxGV4/aJRrRLUqUeagUYVeDzdcq93mAUmc/pAvcqX7Bv1PPdvCTfbiWr4deHc01m7XrBgIcTRh+rWNprkYjvUzhwCI/hdFkhrN4lUdB6MyrtUWx42KZMiKBPWZg2C3BN5dluTRtdeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m47/sJ8V; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m47/sJ8V"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12736a0147cso7331c88.1
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 10:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775064998; cv=none;
        d=google.com; s=arc-20240605;
        b=FgXdhvAjk/ZnfksK1saremJYl1NjTfO8ojvQBnlqPTx2SH+9JacRtyHSUzb6McTIjK
         IPObTNMSR//q++h2Gi55t/dURQxsPLzz8YTXyBOHGYUbjHtNE5RjjDkZ3a18DEESIPvn
         VBR/wa84I9Y6qNt+sGC1TL9TW81pLky6dPWsFTfVE2zJfBxlPahEuPGgZCia4nc7mRLn
         hhb3qRatPPMFI6sM7E24tajI/64vCrADaG2uTUFJwT0ANliBMRIXCMLXIw3dIa6QnxbN
         fXaKWEt+FBbNZHQtJjbWWFRVS3vQIwh16WbFukmFh1xd/2EuRAzgeFmCZqvCs+AfTWSW
         t7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
        fh=OILY/y1maTgTOZF0NWA8IXgneXoqTTEtMZtzGX6jdO4=;
        b=QnHM8izpdG56GvnIz/EydcIszvHc25OAjn6zzjsTtLADVXrVJjOZJEvd1KCUmussp2
         e7PsR+v2nnbJEVSWRQHZiD5iQGL13U0veNWoRFqwxNKuVmIivEMcRalTwte5PYRcP6aH
         3ddolaNj2Lkbb7bFtXs5kbbCWTpRJcrxfB5/jTXr5/us1UqBNk0OlOUDpy+vbnKrEaco
         iGzp9nXqppWNsQxOl8NoOem3mWl2L4+LihAsmR4R2/+Z9Vcp1dpe7fzRt6UM44f/jMG1
         vkrbGLfMy4wNNJvq+h+Q69wZd2w3/GOKoVTcQUCLFRfSub3xcCD3i/LIVQCiDNivdd8/
         zsdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775064998; x=1775669798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
        b=m47/sJ8VF5zmkEbgvymxRwXRqMU1Z/SMQ1njp0gn1sBAbbZeHHcDZwn9Ov5QCfkASU
         IYCyXdshryWiChJCSKlCTLKnWq+cjV+SueJ0RS1kudCFliXnb1YcC/VNmS/glt0Ym+18
         i/hh7HaxM41rZ4fLKiMBtU+DCN5UMWtHllNzl0Lq2ZOhVCOgWKY9f3iMAc/ckyFgm2bC
         phA0/vIEnZ/8ZF/59f6s1sC6QR0J1Nfm78sLyH4nFLXJ5D/XhZh3PjfHWL6vp/vFlaYb
         FqY/DKSgpkqYWCMJ9Pt96U66Bk6BJy9seltRXj/JzBJfl/oFXs38w7bGYUrJGgoyxxWP
         wbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064998; x=1775669798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
        b=COlezzc6prl4mlxGgLZ8AduVkbfJM47FCdTrzOWIXGaWamqkK7ScGaGoRWiGCFJ8/D
         2AepTcWjH7aRB9fGYSf7RBdddiBO3GvpBgDlX0kbbmE4Sfab62XL5n3b9tBtjsmFm1gn
         YFR2qq6xMOLpSax3Jt9FiKsp5U/rerX1eN9W4qvVWvnnBgzaQpjhlLlUGjpP0fMeDUGj
         V6yrQAPwYMW2tAOc7SOf17CbQG0J7NGTYyAA94gbRBa/57V44GfMfkhs9q2NRbcvptPM
         bRQDVwppI7a8D79ksXzX7YQazTabz+CLmt9LXqMh8C1riNo1f1KFgHdS642B4HW0wk6+
         Pm5g==
X-Forwarded-Encrypted: i=1; AJvYcCX4MiQFzW+5WoJtBqCJHqg8KzoE1tXxwk1T6RhUmLk6gJR9m5jW1yGaI4wllG8hHLnqyzNy9ZpB6yY6dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzHV+iIOm3RZ1UzpHcv38erT8g6paW/2mJp3FmxywHHDmiEm7
	TZnXtRn8vmyef0E7nD0iYPpduqLfg8J61hwobzHpx6zSc64wyDEdUiDubudxsqfyxB977kGLLNw
	txSJ7VM7i/WPVsOx8dlCQW4fgXbK83/s=
X-Gm-Gg: ATEYQzwXtMiL6a0ibBtSyuihIHHz92Be1+MSVy7QS0PnF+ARs+Ns9WXsQTBNVpfRc2y
	TGPuj9LQbQtZUDBOtM3pmUznVqk1yJO8/O8Ia64mB/22BA4nDFG7Gxqc0EGWtbEZ4FMKYtJ7nDD
	yzUKqMtUiEM48OAD5KVXyJU7Sgatt/94kn7GzvN9arrnYVLUeKJXzP9td2P1Xc3F26MUBrHw8/W
	Ye5WrIqRnZGovUGF8IlzgddjjMK7ODUHcMOmZ8Lo2IfUUpxU41UjZqMVgNVBAyZMBhDbNep/pDF
	t0D+Q/vc3zGwP9mgVgItdAjKZIj9B7YxIkRiHqKJ/m5rjf4XvNyo4OKxUFdNes51dYztZz5z5so
	96/i/kkuch1adDecvtVdF7h0=
X-Received: by 2002:a05:693c:2c97:b0:2c7:2cac:8162 with SMTP id
 5a478bee46e88-2c9326aa500mr1010168eec.5.1775064998156; Wed, 01 Apr 2026
 10:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-9-ojeda@kernel.org>
 <DHHVEPJHLGDW.1E6KDP9BUFG5U@garyguo.net>
In-Reply-To: <DHHVEPJHLGDW.1E6KDP9BUFG5U@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:36:25 +0200
X-Gm-Features: AQROBzBeO_yfCUmMruxpBPrHPRt9Z-RBtWsQqT4MIRVUyc-eOkOj6bAx0WG8aNs
Message-ID: <CANiq72mnnro6UD3SYgTOG+kipwkTBvbEAGH+jXUa3kLTUNje2A@mail.gmail.com>
Subject: Re: [PATCH 08/33] rust: kbuild: simplify `--remap-path-prefix` workaround
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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

On Wed, Apr 1, 2026 at 3:59=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I'm not sure that I parse this. You do remove the filter-out completely b=
elow?

(I see you saw the other commit)

> Looks like this is going to conflict with rust-fixes (which adds the
> --remap-path-scope). Perhaps worth doing a back merge?

It would be only a couple lines conflicting, so it should be fine.

Having said that, when I was doing this, I wondered if we should even
consider keeping the workaround. In other words, locally for
`rust-next`, the "normal" commit would be to remove the workaround
entirely because there the flag doesn't exist to begin with (i.e. the
workaround should have been removed back when the revert landed).

Then, when conflict happens in linux-next, we can just keep the
addition of the flag from your commit -- the rest can say as-is, i.e.
no workaround needed, because you only enable both flags in a version
(1.95.0) where there is no need for the workaround (which was for <
1.87.0).

It is also why I added the second commit here, i.e. the "make it
conditional", because I was testing that indeed we didn't need the
workaround anymore.

So it may just simpler to do that. What I thought was that perhaps the
workaround is good even if we ourselves don't pass the flag, e.g.
someone else may be passing it. But the chances are very low,
restricted to a couple versions, and the error is obvious and at build
time anyway.

Cheers,
Miguel
