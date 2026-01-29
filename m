Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1562C8EB;
	Thu, 29 Jan 2026 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664963; cv=none; b=aWTcJ0zr1qNabGJutaJit1t6cBTlY7XFDGlivvb0uAfYLkTivr9Cje1L8PLHGBCN2T2nNZ/eOOjbdhG7yz9QBRaplnD63xj4OgqwKJzvTtSyZRcrFEDVXCsj7CTyOY9aOLDNEYEQepwnZrZCZyzH6XHAcX5jqRdpvsiKDAMhzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664963; c=relaxed/simple;
	bh=GRpyLwqgSGmBUUFmthIraj09ltdMgPQ0JUfe4qVWGAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQxHWKJ0vIMu5sEua/jcRRBoiHtQ1NKQi+VMftPXK8hIWRO6I3t/zySzgjxQmDW5lkfCLZHQF7JwqWjNZM3c2aHOTppdv2McTdUK5S+cKH3S/Xspu/WiRGlXk5wp3cg8ULJ7rD/tIKY2jMe94cL0ChW281P8OlURRUyeNBvKRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Wli8miuL; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Wli8miuL"
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3d48:0:640:52d7:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 14CCF82C43;
	Thu, 29 Jan 2026 08:32:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9Wb8RX7Gs0U0-yhX5z8dm;
	Thu, 29 Jan 2026 08:32:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1769664733;
	bh=WrLzNpFX2It2rSsOfuv5rbguqLqTAiHvyaFM2FNmWsQ=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Wli8miuLfwLPg1x9V+IO3mC06u79ZIuXJEWHY8xJaoEmVFQT5zuajQGyJ5SolB7vn
	 1NEWPfY4RtcgWuqzLRHjYnvSnSp/ix+MWACGDJY3l51kgXzwCAEUaNQzHJuwaZuQDl
	 BEz3NX8PyGngUW4yrTHEvbvu9xY2Ct5frD2SSwtg=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 29 Jan 2026 08:32:07 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Jason Hall <jason.kei.hall@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, lossin@kernel.org,
 boqun.feng@gmail.com, aliceryhl@google.com, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v2] rust: block: use pin_init::zeroed
Message-ID: <20260129083207.7fa363c1@nimda>
In-Reply-To: <20260129082710.312ebe6d@nimda>
References: <20260129030732.1072223-1-jason.kei.hall@gmail.com>
	<20260129082710.312ebe6d@nimda>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Jan 2026 08:27:10 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> On Wed, 28 Jan 2026 20:07:32 -0700
> Jason Hall <jason.kei.hall@gmail.com> wrote:
>=20
> > Replace manual unsafe zeroing of block structures with the safe
> > pin_init::zeroed() helper.
> >=20
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1189
> > Signed-off-by: Jason Hall <jason.kei.hall@gmail.com>
> > ---
> >  rust/kernel/block/mq/gen_disk.rs | 4 +---
> >  rust/kernel/block/mq/tag_set.rs  | 4 +---
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/rust/kernel/block/mq/gen_disk.rs
> > b/rust/kernel/block/mq/gen_disk.rs index 1ce815c8cdab..649c3d9b1ff9
> > 100644 --- a/rust/kernel/block/mq/gen_disk.rs
> > +++ b/rust/kernel/block/mq/gen_disk.rs
> > @@ -106,9 +106,7 @@ pub fn build<T: Operations>(
> >              // SAFETY: T::QueueData was created by the call to
> > `into_foreign()` above drop(unsafe {
> > T::QueueData::from_foreign(data) }); });
> > -
> > -        // SAFETY: `bindings::queue_limits` contain only fields
> > that are valid when zeroed.
> > -        let mut lim: bindings::queue_limits =3D unsafe {
> > core::mem::zeroed() };
> > +        let mut lim: bindings::queue_limits =3D pin_init::zeroed();
> > =20
> >          lim.logical_block_size =3D self.logical_block_size;
> >          lim.physical_block_size =3D self.physical_block_size;
> > diff --git a/rust/kernel/block/mq/tag_set.rs
> > b/rust/kernel/block/mq/tag_set.rs index c3cf56d52bee..dae9df408a86
> > 100644 --- a/rust/kernel/block/mq/tag_set.rs
> > +++ b/rust/kernel/block/mq/tag_set.rs
> > @@ -38,9 +38,7 @@ pub fn new(
> >          num_tags: u32,
> >          num_maps: u32,
> >      ) -> impl PinInit<Self, error::Error> {
> > -        // SAFETY: `blk_mq_tag_set` only contains integers and
> > pointers, which
> > -        // all are allowed to be 0.
> > -        let tag_set: bindings::blk_mq_tag_set =3D unsafe {
> > core::mem::zeroed() };
> > +        let tag_set: bindings::blk_mq_tag_set =3D pin_init::zeroed();
> >          let tag_set: Result<_> =3D
> > core::mem::size_of::<RequestDataWrapper>() .try_into()
> >              .map(|cmd_size| {
>=20
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>

Hmm, I just saw this [1].

[1]:
https://lore.kernel.org/rust-for-linux/176900687943.9724.147867126040022459=
62.b4-ty@kernel.dk/

It looks like this change has already been applied. :/

-Onur
