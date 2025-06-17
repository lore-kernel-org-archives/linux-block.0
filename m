Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072F28FA9E;
	Tue, 17 Jun 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147707; cv=none; b=duTwxAMSaW400TuxVmzgqBfkcfCZdg2UQeo8tS9SSypEIHoobM75ePMZUivRIMTR4Z83jxOY3X54PQNo5J2gzp+brp94ZF0sEhYfSkaJhFd3fCojr0W0WQtQhYsR0aS+u9fMccf84muGzRWqi8gNUCwzRIp06r6Rb+kQaFkgEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147707; c=relaxed/simple;
	bh=VRMaUDETe6ZIVApAGqRg9acRfkODjIcR6Fz/uyGEimk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCWrqqBB5KxTFfZQnLI+Q+2aZMlfbezALVBiCnDubU+4k6pY3I2ZGaORiaGlCsxxElj3OfSTONLmcCfMJ3HJ4+PQba94Oz64S9YPEG8P5/CH4A+0bEONvsstc60XsQlyGPXTk77g/PduzyAC513mof/uWXGm/YdeZthHy8PSa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp9CshIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp9CshIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612F6C4CEE3;
	Tue, 17 Jun 2025 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147707;
	bh=VRMaUDETe6ZIVApAGqRg9acRfkODjIcR6Fz/uyGEimk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bp9CshIc9H7RhpRBRZBtyIrCqCEoI8B+ZXV6e5PRj70ZxN5d1nI8JAum4ljdDiFcT
	 256mr1K86U/XE6GXOEz/t88tnho7YL0UKNtUGnYHS0y2e2Sjw/E87yRRWdeYPaH+4x
	 wGP64iuqCL5bmsNKTvH5XX/ZMWHmqrdRSdr4IuLGI8YQjwwCSAMZb4l5tBhl+nxg2c
	 o0XhsdTN8D12iMtxyrd+yLhdw+u9H4pb1eCFGx53Ie5CrVhiNH+Q2u8HagcA36C1li
	 TG7g8S4mznllqjTkj8u69S3c6BUDQfg7NcA8QJExu3aSRUguODSoaFA1FHrrVHTPiG
	 n1G30HCMuY5SA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Jens Axboe"
 <axboe@kernel.dk>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] rnull: add soft-irq completion support
In-Reply-To: <2399a39e-a4e5-4f19-a5c7-2582b584e9d7@wdc.com> (Johannes
	Thumshirn's message of "Mon, 16 Jun 2025 13:56:16 +0000")
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
	<20250616-rnull-up-v6-16-v1-9-a4168b8e76b2@kernel.org>
	<5Mb2NxReiXPkSFjrUdLfq-5bzuvoWJyGLqgZlnc05SLScI4ezIlnWZ--jl6zZeCBNEG4KkuUQxDp2qt8GiwTsw==@protonmail.internalid>
	<2399a39e-a4e5-4f19-a5c7-2582b584e9d7@wdc.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 17 Jun 2025 10:08:17 +0200
Message-ID: <87bjqmbxji.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Thumshirn" <Johannes.Thumshirn@wdc.com> writes:

> On 16.06.25 15:28, Andreas Hindborg wrote:
>> rnull currently only supports direct completion. Add option for completing
>> requests across CPU nodes via soft IRQ or IPMI.
>
> No idea about the Rust stuff but I think you ment IPI not IPMI.

Absolutely, thanks! Sneaky little M got in there.


Best regards,
Andreas Hindborg



