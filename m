Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFA24889C;
	Wed,  5 Mar 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184463; cv=none; b=bo3DSmDMqhzbDE2JUkxhjj3HxnZXWRNucJSAy8Nkfnydj7T7Ev8xhv/A/jLSm/BZWJjmfGhSDQieVLXYD6SqZ5cVC4mM/giia+E6xUllDFJR9ORIEmAJlr2ed/5UUZtTVBc8AxV+4EzCBNsE1CXel5lYmkPWqz7ZQtkyJv4l4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184463; c=relaxed/simple;
	bh=g9ktS8K7rRoujwZfqZdfcH5n9clfO1z5LX6Sxgf2RCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tw6mJcmQrqHW67gFLRaN+koJTPlNuG7Ypx84vhwSVj6dVF1RyAgcZ4eRmZ8uT0CspBIc8mz2iIon0GPtl1eKHuKzI/oxUnFI4vVNRXeQnixa/dxSZxUpdza3p23EkQ8PixLi10KAKVhsswa6jqzk5EjfCE+fFmYkkhxsgxmXeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipGjJ/CD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipGjJ/CD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4537C4CED1;
	Wed,  5 Mar 2025 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184462;
	bh=g9ktS8K7rRoujwZfqZdfcH5n9clfO1z5LX6Sxgf2RCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ipGjJ/CDS553s7hCyO5v/E+vJZlgFG9NmHvjPEPf8pwx3dNVMg6flc/QnRXE3B+sh
	 Xfq2cR8sCeDWINY8+XaAivWuEe1Toa4f1bWbfJGEL6351o1A+bZQV/nrHMguyToUww
	 Oth2H+nrmhEhcWZD5kner56fcVNsu9vYAorn9n1dFHtuPKeN+sFxWmlyjdk32mVTcw
	 Boo14ca5igGp7sKnEVJS4vjx72ZiBypv1T+KjVJmbRplXVj82xc9tPw6+g6qAHGE6e
	 Awgr1VM4GXzX4BzP5/0oQ/b2gTM9VagRP7xgQ3GvxvFOjA5yAwjQo6DCsHNy6Qx7OQ
	 s4UTUJ8HR9k/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <linux-block@vger.kernel.org>
Subject: Re: [PATCH 15/22] rust: make pin-init its own crate
In-Reply-To: <D88DIE85YT01.11H51NPNE3HP6@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 13:40:19 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<LBAOJwgDK3vs6V-k9Olh9PVQ69a3qCaCgLZctAshaNi73epZNKVgY4rKa-81-5us0Tpj3m3U_W3pCHFTKlIbVQ==@protonmail.internalid>
	<20250304225245.2033120-16-benno.lossin@proton.me>
	<87bjufd6bj.fsf@kernel.org>
	<p2Xt1iMJJIRI9ZD65zucf5N-1vUDxFzg2l66bCD-rZNCrBdZwPi8iu9rKdmEUMlh-gEWESr5rEOuejJGRNF4pw==@protonmail.internalid>
	<D88DIE85YT01.11H51NPNE3HP6@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 15:20:49 +0100
Message-ID: <8734fra79a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 1:12 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> Rename relative paths inside of the crate to still refer to the same
>>> items, also rename paths inside of the kernel crate and adjust the build
>>> system to build the crate.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>
>> [...]
>>
>>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>>> index 7ff82c82ce0c..8e116e266524 100644
>>> --- a/rust/macros/lib.rs
>>> +++ b/rust/macros/lib.rs
>>> @@ -2,23 +2,20 @@
>>>
>>>  //! Crate for all kernel procedural macros.
>>>
>>> +#![feature(lint_reasons)]
>>
>> Commit message should probably say something about this.
>
> Done.
>
>>> +
>>>  // When fixdep scans this, it will find this string `CONFIG_RUSTC_VERS=
ION_TEXT`
>>>  // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, w=
hich is
>>>  // touched by Kconfig when the version string from the compiler change=
s.
>>>
>>>  #[macro_use]
>>> +#[expect(unused_macros)]
>>>  mod quote;
>>>  mod concat_idents;
>>>  mod helpers;
>>>  mod module;
>>>  mod paste;
>>> -#[path =3D "../pin-init/internal/src/pin_data.rs"]
>>> -mod pin_data;
>>> -#[path =3D "../pin-init/internal/src/pinned_drop.rs"]
>>> -mod pinned_drop;
>>>  mod vtable;
>>> -#[path =3D "../pin-init/internal/src/zeroable.rs"]
>>> -mod zeroable;
>>>
>>>  use proc_macro::TokenStream;
>>>
>>> @@ -374,5 +371,3 @@ pub fn paste(input: TokenStream) -> TokenStream {
>>>      paste::expand(&mut tokens);
>>>      tokens.into_iter().collect()
>>>  }
>>> -
>>> -include!("../pin-init/internal/src/lib.rs");
>>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>>> index cdf94f4982df..bdd94c79b0d4 100644
>>> --- a/rust/macros/module.rs
>>> +++ b/rust/macros/module.rs
>>> @@ -236,7 +236,7 @@ impl kernel::ModuleMetadata for {type_} {{
>>>              mod __module_init {{
>>>                  mod __module_init {{
>>>                      use super::super::{type_};
>>> -                    use kernel::init::PinInit;
>>> +                    use pin_init::PinInit;
>>>
>>>                      /// The \"Rust loadable module\" mark.
>>>                      //
>>> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
>>> index 33a199e4f176..11d241b85ac3 100644
>>> --- a/rust/macros/quote.rs
>>> +++ b/rust/macros/quote.rs
>>> @@ -2,6 +2,7 @@
>>>
>>>  use proc_macro::{TokenStream, TokenTree};
>>>
>>> +#[allow(dead_code)]
>>
>> #[expect(dead_code)] ?
>
> `expect` can't be used here, since `quote.rs` is imported in
> `pin-init/internal/src/lib.rs` and used in that crate. But it is unused
> in the `macros` crate, hence we need to allow it.

Got it =F0=9F=91=8D


Best regards,
Andreas Hindborg



