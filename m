Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFC4A02;
	Thu,  7 Aug 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553828; cv=none; b=V82e8GoJXtDu/m24DZGg3D+EL7MVGGmNLQXF2rpIPxTRF6MWV7v0Y6Xa4wP1ZhtUWvrbQuchyXBfWWsx3eALJNASbJXzJejE+U2mroPscfzCYHXfVvoUyv1QHkFcwjG+zmloVK3FkLMtijiVnB1icsvfwlxf1iBceDdCPbLdtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553828; c=relaxed/simple;
	bh=wWVot/bRWGefR1FSnJlUkmpVMwrgagTyfs8qSQV0z0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AF+78no4mKf9AyFyIBXNhA9b0LS6FIVdeczzk8//yonQ0qK5O8RiDo8/f6gekhybHDefzFDlGNiEzldjkxAAICriNU3wtVsO5rr3mCRjR5Omcr/GtKaLCnV9u+0aIriZWOXn1BVofdbpAD0mw2FSIz5h85MmSHDL+npTJgXycck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8j5Yebc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8j5Yebc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC53C4CEEB;
	Thu,  7 Aug 2025 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553828;
	bh=wWVot/bRWGefR1FSnJlUkmpVMwrgagTyfs8qSQV0z0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g8j5Yebc4fzVLrcVIS0VhO5MpBkiyRMGTrWemsVmy4KlsEjMNFKQAo419SUlGGbtc
	 hLzX4FOkYqR2Y8kPirYFfvn9M4pyYtO/+J+g+sZNaa4fCHq1CSESOee+DjdTwgg8I4
	 2YUp/cNRmmJA1Hox308xGkVQRtW8hRZese9DNmb74hVNdyYKDBrL1kFsodjCl73a7B
	 dKOjDFC9cD596KccbohBZIvchwzXZIFaJggeL+jV9PSVPAiOmXRcUXKieG59f0Clx4
	 9aaxUXHLNheZI+2QyhSwpg2MVeGGHzH09Amm8zu84WSp83Axbb1Fz8E2J5UckpgdMy
	 ok4DRQpUnQApA==
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
Subject: Re: [PATCH v3 06/16] rust: block: normalize imports for `gen_disk.rs`
In-Reply-To: <DC4C6260-9D2E-40B7-9A0F-F629EB831F5F@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
 <1YjnBHBMF7DAKjkQrfW9goplGCUynLmjrUnLo3PrN5qMYx6uUcolbOtjWPNyVQEwyehPW8Xk7B1oeBAffoYr9A==@protonmail.internalid>
 <F5A3232C-50E8-4615-929A-80F3ED4EFEBA@collabora.com>
 <877bzg8pvp.fsf@kernel.org>
 <BPuVBI3Fi8DRIKGqquXjiih_dy_E_FMoZoJXUr644LzQLlW5GV2OFFRvzrFIWb7AswQo-zXkAp-QoF3xdT6Bcg==@protonmail.internalid>
 <DC4C6260-9D2E-40B7-9A0F-F629EB831F5F@collabora.com>
Date: Thu, 07 Aug 2025 09:12:49 +0200
Message-ID: <871ppn8v0u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 6 Aug 2025, at 11:51, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>>
>>>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wro=
te:
>>>>
>>>> Clean up the import statements in `gen_disk.rs` to make the code easie=
r to
>>>> maintain.
>>>>
>>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>>> ---
>>>> rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
>>>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/g=
en_disk.rs
>>>> index cd54cd64ea88..679ee1bb2195 100644
>>>> --- a/rust/kernel/block/mq/gen_disk.rs
>>>> +++ b/rust/kernel/block/mq/gen_disk.rs
>>>> @@ -5,9 +5,13 @@
>>>> //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.=
h)
>>>> //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.=
h)
>>>>
>>>> -use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>>>> -use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
>>>> -use crate::{error, static_lock_class};
>>>> +use crate::{
>>>> +    bindings,
>>>> +    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>>>> +    error::{self, from_err_ptr, Result},
>>>> +    static_lock_class,
>>>> +    sync::Arc,
>>>> +};
>>>> use core::fmt::{self, Write};
>>>>
>>>> /// A builder for [`GenDisk`].
>>>>
>>>> --
>>>> 2.47.2
>>>>
>>>>
>>>>
>>>
>>> Same comment as the preceding =E2=80=9Cimport=E2=80=9D patch: this is s=
yntax is problematic.
>>
>> I used to share your viewpoint, but I changed my opinion and now prefer
>> "normalized" imports (the combined form).
>>
>> Now I can just blindly merge all the imports, remove duplicates and then
>> ask rust-analyzer to normalize imports again, and then format with
>> rustfmt. I find that this workflow is very low overhead.
>>
>>
>> Best regards,
>> Andreas Hindborg
>
> That=E2=80=99s because you have a separate commit where you do this befor=
e applying
> your work on top. If you=E2=80=99re rebasing on top of someone else's wor=
k, then a
> lot of conflicts will pop up. And unlike the saner approach where each im=
port
> is in its own line, it=E2=80=99s now absolutely not clear how the conflic=
ts should
> be resolved.
>
> The only thing that can be done then is to accept whatever the current ch=
ange
> is, and ask rust-analyzer to reimport everything and reformat.
>
> IMHO, this is not great.

If we apply the normalized format everywhere, this will not be an issue.
Merging of imports can be almost automated. Just merge with strategy
keep all, and then normalize and remove duplicates.


Best regards,
Andreas Hindborg


