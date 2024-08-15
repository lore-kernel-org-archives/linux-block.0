Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057D1DDF5
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749353; cv=none; b=Vwj5R+UTqQEyBoFdSrciCS+w8MOwtFgwoF5aVZ48t9WGSuqksEt2gOHzwmbTjh2C52f1FcXXVtZD6AgrwyPM3foeGyNZZQEYWRKynmp41Rmsk8XrUZIKVBmgMZ+mmZR0/X1MdUiluKKIMjx0uo/bt5uyRJ1tMJy3dcsS/ASZSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749353; c=relaxed/simple;
	bh=3IA/lEQS5Ka5U3GAMoEyvBhsFlr1JFKsKR/ohfA3REs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uibhTXThcQIghl4a4DjDaWKz0RT6siY5Nh/41gNvlauopmUyvaem1bbvi2q9ZRIUJBOfQSEfv6c3l5jwn/QK79H93iooJekX0qkvD8LTINSksphU0gtb/bU388tgeN+vhhXEhE/OEQx9+nb77Kr147peuSNA+9s1c5GKQdpA2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bEPOA2se; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bEPOA2se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723749349; x=1724008549;
	bh=3IA/lEQS5Ka5U3GAMoEyvBhsFlr1JFKsKR/ohfA3REs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bEPOA2seWoWAvvPfEDo2VYV4iguqmyMHOj798GZZgq48xgguk84oyqCyFLm8kutlV
	 f8IXV12LywLJOn7Mrt1IM8nsCD596IfFNCgQdFKJAl5O98wjiFzydwa9w3y8rB/IcV
	 WJ2LaoO7f5rKO10Q0clbr4P1tm45xabLTFw9tiawcm5eLfUMMAzYLQU5s0/M60Czu+
	 0IeiJ929pnADxyp9bW1fMng244RRbl/9i0v6n4qgC2q8vouJktkGVZ4nrmw8vIThJi
	 kJBbu3jgz7n/HDwGJU6hp8Pe7dmXbGaSnf1eAlgS95U0FtqfXNjB7ppyl6PIUEbthe
	 UcB81T8CC3neA==
Date: Thu, 15 Aug 2024 19:15:43 +0000
To: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <5b251842-564c-4b7a-8d4d-d7fc2b1b857c@proton.me>
In-Reply-To: <10ae8a5a-5dbc-4d6a-8f86-30236dacc5b3@proton.me>
References: <20240815074519.2684107-1-nmi@metaspace.dk> <20240815074519.2684107-3-nmi@metaspace.dk> <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com> <10ae8a5a-5dbc-4d6a-8f86-30236dacc5b3@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3516b6ed98df991ff6888e2756a91275131bcb07
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 21:05, Benno Lossin wrote:
> On 15.08.24 10:04, Alice Ryhl wrote:
>> On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.=
dk> wrote:
>>>
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic l=
ock
>>> class key without registering the key. This is incorrect use of the API=
,
>>> which causes a `WARN` trace. This patch fixes the issue by using a stat=
ic
>>> lock class key, which is more appropriate for the situation anyway.
>>>
>>> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
>>> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
>>> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Gene=
ral/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.=
20lock.20warning
>>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>
>> LGTM. This makes me wonder if there's some design mistake in how we
>> handle lock classes in Rust.
>=20
> So `LockClassKey::new` doesn't initialize the `lock_class_key` and is
> also movable. I think in this case we either just overlooked it or
> thought that the C side would initialize it.
>=20
> For those people that know about this, are there APIs that initialize
> `lock_class_key` themselves? (ie not a function to initialize a lock
> class key, but rather an API like `__blk_mq_alloc_disk`)
> Because if it is usually expected that the class key is already
> initialized, then I think we should change our abstraction.

Sorry, I got confused, this has nothing to do with initialization.

---
Cheers,
Benno

> Additionally, I think that it needs to be pinned, since it contains an
> `struct hlist_node` (I might be wrong on this, but that looks and sounds
> like an intrusive linked list).
>=20
> Also the `new` function is probably prone for misuse, since it will
> create a new lock class key every time it is run. But as I learned in
> [1], the more common use-case is a single lock class key for several
> locks. Therefore it might be a good idea to at least rename it to
> `new_dynamic` or similar and add appropriate documentation pointing to
> `static_lock_class!`.
>=20
> [1]: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/t=
opic/.E2.9C.94.206.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20d=
octest.20lock.20warning/near/460074755
>=20
> ---
> Cheers,
> Benno
>=20
>=20

