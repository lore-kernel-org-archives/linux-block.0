Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C87241103;
	Wed,  5 Mar 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176784; cv=none; b=VBSrNUQu58IFptKmcIPIR0X9SC+0TEX8ewYk9KuGUyneRTgVTcehnTwawwL3NHfNUC6ExJixU+iit2RURimOKGSTyQN5BjrXKjxoxUmxWqcdZ1qqtgUv1rnwy+vT3FblEYDCiOzTA/0DjTKAxgVIS1BIh4pFzoaJdgU3V4/YbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176784; c=relaxed/simple;
	bh=eubMDtdgNuB2skW94UWckusQsV1iDvfKSRE2EL3KFZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kd/i5vso2o9bZxvTQbDtiAkrnQeDikpyoNhrsQ1oJ6B0B1FE64DX+SgPPfsDKzJDcvJWrgTK+nf1kdyXJqU+GaGJlalTTmXvnHIuIRbkgocxBcMlJah+RSSSB/hnz+qrtkObODKbXMyib7w9V07TvVvl9sc4BCrHUPoCuq8yaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZCtRYJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZCtRYJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FA7C4CEE2;
	Wed,  5 Mar 2025 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741176783;
	bh=eubMDtdgNuB2skW94UWckusQsV1iDvfKSRE2EL3KFZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SZCtRYJcyp8z7gx3HlKRa+TeJ/MJnuQTamXsvEdPArvPc5OtO7CkegdAHNNBIoWf8
	 ULwZ7z9gIKOh/UlH/gB46CdDopK4fzZD+/ewYKZ1wKMu4JEEJsa9WlveGN7c9XHtHX
	 oPHpnQlZgRw89KUI0Wpll9sv16fqOpbSUFVwJJKLjIuGHlV/0GL1pxfgicnMfjwSSV
	 IPn7TrgCj6BnKpNZm+uu8ZcSzpuZ9oI0aVZYyQAjlvwE5lY6+0ebGNClFUxrhsmspm
	 TaSG1e1zEfh31VfzeY80CFw4C50KFwMw4UBjBK7u6HOCmu8mXKq4AOEFeMQu2+F3Tq
	 fKpur5i9jVVfQ==
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
In-Reply-To: <20250304225245.2033120-16-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:21 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<LBAOJwgDK3vs6V-k9Olh9PVQ69a3qCaCgLZctAshaNi73epZNKVgY4rKa-81-5us0Tpj3m3U_W3pCHFTKlIbVQ==@protonmail.internalid>
	<20250304225245.2033120-16-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:12:48 +0100
Message-ID: <87bjufd6bj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Rename relative paths inside of the crate to still refer to the same
> items, also rename paths inside of the kernel crate and adjust the build
> system to build the crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---

[...]

> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 7ff82c82ce0c..8e116e266524 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -2,23 +2,20 @@
>
>  //! Crate for all kernel procedural macros.
>
> +#![feature(lint_reasons)]

Commit message should probably say something about this.

> +
>  // When fixdep scans this, it will find this string `CONFIG_RUSTC_VERSION_TEXT`
>  // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, which is
>  // touched by Kconfig when the version string from the compiler changes.
>
>  #[macro_use]
> +#[expect(unused_macros)]
>  mod quote;
>  mod concat_idents;
>  mod helpers;
>  mod module;
>  mod paste;
> -#[path = "../pin-init/internal/src/pin_data.rs"]
> -mod pin_data;
> -#[path = "../pin-init/internal/src/pinned_drop.rs"]
> -mod pinned_drop;
>  mod vtable;
> -#[path = "../pin-init/internal/src/zeroable.rs"]
> -mod zeroable;
>
>  use proc_macro::TokenStream;
>
> @@ -374,5 +371,3 @@ pub fn paste(input: TokenStream) -> TokenStream {
>      paste::expand(&mut tokens);
>      tokens.into_iter().collect()
>  }
> -
> -include!("../pin-init/internal/src/lib.rs");
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index cdf94f4982df..bdd94c79b0d4 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -236,7 +236,7 @@ impl kernel::ModuleMetadata for {type_} {{
>              mod __module_init {{
>                  mod __module_init {{
>                      use super::super::{type_};
> -                    use kernel::init::PinInit;
> +                    use pin_init::PinInit;
>
>                      /// The \"Rust loadable module\" mark.
>                      //
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index 33a199e4f176..11d241b85ac3 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -2,6 +2,7 @@
>
>  use proc_macro::{TokenStream, TokenTree};
>
> +#[allow(dead_code)]

#[expect(dead_code)] ?


Best regards,
Andreas Hindborg


