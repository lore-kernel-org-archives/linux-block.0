Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66222FB60F
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715783; cv=none; b=seN4/mesfbbVpyGivuI4njqlhr95z5X1Di8sXeBmKYjvH5mQdJnDiOa5SERxFWscN1h/6A2UM5GC6eohSSQvZKqXPzauityQaIgYymdbaBLoworz1Bzc04cCxfgNKDIrnz04APoaui7JYb15/6v84ztQDsy5T82k0Z+QDn8NX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715783; c=relaxed/simple;
	bh=yGTmQwopt1HdGhxa/Ad97/8uXXqeHBaz5YtUtcqQjCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzw8XtrKJ5psdrH6t7PaCYbBbWgJxcpSCK9w/GjEWB7unLzuf9TCx9mcSo89RGn/KGf/4KDLJi4YS1vqaEsZ0YIwRdh4ct8J2LPHojvQT4m1gS5hpD/iAKPfCuIt3EOe8wnCDPCTbVvnWK6IwPYUSOzMYp/hoDerF8+d5JgwU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwwSNaT8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwwSNaT8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so4928345e9.1
        for <linux-block@vger.kernel.org>; Mon, 01 Sep 2025 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756715780; x=1757320580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHm6+8TqjeCNqsd1vb4l6ddQt0tZxWa+70awNp7aNXU=;
        b=hwwSNaT8/VngiRY0kRUEfhE5Ec/h0JztgogCAdECtVxHn4/yW5Xeua8HuAFpb/RqRZ
         1BS2VREhDJD+kqo8MyH66od2R9XNSShfdmV50W5wdB8sCBHUd8DqZ0Na2CEqHodbdWxJ
         CSgC/PODdxpIndyQ1ybQi5M5T/xphNuk3hg5VGwLZjbwRIHQUH6ATL9XYDKkEmvAneW9
         0RAV6RCUG/NSrFfzEpCwD8Gzyec+03LzhwF0OP7kxk1basGkMqeyj1z8A7gzF+1AHZlF
         t4j9L3eYw5wQxMASsHGX0xDUJOfsl0pC1Bm/oegYei3H5Iepx2gTzLRUT8pEjV2ckfdx
         f+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715780; x=1757320580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHm6+8TqjeCNqsd1vb4l6ddQt0tZxWa+70awNp7aNXU=;
        b=SypALLVb536LjI/J8F5uqiIkqIiLgJhSdH3m8X+cJ83RJ9FjhbutUpBpb0d0waQeV/
         TnsmL6uZFKQ9mJOS559Y87NuBDyVQE/V6CFyCio/frge1tm2uBMscfS/plb31RAFP8Ll
         5tK6SDQTYfIQfFSGnG9x27U4ipwA726zh8tBcJUHQcWzPUh1v/Du56jK5yWGPIXfBpox
         JLr65OEAZW+qGuKGGLIRW7xopL+mqljMCWRbNJlCkfW4uTg6fPrAfVmz0Id5VWNxFr39
         o1xdiHVfo/wUsyGUykFiqGM1BROFfr3KtVNG7FSHVaHKBz6gdHSOKUyxfTi08PI626+E
         Jtwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVHF8SnwBliRemIS2IyEMLRuJK3l/KzGZwuIkpIYeTQflFDuVL/znm6MhENm1zoq5jzs2OG4tKg5jr3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36AM2YjsMQG6bu71ZfkgHgAolRdSfWypFcwY7JxARrroGmbRv
	hWlVODOeeNt8S8CMQD27Pth1SWtkkWZNUTk1RkeefXDKcRwTJnzzTqYm/z9JYOdgY+sVhG1DioK
	hmeeA2sJROtgaLkeDzIPSAPwtsOK4IOShmWEIrvp3
X-Gm-Gg: ASbGncv4ifG5jPjINjHhGRTKNpOelxPW/oXO7Tn+5BEV3b5qctF1pIlqJ3Htu71WZGE
	F05JBIZsp4CEwEqzK3cm25WvAxx2wTV/8QOkF0/qIGaV7uxmKVLMajwiTyXXID4dVBNnw9YGu1O
	/jBf8RSomnexOQdVWDmBl3Ga5RTWhsy/t10fE/jmiaFtRXhCDGS+WKVraI5RHYR3WkHqsD6VKaA
	HIBYqFDnGDL2rGhs2agNWU4g9GlSWgEmri0zrXHs2rCVYOZ7sLspl+8Td3mbtXE/hOg676h8XLs
	Ibn6qFMS1+0=
X-Google-Smtp-Source: AGHT+IFOyZ/K9inIYcfsBcdFd2sn+axEaovrgR1WQbNKlDCM7EkUFX8hdWD8GiWTp7Mb8lsTdSYIgKbtCsVTIIXZFIE=
X-Received: by 2002:a05:600c:8b42:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-45b8558b522mr50268455e9.36.1756715779928; Mon, 01 Sep 2025
 01:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org> <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
In-Reply-To: <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Sep 2025 10:36:07 +0200
X-Gm-Features: Ac12FXwspuKkks0jeuxbZRG0FFiSi8FCXOsFN9qbGxckrqaGTXEv6cLZ9MWyrFc
Message-ID: <CAH5fLgiEi4gZtb6qProd0tXBHU-ZEs2CKCduO25w9V4ZGqgF4g@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:46=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrot=
e:
> >
> > Add a convenience function to convert byte slices to boolean values by
> > wrapping them in a null-terminated C string and delegating to the
> > existing `kstrtobool` function. Only considers the first two bytes of
> > the input slice, following the kernel's boolean parsing semantics.
> >
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> > rust/kernel/str.rs | 35 +++++++++++++++++++++++++++++------
> > 1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index d070c0bd86c3..b185262b4851 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -921,6 +921,20 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> >     }
> > }
> >
> > +/// # Safety
> > +///
> > +/// - `string` must point to a null terminated string that is valid fo=
r read.
> > +unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
> > +    let mut result: bool =3D false;
> > +
> > +    // SAFETY:
> > +    // - By function safety requirement, `string` is a valid null-term=
inated string.
> > +    // - `result` is a valid `bool` that we own.
> > +    let ret =3D unsafe { bindings::kstrtobool(string, &mut result) };
> > +
> > +    kernel::error::to_result(ret).map(|()| result)
> > +}
> > +
> > /// Convert common user inputs into boolean values using the kernel's `=
kstrtobool` function.
> > ///
> > /// This routine returns `Ok(bool)` if the first character is one of 'Y=
yTt1NnFf0', or
> > @@ -968,13 +982,22 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> > /// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> > /// ```
> > pub fn kstrtobool(string: &CStr) -> Result<bool> {
> > -    let mut result: bool =3D false;
> > -
> > -    // SAFETY: `string` is a valid null-terminated C string, and `resu=
lt` is a valid
> > -    // pointer to a bool that we own.
> > -    let ret =3D unsafe { bindings::kstrtobool(string.as_char_ptr(), &m=
ut result) };
> > +    // SAFETY:
> > +    // - The pointer returned by `CStr::as_char_ptr` is guaranteed to =
be
> > +    //   null terminated.
> > +    // - `string` is live and thus the string is valid for read.
> > +    unsafe { kstrtobool_raw(string.as_char_ptr()) }
> > +}
> >
> > -    kernel::error::to_result(ret).map(|()| result)
> > +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtoboo=
l`].
> > +///
> > +/// Only considers at most the first two bytes of `bytes`.
> > +pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
> > +    // `ktostrbool` only considers the first two bytes of the input.
> > +    let stack_string =3D [*bytes.first().unwrap_or(&0), *bytes.get(1).=
unwrap_or(&0), 0];
>
> Can=E2=80=99t this be CStr::from_bytes_with_nul() ?
>
> This means that kstrtobool_raw could take a &CStr directly and thus not b=
e unsafe IIUC?

That's what Andreas did in the previous version. It ended up being
pretty complex because CStr::from_bytes_with_nul() requires that we
compute the length of `stack_string`, which isn't really needed here.
I recommended having a _raw method like this to avoid that complexity.
I don't think this is meaningfully more unsafe the way it is in this
patch.

Alice
