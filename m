Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EE25485D;
	Tue, 25 Mar 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899209; cv=none; b=j2RuGnfBNQZz8KXsjgXtar9w8Zr/c+jdAmXSgEspGwYcCwl+m+t5+UdruOkvWGxuI0KAIMuV1uTICxmNT+lhQWVC9/yyBaM0+qDGJ4o8BOyegekST/udxUkR64TEPu1Ahr1Pzjfp/BFgVArEuWi7J3L77EALmuyuOIotuS5Kd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899209; c=relaxed/simple;
	bh=L/9OZbHih+ThSpCoQVn5U45aw0Qkhz8V3Pr4tkwf4/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xt6EI46jCBiYvOLh44HAjDTleqkahodvUERzgawVkc/9mmoL2KqkcjPhPEeKm3mW8+ddbqCdER12psxbMPRH1ocGfuzgGIHYwy+qCaNfUdKOCw+ocr5VjoKyZARjlLGpteHVL7GnSscUUk9LqVfvKMl7I5rKyZ9ImPRCAfWJTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aIHo0FKZ; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aIHo0FKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cazukxct4je5rfknpomo5ndhoy.protonmail; t=1742899198; x=1743158398;
	bh=7Qxu14y7hXsByiWaRphWUIUPNCDRSXJiL8l6Iwsjd+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aIHo0FKZH0kRllaPjkCGXFAr6LoxqTKm7hgdunLsTv4w5oVNQtrGYaBtwwFM+3+Xf
	 qb4LhaahWEaV+TcejHjZHz9kb3ta7oFcwRu+LTwldD/khMWlbvdAjibUuTslYBolxf
	 XXuNAfr8AkRPJ4BxpAOPyFK8CpuDZ0j7OmDpiAGN3D8IirMPcqDu3Jf3SliaHYKu3D
	 P9xlyRyG9v1oxDDOrFqCEk2wLMAgSZf59WKZHklHsEj4PaYmqTT2wDB7bkKONR/Dod
	 9ko2k1DPmIVnQTn6h28XdhksWdmirA7W0Xto5S73RspeL499sOmWaw9h52GP5aS/qy
	 IFDNr70n0Yxig==
Date: Tue, 25 Mar 2025 10:39:54 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy
	<robin.murphy@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 6/6] rust: enable `clippy::cast_lossless` lint
Message-ID: <D8PA773W07SS.3T2SZUIJH4HOH@proton.me>
In-Reply-To: <20250324-ptr-as-ptr-v6-6-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com> <20250324-ptr-as-ptr-v6-6-49d1b7fd4290@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d544dfa742d24e7be7a673d1c81bdd5dcc22818d
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 11:01 PM CET, Tamir Duberstein wrote:
> Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
>
>> Rust=E2=80=99s `as` keyword will perform many kinds of conversions, incl=
uding
>> silently lossy conversions. Conversion functions such as `i32::from`
>> will only perform lossless conversions. Using the conversion functions
>> prevents conversions from becoming silently lossy if the input types
>> ever change, and makes it clear for people reading the code that the
>> conversion is lossless.
>
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_loss=
less [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

One nit below, but you may add:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  Makefile                        |  1 +
>  drivers/gpu/drm/drm_panic_qr.rs | 10 +++++-----
>  rust/bindings/lib.rs            |  2 +-
>  rust/kernel/net/phy.rs          |  4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)

> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 0486a32ed314..591e4ca9bc54 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -25,7 +25,7 @@
>  )]
> =20
>  #[allow(dead_code)]
> -#[allow(clippy::ptr_as_ptr)]
> +#[allow(clippy::cast_lossless, clippy::ptr_as_ptr)]

Not sure if we instead want this in a separate attribute, ultimately it
doesn't really matter, but why should `undocumented_unsafe_blocks` be
special?

---
Cheers,
Benno

>  #[allow(clippy::undocumented_unsafe_blocks)]
>  mod bindings_raw {
>      // Manual definition for blocklisted types.

