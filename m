Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3128FAAB;
	Wed,  6 Aug 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492469; cv=none; b=mnrRYoBFNctYRr4lhRYcG2/QtA+K3g5fd5OJF/xgNiZWBvlc+xBH0TFTGtY5/4rD/zmCnxqJmeSpb2c+GEwH9VdeFKJ+Fx1xah8NWP4Gw+eQtq6u9JkJRP4Pjhc7EqD69KS1FZe4oYyto4l1r9yGLrTvd87POO5+pNWulcr90v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492469; c=relaxed/simple;
	bh=NaiA8W9/tf9ZqklAa969sv6kZ2CMk3Z3s8Ryo+amXdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJY3xHuyOEvLKRwI/TgfCVxN1oIHEQR5T5Z2RivcmPclEMjZZmBuIc3QpNM2rjEWfi6rhsmLfe89XGXm7cG0NO7CNFzgvbfFIstCvxS2/Ozo+P0iHOrFk+DQHDddq6guSW8ICKzuo1jsstWPNjgEQn4ZQRnPHl9DyQdFmYuV38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXJFY6eZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXJFY6eZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFFCC4CEEB;
	Wed,  6 Aug 2025 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492469;
	bh=NaiA8W9/tf9ZqklAa969sv6kZ2CMk3Z3s8Ryo+amXdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eXJFY6eZsuxOMo0s8vRHIaNyA2GF9Qy5/ERe+VUpHabDwXnDF9VRqRSfUfH3BOTnO
	 keAfAzuijw2EbAFjxlOb2PYVGmEDnYgk59I9AyCvemQ//r2v8in542PLOTFdnVSVgq
	 UWYeweJKI4CkC8qId2RNwNOWF/tRe1EEeH1XWzMv156uEcoBKFVCYRnce77NMKzn93
	 AqecY0S3Lmo3vRfFtpkvjXYYgb16m2E63JFZhcfHEboJx6Q7kddg3SHeuvKrO9vLmA
	 mwa2YTIYzmkjcNobldrvs9JC6/IWJNpaW93qZ8aIzSMV6gtI4HrtMTyXhVJEzAEUCU
	 3cpmoX3OECGTQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/16] rust: block: use `NullTerminatedFormatter`
In-Reply-To: <2B209DA7-1989-40EF-9535-2A9CC98E0980@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
 <eGPVmCI_u7iqmBeEFQw7IXRxqDNDy2_J6CrTuRHTC9akfGRRKpJjGLPLiuW9dU7cp11syc47QuVJvqDpG-SaMQ==@protonmail.internalid>
 <2B209DA7-1989-40EF-9535-2A9CC98E0980@collabora.com>
Date: Wed, 06 Aug 2025 16:54:36 +0200
Message-ID: <874iuk8pqr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
>> the name buffer. This new formatter automatically adds a trailing null
>> marker after the written characters, so we don't need to append that at =
the
>> call site any longer.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/block/mq/gen_disk.rs   | 11 ++++++-----
>> rust/kernel/block/mq/raw_writer.rs |  1 +
>> rust/kernel/str.rs                 |  1 -
>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen=
_disk.rs
>> index 679ee1bb2195..39be2a31337f 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -7,9 +7,10 @@
>>
>> use crate::{
>>     bindings,
>> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>> +    block::mq::{Operations, TagSet},
>>     error::{self, from_err_ptr, Result},
>>     static_lock_class,
>> +    str::NullTerminatedFormatter,
>>     sync::Arc,
>> };
>> use core::fmt::{self, Write};
>> @@ -143,14 +144,14 @@ pub fn build<T: Operations>(
>>         // SAFETY: `gendisk` is a valid pointer as we initialized it abo=
ve
>>         unsafe { (*gendisk).fops =3D &TABLE };
>>
>> -        let mut raw_writer =3D RawWriter::from_array(
>> +        let mut writer =3D NullTerminatedFormatter::from_array(
>>             // SAFETY: `gendisk` points to a valid and initialized insta=
nce. We
>>             // have exclusive access, since the disk is not added to the=
 VFS
>>             // yet.
>>             unsafe { &mut (*gendisk).disk_name },
>> -        )?;
>> -        raw_writer.write_fmt(name)?;
>> -        raw_writer.write_char('\0')?;
>> +        )
>> +        .ok_or(error::code::EINVAL)?;
>> +        writer.write_fmt(name)?;
>>
>>         // SAFETY: `gendisk` points to a valid and initialized instance =
of
>>         // `struct gendisk`. `set_capacity` takes a lock to synchronize =
this
>> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/r=
aw_writer.rs
>> index 7e2159e4f6a6..0aef55703e71 100644
>> --- a/rust/kernel/block/mq/raw_writer.rs
>> +++ b/rust/kernel/block/mq/raw_writer.rs
>> @@ -24,6 +24,7 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
>>         Ok(Self { buffer, pos: 0 })
>>     }
>>
>> +    #[expect(dead_code)]
>
> Not sure I understand, is this superseded by..
>
>>     pub(crate) fn from_array<const N: usize>(
>>         a: &'a mut [crate::ffi::c_char; N],
>>     ) -> Result<RawWriter<'a>> {
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index c58925438c6e..7396c49174cd 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -858,7 +858,6 @@ pub(crate) fn new(buffer: &'a mut [u8]) -> Option<Nu=
llTerminatedFormatter<'a>> {
>>         Some(Self { buffer })
>>     }
>>
>> -    #[expect(dead_code)]
>
> =E2=80=A6 this?
>
>>     pub(crate) fn from_array<const N: usize>(
>>         buffer: &'a mut [crate::ffi::c_char; N],
>>     ) -> Option<NullTerminatedFormatter<'a>> {
>>

Yes. Alice suggested combining patch 8/16 that removes
`block::mq::raw_writer` with this one.


Best regards,
Andreas Hindborg


