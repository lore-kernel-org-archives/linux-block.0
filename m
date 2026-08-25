Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33146F4A0;
	Tue, 25 Aug 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663773; cv=none; b=qcrgO4V4vzzkVXSaEvgWncqm0eWUxO3DvmoDkZi2Hp0salFzpeu0wodqQCVYFYxcY29crlsfi9kDBWA3DYNPEpUIi1kKPxFG/X03Zb+J3yhUbnnRsO/jvx86PaTos47Au26QeqDw1Tn4fUTt5lL65iEFr+mDXnMmsB2xbADCOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663773; c=relaxed/simple;
	bh=wq5Y5El/WmYkY1phAK+kZjbNSU+OK/F8wzdDHG1sfes=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=js4jg5WObkleW3/ihA0NulHhKu5HvErPOZO/at3n5LwfJ0gQi4INX46SULevGC4TntBcVES3ZZZAnWy7UGsKYJBDjZkm8kQoyqfMCkIhNBfS7YCR2/1omOVyPzZR/W9H9egpNL9gLcErExzK0OVBUTrnBVi63c62u8Ozq5cvRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOOaAim6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOOaAim6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337BA1F00A3A;
	Tue, 25 Aug 2026 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663772;
	bh=SJq7313Y8SDZUpZpBKpgvRr+tGT4kF99sb5KXxTJs5M=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=jOOaAim6vepRVMufMhXqW+jdR92Uj/CQip+PzFYfubv/OMZ3eyUSRGWiKKmKNc3Qs
	 CIm4t5wBReG0/EzVZMMYQaCDwyoS3D65nGSJBRGnjlSdgcrmSdhqvsDrsmHHFvg81d
	 1a8XfJN8Etg9fgBwxvXnF/+QyTa7KXeMaLqVz3T7rfFs5ePpHmWgzlp0ic560K2ES8
	 +sKY3nnCCb3UYoS5DX0VufYTeHjc+/HK7+EsZ/TDSLU4pY9wuI+v6lBKKxY6ZU55MY
	 42LtwLW+ei/NoBBso+QNdCFfVmnM/IhMY8bURoNTKHVq9tVjiB5WIiT8PMFwPcIb5m
	 Ow2FZWe/ZmKAw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:16:00 +0200
Message-Id: <DKY1WYBNR288.36W5V60TR81MG@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v20 7/8] rust: Add `OwnableRefCounted`
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin@linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira Weiny"
 <iweiny@kernel.org>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <driver-core@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>, "Oliver Mangold"
 <oliver.mangold@pm.me>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-7-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-7-490735672187@kernel.org>

On Mon Aug 24, 2026 at 1:17 PM CEST, Andreas Hindborg wrote:
> +/// struct Foo {
> +///     refcount: Cell<usize>,
> +/// }
> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>> {
> +///         // We are just using a `KBox` here to handle the actual allo=
cation, as our `Foo` is
> +///         // not actually a C-allocated object.
> +///         // INVARIANT: We initialize `refcount` to 1, satisfying the =
invariants.
> +///         let result =3D KBox::new(
> +///             Foo {
> +///                 refcount: Cell::new(1),
> +///             },
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result =3D KBox::into_non_null(result);
> +///         // SAFETY:
> +///         //  - We just allocated the `Self`, thus it is valid and we =
own it.
> +///         //  - We can transfer this ownership to the `from_raw` metho=
d.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: We increment and decrement each time the respective funct=
ion is called and only free
> +/// // the `Foo` when the refcount reaches zero.
> +/// unsafe impl RefCounted for Foo {
> +///     fn inc_ref(&self) {
> +///         self.refcount.replace(self.refcount.get() + 1);
> +///     }
> +///
> +///     unsafe fn dec_ref(this: NonNull<Self>) {
> +///         // SAFETY: By requirement on calling this function, the refc=
ount is non-zero,
> +///         // implying the underlying object is valid.
> +///         let refcount =3D unsafe { &this.as_ref().refcount };
> +///         let new_refcount =3D refcount.get() - 1;
> +///         if new_refcount =3D=3D 0 {
> +///             // The `Foo` will be dropped when `KBox` goes out of sco=
pe.
> +///             // SAFETY: The [`KBox<Foo>`] is still alive as the old r=
efcount is 1. We can pass
> +///             // ownership to the [`KBox`] as by requirement on callin=
g this function,
> +///             // the `Self` will no longer be used by the caller.
> +///             unsafe { KBox::from_raw(this.as_ptr()) };
> +///         } else {
> +///             refcount.replace(new_refcount);
> +///         }
> +///     }
> +/// }

This is valid as Foo is !Sync, but I think it does look racy on casual read=
ing
and possibly even encourages people to do the wrong thing, i.e. to peek a
reference count and subsequently act on the read value.

Besides that, if the value can't be shared across tasks it's not overly use=
ful
in the kernel to reference count it in the first place. Do you have a bette=
r
example for this?  Maybe a broken down version of the one that motivates th=
e
patch?
