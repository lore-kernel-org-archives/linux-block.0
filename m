Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A7244673
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108319; cv=none; b=NE/CvkIXN2Gtw68sK0a61/bgMHEAaqMrl5/oboTlARqcrDe0NJJvvoEX8Q2at/z9eseL/Z/Wt2iEoqnVg4fx1le7S5KDQrPQ5fy1qmHt/iTwo1VEovitj9RpgW9cYGpw8znxgybVGV0ZXQaSnMT5klNkn/p4kNc0jX4xFT1DIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108319; c=relaxed/simple;
	bh=Vg7gh9cfy51BXM2JMJDjES6VAxhOmu+e+zQgq91e+7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4SiTtzjjTZKzq7MqGCLDluwFvPE/pKfmZ0LUMAemmI05mE8jShlBqu818oLMU/WS7uC4vUxF4qCzil/5Bna4IqNMJOGdKfxZwAHxnlXm4xiIryN/FnTh0bi+C6lF1tNn8SKQcf0lPNwrF2zm2SXNWXTr5deVzHuBZxht12RdSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJDJwV/L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJDJwV/L"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e414252dso57481f8f.3
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755108315; x=1755713115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZhIj1HIBrkAfuxlxrCJHN84IlcctzUEsdAGx6WHyfc=;
        b=RJDJwV/LeLboJG6zJ1QJ3HkuKwsinxrfP/CMzgxK62TZgm6hbVua0hMxWWFJ5NhUk+
         /1YFjvmg0ZCxOhkf8KmWAGEzq0bfMImpjbd+ggr+2Ch+lYFPADFQKpxLnXCflvODvNXf
         XGScLq34OSxy3kZBdjHEWhKpU4BPcdQv6owLRGqNUo/PA+Q0ae7HLEmCAvYxtJ2kvaKO
         7VFBWPmr7ej/jgT7+KTwXqCnbJB93rXvFeErGnju6bMDnDMCKdLMbXyMwqfZ4o/FEDs7
         QN8p03bfmIsD1NaZ5o/efkO0+Bz94z4jI89XUo0nsJBPaYYudYFWKcqNm+vIb1/wX41x
         Uc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108315; x=1755713115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZhIj1HIBrkAfuxlxrCJHN84IlcctzUEsdAGx6WHyfc=;
        b=awK7InGFvtAH/Ow56w4H4Sn5hp19osJHHvfmyEnXXPgwgas2eCrg63z7AR3lukElfm
         Xe0Fhn33usgsWJjmHaA0J/kzUF6B3ES3H8lKNyMLRj2eJJpHlmZa4u9Q5ofHc5ibIo1y
         HL7ed0cbd7rE0THnyeQfcbF/UiYWavpK3rS4YFgBTxPbffM/LBaZplSFlzZxKWr0yDcl
         EA7VcxQBEtGA0efcqwp8Knt1PgBOtKmz/wp9yPp/aLQ4ni/7ePFg4i9EdJmIssAPH9b9
         vXWOOSOO8VKplRLhTmeiugt6+mg4Xo9zjqGwN7cWccqoTjnvABpW8+P8+uAU74YHltXf
         VSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHRP/APk4m7PxN8+g0SupiDaB1D5rzkorpxQBzPT+KB7Rg+LmmH48QFgFfgobNo3ukTgUYB7Pn8Y7hug==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhtdd8irD8bzh3tqi4kqVr3BFTM4lUMGy1vIV5U8cBW34F/YJE
	2igWSHCwPNrNVwhXyXD+ByyqnFHHSCmf/+oJyIOblYuRhv46d8xQFCGMCesS4bJgpp3csvphIal
	ji0QCwZ8Oj9NNIPex6wimxLfX0CwwvlTDge+pG3/g
X-Gm-Gg: ASbGnctHHMIZ1I6Qpp6CKc0eLksj6eOk0siDyylty/4nayTzBFHHO+LWGxEGaGWPY2U
	XQfKpcegiwIhESjy/Fts0hfXXg2CrmwFcczU4YCetAExRMmrPjbN707pkq71laqwAwwb2zc2ekO
	mDGkj/sR8YaUECSLCgpLLmta6w3IKBAfXsCKLXk2V9JnyKjBA52Z15shKukQWlvDM/HE4nhJk7Y
	nxZgT4+
X-Google-Smtp-Source: AGHT+IEXxPpWP/dtV2YRycGfty4buirPPVySHBnKiGkqMEsgvMURnxPmxX4fTm9QuMVyENgF0pJocmO64hiRDd19eKg=
X-Received: by 2002:a05:6000:238a:b0:3b8:fb31:a426 with SMTP id
 ffacd0b85a97d-3b9fc383fccmr150346f8f.57.1755108314922; Wed, 13 Aug 2025
 11:05:14 -0700 (PDT)
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
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com> <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 20:05:02 +0200
X-Gm-Features: Ac12FXz5FhnA2ZFwHRbSUpKHD0xBzeC_yFvarbuLcF5iab4q_93gsNFoSEqE4nw
Message-ID: <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com>
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

On Wed, Aug 13, 2025 at 7:36=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > For your convenience, I already wrote a safe wrapper of kstrtobool for
> > an out-of-tree driver. You're welcome to copy-paste this:
> >
> > fn kstrtobool(kstr: &CStr) -> Result<bool> {
> >     let mut res =3D false;
> >     to_result(unsafe {
> > kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
> >     Ok(res)
> > }
>
> Thanks, I did one as well today, accepting `&str` instead. The examples
> highlight why it is not great:

Yeah, well, I think we should still use it for consistency.

>   /// Convert common user inputs into boolean values using the kernel's `=
kstrtobool` function.
>   ///
>   /// This routine returns `Ok(bool)` if the first character is one of 'Y=
yTt1NnFf0', or
>   /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EINVAL=
)`.
>   ///
>   /// # Examples
>   ///
>   /// ```
>   /// # use kernel::str::kstrtobool;
>   ///
>   /// // Lowercase
>   /// assert_eq!(kstrtobool("true"), Ok(true));
>   /// assert_eq!(kstrtobool("tr"), Ok(true));
>   /// assert_eq!(kstrtobool("t"), Ok(true));
>   /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
>   /// assert_eq!(kstrtobool("false"), Ok(false));
>   /// assert_eq!(kstrtobool("f"), Ok(false));
>   /// assert_eq!(kstrtobool("yes"), Ok(true));
>   /// assert_eq!(kstrtobool("no"), Ok(false));
>   /// assert_eq!(kstrtobool("on"), Ok(true));
>   /// assert_eq!(kstrtobool("off"), Ok(false));
>   ///
>   /// // Camel case
>   /// assert_eq!(kstrtobool("True"), Ok(true));
>   /// assert_eq!(kstrtobool("False"), Ok(false));
>   /// assert_eq!(kstrtobool("Yes"), Ok(true));
>   /// assert_eq!(kstrtobool("No"), Ok(false));
>   /// assert_eq!(kstrtobool("On"), Ok(true));
>   /// assert_eq!(kstrtobool("Off"), Ok(false));
>   ///
>   /// // All caps
>   /// assert_eq!(kstrtobool("TRUE"), Ok(true));
>   /// assert_eq!(kstrtobool("FALSE"), Ok(false));
>   /// assert_eq!(kstrtobool("YES"), Ok(true));
>   /// assert_eq!(kstrtobool("NO"), Ok(false));
>   /// assert_eq!(kstrtobool("ON"), Ok(true));
>   /// assert_eq!(kstrtobool("OFF"), Ok(false));
>   ///
>   /// // Numeric
>   /// assert_eq!(kstrtobool("1"), Ok(true));
>   /// assert_eq!(kstrtobool("0"), Ok(false));
>   ///
>   /// // Invalid input
>   /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
>   /// assert_eq!(kstrtobool("2"), Err(EINVAL));
>   /// ```
>   pub fn kstrtobool(input: &str) -> Result<bool> {
>       let mut result: bool =3D false;
>       let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;
>
>       // SAFETY: `c_str` points to a valid null-terminated C string, and =
`result` is a valid
>       // pointer to a bool that we own.
>       let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &mut=
 result as *mut bool) };
>
>       kernel::error::to_result(ret).map(|_| result)
>   }
>
> Not sure if we should take `CStr` or `str`, what do you think?

Using CStr makes sense, since it avoids having the caller perform a
useless utf-8 check.

Alice
