Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4E3DDDB3;
	Mon, 31 Aug 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180922; cv=none; b=WCeQ8wTqB4muRzIK2D+N5dL+6InAi/QSbZ/V0ZyBxDnZsZ/orI3nB4bVBUYq2iyQW7Xs6xfGfvKpB1ZSlDmxtm9B8iRk67NGaH5bJgtNV09wgXHXeBYVd+D3CwcbRdQtdNTZWUq8b8Fn9y/8bghgnF+Iof4hkagZ1HKfV193RRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180922; c=relaxed/simple;
	bh=zRK6O495q3PpP5FvYeC9SvBghHM7l483OnCCPdL0B+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lcdHulSOOv74qVGQVXOwKeatjx4FM6MvMVc+q1S41HYvCZYlbZ1a7d/Hs34GRJHU3p+GjKlCnsTTfarHN0G8LgNVAgTLqR22g2sqqRFTM83iXrFFE2G3gOs7JhXLhydyVIZM/HyOGvfu/GO0IMn071S5Uoyc+fPFCiCw/7/udZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofQYh7CM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofQYh7CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6021F00A3E;
	Mon, 31 Aug 2026 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788180919;
	bh=zRK6O495q3PpP5FvYeC9SvBghHM7l483OnCCPdL0B+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ofQYh7CMzOBIXNCTTwQyZ/35PAqw9Mg8diW2dQ08o/eSxh4P99jfZhthHiSDOQsXf
	 E0DRG9bBlZQZoKC3+Zg1k9EQsGA7wLkNVjWcR9WV+tOKurPOZf0Rhy2qJ2pcv9yoTW
	 khMA5Ln9j78uh2pr3w+LX4ZZPI5kXbY2p8sz6tWRhncEJ9A9qB6d7tisEW8p8l/Loj
	 cnJFShpDKcltSkKXQ1sICavyHLoKQgxCtogU5MOqlEVufA6dR6AI5Vk+11/dq8h2RM
	 K+tKIYKR+D4gpckffFleRvDORXBq8Hdt5+/0cQodV3M1Tk1+AzsauiGRwBoJSH8CMD
	 OcdSOIJ/MS6bQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Sophon Z via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sophon Z <aiqubits@hotmail.com>
Subject: Re: [PATCH] rust: block: Fix GenDiskBuilder block size documentation
In-Reply-To: <20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com>
References: <eqzS1cYG2bYJ10oFrfX_D7UVNqb_NuK3wsMUUEXpdBj7yCtzD24WOzI8zIKg2FlD04VFp_R9xt65fGmEqpt6QA==@protonmail.internalid>
 <20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com>
Date: Mon, 31 Aug 2026 14:55:07 +0200
Message-ID: <87ld9mxxec.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sophon Z via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>
writes:

> From: Sophon Z <aiqubits@hotmail.com>
>
> GenDiskBuilder::validate_block_size() accepts powers of two from 512
> through PAGE_SIZE, but the documentation for logical_block_size() and
> physical_block_size() states that the maximum is 4096.
>
> Use PAGE_SIZE for both documented upper bounds so that the documentation
> matches validation on architectures with larger page sizes.
>
> Signed-off-by: Sophon Z <aiqubits@hotmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

@Jens, please pick this one.

@Sophon I'd like to call the C static inline `blk_validate_block_size`
here instead reproducing the check. Feel free to add a patch. You need
to add a helper in rust/helpers/blk.c to be able to call the function.

You would also need to update the documentation again, as the C function
has special handling when transparent huge pages are enabled. I would
suggest to just saying "check that the block size is valid".

Best regards,
Andreas Hindborg



