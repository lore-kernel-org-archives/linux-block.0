Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD78270553;
	Mon,  1 Sep 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715197; cv=none; b=c6QWHsSDPD++Ge5WyQ6DcBtibH6uhKZmCnvHmEpg3IgUo9uEY2G89lfzEan/zRtvEduz2e6QDM1tF1fbT1Sg5mWuW10ZI78qeU7hZShT8l0hKaFpdrpqs5+NLtdKrVSl5j9/tiyQMXX8H0tNqAYpX9Q6V7vJ3N1JpnxORfwfxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715197; c=relaxed/simple;
	bh=TfDgLy/6mxfiXzACBtsrVnjlPWf4P4lV9WizAo0NcqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NbB+YvbSbyCcIE6/nGs5rwwTtPM8RxtrA4fd56q88mM7f+3FqNrztfVR5wTQHHXNLT+30K6/eRlvd7JgTpzvBygqag4RUKPVgfJxGdaRDKzlgWK0kd87lyo6XtuixG4SvPYYBC6yTbzna4J4W5NuUKujHreU2xd3n5ixmNPz1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUz5o1vq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUz5o1vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3B5C4CEF4;
	Mon,  1 Sep 2025 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715196;
	bh=TfDgLy/6mxfiXzACBtsrVnjlPWf4P4lV9WizAo0NcqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JUz5o1vqBk96jh+dltQfA4AYRvVte1ebPAVYM9q6Z6wKYaBI0cezDPrrhxxqcoW7d
	 KxH2AIS8baI+hwZ960YD2+5zRAPuN0txpoo31Q05Wz/9DGaomTubpEcOgE9qxRKxBo
	 /luHOsJ1/8AbTLyWZNDbVDy3Q4o/lB4mqY9MrGy7+N0zz5aoFQcAk6+T1rNpx7ioZL
	 Dyddc3TfcciJm4GFXFypFCH1HJhQg2fp769/0bEdb1feBtTOXcm0M5xHPTwhYcj7a6
	 p2uiRm14mcEYrWL1igRvXHo9OuVw89/dFB+iCu4yQNxPLYl3xwrYMzE0mHOXqUFSw1
	 bQPRejEX4fSOg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Boqun Feng
 <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao
 <leitao@debian.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] rust: str: allow `str::Formatter` to format
 into `&mut [u8]`.
In-Reply-To: <20250829-famous-honest-pelican-7fe42e@lemur>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
 <b2IkbJXRER5mLrLu1mpLMb6tjooPM_des2iveijPsIGSfUzKYRomwCoKPnXSJsidg1c-KY2R76d0TYb2DZmbzw==@protonmail.internalid>
 <15990453-889F-40C3-863D-DB41306E2A84@collabora.com>
 <874itqidfy.fsf@t14s.mail-host-address-is-not-set>
 <4aMZ71QBkWOfiKyazE-teR5D4P71VMaZNMAqiYfV_T3gXM0JepjnlYHK2tZZnPBa31CaJnHC_2ixLeivqCFlAg==@protonmail.internalid>
 <20250829-famous-honest-pelican-7fe42e@lemur>
Date: Mon, 01 Sep 2025 09:58:56 +0200
Message-ID: <871poqioxr.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Konstantin Ryabitsev" <konstantin@linuxfoundation.org> writes:

> On Fri, Aug 29, 2025 at 01:18:09PM +0200, Andreas Hindborg wrote:
>> > I gave my r-b on v3 for this patch IIRC. What happened?
>>
>> I probably messed up. I'm having a really bad time with b4 collecting
>> the tags.
>
> Can I offer any help?

That would be great. I'll be sure to write up a proper bug report next time I have issues.


Best regards,
Andreas Hindborg


