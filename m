Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8F2904;
	Wed,  6 Aug 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474880; cv=none; b=pIiw7Sgvf/BIynvvvlZvI/h0ZEijAgt8MfVfUJ68Cr6DCqDVbrLacwKoAgFuiBoJzduIT2+7iEBCBuKa276UZA2f0XTw1mZZWWH+lh3howpogEvFTY8tZPp6wPSvj/SYrGCaY/RGPbdLcu4K9S5LCaM0FpMdBDkf1R8RCBuZMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474880; c=relaxed/simple;
	bh=wdOwLqd1afImjWOGYXMFKYzpgUi1UhE1t0iwGIBB+80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjQRRC2lTEYxPRn/h5fehG9njOVZTFWYFxmLMb6McWbm5yTmGZf9sPibDEMNOyCBLT/14DpGOE0TgWJS89CXzvlJm7yBRTYxHnbH/JRu9DQXkp9uGbftoId8ULYkXjjJNhALeWy5LwPp4z3Cd5GxuIa2Uu22mNXEIorhCC6U6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXuKr9Bv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXuKr9Bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F08C4CEEB;
	Wed,  6 Aug 2025 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754474878;
	bh=wdOwLqd1afImjWOGYXMFKYzpgUi1UhE1t0iwGIBB+80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JXuKr9BvlVkzls67XHf9pIfiwY8ZZzsMRUAgKRwKKFtuZB9WW4dQm8eMS0NFyzDtr
	 vDJ6vOmQz3p82yWf7DmdHzRg0/ttwrgH+sPQuLVvoqMDYctQDUt3lEuKYycMTrGFwg
	 wp6GVlDEbb5bV2QIsPMJUiCRc4IIdczlZ4YiLATykaPUqe3ZTKD1j+cbY6MmucW1xF
	 LP9hl3/unelSOrSO2RpceB/SrN612GsjUlEtoqMHxl1rQF0zA4ybX5M5lugCMYHtwb
	 aQi6LrMd+XgqHaOp82bNv0ITApnDXXse+4pZctyGTd4WruqwAsd1PgVdF3XLVk61EL
	 wHaMs+yR5BYVw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/16] rust: str: make `RawFormatter::bytes_written`
 public.
In-Reply-To: <aHYhJBHUoWq46kKW@google.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
 <B8hSUb0MtaCFiHXKHqLYTeaCLsaV6tKmkUEKAZnMTZHormV7MdH4pNWSI39Djn72NA-eKJqc-97vwjQQflAFmA==@protonmail.internalid>
 <aHYhJBHUoWq46kKW@google.com>
Date: Wed, 06 Aug 2025 11:43:18 +0200
Message-ID: <87ms8c945l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Jul 11, 2025 at 01:43:05PM +0200, Andreas Hindborg wrote:
>> rnull is going to make use of `kernel::str::RawFormatter::bytes_written`,
>> so make the visibility public.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Making methods public can be part of making the type itself public. I
> don't think a separate patch is needed.

I'll merge them.


Best regards,
Andreas Hindborg



