Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C5279355
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489464; cv=none; b=F0+Hp7FZ7wqwMjJ/lHIphgQ0c2WnOA6iI+ianUWhLFrHKLb3ONS3FDsAzCGrZWMXggvH66YkqmJDeeWwts8UBixX6xvsvUh1laK8m143X6u7NXOhyz+1/awCLsmD4xiCqcw1g7Ci3kW89MsJSV2oUEpXXum8TerZ7ktdmU0NDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489464; c=relaxed/simple;
	bh=upOPgQrKow7ScyuKD1WfCKj6976lQXmqW8HddZVDJoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuTA332HhwXlydruk2ARcwLgp804D1zPTMPgDKRYQObVQIWMlEfs1B4je3mLlEPvUE2Ag7wl9rYJ9wB3UD58e+Ol76Pdhk6uXDo6EDSdLkxeQrdpdFOjF6sVec85lVXBZ3Gb3MXV8thM9pX4sqgMv/eACVyt7Vwlz9QY+omdNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqD9k+yc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqD9k+yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20044C2BCB0
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489464;
	bh=upOPgQrKow7ScyuKD1WfCKj6976lQXmqW8HddZVDJoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kqD9k+ycQlsiYEuHvSJeSyj6IRexOnfGBKsKJSNIrwAwZTHRSHkstsk1e8qmv714V
	 FUeHB5NV6WB/0CHoUr1Lz5BcP8qsJXzTG+0JENcCwgi5JPw01njdTBXGZ88ZdKTTKz
	 5JxnP9jfP9WcAfmbgR3zkTwF4YSGdqaoY6Y1tt9fDxwV+VxZhuFAXjaGFxcfFDAX9I
	 GG4IfT7hAE/g5gMEUz/ACvTuOyhX6rQEGd8gv6B0QFGdjdmSKpTx8VxOVqSB1+yOiy
	 cS3ATA0jMkmkM6QhsQ+y8HtZJ6SKahrSm/DoKMfme1blIQ9Trr9b2zy9kl5UEA9o85
	 v11je9Jgag/Lw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38de18126e7so22246201fa.1
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 08:31:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsIxYg3ttJ6PsodgNEln921Ei5gW7edN7fQQcUUaA8OnMsh5KZHXNS5RlMd1NoQ88bBGdPC0u+4nrhyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGpLPDdG8+vJ7SjxowHV0+96WNk7X9sA2fCDiVLRG76pDRpCL
	OMRj2WguJzcdJELGUVZ6aob7wNG7I0nt9JbuTRot+g/9rz+SVTkSqtRQqRDLu9/XqePyhurNIgQ
	Rbjc/ehl2ufG9aPAjGIIPimlgPYcDF1E=
X-Received: by 2002:a2e:80d3:0:b0:38a:f5a6:9173 with SMTP id
 38308e7fff4ca-38d91c092bamr32802941fa.27.1775489462303; Mon, 06 Apr 2026
 08:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org> <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4> <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
In-Reply-To: <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 6 Apr 2026 11:30:26 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
X-Gm-Features: AQROBzB1MuYM_2_U32IZvjJjOPHSscckixukkJGDNua3mGMOgh49W4AabPzp8YM
Message-ID: <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Mon, Apr 6, 2026 at 10:38=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 6, 2026 at 4:29=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
> >
> > Could you add a reference to the upstream bug report [0] here?
>
> Of course, thanks for the tags!

You're welcome! Actually it seems the lint was already improved
upstream, starting with 1.90.0.

Link: https://github.com/rust-lang/rust-clippy/commit/c0dc3b61 [0]
