Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A96291C02;
	Wed,  6 Aug 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494341; cv=pass; b=HJNp/84EMGK9w8lvrll45Q9XyD4YL4hBKa/t7akSFg31h0T70xBZEC09iZATcmQYknqXNdvyQcbrcjLkDej1sfEIqVJz7scsQGwCWwGBwdkBwhny/Hf+MuTosnvP4uDUz54CLB1IpCpZEMlq2MVVg9/pku7UEwVVI0+Ffr4tkzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494341; c=relaxed/simple;
	bh=Zmwv4vh3Fx0bxFxRlXfARN3k9faUJVlnf8ZTxt8rEjI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Fr5gO7PXtNIFDnWiL6dlrAJ/7r3sq+MkW2hhqUuPNDxb6gA0fz5a5hxFM/E6D3F00GO/A4ipriHKVMpO4ZSHRwhR7dSp9SFaMVDmPRzMhh9yGLQQ0o5Vm3JHn0dyWAc1f0siMWXqK6ck4FPX9fJc3Xfy4oLj0BLYTgMWH4v+bNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LjPqLBSg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LjPqLBSg"
ARC-Seal: i=1; a=rsa-sha256; t=1754494322; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EvOxFINf6Q6TJgBgY9eusaVIUI7WQx4ErTpp8xqCj3msXCOyIl29M5MEpEX8T0IUExzELan5X7d9lZ+qavstYEMBoOhD9JCKJr3nnyAmaCNi97tSklILMeD3wWDi9RsAx//vSjbYIIwi0UUXWveb+hIRgFcXYw4HAeMVBvdZ1/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754494322; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zVx/BBwBcVenmzScNrfKqLq/SI6/4vzW+8q9NLGYSVw=; 
	b=drSSVxdylxxzpYsIkVa+wYn+FqE2poR63zDv2unDMC4vq4KHR8ICdxEnUhYHsqKrA4FO5o4aOhI4ftUJhPP0R3kgIYjxODiG01kDUrRp9+QOCo9Z4OlJoigzVrI11nBiQdOJ3ULku01d5mxXrGIHZJlOOClai/IvekowxwAkZ8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754494322;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zVx/BBwBcVenmzScNrfKqLq/SI6/4vzW+8q9NLGYSVw=;
	b=LjPqLBSglAaBV3N8yv9Je0baMe4xWUM2MEzU5pStsjaCkQSF8n9y2Y5Gbf9If96s
	GgIneJ94i9zggEodhYP6pBT+7BftYkR7E8AvGCuJBZJ/f2omxMdaR9fVDz348EjuoB6
	YVfrHQ2Q7hJr4aMZGVyR1WeLZBxFuUU/jtUdDkzc=
Received: by mx.zohomail.com with SMTPS id 1754494320728780.5263856446262;
	Wed, 6 Aug 2025 08:32:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 06/16] rust: block: normalize imports for `gen_disk.rs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <877bzg8pvp.fsf@kernel.org>
Date: Wed, 6 Aug 2025 12:31:45 -0300
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
Message-Id: <DC4C6260-9D2E-40B7-9A0F-F629EB831F5F@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
 <1YjnBHBMF7DAKjkQrfW9goplGCUynLmjrUnLo3PrN5qMYx6uUcolbOtjWPNyVQEwyehPW8Xk7B1oeBAffoYr9A==@protonmail.internalid>
 <F5A3232C-50E8-4615-929A-80F3ED4EFEBA@collabora.com>
 <877bzg8pvp.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 6 Aug 2025, at 11:51, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>>>=20
>>> Clean up the import statements in `gen_disk.rs` to make the code =
easier to
>>> maintain.
>>>=20
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>> rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
>>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
>>> index cd54cd64ea88..679ee1bb2195 100644
>>> --- a/rust/kernel/block/mq/gen_disk.rs
>>> +++ b/rust/kernel/block/mq/gen_disk.rs
>>> @@ -5,9 +5,13 @@
>>> //! C header: =
[`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
>>> //! C header: =
[`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>>>=20
>>> -use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>>> -use crate::{bindings, error::from_err_ptr, error::Result, =
sync::Arc};
>>> -use crate::{error, static_lock_class};
>>> +use crate::{
>>> +    bindings,
>>> +    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>>> +    error::{self, from_err_ptr, Result},
>>> +    static_lock_class,
>>> +    sync::Arc,
>>> +};
>>> use core::fmt::{self, Write};
>>>=20
>>> /// A builder for [`GenDisk`].
>>>=20
>>> --
>>> 2.47.2
>>>=20
>>>=20
>>>=20
>>=20
>> Same comment as the preceding =E2=80=9Cimport=E2=80=9D patch: this is =
syntax is problematic.
>=20
> I used to share your viewpoint, but I changed my opinion and now =
prefer
> "normalized" imports (the combined form).
>=20
> Now I can just blindly merge all the imports, remove duplicates and =
then
> ask rust-analyzer to normalize imports again, and then format with
> rustfmt. I find that this workflow is very low overhead.
>=20
>=20
> Best regards,
> Andreas Hindborg

That=E2=80=99s because you have a separate commit where you do this =
before applying
your work on top. If you=E2=80=99re rebasing on top of someone else's =
work, then a
lot of conflicts will pop up. And unlike the saner approach where each =
import
is in its own line, it=E2=80=99s now absolutely not clear how the =
conflicts should
be resolved.

The only thing that can be done then is to accept whatever the current =
change
is, and ask rust-analyzer to reimport everything and reformat.

IMHO, this is not great.

=E2=80=94 Daniel

