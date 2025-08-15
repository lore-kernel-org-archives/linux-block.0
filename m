Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4924635E;
	Fri, 15 Aug 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246578; cv=none; b=HXJwFV8camhG01AMbo9f+rwVd1kRAKwPTPRS+O0cZRNg3dILNsoQKuMJFhduiTCkFJO8Lie9orkgJYW9IjQ21b5H23nvJm0Mp5Zi/jPrTE20mcr5+T6UsaJ8H4Sn47FWhVBd4Nboed7fekkAwXkD28M8J5CownRpZ73RYbt9Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246578; c=relaxed/simple;
	bh=Xyye2AF1wmSsP0D40BarzXd3YLVHTSI2Ehw/u8Z/TTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUs7DACyzZbChtFMxzWPKRVBUXFXtcLB0osEPwH5XjCfzEXctU4MIsNHYgiAjd5AxWKDt8IN96rJ2ptBASSptU15PAhRa6FOvCMpMIxO61OWrt2uz6qEBfhHqatvCCHIs2Q9G3GFueoIiiVBp0RpB+Kjlqp4sQKDZKvDAwQlnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR/8qZrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR/8qZrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0353FC4CEF4;
	Fri, 15 Aug 2025 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246574;
	bh=Xyye2AF1wmSsP0D40BarzXd3YLVHTSI2Ehw/u8Z/TTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CR/8qZrqwjQwjYJ0phriw9y4I1wwIB+XpdSacoRPLLaJoe3dvbg2UXioDbTd4f/2u
	 ozX88f2vzdFFPy0FOaFC88ZxeQJjSw9VB2HysXyS9LPObXl6amgDdI8xipldKZBZti
	 A+JHDPvspYPKp0RKc1O2coa1J5xA5Fg8Geh3lfUXnaJYLqi3+TbzUaeFfGlk0761jK
	 fge08BleYeouq/bnYTswDhgmJsobxoO0LdjxGXxupNX/zVSqgpfYjbKDbEQ9WfoXO9
	 M4IrKllrRKBjTgYp5B36hrTU0SzdyXQ3OJOtLRIOOfhs9lav8gUghRlWE3y3PUK5Bm
	 HGZIKAakMtiIA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] rust: str: add `bytes_to_bool` helper function
In-Reply-To: <aJ7r_W0BzdSYMfT6@google.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
 <zsaOdCKnN1sVET34FMYvITPQpgAkfL_JPF6FtL4MUbyubgqSNo5PsO6bgIyzmMP2bhkEAbXEyui3iTqZEkrx0g==@protonmail.internalid>
 <aJ7r_W0BzdSYMfT6@google.com>
Date: Fri, 15 Aug 2025 10:28:32 +0200
Message-ID: <87ldnldm4v.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Aug 15, 2025 at 09:30:41AM +0200, Andreas Hindborg wrote:
>> Add a convenience function to convert byte slices to boolean values by
>> wrapping them in a null-terminated C string and delegating to the
>> existing `kstrtobool` function. Only considers the first two bytes of
>> the input slice, following the kernel's boolean parsing semantics.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/str.rs | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index 5611f7846dc0..ced1cb639efc 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -978,6 +978,16 @@ pub fn kstrtobool(string: &CStr) -> Result<bool> {
>>      kernel::error::to_result(ret).map(|()| result)
>>  }
>>
>> +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
>> +///
>> +/// Only considers at most the first two bytes of `bytes`.
>> +pub fn bytes_to_bool(bytes: &[u8]) -> Result<bool> {
>> +    // `ktostrbool` only considers the first two bytes of the input.
>> +    let nbuffer = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
>> +    let c_str = CStr::from_bytes_with_nul(nbuffer.split_inclusive(|c| *c == 0).next().unwrap())?;
>> +    kstrtobool(c_str)
>> +}
>
> Ouch. That's unpleasant. I would probably suggest this instead to avoid
> the length computation:
>
> /// # Safety
> /// `string` is a readable NUL-terminated string
> unsafe fn kstrtobool_raw(string: *const c_char) -> Result<bool> {
>     let mut result: bool = false;
>     let ret = unsafe { bindings::kstrtobool(string, &raw mut result) };
>     kernel::error::to_result(ret).map(|()| result)
> }
>
> pub fn kstrtobool(string: &CStr) -> Result<bool> {
>     // SAFETY: Caller ensures that `string` is NUL-terminated.
>     unsafe { kstrtobool_cstr(string.as_char_ptr()) }
> }
>
> pub fn kstrtobool_bytes(string: &[u8]) -> Result<bool> {
>     let mut stack_string = [0u8; 3];
>
>     if let Some(first) = string.get(0) {

Clippy will complain about `string.get(0)` suggesting `string.first()`.

>         stack_string[0] = *first;
>     }
>     if let Some(second) = string.get(1) {
>         stack_string[1] = *second;
>     }

I don't really think this procedural assignment is better or worse than assigning
at declaration.

>
>     // SAFETY: stack_string[2] is zero, so the string is NUL-terminated.
>     unsafe { kstrtobool_cstr(stack_string.as_ptr()) }

I'll split it up.


Best regards,
Andreas Hindborg



