Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E214657FA;
	Wed, 27 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905822; cv=none; b=MLV+iMyz26+AIKEH9L1sAReF5M/2nEoMy8xuargAsRKSCsDF/NUdQ7umvqjwJPokQOt2H7Bqpddn0J7fbQ7Rt68uGFkFriij/n9Ky7M/FOa8Tsez773tz5NtVVOs2/gyDcNbflLnkeUcfue/7wJKyF4WOrxHfqeC8XIqYPAdQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905822; c=relaxed/simple;
	bh=MAoK76CCQ4HIMZc1TOZtQq30iprIkZXMGD2BkhDs2zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=triviRZNT+4JscapfvyG+JM8lj1q4vz29FJ1WNVSc+Ama60VdBQQVA2zjoar6v1xIceOGUJiZk2Ho+jDjGgvWBKerNDVkwF2YHvLY9UqCspiPcj7BM2zY9fcCC8TnMU4MwyLw2+hj0jPXXmsTc+48IdJtH7ZrAesLx1D2RseeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8fNLdHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8fNLdHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9A71F00A3D;
	Wed, 27 May 2026 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905820;
	bh=7EDnu0IkYC/+E0GNhmUarvZ/YqQEGB9Pz9lWqkeULHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M8fNLdHN5Z145FVKVYsZQoaO+HDQ/AwYCH0fOVnXqXHwMRUcGpTfhYQ3ZKSFlEvLS
	 972BzYuWW9HMfDE7x7xCoq99L2ODQJKoTzRPOuFIuxaYNXYOnsk32tUfEUjiiw/gF/
	 +4vx8QzW++q6F6CtkUQD7B6DqlHwlwhjqNY4w3K+nxQJHzJztbjIC4wGA3+FhFyGRD
	 9jZnNjW4Q9SoAFbqytqkpHDK6VIabGaNKqMR2La/k+mncF9MFuDsND91AyEqM7MMSo
	 KRQ8JQ4rLfN60aRP3X+/SSbBSHtZ6ozcLDfnFYObVpei06e1rxccn432O2aCgefC/B
	 A57uAhjQmx66g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: mateusz.nowicki@posteo.net
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with
 C signature
In-Reply-To: <1552076fb3201e5e47ead0989e793472@posteo.net>
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
 <1552076fb3201e5e47ead0989e793472@posteo.net>
Date: Wed, 27 May 2026 20:16:50 +0200
Message-ID: <87o6i07m5p.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

mateusz.nowicki@posteo.net writes:

> Hello Andreas,
>
> how can I catch it earlier in the future? I verified patch correctness 
> with compiling 'allyesconfig' but
> I didn't catch rust issue.

As Gary says, CONFIG_RUST is silently disabled if the required tools are
not present. Please see the quick start guide for how to get a suitable
compiler on major distros [1].

You can run `make LLVM=1 rustavailable` to check that your tools are set
up correctly.

Best regards,
Andreas Hindborg


[1] https://docs.kernel.org/rust/quick-start.html

