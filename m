Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D31C861E;
	Wed,  9 Jul 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076207; cv=none; b=Dgu3xGi6jh1Agb/5moqHVp8ZG4W3s0PLWR0IuIKFXUoFou2x8y1NIcmbXeTH+n1cO/yH6eaotJeqy2XKq/HYDpl2KV3EpfVLRPLyDUnoQ2LdNEwPcSjZCDKDAvt5R8SGsblonI3J9wrxvBwGboLc6MhB2OYbJubyYMUEsD4C9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076207; c=relaxed/simple;
	bh=WjK6a/OHmJ6yvQ1O4hsR8AA2PzVHS34PUkaDU5m9YRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2x116aflenbbqOB3hMPGHlpU8mCqfWgwx25RdLX8x2NYut8hcHCgIsO2zKRkkfKo9M9jxzZBuzuhbH6Z64nwxMOSNqUPKyNP448Ij4A4WqOYUn7pvbbJBPCsUSqBJ0Q328pJzzjGAUQ247+3x68TMB/F/HCvVcDcMOyR8VgSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNqZ8xT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNqZ8xT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E5FC4CEEF;
	Wed,  9 Jul 2025 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076206;
	bh=WjK6a/OHmJ6yvQ1O4hsR8AA2PzVHS34PUkaDU5m9YRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=khNqZ8xTtDNK0sxRh61VvDlqTs3CqsnmJe/+C2cxmrr1blGmdYKCPGGvPXeJHqtfk
	 YvP7z7nOn5ExlCxbzpIM216W+riK+sWsMjnCGIbw26H7TgOTECQNwQymsIzKC900Ps
	 NwoNQ4noSMGolzQvTB5QxucaV8vx6Bf83+S+/zu5bb96pmLf/Cr/qz7EKbPPRA2gew
	 QoDHgxnqEY3iELWhBOfMJMhWcaAP401Y1XLszkFDIjC1Cua0G3KfrwaCv8rD6iheEG
	 9vqUvgWLMa/Ga3ksiWqMuWB0VmO2Xe4ENm+Fz3tHdnYy8Hqh01uz/e6WkQ3VS2UAsZ
	 HE5MKXAjvBCwQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] rust: str: introduce `NullBorrowFormatter`
In-Reply-To: <aG5tObucycBg9dP1@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 13:23:05 +0000")
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
	<20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org>
	<kpVk60lBMPJ_b4glgS0w-BfbIjN1cMCDSKDoM0RAB4p1Bg1BNfIdA4YRuOu70BbSZjlserkd8EJDwy0vVmR7yQ==@protonmail.internalid>
	<aG5tObucycBg9dP1@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 17:49:57 +0200
Message-ID: <87qzypjrdm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 09:44:58PM +0200, Andreas Hindborg wrote:
>> Add `NullBorrowFormatter`, a formatter that writes a null terminated string
>> to an array or slice buffer. Because this type needs to manage the trailing
>> null marker, the existing formatters cannot be used to implement this type.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index 78b2f95eb3171..05d79cf40c201 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
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
>> +pub(crate) struct NullBorrowFormatter<'a> {
>> +    buffer: &'a mut [u8],
>> +    pos: usize,
>> +}
>
> Do you need `pos`? Often I see this kind of code subslice `buffer`
> instead.

How would that work? Can I move the start index of `buffer` in some way
without an unsafe block?

>
>> +impl<'a> NullBorrowFormatter<'a> {
>> +    /// Create a new [`Self`] instance.
>> +    pub(crate) fn new(buffer: &'a mut [u8]) -> Result<NullBorrowFormatter<'a>> {
>> +        *(buffer.first_mut().ok_or(EINVAL)?) = 0;
>> +
>> +        // INVARIANT: We null terminated the buffer above.
>> +        Ok(Self { buffer, pos: 0 })
>> +    }
>
> I would probably just use an Option for this constructor.

OK.

>
>> +    #[expect(dead_code)]
>> +    pub(crate) fn from_array<const N: usize>(
>> +        a: &'a mut [crate::ffi::c_char; N],
>> +    ) -> Result<NullBorrowFormatter<'a>> {
>> +        Self::new(
>> +            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
>> +            // at least `N` bytes.
>> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
>> +        )
>> +    }
>
> Arrays automatically coerce to slices, so I don't think this is
> necessary. You can just call `new`.

Nice!

>
>> +    /// Return the position of the write pointer in the underlying buffer.
>> +    #[expect(dead_code)]
>> +    pub(crate) fn pos(&self) -> usize {
>> +        self.pos
>> +    }
>
> You delete this function in one of the later patches, so it makes more
> sense not to add it.

Oops.

>
>> +}
>> +
>> +impl Write for NullBorrowFormatter<'_> {
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        let bytes = s.as_bytes();
>> +        let len = bytes.len();
>> +
>> +        // We want space for a null terminator
>> +        if self.pos + len > self.buffer.len() - 1 {
>
> Integer overflow?

In the subtraction? `buffer.len()` is at least 1, because of the type invariant.

Or do you mean I should do a checked add for `self.pos + len`?


Best regards,
Andreas Hindborg


