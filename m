Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42A270559;
	Thu, 14 Aug 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157227; cv=none; b=ksMmEkpw5ivVw2MR2BNKCxuIU9/T2IHCdCdCWwLt3g+OnOUGnpWsmyDv/8/wZvCIsaMhIZJf69skzEx8KaIUmdXZhspXDrIKlXelg7Y3rM58GXL7593kAgS4TFGleS8gX7+twzDhTOJUPnK/Mh5+Y9krXg259bDDXzyHrF1lsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157227; c=relaxed/simple;
	bh=+Gb5lCMHMsLqlAIttH2PAfl6IketLup6dYf05JSPbnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWvUNUB7hWuMqZ78SeufWnnGbWRjezUBy+k9grIi7AFfihxlNAjIWICyGP5P+Z767Y6mrWW4uQ5JgdGaqQ/L8vtrAak31s3zjlSTjQgY5FF4RtpRWLqK7jZXUrA2T5+gjODIwxprPkRQa8WwVvgY794yGw+y375vTrfln0kStbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2IxNEFy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2IxNEFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D74C4CEF7;
	Thu, 14 Aug 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755157227;
	bh=+Gb5lCMHMsLqlAIttH2PAfl6IketLup6dYf05JSPbnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o2IxNEFym0JKWZP1M9HsvDC6WtVQAsOM2aPJBT4qe5+jzI4zxNthfTZ9Nv98AsO/5
	 cVn1uNfeQFg2pEgu+vl732JUypCdFXM9ZAVQ4fgXsaWQPaClqz7p5fKClYd5mn+y7O
	 8hTG+flMW5l1TeBD38KBxagZwqWRCkJH46hApXnYa9TH309elY2tJQm7tddeTOYy+O
	 8uf44Vt0HyV/NlVizPCi6ltE43ylFF4KfvWaNJdnZIZ3R8nXshmdtrIbQsc3f/AP32
	 U28xHqSzSr8vu8jn/GBGxtMal4aA8Nm8QR7l28fNkHMClxP0P7uBc7zvYukzTBp3AX
	 W9ySJwuTAJUEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
In-Reply-To: <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
 <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com>
 <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
 <WporCpRrDB_e8ocWi63px_bwtPWqRjDL4kVPNNXFNoI6H-4bgk5P_n4iO0E4m-ElwkiNTyBITwgdMXjREE8VXQ==@protonmail.internalid>
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
 <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
 <wKjTynzVeXix56T1eCrpF4Y7zM7dJVumIB3DljSJeXkHx7Vyb4jKR5X5c5B2yV0DFKItLrncGLWxcTkVynD12g==@protonmail.internalid>
 <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com>
Date: Thu, 14 Aug 2025 09:40:13 +0200
Message-ID: <87zfc2e4gy.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Aug 13, 2025 at 7:36=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > For your convenience, I already wrote a safe wrapper of kstrtobool for
>> > an out-of-tree driver. You're welcome to copy-paste this:
>> >
>> > fn kstrtobool(kstr: &CStr) -> Result<bool> {
>> >     let mut res =3D false;
>> >     to_result(unsafe {
>> > kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
>> >     Ok(res)
>> > }
>>
>> Thanks, I did one as well today, accepting `&str` instead. The examples
>> highlight why it is not great:
>
> Yeah, well, I think we should still use it for consistency.
>
>>   /// Convert common user inputs into boolean values using the kernel's =
`kstrtobool` function.
>>   ///
>>   /// This routine returns `Ok(bool)` if the first character is one of '=
YyTt1NnFf0', or
>>   /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EINVA=
L)`.
>>   ///
>>   /// # Examples
>>   ///
>>   /// ```
>>   /// # use kernel::str::kstrtobool;
>>   ///
>>   /// // Lowercase
>>   /// assert_eq!(kstrtobool("true"), Ok(true));
>>   /// assert_eq!(kstrtobool("tr"), Ok(true));
>>   /// assert_eq!(kstrtobool("t"), Ok(true));
>>   /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
>>   /// assert_eq!(kstrtobool("false"), Ok(false));
>>   /// assert_eq!(kstrtobool("f"), Ok(false));
>>   /// assert_eq!(kstrtobool("yes"), Ok(true));
>>   /// assert_eq!(kstrtobool("no"), Ok(false));
>>   /// assert_eq!(kstrtobool("on"), Ok(true));
>>   /// assert_eq!(kstrtobool("off"), Ok(false));
>>   ///
>>   /// // Camel case
>>   /// assert_eq!(kstrtobool("True"), Ok(true));
>>   /// assert_eq!(kstrtobool("False"), Ok(false));
>>   /// assert_eq!(kstrtobool("Yes"), Ok(true));
>>   /// assert_eq!(kstrtobool("No"), Ok(false));
>>   /// assert_eq!(kstrtobool("On"), Ok(true));
>>   /// assert_eq!(kstrtobool("Off"), Ok(false));
>>   ///
>>   /// // All caps
>>   /// assert_eq!(kstrtobool("TRUE"), Ok(true));
>>   /// assert_eq!(kstrtobool("FALSE"), Ok(false));
>>   /// assert_eq!(kstrtobool("YES"), Ok(true));
>>   /// assert_eq!(kstrtobool("NO"), Ok(false));
>>   /// assert_eq!(kstrtobool("ON"), Ok(true));
>>   /// assert_eq!(kstrtobool("OFF"), Ok(false));
>>   ///
>>   /// // Numeric
>>   /// assert_eq!(kstrtobool("1"), Ok(true));
>>   /// assert_eq!(kstrtobool("0"), Ok(false));
>>   ///
>>   /// // Invalid input
>>   /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
>>   /// assert_eq!(kstrtobool("2"), Err(EINVAL));
>>   /// ```
>>   pub fn kstrtobool(input: &str) -> Result<bool> {
>>       let mut result: bool =3D false;
>>       let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;
>>
>>       // SAFETY: `c_str` points to a valid null-terminated C string, and=
 `result` is a valid
>>       // pointer to a bool that we own.
>>       let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &mu=
t result as *mut bool) };
>>
>>       kernel::error::to_result(ret).map(|_| result)
>>   }
>>
>> Not sure if we should take `CStr` or `str`, what do you think?
>
> Using CStr makes sense, since it avoids having the caller perform a
> useless utf-8 check.

If we re-implement the entire function in rust, we can do the processing
on a `&str`. That way, we can skip the allocation to enforce null
termination. At least for this use case. I would rather do a utf8 check
than allocate and copy.


Best regards,
Andreas Hindborg



