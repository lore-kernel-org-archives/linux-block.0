Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC33B8BD1
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571199; cv=none; b=d3oeQWUlzVr5ayP8SLvCSDORTBLSPTy6vLEfTk6fUzMskEkcybbaR6iM6d9tBcv5EDbptRh1zEMQsRyYnN5LQ/B7LzMZb/2GFYvxyp7flBRPrGtUCUbRAUt1o9Km8h+XwIeZwuQXsFf8Lo1RPDhyPtg8VXZXESbTvXk01z8zL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571199; c=relaxed/simple;
	bh=5mucqtRqZUC32Ucba3hcpr0TYw4Hx9sPWSW0EAmo2Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClZ+njAdhrM2Mt9RfHhkwXN5C/ASOMrhNpNBtIamNOpQeWvpcsHhG+jlGhiY4Ctq8jxoMSEI2yGq4F4Axao8rcXKQc1XRPpuP1dOPv13dUlHj0j19ayfbhi6oOHUq/uBTdkkflmvnaOOjp+Jrwi1UHY3vIL42819KYNn2jBZHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEucaIos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEucaIos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552EAC2BCB4
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571199;
	bh=5mucqtRqZUC32Ucba3hcpr0TYw4Hx9sPWSW0EAmo2Qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gEucaIosHM9b3uXIg9wCIDGrIN+QFR/6iPwXQnWdFH9HWtMNSWt3HnRH18WyUTQpJ
	 s4umHD45tbjfhln8lAimbMNko8WzgfUQDHagpK5O5HB0bTIScDMv2ww+UgBRgkwiqd
	 IRpFehScAdjq8204q/+sCn+ZIHPw+22qUrQNrb3JyH8+zCNdKy3liqkjAvk8WeRpM8
	 gb9416wPR3BQbGzj3b+S3F3dUN9WQF1hw9T8EguZWupT+YQu8uF/mwY1YlJ7eF6Oj+
	 00geFQ0nmAc07pftQft657gbDmcjFQDJjODzgg5FqLvePA1Fq11yxK9ldCXqXvijeM
	 coQR79hDwKq/Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so5668462e87.2
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 07:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUVhNmxcmWqX8mDyzY/PhANXRkpLZZbTTlCEy6urclT/p+aP5I9RvNrafF0NRaW4OMVetcLxkuYwzaqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BMzdQPVfE30gDU6XMowOXIVc+nS/8D/H1ERoaMVEg9C5IO9r
	uXq4oHMD7587MIvJt7BnliUf85/XdXEQNHrFsanlG9MCg9mXi8jXDs797FPRbAMrXiJs/qTmaaS
	nWPiBDX05v+RZh1gVOAPjON+IusCzvww=
X-Received: by 2002:a05:6512:1385:b0:5a2:a8ab:ab5a with SMTP id
 2adb3069b0e04-5a337584899mr6421611e87.30.1775571197439; Tue, 07 Apr 2026
 07:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org> <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4> <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
 <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com> <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
In-Reply-To: <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 7 Apr 2026 10:12:41 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9kqhQ7De+faY20PxGS3pYAyuRM6A6NVtNdNvdn_t9vwGA@mail.gmail.com>
X-Gm-Features: AQROBzCOb76MPiztEakAab4vOA01AReuQXW6N_U0hZ8trRfXq-PYQWgznDgWpRA
Message-ID: <CAJ-ks9kqhQ7De+faY20PxGS3pYAyuRM6A6NVtNdNvdn_t9vwGA@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 4:37=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 6, 2026 at 5:31=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
> >
> > You're welcome! Actually it seems the lint was already improved
> > upstream, starting with 1.90.0.
> >
> > Link: https://github.com/rust-lang/rust-clippy/commit/c0dc3b61 [0]
>
> Indeed, I had the PR linked in
> https://github.com/Rust-for-Linux/linux/issues/349, and it is nicer,
> but it would still fire in a case like this patch :(

Ah, that is possibly https://github.com/rust-lang/rust-clippy/issues/14827.
