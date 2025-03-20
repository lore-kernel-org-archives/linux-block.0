Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C541F4CAA;
	Thu, 20 Mar 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456059; cv=none; b=JR8x4O09GCraJe6IxrPQnGli5DIrZXEqTkekSoP8le5JH0AqoPfMBwL8VYJt9reBeX5VPYsafBl3Pe3XE0Rsa1SZsL5/AR7Kg4YQ3EX4MLymrl8ApSIjRQ+u6X15Hpia4asHt9OUSY3vSoHniZQonwIJl4NZrYVJh91Gq5RXAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456059; c=relaxed/simple;
	bh=dEgIu5JFl69nfskeMv2P46iK0G8264RLyhXX3ch3Fpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0hW4biwxP+cc+8b7qAUnQBOIM7HmWORbhCVP7fO4R8tny+17qZ35H4mPtlZQYC7k+hpsnGGBjaR4Fu/IpEHEFu3EM46+Su5T4Ba/dpd5Z0psullVT9+DZT5zTGjPMQmVTE+/fEYEwgosZmTV9NoW7dpX5sO9NbGKcsde0su3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw9lP9A0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw9lP9A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B44C4CEE7;
	Thu, 20 Mar 2025 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742456058;
	bh=dEgIu5JFl69nfskeMv2P46iK0G8264RLyhXX3ch3Fpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nw9lP9A0GaVwWX+V5YoQAch+85sv+yG0J+q9r5PAh7NUdrWyHjH2R2YPH9672L/Mv
	 tf06yIra/N2bKTIaBDLdFd6SmjfMvCc+iIuv60Kv3g6cWnAxqRHU7O0Mma/X3IIuPv
	 g8y2RgIOJ0pSBk7nrdaZ+fUGN4GTFq7wVhGZ04gQ+xrkeZndlL9+vrkM2sV8deZYff
	 JevsKQ21+ikRDI/UiU/myC85aDdQm5mrdEb3uqETSV2BBFYm7XuM7sUh0Ww1stUwNm
	 86DAcLcUAKC+RJBLycyXsQ9ms30+UcEZV3gw2Gg57RAb92eFVWUwk17qcNE4zR8M/X
	 6LC+rcAJhBpdQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Antonio Hickey" <contact@antoniohickey.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 16/17] rust: block: refactor to use `&raw [const|mut]`
In-Reply-To: <20250320020740.1631171-17-contact@antoniohickey.com> (Antonio
	Hickey's message of "Wed, 19 Mar 2025 22:07:35 -0400")
References: <20250320020740.1631171-1-contact@antoniohickey.com>
	<LfcqgLNmIhw-IhfT0LhvNJcCjxLQKkGeeMWXFIb2i0apQfC9ij3HTqCjM8QMEuVEBbRjflnr5P1gUA48JB7yEg==@protonmail.internalid>
	<20250320020740.1631171-17-contact@antoniohickey.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 20 Mar 2025 08:33:06 +0100
Message-ID: <87r02sduml.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonio Hickey" <contact@antoniohickey.com> writes:

> Replacing all occurrences of `addr_of_mut!(place)` with
> `&raw mut place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw mut` is similar to `&mut`
> making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



