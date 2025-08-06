Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB21E4AB;
	Wed,  6 Aug 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486692; cv=pass; b=qjTqtgU2uoONWaYI/xv9/PA+Ebbl4yQLOqb7cNjRVCDs6BT5PxgoRPzOB2O5scy/DBXiSsrGe6FXw2zq4Hzymy/VvmpRo+75l4luRTWnI5hV/JcgropmKYhNVM6+Ia3vhyaOU8x1kB8ZM1yqlsZx/FklXhh+e13AX9lFojjFh54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486692; c=relaxed/simple;
	bh=C1kQn0AHf7R/LJGPEUJWLITI5kApz6ySrHY8pkeGQFY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QCdY97ZSXKntOJhQt45VaClQCNPY7Ykw5TcBjABrPKmRZSJHe41LNQlet92DZjKz2xxRGCukdf/kavuWeRcx1exsEpg46jUEyadc9vRdHME+FuupKQamA2RLQ1BYNaem51dIiCUdgEOGF4hfF3j4lwf5Z2J4qmfLS8pEIBjbXmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RtND5UJO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RtND5UJO"
ARC-Seal: i=1; a=rsa-sha256; t=1754486671; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gl1YfDGx0YTPh0Cw0sB7lsVM8f/huPXWPRjc3RVupxVYgpu5zlKtV6f9QmrG4YhecPKYhD0t8/zsksKHqLvz/5yH9mNoomWKfYOHdK7XS5AOTg0zKq3/Erm224zq4jlNG3f1pecMK50IbdalanjaOYX7hN9jjPpQin7jg7ZRNS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754486671; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IRKNqubnu5Y6APRIv9QndYEifGukhkmz869hne9+3FA=; 
	b=YY1vSEFSunyRwLiStG0kxdLU3fWujGPi4g8LQkIb39z8lCCjyt9BBu4REqHDen33bu3RWfXEyo05IBrU7RwU0aSy1G4WK93z71Ydcaj2nYN3oFiJh+xlLrn77vmAXoMUkSz61r5w39xgITZ68nVbLBrq/2qJpDVmQAJDXuSp3HQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754486671;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=IRKNqubnu5Y6APRIv9QndYEifGukhkmz869hne9+3FA=;
	b=RtND5UJOyvCTXOt5vc1YHqZqNtnOdPZ9WrBVTkalkbeQwb0qTNtzPI8DTW243Lgq
	aGN8EvHmHPurT/Iq+kokWIp9o669VLfZI90jdYqo4+AKFuh+jpbgcVhhZHjqJxHx5ja
	6lOva/pZ7/D24HoXdL3BwZJLuf4+bQcOdCryd/L4=
Received: by mx.zohomail.com with SMTPS id 1754486668162223.7444188453586;
	Wed, 6 Aug 2025 06:24:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 07/16] rust: block: use `NullTerminatedFormatter`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2B209DA7-1989-40EF-9535-2A9CC98E0980@collabora.com>
Date: Wed, 6 Aug 2025 10:24:12 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB791098-808F-42F2-BA44-EC2BCE7B0AF0@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
 <2B209DA7-1989-40EF-9535-2A9CC98E0980@collabora.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 6 Aug 2025, at 10:22, Daniel Almeida <daniel.almeida@collabora.com> =
wrote:
>=20
> Hi Andreas,
>=20
>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>>=20
>> Use the new `NullTerminatedFormatter` to write the name of a =
`GenDisk` to
>> the name buffer. This new formatter automatically adds a trailing =
null
>> marker after the written characters, so we don't need to append that =
at the
>> call site any longer.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/block/mq/gen_disk.rs   | 11 ++++++-----
>> rust/kernel/block/mq/raw_writer.rs |  1 +
>> rust/kernel/str.rs                 |  1 -
>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
>> index 679ee1bb2195..39be2a31337f 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -7,9 +7,10 @@
>>=20
>> use crate::{
>>    bindings,
>> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>> +    block::mq::{Operations, TagSet},
>>    error::{self, from_err_ptr, Result},
>>    static_lock_class,
>> +    str::NullTerminatedFormatter,
>>    sync::Arc,
>> };
>> use core::fmt::{self, Write};
>> @@ -143,14 +144,14 @@ pub fn build<T: Operations>(
>>        // SAFETY: `gendisk` is a valid pointer as we initialized it =
above
>>        unsafe { (*gendisk).fops =3D &TABLE };
>>=20
>> -        let mut raw_writer =3D RawWriter::from_array(
>> +        let mut writer =3D NullTerminatedFormatter::from_array(
>>            // SAFETY: `gendisk` points to a valid and initialized =
instance. We
>>            // have exclusive access, since the disk is not added to =
the VFS
>>            // yet.
>>            unsafe { &mut (*gendisk).disk_name },
>> -        )?;
>> -        raw_writer.write_fmt(name)?;
>> -        raw_writer.write_char('\0')?;
>> +        )
>> +        .ok_or(error::code::EINVAL)?;
>> +        writer.write_fmt(name)?;
>>=20
>>        // SAFETY: `gendisk` points to a valid and initialized =
instance of
>>        // `struct gendisk`. `set_capacity` takes a lock to =
synchronize this
>> diff --git a/rust/kernel/block/mq/raw_writer.rs =
b/rust/kernel/block/mq/raw_writer.rs
>> index 7e2159e4f6a6..0aef55703e71 100644
>> --- a/rust/kernel/block/mq/raw_writer.rs
>> +++ b/rust/kernel/block/mq/raw_writer.rs
>> @@ -24,6 +24,7 @@ fn new(buffer: &'a mut [u8]) -> =
Result<RawWriter<'a>> {
>>        Ok(Self { buffer, pos: 0 })
>>    }
>>=20
>> +    #[expect(dead_code)]
>=20
> Not sure I understand, is this superseded by..
>=20
>>    pub(crate) fn from_array<const N: usize>(
>>        a: &'a mut [crate::ffi::c_char; N],
>>    ) -> Result<RawWriter<'a>> {
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index c58925438c6e..7396c49174cd 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -858,7 +858,6 @@ pub(crate) fn new(buffer: &'a mut [u8]) -> =
Option<NullTerminatedFormatter<'a>> {
>>        Some(Self { buffer })
>>    }
>>=20
>> -    #[expect(dead_code)]
>=20
> =E2=80=A6 this?
>=20
>>    pub(crate) fn from_array<const N: usize>(
>>        buffer: &'a mut [crate::ffi::c_char; N],
>>    ) -> Option<NullTerminatedFormatter<'a>> {
>>=20
>> --=20
>> 2.47.2
>>=20
>>=20
>>=20
>=20
> =E2=80=94 Daniel

Ah, I just saw the next patch.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

