Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199219E992;
	Wed,  6 Aug 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492468; cv=none; b=OutgPYXNiXV1HNp+Y5JR2qmG4ZAiQNQ6G3Ghen11/yltm44qP4xY4CP7hcK3OusnDEbfetZXKAAwFFyrVgqjxwOBwvUfp+ua7yC+ylllB/+c41/BvWTWrDfBN1gkH7hcixoM7z10d3megx8A6B/s30q5ogpjt87Nq9bVvrbeU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492468; c=relaxed/simple;
	bh=3x0pztg71wW5Mr4XvTcNhb8qStOVBIxyYbdDxuoOqdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdcFlly45RZ6DJYU1tHXQqDc2HzLOhmf7tK1fE2kIFsGflyQMLPz5I3FwpjHiKUSj4AKiNNON9DaX7AyUMNAPoIhLvJEN8AbDhVmbPx2Y4/FyLencMm7BH6JoRxUGegIhpNeO8OeAtUczo6ekrVqnraBFSvY4t9pERgUURSoGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGLtct4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGLtct4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D93C4CEE7;
	Wed,  6 Aug 2025 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492465;
	bh=3x0pztg71wW5Mr4XvTcNhb8qStOVBIxyYbdDxuoOqdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CGLtct4lBBnUfvqSGuKmUT8uwlZj4rZu5XQSIYTLZRA+F5wYWgcylm6T8RoQrgyjK
	 usMzmbMgl2Hf41kAFRjPe2inkaBqBKJZ9wO3uH5O19vr/Wwc9Xma+ngfrEbqAfCcOZ
	 bXJQUXNGc2kgRUSRcsRhd5lR73seKt9PzCmkFgnKwUYd4F9oL7MdiF92jbYVDjyPun
	 1VCXGM/sEf6//Kfx/2UBaa6XymVS31Ky7J5mUNyknM+N9iSRutULL2WxycR9rAMpqu
	 /R7y3f/v2CPn+NRd5zmcAxWI2zLqeQoUhWpEBkX0sPc3HyAIgqfdJ0F4cZtXRlXJWx
	 4c8L22IumBcrQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/16] rust: str: introduce `NullTerminatedFormatter`
In-Reply-To: <D9A4DD7C-D9C2-4D91-B6C3-684BA1C100C0@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
 <VdhW0gqIRZ7RLuzmrs6QN5FS-l4_hHLuKA1jb2U9YJT7z4GUb8ZxtGoBirJGZdUeD8Qdxz9nP3NobQ1EZU-MEw==@protonmail.internalid>
 <D9A4DD7C-D9C2-4D91-B6C3-684BA1C100C0@collabora.com>
Date: Wed, 06 Aug 2025 16:47:42 +0200
Message-ID: <87a54c8q29.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Add `NullTerminatedFormatter`, a formatter that writes a null terminated
>> string to an array or slice buffer. Because this type needs to manage the
>> trailing null marker, the existing formatters cannot be used to implement
>> this type.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/str.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++=
++
>> 1 file changed, 50 insertions(+)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index b1bc584803b0..c58925438c6e 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -838,6 +838,56 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>>     }
>> }
>>
>> +/// A mutable reference to a byte buffer where a string can be written =
into.
>> +///
>> +/// The buffer will be automatically null terminated after the last wri=
tten character.
>
> Hmm, I suppose you want this to be the only null? See below.

This code went through some iteration. In the original code, I kept a
pointer to the beginning of the buffer and an offset. It made sense to
require the buffer to be null terminated.

In this iteration, I let go of the pointer to the beginning of the
buffer and point to the next writable byte. If this byte is zero, the
original buffer is null terminated. Alice suggested rephrase, and I put
this for the next spin:


  /// # Invariants
  ///
  /// * The first byte of `buffer` is always zero.

At any rate, the final string is allowed to have multiple null
characters in it.

>
>> +///
>> +/// # Invariants
>> +///
>> +/// `buffer` is always null terminated.
>> +pub(crate) struct NullTerminatedFormatter<'a> {
>> +    buffer: &'a mut [u8],
>> +}
>> +
>> +impl<'a> NullTerminatedFormatter<'a> {
>> +    /// Create a new [`Self`] instance.
>> +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFor=
matter<'a>> {
>> +        *(buffer.first_mut()?) =3D 0;
>> +
>> +        // INVARIANT: We null terminated the buffer above.
>> +        Some(Self { buffer })
>> +    }
>> +
>> +    #[expect(dead_code)]
>> +    pub(crate) fn from_array<const N: usize>(
>> +        buffer: &'a mut [crate::ffi::c_char; N],
>> +    ) -> Option<NullTerminatedFormatter<'a>> {
>> +        Self::new(buffer)
>> +    }
>> +}
>> +
>> +impl Write for NullTerminatedFormatter<'_> {
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        let bytes =3D s.as_bytes();
>> +        let len =3D bytes.len();
>> +
>> +        // We want space for a null terminator. Buffer length is always=
 at least 1, so no overflow.
>
> Perhaps this should be a type invariant? I know this is a logical conclus=
ion
> from saying =E2=80=9Cbuffer is always NULL terminated=E2=80=9D, but it=E2=
=80=99s always
> nice to be even more explicit.

I can add a minimum size 1 byte requirement =F0=9F=91=8D

>
>> +        if len > self.buffer.len() - 1 {
>> +            return Err(fmt::Error);
>> +        }
>> +
>> +        let buffer =3D core::mem::take(&mut self.buffer);
>> +        // We break the null termination invariant for a short while.
>> +        buffer[..len].copy_from_slice(bytes);
>> +        self.buffer =3D &mut buffer[len..];
>
> As I said in my first comment, if you want this to be the only null, I
> don=E2=80=99t think the copy above enforces it?

It does not need to be the only one, as long as there is a null at the
end of the final string, we are good.


Best regards,
Andreas Hindborg



