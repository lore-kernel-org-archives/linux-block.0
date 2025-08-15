Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7684274656;
	Fri, 15 Aug 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246568; cv=none; b=X5PBsE2CpXs2uGkep4+fDLtvhFL7pMtB6E3GY5SDHqndmhBVI3w8TGgTfFt3rqIOW/8X3UxjG1qDB05fc1AI4NSYJMGFW2ZW7GWrSSPuO6uY2QZSyPsNPYwnK3St38dD8drA1ZTTMTE+3olNWKLWv97OCQZC0eXlD+tCcfBFgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246568; c=relaxed/simple;
	bh=04WDM1P3dI298aPORjuUEvo2ZzH5WcrdlgbcYAXeKik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tCpkDf9r1bHW7RFhjrux33E7Ocvub43nWrkxbmw6n0yVdxSVwavkj2bobqsVaB7dlanIuspXdm0kuVUhtKP75+1N6mSp/nhmH8CAh0XVY+TVzCPOt0x4DbpxeqK32GPZmYBohFmDRc7ihdQROx0Ub80qEpJknzFP5Q5bZeolhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBit8ylj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBit8ylj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC6C4CEEB;
	Fri, 15 Aug 2025 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246568;
	bh=04WDM1P3dI298aPORjuUEvo2ZzH5WcrdlgbcYAXeKik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WBit8ylj2asPwx1SZmIFbsQd/tWKfh9JYqqMUSZJTl48dxx/VAvCETS9frLuvtsb7
	 oxxt8wenkSVCW9DqEReRzVrXLgz/YiMrC7L1L9pI1OFGLjeEAgKpnrbtNJ9/IZ1yrW
	 NOMUP0uL5Leddg804Fsb2Z/spoNOl30CXuGGBOX/ucDFdlFzMeyqGPQ8s9VfADHSnG
	 fgKomVzFp4J4sigCpbxMAqcTQjsaCbW07zrnBY9DCDeOiAp1YIsjx8id6VY52vSarE
	 X+hJlBcY4DmcnmqxXC46XjDh8Nf0A+Rpb7uxNV2Vl5Gq5CBxDO8fpIOkLz+b8PN4Wd
	 z8nvDYDwSSV7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/18] rust: configfs: re-export `configfs_attrs`
 from `configfs` module
In-Reply-To: <aJ7sQF6ObVlwX3U0@google.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
 <UNKR4V3pgHcYGU76GBf8aBKpJPgL7tf5Ct7oM0C_JEiL6Hq2uewAuV3yQCcJ55QSQJ-0_bMM3zA7f_zmAIGHjg==@protonmail.internalid>
 <aJ7sQF6ObVlwX3U0@google.com>
Date: Fri, 15 Aug 2025 10:29:15 +0200
Message-ID: <87ikipdm3o.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Aug 15, 2025 at 09:30:42AM +0200, Andreas Hindborg wrote:
>> Re-export `configfs_attrs` from `configfs` module, so that users can import
>> the macro from the `configfs` module rather than the root of the `kernel`
>> crate.
>>
>> Also update users to import from the new path.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>>  rust/kernel/configfs.rs       | 2 ++
>>  samples/rust/rust_configfs.rs | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>> index 2736b798cdc6..0ca35ca8acb8 100644
>> --- a/rust/kernel/configfs.rs
>> +++ b/rust/kernel/configfs.rs
>> @@ -121,6 +121,8 @@
>>  use core::cell::UnsafeCell;
>>  use core::marker::PhantomData;
>>
>> +pub use crate::configfs_attrs;
>
> In other re-exports of macros, we've placed it immediately after the
> macro_rules! declaration.

Ok, makes sense. I'll move it.


Best regards,
Andreas Hindborg



