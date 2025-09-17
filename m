Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D7285073;
	Wed, 17 Sep 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106618; cv=none; b=Smt0R3DIoKsgljiBuLXlIrL9XtuHneyvUD7GhZMkdLGXz11uWIEvhSMXF0EeBwjcuaaJepCYDuEkwwUjZ8t6vm7Qc34pxbdLDPM0L41wA7ey/MqBYQdMFMvLYaX9/NL71+jgiGVtvpTitAo37Mcdfebb/2L5q2a7eH218gFOjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106618; c=relaxed/simple;
	bh=DGk49X14zZg9MmxpT2/9o8BFJoLXCKJri9nMerohPlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMa+CFEUDVGNBmcMgX2DpsL97qxPxZv64TendcjcYhsux0Ng1L277ra0/ShVdQWaGbVVLJnws7tMYwqKZMUYJdwWlrjPhKv+w4teiPuVThn3bGC02xnXxCQjhk2Qh4RBwXsB3lpnIBx9tZ9xaQylPEyZrrMKZ5+pIRgMAIHBtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpQQ1C38; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpQQ1C38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF6BC4CEF0;
	Wed, 17 Sep 2025 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758106617;
	bh=DGk49X14zZg9MmxpT2/9o8BFJoLXCKJri9nMerohPlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YpQQ1C384TI2WGAvkQWzejM3PSmjXMkXH0/ckB3BQXVZ4kXDvwxFt5nrcZHSLb5z1
	 HM06Ku7j015KtYufNngi0KrSldLd1tIXbpFSxS3MtWWgOO6KsGR+pFgX1+E7ETPa3m
	 H19BsL6bg7hwQdtVW2HMXOlbkrdP+fnr9C71wzUyXmOwwRBmKpzanX9wXWhZKuhQi9
	 Rrtb+61Bu7m3K7LRf2xlatInybZNRUxsY0aYWOxhORS/XEIC4M5Ipy/KYP3gy2umeG
	 R45YScn4w0//mLZCwU4hE8J/cv06Jkxv1b6kypKvAebpHckTTzgxD1D+KgP8XVnjww
	 vcp0sypVHFtzA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Yutaro Ohno
 <yutaro.ono.418@gmail.com>, Manas <manas18244@iiitd.ac.in>, Xizhe Yin
 <xizheyin@smail.nju.edu.cn>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] rust: block: replace `core::mem::zeroed` with
 `pin_init::zeroed`
In-Reply-To: <20250814093046.2071971-6-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
 <FZTw0hzHoikt9HGS5iJbjDgyb__kfDms8TR-RjFfOQrw8OaCfg0eslVaLuBMKj75oJ-mcsX10igGP5ZXVdnPsQ==@protonmail.internalid>
 <20250814093046.2071971-6-lossin@kernel.org>
Date: Wed, 17 Sep 2025 12:52:17 +0200
Message-ID: <87qzw5wdum.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



