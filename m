Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D171B6D01
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748853923; cv=none; b=RiABjqCe01J5sgcv1Er5hAKmZe6mcXRxY3YWSSZL2MJCgQ1sD64UQgN2wrur6G8glEWJxrdeT5H4OCrxPXVWOWk5hcid9Hdu9r6NL/PYEqwX39DrDObCgQSMB+pgPTrKhh++QWHkibEwI94EahYi47qVlEPKJNnZvlXNrKF+7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748853923; c=relaxed/simple;
	bh=FnmJdnnfQEOeXtBs17TTqlpvE/Z6l2P4aZY4NkM4qxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcYOYZ3FxXh4+8MbTOePKJAwLEHLgswErlWY2EreFZ33JRp6N5mSXc4HSkVQEURmeKLQ65xJYgxYLs4R28JNoMzPFPWuryGif8FWPgwgh0MdQ8F3FIg2DztOq+FEAQpZNwZrQbEh/wbm3WvpgTrvqloQoppxG7K5YRYvF3+Gi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIOjdn0/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIOjdn0/"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso543171f8f.3
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748853919; x=1749458719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VThKlttpzakaK+gyheH3wNtNAtAxPTgkZTge5fKamo=;
        b=aIOjdn0/uAGIvgue2rZNxXVyyYtn34qf2+wdYw83h/wiSyICBU6FpJAx7yeu2Otmy7
         PDdjE99CIEyrE3tCK+4Tp9moDWlygpdD/3Y5HLkH3d4m+pbsy2I47tNLMwXethtqAqkD
         wbLcujv5avzsXJLY8dE8DEmTwM5jHSsRDWdWBz68Bb0OMSd7DsyBfHGAq5sUoeibiva5
         aZk+wrdp55qS5xqrAfnXJ9ayEHvfuSCpIWfxUZlmwN/loCWl8ZOQ86hz7QuXJEQ60Y60
         xo7B1QqcLAL2gWI2dNl+Gj5F8SlZSMwVMy7yXqO7r4+9fnBXLVEM5mSPfTmxexxD1LVa
         2Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748853919; x=1749458719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VThKlttpzakaK+gyheH3wNtNAtAxPTgkZTge5fKamo=;
        b=ZfiqlL3NzD2+iNBThvSeoePzOtK7RPz5B44Sr29TUCJgoQzEua/SsLkHVTvJeH0MEN
         cytQQXhNcnNIbI74Gay6yDpW72WLyWLAVv7XhuM9lHH4QV8j2ClZefG76HbpZ7O72gHT
         ED9w+xUdlxaQRnfrQ2D/yu4BlyPvT9flGm71o9qSrCBTwwovw5LCA/ZEBbxLvN9k/Qqn
         i7gzQPDpeXMuquuflXTef8UgN2ETzByMLZSeuSiBZ7guYEfXpc86KlG2KKLDdqbBA741
         MwEGWzROzZm4FZqMbCcQBd+RRW6BQ0QwqsR8uRnev35YhnMRBKj3rRJSENX5HCMxeKBw
         bUmg==
X-Forwarded-Encrypted: i=1; AJvYcCUqnhrmexl4RpAOBR424N+cMGz9E3ztJ1Av4xYMzUaLg07xrlEE5GKWzMJCHo4/cJPIIf6Aa+sW1N7dkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiVaapb2qEeDq20or4xa665LIcvx+eetQhJpKQf4U4M78XER3
	oQZBQRIEA3O38NvosF/OtP+8sL3xL7ZhpbaJehH8kFvqUNYxOle0IXTx7Pkhx6OV0ZZdE9oB+7g
	1VHK3wb771D7cwEf2Bw==
X-Google-Smtp-Source: AGHT+IHMPBuyHnbsu1fzojxAvVWoB+t0RQajrCfQEAuCK7B7x+b6pusC9Fc1oNLvaFICxRkoCWW8Tzuvcbz6+Eo=
X-Received: from wmbdo10.prod.google.com ([2002:a05:600c:680a:b0:450:dcf2:1c36])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8a:b0:3a4:dfc2:b9e1 with SMTP id ffacd0b85a97d-3a4f89a7e71mr9312736f8f.2.1748853918569;
 Mon, 02 Jun 2025 01:45:18 -0700 (PDT)
Date: Mon, 2 Jun 2025 08:45:16 +0000
In-Reply-To: <20250530-cstr-core-v11-4-cd9c0cbcb902@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com> <20250530-cstr-core-v11-4-cd9c0cbcb902@gmail.com>
Message-ID: <aD1knOuEFxv6VQy1@google.com>
Subject: Re: [PATCH v11 4/5] rust: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, May 30, 2025 at 08:27:45AM -0400, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible and rename
> `kernel::c_str!` to `str_to_cstr!` to clarify its intended use.
> 
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

> -/// Creates a new [`CStr`] from a string literal.
> +/// Creates a static C string wrapper at compile time.

A C string *wrapper*? What do you mean? I would drop the word "wrapper"
here.

> -/// The string literal should not contain any `NUL` bytes.
> +/// Rust supports C string literals since Rust 1.77, and they should be used instead of this macro
> +/// where possible. This macro exists to allow static *non-literal* C strings to be created at
> +/// compile time. This is most often used in other macros.
> +///
> +/// # Panics
> +///
> +/// This macro panics if the operand contains an interior `NUL` byte.
>  ///
>  /// # Examples
>  ///
>  /// ```
> -/// # use kernel::c_str;
> +/// # use kernel::str_to_cstr;
>  /// # use kernel::str::CStr;
> -/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
> +/// const MY_CSTR: &CStr = str_to_cstr!(concat!(file!(), ":", line!(), ": My CStr!"));
>  /// ```
>  #[macro_export]
> -macro_rules! c_str {
> +macro_rules! str_to_cstr {
> +    // NB: we could write `($str:lit) => compile_error!("use a C string literal instead");` here but
> +    // that would trigger when the literal is at the top of several macro expansions. That would be
> +    // too limiting to macro authors, so we rely on the name as a hint instead.
>      ($str:expr) => {{
>          const S: &str = concat!($str, "\0");
>          const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {

Alice
