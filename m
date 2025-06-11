Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D89221294;
	Wed, 11 Jun 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677231; cv=none; b=Lh+huGkWUTcCB92T9lHwSm2Xy2R9Ec/P4qhe858UCYOMYIsw+bO3dPOOqcZyrS4RlCyXbHFfhEkUxklZhNVam9nObbz2o852Cs+AXL1IX2hPTblDhIA9pgf5h1FBK3NsGMd9OHRV+BmjrVCMQaPQO68dVeZXYW+w2kckJz60DiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677231; c=relaxed/simple;
	bh=jUy8QAn0m9tzE07JAe76z+1J1MVw/EYMYYDN9ar6REQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q7ti/pnSqM2K760TpcL8naYOlLHys6Qckh4bEbPBh4kHRWwbN0Zj9vRBNXv84cb5FytS0vTasP0klUIBAyyPUmFj+78HU8wFcRl3+WKPB+Gh/qol0xB9fwtF5nx0AvCoKl3AVvMiFaEr0/YsilOmq0QAyK+j4pmQCEeJVEm3/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElwcDGOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElwcDGOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F4EC4CEE3;
	Wed, 11 Jun 2025 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677230;
	bh=jUy8QAn0m9tzE07JAe76z+1J1MVw/EYMYYDN9ar6REQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ElwcDGOaoP8xjRrx1iWqhxRB0GclLdep88yUuSevxWZwQBpHqH4j0PGTqedCv44oO
	 NafBTlU4LtgTqF5BZ6cAu+mziQtJk7ZMzn4SRdwjVy/vWyOGMsSBf9tZsaXoMpXwMp
	 yJyZwx7dfo/AESHwHFJxJVR2iisk2Hs8d2m3aZhO6D75KyKwsSlETHFuLVIam9Rjrj
	 L9bA3HbGDIorLGCfKinr5e/tMvFlnNUdW9tEUDD24vh3w8lk2I+IzpBZTGde9yJRQ1
	 yHuVCUbCa9Ye0V44ziD5Uv4F9Xl7G7K+JW6CqFSKHuhN0ALuet1h/lfrWerNJQ4pvD
	 u94pz5Q88JWqQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 23:27:06 +0200
Message-Id: <DAK0T99XTJ22.2FTHQGST9Y8IC@kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Jens Axboe"
 <axboe@kernel.dk>, "Fiona Behrens" <me@kloenk.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] change blanket impls for `[Pin]Init` and add one
 for `Result<T, E>`
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250529081027.297648-1-lossin@kernel.org>
 <20250529081027.297648-2-lossin@kernel.org>
 <df637115-e0ce-45ae-a9b6-817ea7454bce@kernel.org>
In-Reply-To: <df637115-e0ce-45ae-a9b6-817ea7454bce@kernel.org>

On Tue Jun 10, 2025 at 3:44 PM CEST, Danilo Krummrich wrote:
> On 5/29/25 10:10 AM, Benno Lossin wrote:
>> Remove the error from the blanket implementations `impl<T, E> Init<T, E>
>> for T` (and also for `PinInit`). Add implementations for `Result<T, E>`.
>>=20
>> This allows one to easily construct (un)conditional failing
>> initializers. It also improves the compatibility with APIs that do not
>> use pin-init, because users can supply a `Result<T, E>` to a  function
>> taking an `impl PinInit<T, E>`.
>>=20
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Link: https://github.com/Rust-for-Linux/pin-init/pull/62/commits/5861251=
4b256c6f4a4a0718be25298410e67387a
>> [ Also fix a compile error in block. - Benno ]
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> ---
>>=20
>> This patch is also needed by Danilo for initializing `Devres`
>> ergonomically.
>
> For this purpose, can you please provide me with a signed tag for this on=
e
> please? Otherwise I can also add the explicit `Infallible` generics in a =
few
> places until next cycle.

I rebased `pin-init-next` to have these two commits as the first two and
will create a tag a bit later in the cycle when I'm sure that they are
stable.

---
Cheers,
Benno
