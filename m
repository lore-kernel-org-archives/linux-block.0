Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965E3BBA1E;
	Thu, 18 Jun 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778774; cv=none; b=XlcVfCUnIz/Stdwd6t/KQmmahB0odp+4dlNFrDQu7lRJ541rlKRBa202rjy1etntcqepkf3b/8tvfiEWu4SscqB4xlyiOpO1hX11ac3w1I4Zoge5PsFBPiiohKcwFBvANM++rIFBYbCJCtKpuDWoSKphsNaVC7IL+bz20pp3nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778774; c=relaxed/simple;
	bh=Mhrt51U/3Bst1MWMhW1jqJPyTksxpuMd96R5jg+Xe0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pDFBkUau7FAGK9cyOGwSYE9s53tjiceGs6XarXWLzaE1Dt+5ib4/y1u59cjoJrWmhj6A+/mWXkXpUROGTViKfD/B8HctwKjMtQNwer3npHAXuSmKRNtfuH6iZQm9HsqF/5m5gO9ARy+FBPl+URU9trjF3Gq5YOdvj3GB9I2Wxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWToeEld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWToeEld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6761C1F000E9;
	Thu, 18 Jun 2026 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781778771;
	bh=Mhrt51U/3Bst1MWMhW1jqJPyTksxpuMd96R5jg+Xe0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JWToeEldL94Uxy4bw13SddCruUAAGoHq8yGE8wawQT9pPLc9w3a4D0Dz6E18FvpJk
	 fERcATt9rlw5myELakU9CQ0PgBfkJQrySMHHC97a8s67XYaQcNLzqCw3IeHXTTFoSY
	 GZUo33r7yDePj9pc6dk2Sy8lFihyAbRnxBubn+vD1pauLRzw5WK8rHE6HQvcS9MNS9
	 wtBAXv2RU2jnS/DnsZYZD2DzbwD5M2Ha6vMfiNeamlwwV/AMqjxW1COMorE0ZM8d9s
	 DDDRIwRDw8Fn5aw/CNnB8Y6G3JTIdev9LhasZCUyWQi0Vnn7GatSCWgbTJ1VHq4qAQ
	 b9RYPtErqEkNw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alvin Sun <alvin.sun@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org, Alvin
 Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 5/5] rust: block: mq: remove redundant imports and
 format
In-Reply-To: <20260520-miscdev-use-format-v2-5-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
 <ftIkd4Azz8dKfEHMvhxOqdNT0WY0ptvcD4_qdkWPSSzGOZyLcAMD7ECCFojCPMt_Eej80uTQAFCA9wGaRWzWmw==@protonmail.internalid>
 <20260520-miscdev-use-format-v2-5-64dc48fc1345@linux.dev>
Date: Thu, 18 Jun 2026 12:32:40 +0200
Message-ID: <87se6kf8af.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alvin Sun" <alvin.sun@linux.dev> writes:

> Drop `Result`, `Pin`, `pin_data`, `pinned_drop`, `PinInit`, and
> `try_pin_init` imports already provided by `kernel::prelude`.
>
> Simplify `error` imports and flatten parameters formatting.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>

@Jens can you pick 4/5 and 5/5?


Best regards,
Andreas Hindborg

