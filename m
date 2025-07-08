Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF4D1C6FEC;
	Tue,  8 Jul 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999609; cv=none; b=X51IwYf6QIBF+A/Fk53IODQCMg8Aw+uO75QbGON1R5cilWqOOY20VNXISMIor7xVWyep9Z08V01dMk30kZiooVf9NwbXvHf4bwmJUyH4sk6C78PtXy0gglY5BnB8UXhDXiENZ0BaIIgblNworaJ1e/+XoYMX30twGjQPrvQ5P5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999609; c=relaxed/simple;
	bh=6K6pCHiuDilCHIrX8F8+0og63++MiSKHOXtlPAoRGYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P9OD2qLxPmHe0ImqJkEhgbx5vteyAvggBzYCB1E+Ut63DfjWNpPGckkTNZmKA8RwXf4PXNHQTq7ibRtA3uIDrzT8WLHe5DkFeZ0OP646rl1YHbmwooUleM1Cyjt34UFcHXBb6H6lF/I5yDJhd9Guw9i1eQ58mplbuA5XYJVpyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szuO0kT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szuO0kT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129EC4CEF5;
	Tue,  8 Jul 2025 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751999608;
	bh=6K6pCHiuDilCHIrX8F8+0og63++MiSKHOXtlPAoRGYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=szuO0kT9jwaw2exR1WUxHFpz63sZKSGjwO7pBZE+EiqccVzWam6Z3zMKzUQOpEzfF
	 g8YuWeb628+d0+odzk9JZKJ5fZGrj6vwVHGkAEaPVmL3oyp/DQ0JQEZ3k80jc4oYJ7
	 iI/IlXd1hWCv1kbNqM7Bd2bX84miJpqmRk2ThW3UKkgG5Hj6clKsZkup6YTBPZ6VHB
	 tuhmVVtZgOO6E999KezTnsYh/6ljrM2p0acCB49v0+5itM9rfgBXuW7FAnUQukGgMN
	 9bVUoLJgns8Unet6uKbjriyRGdEHZwCZBGhsWybufjflv6XIqIGBaogDrMgvRHi+xj
	 jMFgvbXX03btA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Trevor Gross <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  Breno Leitao <leitao@debian.org>,  Fiona Behrens <me@kloenk.dev>,
  Christian Schrefl <chrisi.schrefl@gmail.com>,  Alban Kurti
 <kurti@invicto.ai>,  Michael Vetter <jubalh@iodoru.org>,
  linux-block@vger.kernel.org,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Rust pin-init for v6.17
In-Reply-To: <20250708141442.1339091-1-lossin@kernel.org> (Benno Lossin's
	message of "Tue, 8 Jul 2025 16:14:40 +0200")
References: <20250708141442.1339091-1-lossin@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 20:33:18 +0200
Message-ID: <877c0imt1t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <lossin@kernel.org> writes:

> Hi Miguel,
>
> This time there are a couple of interesting changes, see below. Most
> importantly, we can now use `Result` as an initializer. And implement
> `Zeroable` via the `MaybeZeroable` derive macro. When the second part of
> [1] is merged, this will make all types in bindings that can be zeroed
> implement `Zeroable`.
>
> There is one small mistake in the second commit e832374ccadf ("rust:
> pin-init: change blanket impls for `[Pin]Init` and add one for
> `Result<T, E>`") I forgot to ping Andreas about the changes in Rust
> block and thus don't have his Acked-by. We discussed this privately
> and he his okay with the changes. I didn't rebase due to the fact that
> the commit already is pretty old and that Danilo already merged that
> commit into driver-core-next, see below. Sorry about this!

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


