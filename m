Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BF1D432D;
	Sat, 11 Apr 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903642; cv=none; b=ZrEnhe/2uHfgp+fJNi7tVe6cofr2VApgZr7zBKlhpwoQF8noOGqS7vnz6t8gdIu3g1bzB+ZQILg0EnSIlFnpxTVHMSjhmj2axMr7y86J34PNc6KImlwd641QLJGjPOeS46H3NpvmVhfDXbBYNBX0NXSMBcQAfcHmz2sOIByGb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903642; c=relaxed/simple;
	bh=5rzeVEGS9Zn60kB/gQf1iJniZc9Gtv64spP9ta9raPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cjn1j+wMjhUxfBna/Dock9y/sP5uEUEuEY2pMCGyfk0FqaLSjKjlzRWRsjOCmiiEv6zoCLkriPNh9txJ842bZd+uCIXqVo9PPG8NxZVk2taINS06kwFKL1o02lWahOMnrDAP4oWEcReIxun/OgEKTQkxM80wKKbh3+VIwei9MWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwsr8rCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwsr8rCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D69C4CEF7;
	Sat, 11 Apr 2026 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775903641;
	bh=5rzeVEGS9Zn60kB/gQf1iJniZc9Gtv64spP9ta9raPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lwsr8rCgYrzMn8Ef5B1BpKXEccMT/GJHdBC30JdvryOw4u8mjDZR0Vmo8VbMB31yX
	 eQT8QoX268Y5J5P1cg6WU7V4aZIniC2vMF4wVxalsUl3StQIxpq/UZtZD6GTJ8x2e6
	 q+2HzLXFOayj5KFr5nQIa5GVmnHquvdKmVl1GYTsZjoJLdwUkPgI6b3bVShnQTJc+l
	 y0VqLAswuIo8tqpidNqco3PACjDjs9hBAx7hbiEJ6Jc5IvV5Ex0mGkp3uTEaOsSjIe
	 uVyGiFMiEdG4UgzcUpPJoMh+IYYXXYcPrkKarbAv1IQrHNXpPb5G7F2aBOZR3BUZns
	 FJ/cSKMin+XEA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] rust: block: safely abstract the blk-mq poll
 callback
In-Reply-To: <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
References: <34Y9hHd4E8CdmCmv6LKr2tXYoUyzhgpwOGgK88jxj_B5UHGX-NM-7g0Wr3PXLWBlF0lzMM8lcS_LHtoQAGVn7g==@protonmail.internalid>
 <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
Date: Sat, 11 Apr 2026 12:33:38 +0200
Message-ID: <87ik9xwzul.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wenzhao Liao" <wenzhaoliao@ruc.edu.cn> writes:

> Rust blk-mq drivers currently cannot implement the `blk_mq_ops->poll`
> callback: the Rust vtable hardcodes `poll: None`, and there is no safe
> way for a driver to receive the borrowed hardware queue context or the
> optional completion batch pointer that blk-mq passes to C drivers.

Again, this is covered by the series at [1]. Please instruct your AI agent
to read that thread before submitting more patches.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org/

