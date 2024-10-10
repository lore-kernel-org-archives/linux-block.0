Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B571BBBFE;
	Thu, 10 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549729; cv=none; b=S3ddd63pwSTozcwiFZBxf1ZjTztSaIiliBsrfDvALK6jWaU/tgsDvUKecwR9TgYonPfiZYTMw0zWZ/IEAKft5kDJphw2Babu8TBbhaN/llXv8JXTU7otVIrM0/VmuTkEhlpOeLUx4Yf/J9dMMeWzJaNC59cM9GFHuqtoU91imso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549729; c=relaxed/simple;
	bh=BP/NyU32iNnI0wbBZ6m0jrsloJW4yQKk7eteYOIpzxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BrC7Ky11PhZXGi6S8t+5VcJihMxfHeabds2vIC79ZVF8fTyKh+sTY1NBua6R6cVk1eHLY9lzzEwqj7B0oNBfkeiELkDw2FeJtPL53zn3oLvxnsqU8eZYw2OVNKaXR6XMGBXOmgx1ar4Lup/4SThs1v1RHh3HHVmMkpDEu9I8Rr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug+erv6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug+erv6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50258C4AF1A;
	Thu, 10 Oct 2024 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728549728;
	bh=BP/NyU32iNnI0wbBZ6m0jrsloJW4yQKk7eteYOIpzxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ug+erv6XZ60pnzz495psoncrkuL47QS2+7EggDf5OeIknijgKojYnZsuq4JDyj3H5
	 0xN3/ewKYz+CBqUUeUvXe2qwD6S6ocoCp+JQeo0gvZg5T35KwIrqCY5btCr3qRQNs1
	 /wkVOkK956+RY8aM3ykWh60Gjr1KGXEvlaU829+uurwlKfOCGem+FHyHJIhYy9/EoF
	 i/ZkNd8BNevMh0HzFUM60js9HO9OSSvkjrMtkUQi56TrRnKsQCTEUG3ojYJZw0e0t7
	 1FxIP4Hek65ouxyAQtLrN2iakMHtzV37NB/mmLW/hKxz1d8YkWb0jj5BSrv8NcochR
	 KEhb+h6iVLwIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Jens Axboe" <axboe@kernel.dk>,  "Will Deacon" <will@kernel.org>,  "Peter
 Zijlstra" <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <20241004155247.2210469-4-gary@garyguo.net> (Gary Guo's message
	of "Fri, 04 Oct 2024 16:52:24 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net>
Date: Thu, 10 Oct 2024 10:41:21 +0200
Message-ID: <87wmigmjta.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
>
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>



