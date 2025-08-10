Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F121F949;
	Sun, 10 Aug 2025 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811621; cv=none; b=NuVyIK32b50Uiv7kj97uuLJDXBS3vytaC5ltAuOzuPHnounKXGMWnTfo/30/gVEo+oIedr+y7+V4OUlOv5IFI7LHROdCpVnPKQNcHGK0iyAWrtVNK6r6Me6JxEZU1QMPuz3QdEkgjdcTER/VdSvniQmcKpIZoN9lHbX5tmicJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811621; c=relaxed/simple;
	bh=WHWmEOsLCNGyz3tr9tafWz5xXeDFPhb+UwnACzQ5E/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=u2643j50pFFpkZA2UjUYXgwcg5ekMAZVsb27ODIa1+Pb5EV0WPoCmoLRccISRv0avwJ9tkSktg5oKuvOZ2GW5OG3HdCuecDynH4gZaB63mGKTtcewjQUES1+AS8swC+bH7R1H34aXXRTJa+iuILWIxSQ95lgZ3TW5iSg+WErPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VABYmxx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VABYmxx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D0AC4CEEB;
	Sun, 10 Aug 2025 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754811620;
	bh=WHWmEOsLCNGyz3tr9tafWz5xXeDFPhb+UwnACzQ5E/U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VABYmxx1IScFp5K6i/ANhrPtgaWmjVEA+zoI2e0amo4vW2034KFqvp9j+4aTcmwPI
	 l9FQoCuRaAeRKS+y33JqTq/FZySPUhHeWfNvz2zdR4gYcBx9gfV2ZKH2VvvtUwdgpq
	 1NQEbFsVPDV6fQPWpmpXHLlHPfCUBwlkbenTd2ipSb6yyUyqDflsb4HqHE3m6l3+y0
	 EToTsY0V+vVy3lnrirGLYl/man4e/xMB7XcIwcEKqnW2IZv4Ew6FN94jHytuO4gGLx
	 pdBwODgRagH2toZDEzxguZLCR3h11S8D8beeVkl5FLl6RyaEYcNjJnxGw0iy2bJsmX
	 R7L2xPSN4pD1Q==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 Aug 2025 09:40:15 +0200
Message-Id: <DBYKSUYMQPEC.16UUNM5ALNR6Z@kernel.org>
Subject: Re: [PATCH v2 11/13] rust: block: replace `core::mem::zeroed` with
 `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, "Yutaro Ohno"
 <yutaro.ono.418@gmail.com>, "Xizhe Yin" <xizheyin@smail.nju.edu.cn>,
 "Manas" <manas18244@iiitd.ac.in>, "Fiona Behrens" <me@kloenk.dev>
Cc: "Lyude Paul" <lyude@redhat.com>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250523145125.523275-1-lossin@kernel.org>
 <ygVv2TD4X8QxR1siVW36cSGzeG722j-diB-TA2u1vdX6T_J-hb_dKDiU5vqAhccX3PrLw8yIbuHrgoz2aH-dbw==@protonmail.internalid> <20250523145125.523275-12-lossin@kernel.org> <87ms8a5f7b.fsf@kernel.org> <2yeRfzu6TlmaFLopKKmkgCjPM8Q1zo-YY5zgWjrbr00Bd8EwX2husSNSthkSujwznGxXmqteH00Apemot4z77w==@protonmail.internalid> <DBXC9DNUC9F0.2WUOVY87GAA4X@kernel.org> <87frdzhcbk.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87frdzhcbk.fsf@t14s.mail-host-address-is-not-set>

On Sun Aug 10, 2025 at 9:21 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Fri Aug 8, 2025 at 11:35 AM CEST, Andreas Hindborg wrote:
>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>
>>>> All types in `bindings` implement `Zeroable` if they can, so use
>>>> `pin_init::zeroed` instead of relying on `unsafe` code.
>>>>
>>>> If this ends up not compiling in the future, something in bindgen or o=
n
>>>> the C side changed and is most likely incorrect.
>>>>
>>>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>>>> ---
>>>
>>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> Thanks, this one was already picked & the PR that included it contains
>> your Acked-by (it couldn't be rebased since I noticed it too late). Let
>> me know if you need any pointers.
>
> Right, I remember now that you point it out. It's just because I got a
> new fancy email filter (lei q dfn:...). Hopefully I will miss fewer of
> these in the future.

That's nice and no worries, I should have pinged you before applying :)

---
Cheers,
Benno
