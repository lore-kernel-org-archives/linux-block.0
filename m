Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF1433C8;
	Wed,  6 Aug 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476794; cv=none; b=EhYHMSZ1sq4svF28i0JG3AGgLoG7OKuJ3TzB3R9HqErz55MjzB1nnJ6geBaBhhjECnvtHJzDHK5lcamf7XJPILx2Xqr2yXB4f5BRJXWLUtHrFnfu5hUecGIivyRhUAHDFMbSQ4xu4TjNF3GlyEy9v0Mp6q8x+G+jGMC6ndm1yLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476794; c=relaxed/simple;
	bh=prVC3lxppRrhOCtUCxmwBpaVitYSrJeH5aa/qfTq7qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bA9HcVgXOzWTHLM0PkD1m+xZr9C7arjgx1zo1Gpn0Hzpsy4E3Mc3KkSl+km1ha3DET+248PnOG229hPnUc1SNdhXmgCA4bHmCIaY4hZTYeiDaA/OnV8CeU7mc3BxaMy+eaz8LgDvfznVZh0B5gmnmj5U4z1F6RO9t8euCdqqkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx9Ir5n4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx9Ir5n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A58AC4CEE7;
	Wed,  6 Aug 2025 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754476794;
	bh=prVC3lxppRrhOCtUCxmwBpaVitYSrJeH5aa/qfTq7qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sx9Ir5n4UaugNe7R6F49AobZrroStIGqDxaA8Ax7Y4AfSBCb1z72lD60N+CenmYwG
	 AMjQismZkwC+F/b5S1F2KQEvX5kuoSdlTrStmn2Q/NeaetSWhEP7zx/7Yixu7+IzUC
	 oleNfHI5P4mBGM6UoO/niHk5u1FWTPOu+4GVIgZ6ic7ZBOzHivm5kdBWewZa3p2D2O
	 K2Sl93MUc10VRWFGjOByECnwuqML1h9gbVbUqZi+ofyckPjeUhnJ240pbBeDf3CcJf
	 tW950k7sDgpIgtBcJeGznBuGKX9H8v9eDCYdOrz6kw3lDNDdySZln2ocJEeopwMRPW
	 8NZkpwmwOSwDQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/16] rust: block: add block related constants
In-Reply-To: <aHYi-PRsEQ-YpeYm@google.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
 <hCVxhbCxZksAYFB75R-sGCzmJWrbFU_dP4ABVoqVebSiLPiO-rC3MnJVN4vZRLiUO3io-p2wJM-rxjxK-AX4uA==@protonmail.internalid>
 <aHYi-PRsEQ-YpeYm@google.com>
Date: Wed, 06 Aug 2025 12:28:47 +0200
Message-ID: <87fre4921s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Jul 11, 2025 at 01:43:11PM +0200, Andreas Hindborg wrote:
>> Add a few block subsystem constants to the rust `kernel::block` name space.
>> This makes it easier to access the constants from rust code.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/block.rs | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
>> index 150f710efe5b..7461adf4d7e0 100644
>> --- a/rust/kernel/block.rs
>> +++ b/rust/kernel/block.rs
>> @@ -3,3 +3,15 @@
>>  //! Types for working with the block layer.
>>
>>  pub mod mq;
>> +
>> +/// Bit mask for masking out [`SECTOR_SIZE`]
>> +pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
>> +
>> +/// Sectors are size `1 << SECTOR_SHIFT`.
>> +pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
>> +
>> +/// Size of a sector.
>> +pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
>> +
>> +/// Power of two difference in size of a page and size of a sector.
>> +pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;
>
> I was looking for the user to double-check whether u32 was the right
> choice, but I can't find it. It looks like you don't use these yet?

Only `SECTOR_SHIFT` is used in this series, the rest will be used in the
future. They are used for memory backing rnull, still out of tree [1].
Do you want me to split the patch and delay the rest of the constants? I
fully intend to upstream the user as soon as I can.

It is a #define on C side used as a shift operator on usize in Rust code
like so:

  let sector: usize = something;
  let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;

Best regards,
Andreas Hindborg


[1] https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/tree/drivers/block/rnull/rnull.rs?h=rnull-v6.15#n211

