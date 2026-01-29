Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B82C3271;
	Thu, 29 Jan 2026 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664446; cv=none; b=Nck3kdwk3BzYMcT7Flp+GiRPsjOqIHt4sH4oiOFwIpM4YvF5en+3nudvZRu35kz4LOL3HmrycPQX6tyrtikbKSOA40Jl581WQRkkp1tzb5xoniEgvkKhvOjWCJZqLxqxnH90N76iectWnBtjKzZ736LMz3BD+KPJrYqBoEYCU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664446; c=relaxed/simple;
	bh=fqo8CntMTAtZ3xAe1l9CC/RQzvFPfAeiVbWa8O9F9Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3BGTPHBMu8jBooL8Dh5xUkGULj8jhwfCmG78SiNN8FWJWzPiJCkZ9dempyIwMzN6R7l6Q2yul5M+eXkac8X/ANKCCQoDqurzyAOpJ8AstF8lrvD8nkK7JJsyGSzWIOlJeTJrTSJ9i2Wq1DZe6z/4cy82PchaSOz0SJBg2ybVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=OmitwoX3; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="OmitwoX3"
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ea8:0:640:4403:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 5893789F6B;
	Thu, 29 Jan 2026 08:27:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CRbKt13GveA0-nVNcVrPq;
	Thu, 29 Jan 2026 08:27:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1769664434;
	bh=UNgHB4wLUVjfEgpI5MLyVFVj2P+Sgic+5PWW2qTYiiM=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=OmitwoX37Kg1xrxAnuwObXohYzC4tjlk4QPEVdi4M1F+G45XecwxV4E8+qXnyepaV
	 hJyUmbjsi6y0CbH0DqrkUIfSHGtVl/k4kuwulVLO4Cn7IYxC06P3CulIr0BL07Oi2D
	 EJ5J5KrBAF1cUN6GQxMrqBprjH/mRokkfucwIQUE=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 29 Jan 2026 08:27:10 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Jason Hall <jason.kei.hall@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, lossin@kernel.org,
 boqun.feng@gmail.com, aliceryhl@google.com, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v2] rust: block: use pin_init::zeroed
Message-ID: <20260129082710.312ebe6d@nimda>
In-Reply-To: <20260129030732.1072223-1-jason.kei.hall@gmail.com>
References: <20260129030732.1072223-1-jason.kei.hall@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jan 2026 20:07:32 -0700
Jason Hall <jason.kei.hall@gmail.com> wrote:

> Replace manual unsafe zeroing of block structures with the safe
> pin_init::zeroed() helper.
>=20
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Jason Hall <jason.kei.hall@gmail.com>
> ---
>  rust/kernel/block/mq/gen_disk.rs | 4 +---
>  rust/kernel/block/mq/tag_set.rs  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/block/mq/gen_disk.rs
> b/rust/kernel/block/mq/gen_disk.rs index 1ce815c8cdab..649c3d9b1ff9
> 100644 --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -106,9 +106,7 @@ pub fn build<T: Operations>(
>              // SAFETY: T::QueueData was created by the call to
> `into_foreign()` above drop(unsafe { T::QueueData::from_foreign(data)
> }); });
> -
> -        // SAFETY: `bindings::queue_limits` contain only fields that
> are valid when zeroed.
> -        let mut lim: bindings::queue_limits =3D unsafe {
> core::mem::zeroed() };
> +        let mut lim: bindings::queue_limits =3D pin_init::zeroed();
> =20
>          lim.logical_block_size =3D self.logical_block_size;
>          lim.physical_block_size =3D self.physical_block_size;
> diff --git a/rust/kernel/block/mq/tag_set.rs
> b/rust/kernel/block/mq/tag_set.rs index c3cf56d52bee..dae9df408a86
> 100644 --- a/rust/kernel/block/mq/tag_set.rs
> +++ b/rust/kernel/block/mq/tag_set.rs
> @@ -38,9 +38,7 @@ pub fn new(
>          num_tags: u32,
>          num_maps: u32,
>      ) -> impl PinInit<Self, error::Error> {
> -        // SAFETY: `blk_mq_tag_set` only contains integers and
> pointers, which
> -        // all are allowed to be 0.
> -        let tag_set: bindings::blk_mq_tag_set =3D unsafe {
> core::mem::zeroed() };
> +        let tag_set: bindings::blk_mq_tag_set =3D pin_init::zeroed();
>          let tag_set: Result<_> =3D
> core::mem::size_of::<RequestDataWrapper>() .try_into()
>              .map(|cmd_size| {

Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>
