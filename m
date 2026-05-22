Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F32F0C62;
	Fri, 22 May 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430823; cv=none; b=KnQV+ZHEqizjtULclQmU0TQLgVvitzKQBxLv7ETMM7IpfFGIHCRvABusLQWaCRouncjE8x0J3LierzEd6fddGR5wGyH8AiuLlqsXBSuC9gZs+LHtqMk0jsnQw4eC0Oq1yNSq2/XgDbiXd1hVXieh7g/sJ89u07uTVUZjhid5WPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430823; c=relaxed/simple;
	bh=J0yhJ0Qd+VLaIGAScNjIb83qpj61FCl+gql8fOXRUE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbMqTKtMNmet6yRArVt5iLEqLjVAU4iG5dTihHl0yMRYuhy02NNgb7O8L1iyqyoRbBjDH+z/TG+rchQGdDkHg3O5q/wT3uHUMls8gAiZ4xiS9Pt4igG8FJ0hTOPbntQ8BQHMizHOw29IhDQdxwjjH10sOIAx7OYpKYnkHrJjuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqwQljx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqwQljx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB01F000E9;
	Fri, 22 May 2026 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779430822;
	bh=J0yhJ0Qd+VLaIGAScNjIb83qpj61FCl+gql8fOXRUE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nqwQljx8wKYHDJsY4RXPjf9V27v4iFTGRyMy5PLykr+5DkUlNXqHC+NqWfF0hM8sB
	 7l+LB6KBNCIltyzE8ytQVVEUdjZ9nTExd4+2XF3OWu/SRnSYDpEmvRLSH62LJ1g1ue
	 C/6XDyzbqy61jUqvCs8qR0L/5eZsEwGFE3dkI0RhmCvUhDoi1cd7eXWM1yXH21IOKB
	 eABzV52qWIVYmyH/8y5H9clj0tenpU1ZMZRkPdAYLNjEr42bJkc4PI8M7jc6wqul2+
	 73ctJk/8rnTopawi8UMgyn1HXP9dXncPK+4LF8idixqTG++sXSV6RBUqoDaDYFSn5V
	 T/zZ0wvrJltpw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Malte Wechter <maltewechter@gmail.com>,
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: add procedural macro for declaring configfs
 attributes
In-Reply-To: <DIO4B1VH1JZT.27KYCZG39SKDX@garyguo.net>
References: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>
 <6jLOwFoqAZPequd66G_HhqqyUNlo6ycNhNYWHSep2Zzm6RT3XXV8RKr4YqgY0TzxUfy-RSmel9NdCZ7UvwNYGA==@protonmail.internalid>
 <DIO4B1VH1JZT.27KYCZG39SKDX@garyguo.net>
Date: Fri, 22 May 2026 08:20:08 +0200
Message-ID: <87tss06k4n.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Wed May 20, 2026 at 9:40 AM CEST, Malte Wechter wrote:
>> Implement `configfs_attrs!` as a procedural macro using `syn`, this
>> improves readability and maintainability. Remove the old macro and
>> replace all uses with the new macro. Add the new macro implementation
>> file to MAINTAINERS.
>
> The current declarative macro implementation is quite readable and IMO more so
> than this syn rewrite.
>
> Unless there's a compelling use case where it needs to be implememented using
> token munchers with declarative macro but can be easily parsed with proc macro,
> I think it should just stay as decl macro.

I disagree. I think the proc macro is difficult to read and maintain,
and I prefer a procedural parser.

Best regards,
Andreas Hindborg

