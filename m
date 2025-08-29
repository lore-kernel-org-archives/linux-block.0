Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942F22759C;
	Fri, 29 Aug 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466302; cv=none; b=s+W6staKoNr7wkBc9h9BrzJdbjRA9eAt00laAU6++ugWiflOB1pnXUKXhEI0bOiPF1PsR0oU+88FamB10QzvWdKZh4QfqHh/JsOmF8N/jtO+TcQ/SpqdgjjlKVzgg9BFYzPlvdXakmdvO9QBvskKO76bm09pMB0W41Quc4fd0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466302; c=relaxed/simple;
	bh=3Zr64zwtaJ7DWT63M88lIYqh//MOO1IjXFWNld3J9r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIluMbc/K7Rn54FN5WIII6OKd3F9jmB/KjKJ2Y+B9G1CBTUpa1RPI7N2qxi7+tl96iEK1TCmDepPkMpeL1Y8htf/bNMYL8YaKJK1OMoEeTxk1+OZdn0lV0l9uEEq5H2aDHM0zDQNoUT7P2V+Plc6xuMVwWaxY+aDUJntxUN+LYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC7qareE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC7qareE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F793C4CEF0;
	Fri, 29 Aug 2025 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466301;
	bh=3Zr64zwtaJ7DWT63M88lIYqh//MOO1IjXFWNld3J9r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WC7qareEHG3RvOivvnvPNlp18ebeHHo7Wqt2eLW7fB7qZUW3IryArR7bdLFuoUs1L
	 uXPpW02g+pMrwHXyYkiUiieLPPGxBMLOjoI9V4IR0xCLitRX0LlaFE5vKjTqh6ikWd
	 CFQ8mJc0I0p26dXYwJRsVhwPvAtWdwPanRWYlsTxr9ZtHN3//7N7ekHur/S1LLi7yB
	 S5Yic2ulXpj5RnA3NXwNgwPGte4RKnUTCfKLG9Fmu30jv0vg59RGYyFLRhNdit01ox
	 zRTqUwXtvWzJKTp1R2/2UsZzL9+sBB6SgelfkXaWYslDzn/QFJJ23Wk3nvOwNq6wOE
	 4+QhSs9PZ+q5g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao
 <leitao@debian.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] rust: str: allow `str::Formatter` to format
 into `&mut [u8]`.
In-Reply-To: <15990453-889F-40C3-863D-DB41306E2A84@collabora.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
 <b2IkbJXRER5mLrLu1mpLMb6tjooPM_des2iveijPsIGSfUzKYRomwCoKPnXSJsidg1c-KY2R76d0TYb2DZmbzw==@protonmail.internalid>
 <15990453-889F-40C3-863D-DB41306E2A84@collabora.com>
Date: Fri, 29 Aug 2025 13:18:09 +0200
Message-ID: <874itqidfy.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 15 Aug 2025, at 04:30, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Improve `Formatter` so that it can write to an array or slice buffer.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

<cut>

>
> I gave my r-b on v3 for this patch IIRC. What happened?

I probably messed up. I'm having a really bad time with b4 collecting
the tags.

I'll be sure to add your tag in next spin. Thanks!


Best regards,
Andreas Hindborg



