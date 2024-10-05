Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169713B7AF;
	Sat,  5 Oct 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728125867; cv=none; b=cuQYC8q0WUoNrNpgDyO1WyMiXRx18Gqq70efUe164xjNcMT826tDwncf2UgNkmuHw3u/5+2r7NBZev2tR8P9GPvMAQ6d0TXohmtg8bmxU/wylVDqqVctMEo7TGQP3GtD+QFVOX49njkqdKAnt+FFkc4i5M5m2a6RHEHI2LcN1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728125867; c=relaxed/simple;
	bh=YcmHvA/vo6iM/bKu7ozbyguTQ8Eu9e6XcvUhgaSWCg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKzhdL29dp7KEvvkNT7lDEqRHyVvBpW8h69K+LUU8Tx29zfV90Pumb8gK8Nqak7qfK1Z7Mxb1/tVKCH9/92Ho4lnMEKfptmkFJKUjYTJ3hNVKRJp2Kov4G6nDK+MlZmPLSFPHr75OqxB8mMw1hHwKdtE5xPV1fU3OGUy1qbI6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4q8ztm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4q8ztm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500DCC4CEC2;
	Sat,  5 Oct 2024 10:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728125867;
	bh=YcmHvA/vo6iM/bKu7ozbyguTQ8Eu9e6XcvUhgaSWCg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E4q8ztm7AlJqn73KCo3RLJNVqap2auQQu4Gcq5CBEbsFl+K4adQoFJG5lUQZiO7su
	 RvdABxXAwjHM+WQ53aJSH5mtx4NtN9YT+EZ0zWNNmGhHDgiK3Lk6bopUkmn24zoOso
	 lXlCSSRid7r5PkBRNGA+UjWnytZN9jK6liRot8ix69NZ/Jm0jbInAXSFDmuS1qnWkM
	 1bsDPjBNhSOE7lwjAHajX1cEPgYpQSnRY7B+JWEwzbjCSOeseFaE8g+5agwHPqz7Gq
	 F6JVSxZ3B8VQxpfZNGRh25o77+AE3sIsCzljCVTBSPrQGIwbACNUr/LWaMuJ8HxJs0
	 rwrchSzjb9FgA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,  "Gary Guo" <gary@garyguo.net>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Jens Axboe" <axboe@kernel.dk>,  "Will Deacon" <will@kernel.org>,  "Mark
 Rutland" <mark.rutland@arm.com>,  <linux-block@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <20241005101039.GZ18071@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Sat, 05 Oct 2024 12:10:39 +0200")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-4-gary@garyguo.net>
	<OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
	<2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
	<c0xcjD8HeBe9oH6FbSe2gfwHicJV1TbpkAf1xTkDG1SINISgogXt0flUzHacAgzvNjdpSX1Bxn6scW36cQp7bQ==@protonmail.internalid>
	<20241005101039.GZ18071@noisy.programming.kicks-ass.net>
Date: Sat, 05 Oct 2024 12:57:31 +0200
Message-ID: <87v7y6om04.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Peter Zijlstra" <peterz@infradead.org> writes:

> On Sat, Oct 05, 2024 at 11:48:53AM +0200, Andreas Hindborg wrote:
>
>> It is in the documentation, rendered version available here [1]. Let me
>> know if it is still unclear, then I guess we need to update the docs.
>
>>
>> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#implementation-details
>
> So I clicked on the link for shits and giggles, and OMG that's
> unreadable garbage :/ Is there a plain text form that a normal person
> can read?

To each his own, I guess. It is rendered from the source code. There is
a source link at the top of the page that will take you to a rendered
version of the source code, line numbers, syntax highlighting and all.

You can open up the source file in your favorite pager and read it there
as well. This particular text is from rust/kernel/block/mq/request.rs.

BR Andreas

