Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF519CD0E;
	Tue, 10 Jun 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563090; cv=none; b=RsxvS3QKS7VAhGqTItxfbW8h7P2l3ofOo7EwjO+4ncwgBSIP62+9A4c5z8lwrC5Hwzm1Fmus1wnlv63bMfltBMGI0KxRcWne31Q4glVCNcccvD7mqhaocMi7U3Z2VsSPFockouBWexoqG2eZKm1Q1CLVwy1dQ9J4jW9HwvxoudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563090; c=relaxed/simple;
	bh=weAdd0vuOTRXXeJOnmvc/uNNIePdWDoD10O9Jk90+GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceo5cRKrYHtfv7KjkHcZi4PT8BLBGI/QGxWkt6glIVK6bSjL8fvccb/ivUIOimxnZas1bDH1FtMp0Bfol9Gq+pplIiAFegacJ/b3hL8F3zbq0WoGouXYI9RFy7ceMJB8t6B3nVVBT0wkrryZc7AMu6Re+Ztkp6Qks6/0LUz+D+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlgVpsFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlgVpsFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA33DC4CEED;
	Tue, 10 Jun 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563089;
	bh=weAdd0vuOTRXXeJOnmvc/uNNIePdWDoD10O9Jk90+GY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlgVpsFmUr9XRMtbWhwlFjG9Nv+DdMW6s3qNX42ami0uaIgU8Phf4Vlbowg2K+H21
	 p+G4kVZTyylVwtv41syM45ek5MW4V7KipS9jo0YDQT5/Zuq69cEebaubISc5ewF7ZY
	 +PIsfNpWWfocsN3PpCvDYZ2IJdpZ1o3oD5Vxi+zvoERuzJUMqfQAHCbCVANTH3a2aw
	 qhUmElhabJsp9v0naWN90O9h8jwPMn1a9YE/M1NYe0aONPEFju5UyXiMfyLhs+t/Ow
	 8ZhZLfYH6d3kldsSK32Opt7KfIX71E+yq9R2V6LmDPt7IariLkt/W6TwszVEwxYpqk
	 abcz5/DdB9f7Q==
Message-ID: <df637115-e0ce-45ae-a9b6-817ea7454bce@kernel.org>
Date: Tue, 10 Jun 2025 15:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] change blanket impls for `[Pin]Init` and add one for
 `Result<T, E>`
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Jens Axboe <axboe@kernel.dk>, Fiona Behrens <me@kloenk.dev>,
 Christian Schrefl <chrisi.schrefl@gmail.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529081027.297648-1-lossin@kernel.org>
 <20250529081027.297648-2-lossin@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250529081027.297648-2-lossin@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 10:10 AM, Benno Lossin wrote:
> Remove the error from the blanket implementations `impl<T, E> Init<T, E>
> for T` (and also for `PinInit`). Add implementations for `Result<T, E>`.
> 
> This allows one to easily construct (un)conditional failing
> initializers. It also improves the compatibility with APIs that do not
> use pin-init, because users can supply a `Result<T, E>` to a  function
> taking an `impl PinInit<T, E>`.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/62/commits/58612514b256c6f4a4a0718be25298410e67387a
> [ Also fix a compile error in block. - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
> 
> This patch is also needed by Danilo for initializing `Devres`
> ergonomically.

For this purpose, can you please provide me with a signed tag for this one
please? Otherwise I can also add the explicit `Infallible` generics in a few
places until next cycle.
