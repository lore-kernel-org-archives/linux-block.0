Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BA3290D1
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551063; cv=pass; b=jjJFHudcl5nxK7a40/c06KdCE2Jgtw1pGeWLxsLoSMtF9lCoqs4PC+V6ZX5M8qzv7/+ERzQRJEJYIOPAjIwIEZVN/GmsqPddl3JXDUhhnJXiMqkKW/w9kGhWpcmK0j0tfvEipiiAW3hNJOmkXdTvgxWEjJ3j3vdBXDg36jFu/rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551063; c=relaxed/simple;
	bh=DfoJvrhbR9/q+l6t1NPKmCnTz4p/S80iMM1QrEsDKz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJtVlKTJnfHFhY8oCtHtDb+sNOhtwNqod9J8FCk/zuebDCuV2s3HBW2Yc1EKqBI6OrHKmAjVo7o4CnEfw5teSvMfd7L4KK+B7cdCk+OXxXGhb8SHvH9jBvGwAACz21ShOSSfjciJoD7UZSR1iUm+CnHlE27Kcz/NLo8jV2n8Vjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3z1KvP+; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3z1KvP+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2cdf546f956so154145eec.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 01:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551062; cv=none;
        d=google.com; s=arc-20240605;
        b=hv95LLDWYRWsscKjj2equUdS0D2K9S7M8m8QoQ1ihHhpFKaoc1gcIy0nspT6ziHIH0
         3uG+0x78N1B/04+7fz9WldAoNdfaPEYG9e4WLHvlWT73VFxrnJvFSnQuUQbTj8wekpa8
         /Bp5yu0DbChD1pe93Odzif8eOAEIA8qNa1QYXpPBibgyvZH2MixswCwRfbx8WtNPyiDX
         gujsmT088M8jwJ4OetflIsalMz5wMjVYPPr6ugTAttvXq32DtSOIjbA2xKh83qDkmMmR
         72KBUrI6c5kPAMqnU4khyJCleabvOQbqPVp14qX2cDWqvkUO71wWZYzv62u815TnIFbf
         w64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
        fh=O1UGBbVjrW3BkZD60huvIdw18QRjzLWSBHC0NYC7IB4=;
        b=LqfeM0cQB0QWny0v5h2ovhPusCFkoebOfmZjsqmF8C+Yf9FnbR9KRkaFR6iuVSeqQf
         SWBxVLGfo9RL2fd+JepWouaU7t4KWZjIcYMdG8Gb7IXj1YOHPDR4KyhcPFgCTDdsAs22
         xftXrXhGvMp87ULs0aa+jq1XY+x3Q0N3uEjZ2kui1C4NIAbudq1zrKSoeo82sxEMQdnX
         HhS26NPpABbQcoG5cEsWR3c9c6Apb/SgsSmngxcBzCaPJHTfZD1bRlbvAEqKDlOc9is/
         WHjCmyQEVbTjgvavFeFHl0mmYlGoFiRNiUx37gUHB/XoTNdWE9PiY6IrRESTCjjqcO+b
         5fvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775551062; x=1776155862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
        b=J3z1KvP+plrGKYzfUZxtf/Bl93B77UKY7gFXsyg9lnqxQ4lQpfxmrO/IB5Px3zGq8Y
         T+ZNMjJOGcwSbne9t7HmvyK+WzEILe6jT47dIgUyQroNzuY5E93stOPdry4ZVUtk9/Mj
         uCAnMJBY2kCC1pDtB944IjpdTYL7Dw14pNtV8Ld2+V/Kw1cfslaHZ9lkRz3LBrdwG4do
         w4WtY8nQOW774nVjEpKk1UANFMtl8yH6x4HXidfLM6t7tWbCmmWloXHVosYKF+11CYP2
         iQCEiotKrSjXa8syLxVf4uq01IEtVMo+J6nrYj1OKJg0gqWqB7QijeFrErZcJdAywsPK
         k/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551062; x=1776155862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
        b=pNseZ1KlPkvN5Zw6RUvVUBlrRj44+HobHL89oy3Gx6pSAbru8JHQs5iYtJ0TSp+0TQ
         CDkpyIoA7z9ve5DHRMWg1IDQTvx7aODWVFM856U6V/zjiJX4iRFY7NGZ/f3TEDIwFBQn
         awOXYOEAykCScs0NhSP+GMLZqjPKu+7lubXGgd0be1RREosJeCU7RcFDcbcJHdgS08oA
         vDOHJFDHLxekBuzii4kwu7vdXOf621r/QcH3rI1sAiE9USHfIkJDP2mjZ7wKntuIs1oy
         DfZQfq+a/3vYzzPRRJFfMeWszk9ZlAWvGMh69TovmuvPHAxQdLo+2NH8DDdvVwOKcqI3
         zHjw==
X-Forwarded-Encrypted: i=1; AJvYcCUXA1DzEL+CHc1hpv5LB2JF0P9fogeonYk8OKxhpssHZpWrWnEEjFTkE/KNFAfOCPyFmbaXUXnlBkBpvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwStJwEmEL98EsbhLdo15SApSCRsY1ZuCuWsBBpPWCFWcqlDCDt
	WDljQYeVyp5xhQr22JYYGqRTnKBu0e5mQ1fwLjeiaE/lS0uamGg49DmkgDHReGZWzbgYD01b+CF
	VBMYcbH2h1wfo4BTsDgcR6fWs9N+GgWw=
X-Gm-Gg: AeBDietfZtG7bv4ecNDrFBvQL1oQ1LkW+LSvtXS/lCtTIP+ar/izj5tweyHQEpk8IuA
	hGDRDtSrNGFZpypxK41B8nJ354+k97Qjw4nnjZ2kg0nlCWAdtBTyXBqYHXfWvGk6+dj5aHQ34ho
	fnoHK6I4vW3Z0HH1SHkLL8UFFRCk4hzqyEHDRA6827r4SVkqCXp6dzA/vLx+pg/j0EkQndyneWp
	69XWCLjz+z6gXoSrHyk84qVIbZkQQ5xvxsB23IbQmYnU15nYt00gFFaSzt9V+eLurw2jAhAtJIf
	a99dJEQ6U6xKLgd+5JHkPGQmP4oL7IzMr1i0aGPjXXtXpwQlHWbzJty6NY2q2fluE7Mzq1FNiCZ
	Wsm6EJdb9i7NAt3igPkHAsds=
X-Received: by 2002:a05:7301:d1b:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2cbfcd54f9bmr3830933eec.7.1775551061539; Tue, 07 Apr 2026
 01:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org> <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4> <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
 <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
In-Reply-To: <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Apr 2026 10:37:28 +0200
X-Gm-Features: AQROBzD3OQzI1eA28hVCCiGMvz4r5THmhHuU5dUr3xJV-N5wbeOjrOxDF8RLuuQ
Message-ID: <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
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
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 5:31=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> You're welcome! Actually it seems the lint was already improved
> upstream, starting with 1.90.0.
>
> Link: https://github.com/rust-lang/rust-clippy/commit/c0dc3b61 [0]

Indeed, I had the PR linked in
https://github.com/Rust-for-Linux/linux/issues/349, and it is nicer,
but it would still fire in a case like this patch :(

So we could conditionally enable it for Rust >=3D 1.90.0 now that we
have support for that (and allow locally some cases like this one when
they pop up), but it is still simpler to just ignore it (especially
since it can be quite confusing for other developers to see it
triggering).

I think we may want to eventually re-enable it when we use no unstable
language features.

Added:

    [ In addition, the lint fired without taking into account the features
      that have been enabled in a crate [2]. While this was improved in Rus=
t
      1.90.0 [3], it would still fire in a case like this patch. ]

Thanks!

Cheers,
Miguel
