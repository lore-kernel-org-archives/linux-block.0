Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332F1B86FB;
	Fri, 16 Aug 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823963; cv=none; b=HSun7iLWKmOhdq9xk4IGkw7M/+xctgt0+BaIPWYRDZ2LW8gYnkCRVS5JPblhw7DQnxBb/vKJ9xNCEne9bXFpI+iUWpjrQnPzsyHv4NPwLNxHy9hO0yVRLT9BTREh8dB5fne9FLxs60UwVcpKRVsYKNIYiRQmD3l1iRC8zwZFPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823963; c=relaxed/simple;
	bh=PwFCq4HA+VM/TqeJYVTNwOwEiSG7asgzKeswyfcvfxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLf6zpR1padTcTBK7Mh8DT5d1Hu3CKsPhqloDsA5uagVR/VQuXY22UIbdwtEft33HX9dVnyJgpm1s0W8BQ5CMnt45AVR4l9D28mzC4LDyuXwRXB5i2nTzwJnOqRlHjyy/mwzttpZdWhmK5hjx73lLzzKPyncjSA5OkQGQ8ClWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VAl1AtmU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VAl1AtmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723823958; x=1724083158;
	bh=B+BumcKHKtkyfAWPcUH/EmOHcEtK+9Bi+uQxd+QCyJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VAl1AtmUAav1AzMGX/4K2lD4e5JFaNIqlHpQAXb3ulC29Cb5oK1f9lTc10CtYk9Pb
	 SpP2NXLrx4pnvLCZSQXtEUsXrHbdjJaR+XCkowvWqa1IuMjC5ztFNI4xaHkzUO0het
	 mLgCtB8AKrya29B24hUz3UCy4NBwxkh7To2bBHNlz2muFHZtw93DEiY8bPECPvVHFZ
	 clp8x51J/xQYHYW9L3TkhETQcIswgELjJt+kfwbM99yjQlC019um+HvlrP0hK54f42
	 Q9dZSUJxWf73Q6D+9W/GNURoa0EvwXrLpEAQQU1blURBsQU0EvcT/+00m44386dEds
	 DynKbZhL0rjpA==
Date: Fri, 16 Aug 2024 15:59:10 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <34282f40-d6a1-4354-8fd5-24239ada15ed@proton.me>
In-Reply-To: <20240815074519.2684107-3-nmi@metaspace.dk>
References: <20240815074519.2684107-1-nmi@metaspace.dk> <20240815074519.2684107-3-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3599b4c02900e339b0a6f8e36171634a4a326f53
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 09:49, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic loc=
k
> class key without registering the key. This is incorrect use of the API,
> which causes a `WARN` trace. This patch fixes the issue by using a static
> lock class key, which is more appropriate for the situation anyway.
>=20
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Genera=
l/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20=
lock.20warning
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/block/mq/gen_disk.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

