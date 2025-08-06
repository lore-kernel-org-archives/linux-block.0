Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F828A719;
	Wed,  6 Aug 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474882; cv=none; b=SZ7PcMX551hNLpUWEQeyjVeC9oK88ZJDFfRlndMtShqORsygnKEob0CIGNqYN72A95nmJaAFzrie8W0g6mbIlhQGL3wMRVPXlys6JfKgSr1fIMGuMxc7yA2w49HeN5eFdc/UClXJj0L8bxT/OtIvt1eJsBLgxIaYk/HLvwGxLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474882; c=relaxed/simple;
	bh=f1NbJSqh6GBASYJjuBNwRlnzbE4OwTcP2uecLickHEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C+ecMeIwjIr5ms/vOliuTqcXdRPsLe4ZCqydx7lHUh5VeF9ggP9zXP6vJMdyUqlzqR7TM1LSnyG8Bm7Rp/SV3powhYCnbD/35+MlMlzYnB72lV7SouufRbV1c4QJ5pmlizQAAs0Jy7+spSuHbp90wyUp+x12Ao5IGAn5UEPlpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLhthkwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLhthkwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7129C4CEE7;
	Wed,  6 Aug 2025 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754474881;
	bh=f1NbJSqh6GBASYJjuBNwRlnzbE4OwTcP2uecLickHEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kLhthkwezZC/HCDtjD7JwTp64WZxWRTPnHXyeA0xUlwtGb+1eFxbkFNwHx/CPa+AG
	 9pzOUk0JdfAeYSojJSdbXoe5iNFY0MlKXFBQ0R+k5kyVCJX3q/PxcjA5WsN4UMoSjS
	 dkH5ivvBqmM1TeDjG3Nc6bmvEnaBzkjbjyBVl5zc3FiK/EqxwMhCENooWqSOmyYnU/
	 aFU51iVOqWPxHMUv1taFTzgfgrLhzMYWmaOqpjpZInSIS5iTcm6LEidK86TMMlRcy/
	 o42b9E1tRWvtOKAjcnbbi0CtiCAoZILWuE6+/PP3u5AaYDztXAuOrQDUECoqonEHe3
	 JI1ogoMkSrFeQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/16] rust: str: introduce `NullTerminatedFormatter`
In-Reply-To: <aHYiK1cr3I_ShQU2@google.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
 <VRona3ekim6kcLh5zRdYOLtSAOdXThmFYEAkLzqimz281mfPSY2KxurwnznX4YzYNn1ttrz2kdXzCJ3kgLD6Sg==@protonmail.internalid>
 <aHYiK1cr3I_ShQU2@google.com>
Date: Wed, 06 Aug 2025 12:07:49 +0200
Message-ID: <87jz3g930q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Jul 11, 2025 at 01:43:06PM +0200, Andreas Hindborg wrote:
>> Add `NullTerminatedFormatter`, a formatter that writes a null terminated
>> string to an array or slice buffer. Because this type needs to manage the
>> trailing null marker, the existing formatters cannot be used to implement
>> this type.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/str.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index b1bc584803b0..c58925438c6e 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -838,6 +838,56 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>>      }
>>  }
>>
>> +/// A mutable reference to a byte buffer where a string can be written into.
>> +///
>> +/// The buffer will be automatically null terminated after the last written character.
>> +///
>> +/// # Invariants
>> +///
>> +/// `buffer` is always null terminated.
>
> Since you modify the buffer range, the actual invariant is that the
> first byte of `buffer` is zero.

It is still null terminated, although your suggestion is more precise.

>
>> +pub(crate) struct NullTerminatedFormatter<'a> {
>
> Isn't it called "nul" rather than "null"? My understanding is that
> "null" is for the pointer case, and "nul" is the name of the ascii
> character at codepoint zero.

I don't know. I did a quick internet search but got no definitive
answer. Wikipedia says "Null character" [1].

[1] https://en.wikipedia.org/wiki/Null_character

>
>> +    buffer: &'a mut [u8],
>> +}
>> +
>> +impl<'a> NullTerminatedFormatter<'a> {
>> +    /// Create a new [`Self`] instance.
>> +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
>> +        *(buffer.first_mut()?) = 0;
>> +
>> +        // INVARIANT: We null terminated the buffer above.
>> +        Some(Self { buffer })
>> +    }
>> +
>> +    #[expect(dead_code)]
>> +    pub(crate) fn from_array<const N: usize>(
>> +        buffer: &'a mut [crate::ffi::c_char; N],
>> +    ) -> Option<NullTerminatedFormatter<'a>> {
>
> Can't you just call `::new` where you use this method?

Yes, this can be elided, thanks.

>
>> +        Self::new(buffer)
>> +    }
>> +}
>> +
>> +impl Write for NullTerminatedFormatter<'_> {
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        let bytes = s.as_bytes();
>> +        let len = bytes.len();
>> +
>> +        // We want space for a null terminator. Buffer length is always at least 1, so no overflow.
>
> overflow -> underflow

Coming from a computer architecture background, these are the same to
me. Also, core has `u16::overflowing_sub` [2].

[2] https://doc.rust-lang.org/stable/core/primitive.u16.html#method.overflowing_sub

>
>> +        if len > self.buffer.len() - 1 {
>
> this is just `len >= self.buffer.len()`.

It is, but is it better?


Best regards,
Andreas Hindborg



