Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1128E607;
	Wed,  6 Aug 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492478; cv=none; b=PCF4Fuh3AAgctT3sgvvhV7RTIf4Dq+xBaweTI1gCu0Ban5BWDzxMlvYX9SgPRkB8BLZRf6g4IteIAf43Qh7FsupjAAzgvkRbtcvQZ8e4pyf7yZfWZtLrpzT+ksmxv9UY56ShjZIgu2Q3+Cy81gFHQsUQD2XT3iRQ+URENIjtmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492478; c=relaxed/simple;
	bh=hj/L89TTZq/55Xjg9EGPY06V2sClDfmrX6hHP9UOD9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cp2FHiAUpnpZlhh+g41vOyA/oOv+PBplu7c3Nzjh4iHe+4rFfq5kWv+yU2+MNi7QUfEH51+teAx2W0y7Ra0Fes1hEcfBNSktX5uFIY8zwtgfGgz/NNhhw4KI3BvR8g9By1IU+7b4p3kee7XMTn2XGdHbseXKrRdrgVYYTy0ghbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFVLWdeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFVLWdeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406B5C4CEEB;
	Wed,  6 Aug 2025 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492477;
	bh=hj/L89TTZq/55Xjg9EGPY06V2sClDfmrX6hHP9UOD9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vFVLWdeb3AUPCoSEqsHZBiRtU2abybfKsKRfwQbP0N16hQRBR3mSt/i/ABgCENm6g
	 pxLBjMCSLd1AjkQt9yYQksS471NH+2g2dTFWJV7nW0OD4GswdYNZlyUdiJAaBrNls4
	 LBtCy7I1vTMqIjINOPEOMuGjRVMoCzXGS/hC+BAdBUmwtbQQ+RYEeGb6Dhu3kIOwt0
	 qMNNFHsjFWpv6V0FoWmbV/q65bhOUpNSFU63jJlCxoC3BYwZuKoho3blpHfBuYGypv
	 CpZgehDPVFmXx6wZfVJ4oh/uwelOscHqgzFJDuHRcDukt91BsAMILq+tkQeYMQ+iTa
	 /X91Q+czhtGHw==
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
In-Reply-To: <F5A3232C-50E8-4615-929A-80F3ED4EFEBA@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
 <1YjnBHBMF7DAKjkQrfW9goplGCUynLmjrUnLo3PrN5qMYx6uUcolbOtjWPNyVQEwyehPW8Xk7B1oeBAffoYr9A==@protonmail.internalid>
 <F5A3232C-50E8-4615-929A-80F3ED4EFEBA@collabora.com>
Date: Wed, 06 Aug 2025 16:51:38 +0200
Message-ID: <877bzg8pvp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Clean up the import statements in `gen_disk.rs` to make the code easier =
to
>> maintain.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen=
_disk.rs
>> index cd54cd64ea88..679ee1bb2195 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -5,9 +5,13 @@
>> //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
>> //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>>
>> -use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>> -use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
>> -use crate::{error, static_lock_class};
>> +use crate::{
>> +    bindings,
>> +    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>> +    error::{self, from_err_ptr, Result},
>> +    static_lock_class,
>> +    sync::Arc,
>> +};
>> use core::fmt::{self, Write};
>>
>> /// A builder for [`GenDisk`].
>>
>> --
>> 2.47.2
>>
>>
>>
>
> Same comment as the preceding =E2=80=9Cimport=E2=80=9D patch: this is syn=
tax is problematic.

I used to share your viewpoint, but I changed my opinion and now prefer
"normalized" imports (the combined form).

Now I can just blindly merge all the imports, remove duplicates and then
ask rust-analyzer to normalize imports again, and then format with
rustfmt. I find that this workflow is very low overhead.


Best regards,
Andreas Hindborg


