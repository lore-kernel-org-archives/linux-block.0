Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC3239085;
	Mon, 26 Jan 2026 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452070; cv=none; b=mqSFaq/QcYsM1XcPdp3cAt3FIVCiT1CGzeT0MCWKIWiZl2DMQUUdo5G/j8+JCbwLC+tZq6ldYkb+WsWj+pzlCQOtO4WCj5tTALaBMbJMBKMjXJ/HCnhxdAdvqlLok+sgHN6sqi1hTwkhypfRVuK63dP+8HLG07jnb6Z2n6JBBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452070; c=relaxed/simple;
	bh=ZQc43uSRPfc1qUIQsoIAjNuwYf4lBHXrXf64Mia5v58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7M49mDuDG6TTJx7jRJhPlcfDNLtCJz49jZ+JvkDe0CWqMceeNI/vC4Q32bSWXRjvAvojHXeT2yLKUHAme4THvNLenG/7BbUK6X5UhMpyCX2FE2ebH8U6MFED0vmLDSWYcRC5LxzIikhj6HW1mjkFOdquZu9ULWBRzqubJ26Rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYeL/ezJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYeL/ezJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E7C116C6;
	Mon, 26 Jan 2026 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452069;
	bh=ZQc43uSRPfc1qUIQsoIAjNuwYf4lBHXrXf64Mia5v58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HYeL/ezJQHQgXsENB0Uu0AQrc2cpKphJN5Up43qhpI9i4G3hgcHSIhsYbiDaNo+dJ
	 jjISSw+g0iKGodaN/Ds6Q3laaPfj5zYfFVJzVr7iq/3zdPgvDE8MjHR5MPCKeQ36Jd
	 9n6KzvHxwqtM0/LGHOOLdvj0E1plT/J0vnobG2JiXpqwzKIPSGvZ11oDq0pp6Ghzv1
	 PLed5mFNmBl90HaOvXFtP6naVQLZ8h6jrMgsaY8VJPcFKWBSekOANgXZSbpQ0ww26v
	 7/AtG/QeXjsTU0gOkRXH1B9MqaJcbuoSf49Q1tfulptCKU3fy4o67/H9KKsDQ1O1s4
	 ARvwvR3Yqx0oA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block: rnull: remove imports available via prelude
In-Reply-To: <20260123172007.136873-3-gary@garyguo.net>
References: <20260123172007.136873-1-gary@garyguo.net>
 <795qzMaJiv4J6R3ywJGnvJsSEz1Oo9XKAOGd3DhpySquL_JrdxisQmp0NP1EPBFuvBshX5Tcb-ld4_Pu2nfPFQ==@protonmail.internalid>
 <20260123172007.136873-3-gary@garyguo.net>
Date: Mon, 26 Jan 2026 19:27:38 +0100
Message-ID: <87wm14rzz9.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> These imports are already in scope by importing `kernel::prelude::*` and
> does not need to be imported separately.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



