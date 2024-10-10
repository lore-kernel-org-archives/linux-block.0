Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BCBE6F;
	Thu, 10 Oct 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552563; cv=none; b=F0D9nBFUjQJ9MqusSoCrZBUWnEv2Q86u5km1M+XO+yDGTW0LMBOJ/XeBw9InB4sNVHq1pGv+d0ScKxy+6bHQdaaVQYqQwtgaUE2WtQ7B80Fu3DdYaaLTXu2ZkxBYc7yczad4W9WlW+V2SIAUJjIzDSTs/xLsJNC9xe/+ZdE7maw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552563; c=relaxed/simple;
	bh=uHHQuCd+hBIGNhvjjP6qSw0Lol5SDSfCg5OF8r0zrs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkvoX5oY839nrhvCkxisGouGnkJQuLWtwNN9oAU0zcsxVj/uLUoGt0eUcm2J6/UG/XHKdiT2/mPkq2XblZBWpJq+Z3CwO1kVbM96xDTNE9gwBliBIDDuVt6kdaXwKXCXamMBRaHAOnSxDGc93HSjaWsRSmJuDVAVXOD5o52oceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDdaetEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDdaetEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE4BC4CEC5;
	Thu, 10 Oct 2024 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552563;
	bh=uHHQuCd+hBIGNhvjjP6qSw0Lol5SDSfCg5OF8r0zrs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YDdaetEynXX+YuTMPWiX5TdxwuOt3klN+L+GbJU1NwyXKePOjL/KJhTXe9xLacNyl
	 yAX0jq5e2KpK4n7CFfIEUnRY0H4V+QEN1l5ymfLBgmClvjSJZXGCzyoNGA/fBU+vri
	 EgLDjyfQgHSDJNSMNDrgKaj4ht1dQP4KZn8FvpfdkohIYKWggsSgRNlZpMsCAyVKSf
	 tmpDpO+J+2c2l3TXZw/hZ8vJikkKhWVc30SFRBooXsDMy2jNp3eIscKyWw6cf3JUd/
	 vtG5Fq9UssLS0Ym4NzGlwECqrlLq4i7Lp9t0tQQiWl9qij2Jx1Xe9bcLDvaZY6FVNP
	 mXulk9raq4eAg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Francesco Zardi <frazar00@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@samsung.com>,  Alice Ryhl
 <aliceryhl@google.com>,  Jens Axboe <axboe@kernel.dk>,
  rust-for-linux@vger.kernel.org,  linux-block@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: rust: fix formatting for
 kernel::block::mq::Request
In-Reply-To: <20240903173027.16732-3-frazar00@gmail.com> (Francesco Zardi's
	message of "Tue, 3 Sep 2024 19:30:29 +0200")
References: <20240903173027.16732-3-frazar00@gmail.com>
Date: Thu, 10 Oct 2024 11:29:05 +0200
Message-ID: <87cyk8mhlq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Zardi <frazar00@gmail.com> writes:

> Fix several issues with rustdoc formatting for the
> `kernel::block::mq::Request` module, in particular:
>
> - An ordered list not rendering correctly, fixed by using numbers prefixes
>   instead of letters
>
> - Code snippets formatted as regular text, fixed by wrapping the code with
>   `back-ticks`
>
> - References to types missing intra-doc links, fixed by wrapping the
>   types with [square brackets]
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1108
> Signed-off-by: Francesco Zardi <frazar00@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks for the patch!


