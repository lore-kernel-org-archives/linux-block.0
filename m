Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F933DEF2
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583717; cv=none; b=ka3jalpU/l4WWruudHoSPYeuI2cjWCUz1PieQSRik7Za7vrfYexhookteNdn1pAkmcyGRH7R6JzEitqO+150XoR10FHukmTyPqJyZ6poVTJ2H7Ze7FfpW/l+SI4Vh6ersY/La1FKQmPF2DT55CZsYzptAaot53VoOhmIpojZ7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583717; c=relaxed/simple;
	bh=+0veVdhvJiXHWfU3srloHvG6XN01ATLsuTVbT5o95C4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PqNkhy7uRd2ir92IX/IHQTcn4Xn3/iZMoh/ZDPYMtGtHATgQ8mE9C+JNHCcxco8H8hjOaGjbKEhGbg29tpNERHH5EQs0h309HYQHuEoznS31d3jMjnlWTPVtyNi4cX17g8RTrlKSav6qRyuFslvTVpG6UFsogXYEVAj7A9hizOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IXVmEbR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IXVmEbR"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836ff58111so21044685e9.1
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771583714; x=1772188514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuBBZbTgNeFNGP2KTDBOL9VXYwpq19RWtpTtqUl4jLA=;
        b=1IXVmEbR3x/gwrILo+4+FcRcD/u6auiA1qN6OHuF2E4HiKwOiUZV/WZYg7nR01wBRC
         uDc6mN3J7GSC90Cjq/Pl/PdqeVANNljGGVlRQ93GXbKdeP4BAL2CYdSf2odeAiSP926f
         8VvMYgO17j0x4H1kkJt4pw3YR0mvMPf25DbJxkP+1Fy4uPdK2x7u+CnvTohxPUtIcJJ2
         lRq08/yfv6iagcLUZRNAR/c3bd/e0bOGQuLoTAVq328hLV4823aO7H0mvGVAAqO9Bf4u
         pyqYEnbThNivwRIBXpA1eOALuzFWBp/BM6GVy1T4rlAt4NjsZDt3y7QY3qBN4fNLaBLR
         EdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771583714; x=1772188514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuBBZbTgNeFNGP2KTDBOL9VXYwpq19RWtpTtqUl4jLA=;
        b=PyCF64wbB9XWbLz+lj547e1FUXVf4iUyfkL1KXQB/CuOO3no2tmBYDSTuqLM+WEwMj
         P/7m0Mx/YzKrEX49GiFdpewfl8y7EKIsqwv9ugZ1TtJe3gXNinZ1K6jaAxzSQp7/scPn
         kzAqum/OuK8u12WJIy6yTL3Z6NJ46iksUDS+GvbOdhUgKVWg/S5Q4f+d824gFxt7Epv9
         id3qv/WESn2OvKCT5kSv23cuiFIzmctvcXh6ltMM/dmyPwAAhUWxVenPo0Npmb8XqZju
         F1EN6X6s9dXpNyCPJUZWMbYl4si4rQAN1nC/wmUZABo13NXSvmaP5vU2DV6M3eEmkN/q
         moTA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGSSJTMym1sejc1D6x+W8S4jfqbdqujGVF1LOk1ovZWkSyhhgo2bxZHal5XJsfcPc4JbzEs1Rp3/2Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1PyrkNqnptVVRq3BpCJNceJFB2uGjaoI5bPXdbQ+YpBfs5SG
	YXB3z6LLulhnziFwFDagIVzfjw4Uc5/zX1Isio9aaFQfEcJnEJ6Z0j1IMG1KvjZdP8Uu+r5uL2O
	bxFbpNqA8+zjDO0EuWA==
X-Received: from wmbdr17.prod.google.com ([2002:a05:600c:6091:b0:480:4a03:7b73])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b26:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-48398a47222mr123364405e9.6.1771583713704;
 Fri, 20 Feb 2026 02:35:13 -0800 (PST)
Date: Fri, 20 Feb 2026 10:35:12 +0000
In-Reply-To: <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org>
Message-ID: <aZg44EmMWKK-z5KP@google.com>
Subject: Re: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
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
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="utf-8"

On Fri, Feb 20, 2026 at 10:51:10AM +0100, Andreas Hindborg wrote:
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
> [ Andreas: Updated documentation, examples, and formatting ]
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> +///         let result = NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");

KBox should probably have an into_raw_nonnull().

> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);

Use ? here.

> +/// }
> +/// // `foo` is out of scope now, so we expect no live allocations.
> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
> +/// ```
> +pub unsafe trait Ownable {
> +    /// Releases the object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `this` points to a valid `Self`.
> +    /// - `*this` is no longer used after this call.
> +    unsafe fn release(this: NonNull<Self>);

Honestly, not using it after this call may be too strong. I can imagine
wanting a value where I have both an ARef<_> and Owned<_> reference to
something similar to the existing Arc<_>/ListArc<_> pattern, and in that
case the value may in fact be accessed after this call if you still have
an ARef<_>.

If you modify Owned<_> invariants and Owned::from_raw() safety
requirements along the lines of what I say below, then this could just
say that the caller must have permission to call this function. The
concrete implementer can specify what that means more directly, but here
all it means is that a prior call to Owned::from_raw() promised to give
you permission to call it.

> +/// A mutable reference to an owned `T`.
> +///
> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> +/// dropped.
> +///
> +/// # Invariants
> +///
> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
> +pub struct Owned<T: Ownable> {
> +    ptr: NonNull<T>,
> +}

I think some more direct and less fuzzy invariants would be:

- This `Owned<T>` holds permissions to call `T::release()` on the value once.
- Until `T::release()` is called, this `Owned<T>` may perform mutable access on the `T`.
- The `T` value is pinned.

> +    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
> +    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
> +        // return a mutable reference to it.
> +        let unpinned = unsafe { self.ptr.as_mut() };
> +
> +        // SAFETY: We never hand out unpinned mutable references to the data in
> +        // `Self`, unless the contained type is `Unpin`.
> +        unsafe { Pin::new_unchecked(unpinned) }

I'd prefer if "pinned" was a type invariant, rather than make an
argument about what kind of APIs exist.

> +impl<T: Ownable + Unpin> DerefMut for Owned<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
> +        // return a mutable reference to it.
> +        unsafe { self.ptr.as_mut() }

Surely this safety comment should say something about pinning.

Alice
