Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292443E48C
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610876; cv=none; b=JwjHpJVHk+Mq9H9hiPrHKcStK4FYcQ2BujV8RBXX7lQZnv0PrxRbU3l+Cj+QuNuSCZkid0O6rYvZVFIShX5pGdkiuNoSrsuIVmqsCP1gooNPg7yXUie6BkICz3jvgDJPCfr1oE/dnR7pHNb626rcHrkGsn3KpNDsaiy/98vv22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610876; c=relaxed/simple;
	bh=/5GyqFufVnT0ephA4mcW12nnDGKZodyXuu8OjccvjII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UKYaEPHRRLzWalIfHFv+qBaGU33jzm6LhYpnIJXsHwgz0RexHPVvNB4hR0IYtqLQbYiU220Zyf7DIqBA6A4rN9SsWL/YdWG02x121Msx9d5Idp7X/j+s9xRkkHsAVbZKxsL5cCHm5zMMUo9cHgrsL4NcTLtmiAZeQ6d2mVbMme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5An8ztK; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5An8ztK"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-68f9f08cfcaso4074493a12.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781610873; x=1782215673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkz/8WHSlc5z8mgSFYgivmaJvolb4fXApnGq7F/IsFs=;
        b=d5An8ztK8te3TbjRv3dNRhwXyfIjPc2YktyqBrbqUtK1jNVuy7x5TAmHHYc+AN4u+N
         lFxB7laTr7E3rQcNcdQUsyvdp3jdPaUmwQZkmcigC220Cc2L19XkYkERVnFS9E1XMzi5
         1X+EwXKYTpA42ohxCtFTBtGZdn6Uw3adiPaNc/GPZxz5vWK4FK2RHUGmawga9oR/qwMe
         ZawVZ8VQjwBEL4xQNuuaJRylRPnzTpL0vt8zX3vhj0bPfI+Ac2CPUvMWhQPGmZwbtNBQ
         T7rlCWj4Mr1VuxXT8IS8Fg8FOa6rg1BWHYtx92GHoTVdItxt+868JLLi6ILB+BINszQJ
         aLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610873; x=1782215673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkz/8WHSlc5z8mgSFYgivmaJvolb4fXApnGq7F/IsFs=;
        b=jrF2g7Pgq0iKbz93VAT42QbSkcVdsczvnNeCAHN1jV1LJthOOIYxgRtH1E6QTQAUj4
         WqP2GT2f3arVdp7FIiRAVU6W5F/k38L0yE6u2VRcL2f/V6sJ3fL+K66SNDeLYxO9+kLQ
         RFxeyqTfFO3ftxjYt0c7rdSQD5YzNo5Prbklmoyt5bmWdyqf6a4Qg3XUp6ibpjU7d6jA
         7TzD+M/kTskJwoCxinVp4rPNxWcp+LbWlYTvkw6XbeRwXopecOEr1FxdPYV9obJn/23H
         y7AOekPQIqX0o5L7WGmWjNLv7FcSOaHsqDjzC22My15nX6wZPrfcKTXxuNbxtFB+BHZn
         S8LQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AX6oBo8aA5CTSZKJANRhxnmi2VuxMF1PBBZx54nRJHcMlgriyfl1kI0bYBzBiqt1nCU/Z5yl7VvQXbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDbDXDtVVmGj2x9+VJNfI4yjHmWaSxlf9Mn8v7WBRMc3MTW/E
	MK9KXnyMJUhWgWVI9XKQMoMyuQjrxL4Z4lkRjzn8QFa6WfK3TiDumBocbb4+0/qC/ClWzALx/Rs
	3vcftZmFlMBgW1iyURA==
X-Received: from edrc26.prod.google.com ([2002:aa7:d61a:0:b0:68d:205:9a90])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:35c5:b0:695:865:47cd with SMTP id 4fb4d7f45d1cf-695086ebec3mr1540972a12.7.1781610868582;
 Tue, 16 Jun 2026 04:54:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:54:27 +0000
In-Reply-To: <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
Message-ID: <ajE5c-5gZtJRoadx@google.com>
Subject: Re: [PATCH v17 02/10] rust: types: Add Ownable/Owned types
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
	Asahi Lina <lina+kernel@asahilina.net>, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 04, 2026 at 10:11:14PM +0200, Andreas Hindborg wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
> 
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
> 
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
> 
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
>   - Fixes to documentation and commit message.
> ]
> 
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> [ Andreas: Updated documentation, examples, and formatting. Change safety
>   requirements, safety comments. Use a reference for `release`. ]
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall looks good to me, but two nits below. With them fixed:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +pub trait Ownable {
> +    /// Tear down this `Ownable`.
> +    ///
> +    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
> +    /// include freeing the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
> +    /// be transferred to the `release` method.
> +    unsafe fn release(&mut self);

I'd make this take a raw pointer because the pointer can be freed during
the execution of release(), which references don't allow.

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 4329d3c2c2e5..4aec7b699269 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -11,6 +11,17 @@
>  };
>  use pin_init::{PinInit, Wrapper, Zeroable};
>  
> +pub use crate::{
> +    owned::{
> +        Ownable,
> +        Owned, //
> +    },
> +    sync::aref::{
> +        ARef,
> +        AlwaysRefCounted, //
> +    }, //
> +};

We removed the types::ARef re-export, so you shouldn't add it back.

Alice
