Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3462E717B;
	Wed,  9 Jul 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073910; cv=none; b=r2CFBeJWns3mMp290a3u3XH8GItn7h2S6tqpbH2rmrD8z35owTt4+Eu6+ZVZZFvqMKzNSdDnHuKKDmKofTtSGd9C9s8GhuHOXZq2TVyQjnllEq6ufqQAw0s9pfrbOglSBw0mUG75hbc8HTy2IEjv57EO7rqWgZEEMMnzGr2WcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073910; c=relaxed/simple;
	bh=HN/A+MnroCUkLAvblyMBj2F9v7tw8Kej5OqPbBp4+5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=erhxJOutgooNXj6qJye1UShkD+wbTWJin7knRoTX5EVlw0BfW4dn9frFR5hy/8KOccIt09ng53Q6YPrMa0jU+HBJgBFk+03JY4NyMluuC8TbqjBv//cVZeprtmNaazjoQaLtKiol6opq/2pYPlLgR3Vv/v7zNsSdQr/jIbnjTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glCiv403; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glCiv403"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB73C4CEEF;
	Wed,  9 Jul 2025 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752073910;
	bh=HN/A+MnroCUkLAvblyMBj2F9v7tw8Kej5OqPbBp4+5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=glCiv403F5rktJnGzHeOLi35qbzOXC40V3Bt3ZbXLJj5KMApYDL87/1saKM8rDryo
	 ZmGo9QH6jEtVAbkSNqkS9Wn6/F/QeEQg9x8diUdyOyG7u4BLwVqa4ZEdZUN7IgcxTV
	 Aqjb1dYD8DDR0Fe/PFEPKHPL1mluYY/vYAKtsR2D+CPhNEFq/Cj5vlZXzDcDeEM/Gn
	 NlvgfreGuDTi9d2ORL08O7OiYNeabvSjHbDCZa1FoR415hmorvLUXpRIeqb2RT9s6W
	 mQjJq3zmIiqXSgY7L++FNrD5z1EUA7moqDwtLxW+OLiW8v9KysSqhBmPo3pIqrZfiz
	 JXMM5D+pWy6wg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/14] rust: str: introduce `BorrowFormatter`
In-Reply-To: <aG5rTNGn_NbnCISe@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 13:14:52 +0000")
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
	<20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
	<zr4gYI-Z4wTdXvcQMqGuUgU5Z47a3b4VgVtckO7APEwzIfvLTQzn7I92gu-bBhnNylJHkiPgTSCdIxhWNUZxzw==@protonmail.internalid>
	<aG5rTNGn_NbnCISe@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 17:11:40 +0200
Message-ID: <87wm8hjt5f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 09:44:57PM +0200, Andreas Hindborg wrote:
>> Add `BorrowFormatter`, a formatter that writes to an array or slice buffer.
>> This formatter is backed by the existing `Formatter`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> I don't think we need a separate BorrowFormatter. We can instead add a
> lifetime to Formatter and give it a safe constructor from a mutable
> slice.

Ah, good idea.


Best regards,
Andreas Hindborg



