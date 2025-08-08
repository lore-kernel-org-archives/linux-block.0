Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC4A11;
	Fri,  8 Aug 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685965; cv=none; b=UJTm03NL6go+qamSTOLrdS62Tx+sdF7KtajQZwODvSPcmu1dGNOqATX8oWOiPvHzn428gDhjJPZMqHwIo0iLoASUi13OPox9hFua6wo8Wz4NRw1d3j3v9t7oUtLhHjQxqv+2BrdShP9aNu/guNjQ/8kqYrZFARaEucFScBdG6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685965; c=relaxed/simple;
	bh=dWTFQKehWgzaXtKYi2Jg5dqkO/jjGvxpjsF0ff29Jh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=io6TzqtysFI0kJ/9o1CfFWERfnfHE6Sj6gbteVFoi3jszg0WTXwMg6AVd/TiZ7Z6bK2zVZTOBuzscHynPIB0kQ0t+xT6L2yg4KiqQE9dLWxbUmfJLC3BJ1uOlqSt3FNJo1O4bN/KE9zdiuGqvNKMGG69Vx/wIaY75FmToftMZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpPrF8v0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpPrF8v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A35EC4CEED;
	Fri,  8 Aug 2025 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754685964;
	bh=dWTFQKehWgzaXtKYi2Jg5dqkO/jjGvxpjsF0ff29Jh8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=dpPrF8v0Thpl1/DQmGe9eGj+q4zhexDGsGRc9d30R72lPnEyztTH0h+GzS0wdUg4u
	 /FN/inFEzmacyhvMRx5e04WfrOEQDhQrq1ksG0lUvoc8EMQbp4+f0QJSMmWSpSjxOs
	 nOI+LLFkVsF9xZLOE9O1yHNP9NgBftf7K5ljICcgUHovWysK4miYtqaLKoTc7+rQWZ
	 HF0Hsbis3P9Iep2aJuKMBjTLRQNQVd9L7wQsiBiK1VMEie2FZaaLx0HHWFLattBSxj
	 QSqKIpGF69DNYbXUGKmUrwSPQu+/4VPFLK209XlyKoPGRELD8V3gSNerx2Gb3krscD
	 6gd1hYFy6m3IA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 22:45:59 +0200
Message-Id: <DBXC9DNUC9F0.2WUOVY87GAA4X@kernel.org>
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
Subject: Re: [PATCH v2 11/13] rust: block: replace `core::mem::zeroed` with
 `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250523145125.523275-1-lossin@kernel.org>
 <ygVv2TD4X8QxR1siVW36cSGzeG722j-diB-TA2u1vdX6T_J-hb_dKDiU5vqAhccX3PrLw8yIbuHrgoz2aH-dbw==@protonmail.internalid> <20250523145125.523275-12-lossin@kernel.org> <87ms8a5f7b.fsf@kernel.org>
In-Reply-To: <87ms8a5f7b.fsf@kernel.org>

On Fri Aug 8, 2025 at 11:35 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> All types in `bindings` implement `Zeroable` if they can, so use
>> `pin_init::zeroed` instead of relying on `unsafe` code.
>>
>> If this ends up not compiling in the future, something in bindgen or on
>> the C side changed and is most likely incorrect.
>>
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> ---
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks, this one was already picked & the PR that included it contains
your Acked-by (it couldn't be rebased since I noticed it too late). Let
me know if you need any pointers.

---
Cheers,
Benno
