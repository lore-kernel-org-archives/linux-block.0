Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C938364059
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918663; cv=none; b=lRLORDh8dFinBz/012tjcAaM+kltNeStXCLW7kOAGtErqUYKVg2iZa9hGlu3ZOJNwlL3dr72rhsA94F38q5iJmPEzyjo8p8Vf2me0zr4ATejDJMa9ZJJYxyn2VOYQOHfxVpk8N5U2k55a7AStwLNRbumH0KGPO+mdj8B+KwEipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918663; c=relaxed/simple;
	bh=rdtI/eBapYxisnhkJe8WgbchqvYRdF1p2iiYViIA4sA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UU88ToUahNKbeTb17wDMcIDr4BSX3NY9p+wcULVdDkl01unNdkQPOzBWVQgIzw7s3S7Xt0t2+zSl1JfW4G1AmSgoW6DRRdLBI+XKllOmvM7Iga0y8pG5ulue7w9d11zHyk4l/wy22Co2UwN7/k3JMwDYpRhBI/CxpGXK7yLbXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWdRoK+K; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWdRoK+K"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837907ec88so60843605e9.0
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771918660; x=1772523460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :f2079rom:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccaw3Qp4EtXU0xb2rrWk95YgoDmXX+bj8GIv5SpCaTk=;
        b=SWdRoK+KhzJadfTvadCRAPVuKb0sl8vOFEf8WLcK11pL2IwUxnCQdNoc/JD+m/GGSv
         HOXKA26IhZsphuq3ASrefnsrga6VaBIVqaDzDmSWj+KVhzXjmlpTnINzrdAk09yHyODl
         mcm9g8FsIefz5Y4s87s6li5kmGVsh9vAgUhREzI0lzQg3wAOSD2jDRH3O1ZLhoMvMJfF
         cghnpmgcIsjwJ//GjYxWryxt5tsS7ADSeL4Q29LnOEOG4qDtt/e+rZwbtWXkmPYsrGWd
         XOOd74xD/13110wH9rovGcjfGe3HXgQH2a2Gt2vE3e/DXTCTucX/WO9TNN+QSs/GEiLD
         y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918660; x=1772523460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :f2079rom:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ccaw3Qp4EtXU0xb2rrWk95YgoDmXX+bj8GIv5SpCaTk=;
        b=vN0Qg2z/+JDtd2Rvq2tVgBXptXL+aziWbl6maSlrGWoDD+iiHr7yRh3TTfI1fV5Rxu
         z3+nk15o+yJV2RCPY/+4Ozd9ei3XC+f5RPbSyUprtHeqWkQeaob51W0KTZW7vKrBM4BU
         lWuNzDu/n8qq5J/PasKgS0v8IEmVH86yeQCKw4UVmaCO2p5RrApEH7L76ZDRTMCso2Dn
         53syIECRYZtCZ76IEqVb2PsB4HIacILZwcCx1fOLc0Pm6UtA5MBRp96Z1xSxqamqKKYr
         EGB+EwMEdl7tzjDIt/rkTYY4X0Xru7PmZDDbuKbablR66joJcaRH4bZh0otz6PxOR/Ak
         Bokg==
X-Forwarded-Encrypted: i=1; AJvYcCXtRWE3toyLZ0FmDPyE5UXLsy0cILy8yE6HVgxv61+if+cVRY9ITGTkqUh8HfmIpzFGZZ2DSjZWS6wNAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFcM90EXnWW97XZ0F4WK2zsPMWIeZUiL11mcakdiNXKzT+b0N+
	rHGsdKhRUTBZdvgnUSHceDII4Su/muNM6SlmY8AgkVISFn9BAqUlvWXmpPnX4iUYvMBN4zxEkRE
	OlV1GFffqaX3mWr/IRA==
X-Received: from wmxb5-n2.prod.google.com ([2002:a05:600d:8445:20b0:483:43dc:999f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:674f:b0:483:6ff1:18b with SMTP id 5b1f17b1804b1-483a9555bafmr189459985e9.0.1771918659820;
 Mon, 23 Feb 2026 23:37:39 -0800 (PST)
Date: Tue, 24 Feb 2026 07:37:38 +0000
F2079rom: Alice Ryhl <aliceryhl@google.com>
In-Reply-To: <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org> <aZg44EmMWKK-z5KP@google.com>
 <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
Message-ID: <aZ1VQmtapuoerpVo@google.com>
Subject: Re: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
From: <aliceryhl@google.com>
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

On Mon, Feb 23, 2026 at 03:59:22PM +0100, Andreas Hindborg wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > On Fri, Feb 20, 2026 at 10:51:10AM +0100, Andreas Hindborg wrote:
> >> From: Asahi Lina <lina+kernel@asahilina.net>
> >> 
> >> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> >> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> >> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> >> within Rust, and does not allow cloning.
> >> 
> >> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> >> resource management to the `T` instead of using a generic allocator.
> >> 
> >> [ om:
> >>   - Split code into separate file and `pub use` it from types.rs.
> >>   - Make from_raw() and into_raw() public.
> >>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
> >>   - Usage example/doctest for Ownable/Owned.
> >>   - Fixes to documentation and commit message.
> >> ]
> >> 
> >> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> >> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> >> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> >> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> >> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> [ Andreas: Updated documentation, examples, and formatting ]
> >> Reviewed-by: Gary Guo <gary@garyguo.net>
> >> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> >> +///         let result = NonNull::new(KBox::into_raw(result))
> >> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
> >
> > KBox should probably have an into_raw_nonnull().
> 
> I can add that.
> 
> >
> >> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
> >> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
> >
> > Use ? here.
> 
> Ok.
> 
> >
> >> +/// }
> >> +/// // `foo` is out of scope now, so we expect no live allocations.
> >> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
> >> +/// ```
> >> +pub unsafe trait Ownable {
> >> +    /// Releases the object.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// Callers must ensure that:
> >> +    /// - `this` points to a valid `Self`.
> >> +    /// - `*this` is no longer used after this call.
> >> +    unsafe fn release(this: NonNull<Self>);
> >
> > Honestly, not using it after this call may be too strong. I can imagine
> > wanting a value where I have both an ARef<_> and Owned<_> reference to
> > something similar to the existing Arc<_>/ListArc<_> pattern, and in that
> > case the value may in fact be accessed after this call if you still have
> > an ARef<_>.
> 
> I do not understand your use case.
> 
> You are not supposed to have both an `ARef` and an `Owned` at the same
> time. The `Owned` is to `ARef` what `UniqueArc` is to `Arc`. It is
> supposed to be unique and no `ARef` can be live while the `Owned` is
> live.
> 
> A `ListArc` is "at most one per list link" and it takes a refcount on
> the object by owning an `Arc`. As far as I recall, it does not provide
> mutable access to anything but the list link. To me, that is a very
> different situation.

I mean, even Page is kind of an example like that.

Pages are refcounted, but when you have a higher-order page, the
__free_pages() call does something special beyond what put_page(). For
example, if you have an order-2 page, which consists of 4 pages, then
the refcount only keeps the first page alive, and __free_pages() frees
the 3 extra pages right away even if refcount is still non-zero. The
first page then stays alive until the last put_page() is called.

> > If you modify Owned<_> invariants and Owned::from_raw() safety
> > requirements along the lines of what I say below, then this could just
> > say that the caller must have permission to call this function. The
> > concrete implementer can specify what that means more directly, but here
> > all it means is that a prior call to Owned::from_raw() promised to give
> > you permission to call it.
> 
> I don't think we need the "permission" wording. How about this:
> 
> 
> /// A mutable reference to an owned `T`.
> ///
> /// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> /// dropped.
> ///
> /// # Invariants
> ///
> /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
> /// - The `T` value is pinned.
> pub struct Owned<T: Ownable> {...}
> 
> 
> impl<T: Ownable> Owned<T> {
>     /// Creates a new instance of [`Owned`].
>     ///
>     /// This function takes over ownership of the underlying object.
>     ///
>     /// # Safety
>     ///
>     /// Callers must ensure that:
>     /// - `ptr` points to a valid instance of `T`.
>     /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
>     pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {...}
> }
> 
> pub trait Ownable {
>     /// Tear down this `Ownable`.
>     ///
>     /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
>     /// include freeing the underlying object.
>     ///
>     /// # Safety
>     ///
>     /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
>     /// be transferred to the `release` method.
>     unsafe fn release(&mut self);
> }
> 
> 
> Note `Ownable` not being an unsafe trait.

It looks ok but see my above reply.

> >> +/// A mutable reference to an owned `T`.
> >> +///
> >> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> >> +/// dropped.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
> >> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
> >> +pub struct Owned<T: Ownable> {
> >> +    ptr: NonNull<T>,
> >> +}
> >
> > I think some more direct and less fuzzy invariants would be:
> >
> > - This `Owned<T>` holds permissions to call `T::release()` on the value once.
> > - Until `T::release()` is called, this `Owned<T>` may perform mutable access on the `T`.
> 
> I do not like the wording for mutable access. Formulating safety
> requirements for `from_raw` and safety comments for that function
> becomes convoluted like this. I'd rather formulate the
> access capability in terms of ownership;
> 
>  - Until `T::release()` is called, this `Owned<T>` exclusively owns the
>    underlying `T`.
> 
> How is that?
> 
> > - The `T` value is pinned.
> 
> I am unsure about the pinning terminology. If we say that `T` is pinned,
> does this mean that it will never move, even if `T: Unpin`? Or is it
> implied that `T` may move if it is `Unpin`?

Values that are `Unpin` can always move - pinning is a no-op for them.

Alice
