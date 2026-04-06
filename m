Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2A2750ED
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466204; cv=pass; b=qPjhylOrKm8msILhTv/DErMQAWVNf/nhZSCd8EplUb0cLwZM/CGM/xkyr1FMZxqJ49deygnEBGqYM3zTR3fSkhyar8mtjMFW8kcRfEL+KERp2+Y+daLXngfQFH32dPNPp8+nZygZTj2pHJoXe0gwAP332Qz9yce6prOTo0ahCLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466204; c=relaxed/simple;
	bh=R2dHTJQnBLz14FBWbb+c8la9tQYirU1vpp38y1sgoA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnsYx/Sg9ttGwZac/BE/pVpXIXoe6gtlBEisgTBmx2cQErbuYPB1RXcBC9QH8titVp+K2Sw2wtXddrTncubCF2VlyoV0tvuMFdxCTLhsKZ+GgTySAMHd1aB8R97KwMnYQpGJcRt2dt2+2Vhjc3oY2ERV8lLebvalw00HFyxSF5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIATw31B; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIATw31B"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b8095668ebso275404eec.2
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 02:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775466202; cv=none;
        d=google.com; s=arc-20240605;
        b=Uu4JnyJxxFNIclmpcQTStNSxTvA0TVhVCBskcQ524UCRTWz0eYQ9tDVXsdkNPHPOvj
         KlNo8xQEd6ucWNvYidVsl5jprX3ok++AH67dTfMBvKlNTF54zLL+AtPkxhyOuR+nN6f7
         Mq78kSaoWkHU58USZbVTOLd5jNhEAeEdMOtpbrSga/1h0QPRkcvIjMvTJP2nGKme5/iW
         z/cV+EFVrFV6VRi4Nqwy0kLXgtkBQw8aY+5HQm4kTKn4zkDB1jGofl+IqEKyMFskpqkb
         33cnAfz755g0GZhUt2tufn5RooIIG6TGYL1FIxXhBoGp5qf4PjDlfVW8p352sWkxnGiF
         qzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
        fh=APSYLqr0JeKtBYAUufL16K8/5xAb8YFhnpnUkJESXN4=;
        b=KxtgdA/sTAVV+1T20TRsUABUpHi767hLiLr/Uv/bVGvXIyz4cNucBF8q6q3r8mLBZo
         KgSwCjHuTOZhy2D62q8bPUzgJ+p+dX2jgMiJyp3f3VfRmETF+H7grmO5TeMmUZZ8kFMb
         cYAZTeD5B1Ugo+ksn2uL3kiA2W4XxQ9ChSyXRbPu41iONQt7dtRgI46oC9nK2A6/zYEh
         +We5KaYUE+SFdeDR3Y6b0q0njXSma+a+yCk2vlhZXwzrxY+zzTRVXnHprLi1wnp3WX/T
         u4TNabw6CZagq9IsrG18CETJSx8J64N9/nEshy1zosNZTNundI/k4GpLfGkU8ypHo/ji
         uucA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775466202; x=1776071002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
        b=PIATw31Bk+3hkggZjJ21LYlWRCEdonuXrhStaxjfpeEy+RZoMphpX1G6fDXJDfirK0
         Lcix84JqgjmxFvtJfqRfPYEpHGb1ZhF83nIFw3O8IG8D1d9G4/P2un8SlPIrkQlKDQvS
         kAjTgHjN9voZ48IaKsTLutwUAdxm01rYT/4srX8EaIwQURRnjXuJteiO0uary5DO+b1y
         eIHYD5+mctWtaH77V7OyvOW7r4QVs3CY/XzcE6cCxPuvfHIp2DtxiKgzIF0EMRv1ON+k
         6WsWVXYwGXy8FB5vlCj+jWDIFXrgcqNUpc1z7vi6MIUB1fjeeM+HBhDZVaiEGtXGmhmh
         Zktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466202; x=1776071002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
        b=PrUlwIxIYuYDwDt2v2cSIK701NwJQ3SwPh+hkgFY/zkleCRW2hhbFgQ6jFOjfn/v+7
         o5VbkX2KRP81k2e82s93/qmX86ptMDH8yz0QALNMtXByUhpxBXace9iWkmuyGBjniJ7J
         NqhsGBG9GUAl1Uu3UGYgG9ORK6el9sHivUJqMInsnNmFauQP+AFEIYSmZoYemtofGxrY
         SOaZSnWnek6mErfR8HYJKVSnUYQgMeC60TFzWiZmLrf7EmrYeojdjgLGXCx/W0Vt9w65
         YtOmLeVc+23Zm9jnX7yQeJMdNwtwK1/dKwVGq4TO40SOMcE2cPmLdR1Wjfoz04OFktJR
         A8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVIIsdRvLfmJoofsjp3mbBQvf85zzWHq9d4je/eTx1JgC7PpGT4Q818OfMG/hFsYeWXE3OAuYg1JJkagg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2V3RNxS7UE7iNA1UbSeIviBtgHSWWpXmggMl3r4oembnUA79D
	nBxcjavm6EFm+AdWvprtwo4TC3O7+OjRj5KX8XEFzc2oIB0xxjQDtlRjG7e3wxExGq07FNeG0pB
	dm4G72Bf6IhE7wJJz622swlPShOjTOHQ=
X-Gm-Gg: AeBDieuRZah8GAh/YdlIA6jFoHzDiiqCcx+Dc0UC7mPTB4chVMKPck/tZuP5QS8T0OP
	Fz8BQ4BKKno+PpPOyZ0tSM26zakOWhvyIGmfyW9aZxT/6mVdEcz2f6YZiB6w2EkatZrh9NEn7Dq
	e16LjHKSQ17H/UgSXpJ4ABu65ZZrw6jR39IH9gwTwvDdZSP4KnP+G1ts0ZE1L/xrY5tsqeYzhaB
	flY2TiEXTy/s444jYS68V232a3JcG23lrTmz3B5lENBt+7YVuuhNVtfoIgaIV6r/BcTzmoEwmqA
	nHVK8YZWr5cEWAMf8qI7n7EO6B4F2QpHJ8RbIt6M6XvrPTTyC+ncYD814XpdCSyE97y6Ldaj/64
	JFcGTY9jSV4T7a6v6PcAFddg=
X-Received: by 2002:a05:7300:2315:b0:2c4:76a3:bdfc with SMTP id
 5a478bee46e88-2cbf6897126mr2280931eec.0.1775466202269; Mon, 06 Apr 2026
 02:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 11:03:08 +0200
X-Gm-Features: AQROBzDwpcCEtASRfptsJ0WJ2jdyaJlOCl6SPsL-e-w0TnWmNnUbHOjTvtft1Wo
Message-ID: <CANiq72mnGArtgAbe7xXZCYW1x7Zd5hozfnzoftaGy9rxoLO4ew@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] rust: bump minimum Rust and `bindgen` versions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Mon, Apr 6, 2026 at 1:53=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
> we are going to follow Debian Stable's Rust versions as our minimum
> supported version.
>
> Debian Trixie was released with a Rust 1.85.0 toolchain [2], which it
> still uses to this day [3] (i.e. no update to Rust 1.85.1).
>
> Debian Trixie was released with `bindgen` 0.71.1, which it also still
> uses to this day [4].
>
> Debian Trixie's release happened on 2025-08-09 [5], which means that a
> fair amount of time has passed since its release for kernel developers
> to upgrade.
>
> Thus bump the minimum to the new versions, i.e.
>
>   - Rust: 1.78.0 -> 1.85.0
>   - bindgen: 0.65.1 -> 0.71.1
>
> There are a few main parts to the series, in this order:
>
>   - A few cleanups that can be performed before the bumps.
>   - The Rust bump (and its cleanups).
>   - The `bindgen` bump (and its cleanups).
>   - Documentation updates.
>   - The `cfi_encoding` patch, added here, which needs the bump.
>   - The per-version flags support and a Clippy cleanup on top.
>
> Link: https://lwn.net/Articles/1050174/ [1]
> Link: https://www.debian.org/releases/trixie/release-notes/whats-new.en.h=
tml#desktops-and-well-known-packages [2]
> Link: https://packages.debian.org/trixie/rustc [3]
> Link: https://packages.debian.org/trixie/bindgen [4]
> Link: https://www.debian.org/releases/trixie/ [5]

Applied series to `rust-next` -- thanks everyone!

Let's see if we find any issue in -next.

(If someone wants to give tags today, then I am happy to pick them up)

Cheers,
Miguel
