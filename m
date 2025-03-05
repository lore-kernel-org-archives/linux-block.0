Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B11E531
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182030; cv=none; b=bZvbiUepYcfl+5App7zLisTwpqFdLDrsroe+yp7E+BDYsLXhsSRaxS1Yqhd+ES/XCPBdS5v/N6a/nJ/fEXgfz28DxbXK/Spbuyp9Ubmrp1w1neh0ZuzNIJkcx/6ITmMKio0WcGRUTZJSWzAVhtFxZaQRvhmAlnfvqB7BfZqo/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182030; c=relaxed/simple;
	bh=e7TwOMbFJdMvoNvcZfuVrdeGdnthTvDUILUYFsO8VBI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2X9dAZx3URf6nLbNFp6Jck/tdY8sFfM2ISu5+LSB3sCxwOR3MioELSAtjpNpyQXxAFZOp5dQzgRKz4tQpucL3X1LmRGZYmRi4gBW+BsQvNfFya5i3g55oUpw1APV4F1T8E03ZWg+SYj7u6UiG1nfStxx1nG8hv31HbaIwghIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XqpyKo8J; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XqpyKo8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741182026; x=1741441226;
	bh=/msXaYvJoXRol2eVFsyCSpVGRa8zIZ7dH7ygPIw/Gi0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XqpyKo8JRbrIZgKvxFwFPDDt8PMeOd0C40l00ZyDo4UlckLy4MdbyI4dNPLHTPqso
	 DEHJIvr/zKJYpyYAywHCT1E+EjKj5d92ahqEO/TAns0EgMVaYkhapNI3OOuJSAOkk6
	 HWp1sjRNDciTwBqJk0IQwY1mffNeR/LrxVMrPn630FUuEVjE98ZpaLDfYyiJz8EBe9
	 CTOC2+YlXA4m39Dng3/YwLDc+Dsr/2qI6xMi5fe4SES25DtiQGoRo4R+IBNBnhMJYM
	 feTZLevmHDvoXkDHtIcFUnFeYQ9FMtINYryQJzeru3EhABaPil6g78GJA2zZ/aA6xu
	 krchaoJuLEimw==
Date: Wed, 05 Mar 2025 13:40:19 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/22] rust: make pin-init its own crate
Message-ID: <D88DIE85YT01.11H51NPNE3HP6@proton.me>
In-Reply-To: <87bjufd6bj.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <LBAOJwgDK3vs6V-k9Olh9PVQ69a3qCaCgLZctAshaNi73epZNKVgY4rKa-81-5us0Tpj3m3U_W3pCHFTKlIbVQ==@protonmail.internalid> <20250304225245.2033120-16-benno.lossin@proton.me> <87bjufd6bj.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5a0669a79793708d4be68c804eb6d559404b7c94
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:12 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> Rename relative paths inside of the crate to still refer to the same
>> items, also rename paths inside of the kernel crate and adjust the build
>> system to build the crate.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>
> [...]
>
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index 7ff82c82ce0c..8e116e266524 100644
>> --- a/rust/macros/lib.rs
>> +++ b/rust/macros/lib.rs
>> @@ -2,23 +2,20 @@
>>
>>  //! Crate for all kernel procedural macros.
>>
>> +#![feature(lint_reasons)]
>
> Commit message should probably say something about this.

Done.

>> +
>>  // When fixdep scans this, it will find this string `CONFIG_RUSTC_VERSI=
ON_TEXT`
>>  // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, wh=
ich is
>>  // touched by Kconfig when the version string from the compiler changes=
.
>>
>>  #[macro_use]
>> +#[expect(unused_macros)]
>>  mod quote;
>>  mod concat_idents;
>>  mod helpers;
>>  mod module;
>>  mod paste;
>> -#[path =3D "../pin-init/internal/src/pin_data.rs"]
>> -mod pin_data;
>> -#[path =3D "../pin-init/internal/src/pinned_drop.rs"]
>> -mod pinned_drop;
>>  mod vtable;
>> -#[path =3D "../pin-init/internal/src/zeroable.rs"]
>> -mod zeroable;
>>
>>  use proc_macro::TokenStream;
>>
>> @@ -374,5 +371,3 @@ pub fn paste(input: TokenStream) -> TokenStream {
>>      paste::expand(&mut tokens);
>>      tokens.into_iter().collect()
>>  }
>> -
>> -include!("../pin-init/internal/src/lib.rs");
>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> index cdf94f4982df..bdd94c79b0d4 100644
>> --- a/rust/macros/module.rs
>> +++ b/rust/macros/module.rs
>> @@ -236,7 +236,7 @@ impl kernel::ModuleMetadata for {type_} {{
>>              mod __module_init {{
>>                  mod __module_init {{
>>                      use super::super::{type_};
>> -                    use kernel::init::PinInit;
>> +                    use pin_init::PinInit;
>>
>>                      /// The \"Rust loadable module\" mark.
>>                      //
>> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
>> index 33a199e4f176..11d241b85ac3 100644
>> --- a/rust/macros/quote.rs
>> +++ b/rust/macros/quote.rs
>> @@ -2,6 +2,7 @@
>>
>>  use proc_macro::{TokenStream, TokenTree};
>>
>> +#[allow(dead_code)]
>
> #[expect(dead_code)] ?

`expect` can't be used here, since `quote.rs` is imported in
`pin-init/internal/src/lib.rs` and used in that crate. But it is unused
in the `macros` crate, hence we need to allow it.

---
Cheers,
Benno

