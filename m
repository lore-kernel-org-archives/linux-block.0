Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C83F6612
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883086; cv=none; b=ZJEAE2EGlBTA6q3mSuTQ3IuE/uhEM3Tz/HNA3WQIRU/Sc0oH7TOrA0JbgvpLagmJ6ah1v3tDgXXvSMue1r9Hew3o3S+wvOnXMFyPMjdmJxko1ZRRMTruOf3ZwOBJK8SEisWGDw7Ralu93KKSxNZlAZU2uldcF08Ugd77mXuX5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883086; c=relaxed/simple;
	bh=UOnGjMIH5INF51cdLayvFVJn2vwdnlApSDi+yGEG8t0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=acze09N8tTem+Wd2M0hFWCNEDU/W/Shrm5xnmBKToXgy11Alrn8HQZqnFrgj8BjcKby8YsuRFIvxbLusD7hWv5YFb/rLcIY+lSxeRwE/MbidG6NnppXSW+2tGOaa8zSfuBN7Dqr/hy6Mbd3enWjfYja3t6xUFCkLEJ4DcZrnGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=XMQ5sRcv; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="XMQ5sRcv"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2380E240104
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1779883077; bh=34zTNQbjlRlLiERGL7ExHyPOzFuT65s6+2p60BMbtNY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=XMQ5sRcvElSqqUYMmV6KEmHRVqgzEBSMwfeq1TVSu4sQnlTfPwBfCbsddSjX2L5PY
	 tisFL3DTp0qnbI8M4CKqs5wdKLqELxkHBD++sxr2oYIY4Ab9qa1n6XMf4ybCJu2/3X
	 iIiySRCx2vZFneJ8V0U340GKK+LHAEDktLz6zgVZJK222eFnYf1jWvShpBzbsG7uq3
	 YPl+gb7i5DhSOfa3CBELlcTr7QuNIHztSfOFNyViVlc9UncLWx4Z5nDt7A/gSv4BQ9
	 33agNYiPwK4xeJk1ZQTpLh6d1JKxPw4qvYKvCLD9Lvio/4ZvOz9iI+v8B62mL4xIEw
	 dPPm0X3Nfb1EA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gQSmg52SLz9rxB;
	Wed, 27 May 2026 13:57:55 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 11:57:56 +0000
From: mateusz.nowicki@posteo.net
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: block: mq: align =?UTF-8?Q?init=5Frequest=20num?=
 =?UTF-8?Q?a=5Fnode=20arg=20with=20C=20signature?=
In-Reply-To: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
Message-ID: <1552076fb3201e5e47ead0989e793472@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Andreas,

how can I catch it earlier in the future? I verified patch correctness 
with compiling 'allyesconfig' but
I didn't catch rust issue.

Regards,
Mateusz

On 27.05.2026 11:18, Andreas Hindborg wrote:
> Commit b040a1a4523d ("block: switch numa_node to int in
> blk_mq_hw_ctx and init_request") changed the type of the
> `numa_node` argument of `blk_mq_ops::init_request` from
> `unsigned int` to `int`. Update the Rust callback signature to
> match, so that the function item can be coerced to the C fn
> pointer type stored in `blk_mq_ops`.
> 
> Without this change the Rust block layer fails to build:
> 
>   error[E0308]: mismatched types
>      --> rust/kernel/block/mq/operations.rs:274:28
>       |
>   274 |         init_request: Some(Self::init_request_callback),
>       |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>       |                       expected fn pointer, found fn item
>       |
>       = note: expected fn pointer
>                 `unsafe extern "C" fn(_, _, _, i32) -> _`
>                     found fn item
>                 `unsafe extern "C" fn(_, _, _, u32) -> _ {...}`
> 
> The argument is unused on the Rust side, so this is a pure
> type-signature change with no functional impact.
> 
> Fixes: b040a1a4523d ("block: switch numa_node to int in blk_mq_hw_ctx
> and init_request")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/block/mq/operations.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/block/mq/operations.rs
> b/rust/kernel/block/mq/operations.rs
> index 8ad46129a52c..861903e18fbf 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -218,7 +218,7 @@ impl<T: Operations> OperationsVTable<T> {
>          _set: *mut bindings::blk_mq_tag_set,
>          rq: *mut bindings::request,
>          _hctx_idx: crate::ffi::c_uint,
> -        _numa_node: crate::ffi::c_uint,
> +        _numa_node: crate::ffi::c_int,
>      ) -> crate::ffi::c_int {
>          from_result(|| {
>              // SAFETY: By the safety requirements of this function, 
> `rq` points
> 
> ---
> base-commit: 27236c051c01c1c1025e0e0d12a107082557e8f1
> change-id: 20260527-block-for-next-2026-05-26-2200-failure-64907085fc49
> 
> Best regards,
