Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C22E9EBD
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161943; cv=none; b=G0ZJ0pc83MuyHlgpqhKpd3Hrqv8UZ2ZJStPrRbvynyJv+0yRjp3Y368vUy88bNQJgWnaCLaM0SCscyiblKZ5sBxXN3yW7M2VuSxmGFfwW2JyOHrc2gQYZSilyUxOEYjSuLsjZb4dxchOGtzb0cBQOB8jFoz7nxNo04zKvqapHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161943; c=relaxed/simple;
	bh=o1Szdoofusn4ja6J2Nq+EgTM/QeJljSbOzJBQYC5Xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmZCp1oh9NxaHb5+LoRah/qklBlpbHUvqDQoLSD2OISwNfsn7xchixJh0f8AC2wPZVUSYTR/dtWLY/9GBidqPySPOKtECsx12LqW5aqxeluwPoGOnMWeishZWUCKrnLLU7N7hNATgI5Cv8POB8bCMUGtGh3nY/ig5/tUggJLFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0/dIBtK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0/dIBtK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so4668615e9.2
        for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755161940; x=1755766740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2fToAB1Rcjn651wF/AF4BoAGXD5OP38Zu/DND4w8MA=;
        b=Y0/dIBtKTmYifsnHoIBTCIVgap2xoV8Ns5E06zvmEzqpCNc+sDVKcsVIp4uBFr8cff
         n1rJASrGfvqtB2frY7WhcqZqDgULq6pak42bw2Jjhns9euLdLg996QaqJF2RG9eQq1aE
         I1gbeai0a7LihfaFeAuQop6eWYSI9Sd1rro8+EdV8t0ESw0WcEtgpJMYxenYtvelp9dT
         b/P6bWjjvMR8rH1205dpExMfG/XbpLSCf1PxpmH1OpyRuoATVqKi94ZvUb5s/GI/IfDO
         aYwfXzHuUzDGPYXCZXIr3h3NN+AkHF82AHmk1ckNRlFonj/25Jq7j3Hht2/Sfag5gpb5
         T2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161940; x=1755766740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2fToAB1Rcjn651wF/AF4BoAGXD5OP38Zu/DND4w8MA=;
        b=aEmgGiDdqyTYuuoRWnUGJuYevWnY2Rl6kvhxboQugYGDoOkf/yso+7+99kqtEzkVyf
         u8GfL7xPhFS2Mnvygs/DG7rQzuOA2LzSZsPMEowioUywE0WcLEyf57NmCfJz4TROgyU3
         KWzgvZXk9ifFQFZF2X0e27NzKK2QS+7qm3uIMktfxAygx7pWBZTiLv/pGRAXvGe54eWB
         ed6IxLHKSVhS24nAHBfT/FnKDScCi+anbEJt5AGS/jLth41lFWbbV8Nx+LaMlt+gA69c
         k5r5WkkH1oCmiRnP1Y2O+5/5+oA2tw9PAIdhrcZLeRpeKq1xRvu7agVpVLc6X6NE6TYg
         qHvw==
X-Forwarded-Encrypted: i=1; AJvYcCVYt5rDV5VAawNad+Dy3Ab5Vxng2JE6NdxLwAxJw8HRzrJUifQnIp5t2DzcQ/oDOW7ZQ7iaSuM9jTJ59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbAVx3B2Iqkxc7+gBHwv2YS2otXkRH0MySD8WbSNTdjPnuLD7
	IdVz2HtvScaS1q4SRWOJZYVAatHIb2x9IRxJMB2xFayXko+G6NTB5YLJzx4EDnKqT82egIZgFnA
	Up9V+p7USriGdjKfnVDDtna957GuOIrwFn0sWRvpx
X-Gm-Gg: ASbGnctYOLuj9aPPqQB68kaTErNJiCHgcKCgaDJgfFEZqVKy4LKcbaqkBGXn9EdsdUw
	fISmvbzcUDjUcdWxZGynldED0leiHfhcsMGooyPi7mw/z64zFRPF8jQkHJgl0eNhSIPHKWNOv3m
	9YjIeZ3gjXjP43FtNqMQZk22DoDKhaSWdOctouLfyMDNYa27UjoiiGEQygQ0vXdby404InCC+WE
	2Ar8/adWAyxyIieOIoFQwNqXQ==
X-Google-Smtp-Source: AGHT+IEnok90zWddm6EeCa9vOgl+9GHdTol46JTh/NRAVk1/tIT9B8eSdrtVYMiMwwhqV9azFUftNTxZaAYRyPY4DVY=
X-Received: by 2002:a05:600c:64c7:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-45a1b61538fmr14062525e9.1.1755161939436; Thu, 14 Aug 2025
 01:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org> <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com> <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
 <WporCpRrDB_e8ocWi63px_bwtPWqRjDL4kVPNNXFNoI6H-4bgk5P_n4iO0E4m-ElwkiNTyBITwgdMXjREE8VXQ==@protonmail.internalid>
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
 <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set> <wKjTynzVeXix56T1eCrpF4Y7zM7dJVumIB3DljSJeXkHx7Vyb4jKR5X5c5B2yV0DFKItLrncGLWxcTkVynD12g==@protonmail.internalid>
 <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com> <87zfc2e4gy.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87zfc2e4gy.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 14 Aug 2025 10:58:47 +0200
X-Gm-Features: Ac12FXzvl-VOlMNOzmyRS7iEzUNls9Gq8WBcmNjnQTA3yaE2PQLweZJ0Y0vj2qk
Message-ID: <CAH5fLgjnYiAo3jfbyjZeRu5siMgoqYi1fbFaxrixGdqXxtZXcA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:40=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Wed, Aug 13, 2025 at 7:36=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > For your convenience, I already wrote a safe wrapper of kstrtobool f=
or
> >> > an out-of-tree driver. You're welcome to copy-paste this:
> >> >
> >> > fn kstrtobool(kstr: &CStr) -> Result<bool> {
> >> >     let mut res =3D false;
> >> >     to_result(unsafe {
> >> > kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
> >> >     Ok(res)
> >> > }
> >>
> >> Thanks, I did one as well today, accepting `&str` instead. The example=
s
> >> highlight why it is not great:
> >
> > Yeah, well, I think we should still use it for consistency.
> >
> >>   /// Convert common user inputs into boolean values using the kernel'=
s `kstrtobool` function.
> >>   ///
> >>   /// This routine returns `Ok(bool)` if the first character is one of=
 'YyTt1NnFf0', or
> >>   /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EIN=
VAL)`.
> >>   ///
> >>   /// # Examples
> >>   ///
> >>   /// ```
> >>   /// # use kernel::str::kstrtobool;
> >>   ///
> >>   /// // Lowercase
> >>   /// assert_eq!(kstrtobool("true"), Ok(true));
> >>   /// assert_eq!(kstrtobool("tr"), Ok(true));
> >>   /// assert_eq!(kstrtobool("t"), Ok(true));
> >>   /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
> >>   /// assert_eq!(kstrtobool("false"), Ok(false));
> >>   /// assert_eq!(kstrtobool("f"), Ok(false));
> >>   /// assert_eq!(kstrtobool("yes"), Ok(true));
> >>   /// assert_eq!(kstrtobool("no"), Ok(false));
> >>   /// assert_eq!(kstrtobool("on"), Ok(true));
> >>   /// assert_eq!(kstrtobool("off"), Ok(false));
> >>   ///
> >>   /// // Camel case
> >>   /// assert_eq!(kstrtobool("True"), Ok(true));
> >>   /// assert_eq!(kstrtobool("False"), Ok(false));
> >>   /// assert_eq!(kstrtobool("Yes"), Ok(true));
> >>   /// assert_eq!(kstrtobool("No"), Ok(false));
> >>   /// assert_eq!(kstrtobool("On"), Ok(true));
> >>   /// assert_eq!(kstrtobool("Off"), Ok(false));
> >>   ///
> >>   /// // All caps
> >>   /// assert_eq!(kstrtobool("TRUE"), Ok(true));
> >>   /// assert_eq!(kstrtobool("FALSE"), Ok(false));
> >>   /// assert_eq!(kstrtobool("YES"), Ok(true));
> >>   /// assert_eq!(kstrtobool("NO"), Ok(false));
> >>   /// assert_eq!(kstrtobool("ON"), Ok(true));
> >>   /// assert_eq!(kstrtobool("OFF"), Ok(false));
> >>   ///
> >>   /// // Numeric
> >>   /// assert_eq!(kstrtobool("1"), Ok(true));
> >>   /// assert_eq!(kstrtobool("0"), Ok(false));
> >>   ///
> >>   /// // Invalid input
> >>   /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
> >>   /// assert_eq!(kstrtobool("2"), Err(EINVAL));
> >>   /// ```
> >>   pub fn kstrtobool(input: &str) -> Result<bool> {
> >>       let mut result: bool =3D false;
> >>       let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;
> >>
> >>       // SAFETY: `c_str` points to a valid null-terminated C string, a=
nd `result` is a valid
> >>       // pointer to a bool that we own.
> >>       let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &=
mut result as *mut bool) };
> >>
> >>       kernel::error::to_result(ret).map(|_| result)
> >>   }
> >>
> >> Not sure if we should take `CStr` or `str`, what do you think?
> >
> > Using CStr makes sense, since it avoids having the caller perform a
> > useless utf-8 check.
>
> If we re-implement the entire function in rust, we can do the processing
> on a `&str`. That way, we can skip the allocation to enforce null
> termination. At least for this use case. I would rather do a utf8 check
> than allocate and copy.

You can copy to an array on the stack, so allocations aren't necessary
even if the string is not nul-terminated. I don't think we should
duplicate this logic.

And if we do add a Rust method that does not enforce a nul-check, then
I'd say it should use &[u8] as the argument rather than &str. (Or
possibly &Bstr.)

Alice
