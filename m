Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B322609E3;
	Thu, 18 Jun 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779324; cv=none; b=BRXZwQlDD24CHGJkIoDUYP/YXcucaZ6uiOHL5l8Ug6X/pn5mkEXswFeIvzT+u/O8pwvlCuIznONRr8AjNJXnwcYI7Ra+uvlwm4jKDNSaY6Kfj3nl9yKJczyAHyVSImCi772O7YtgR8qS7zIrKUAyWs4P+UIrh1VfbIA9APcdIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779324; c=relaxed/simple;
	bh=36J+0U9ym2f+2scfvGRRidPyWrejCq4VO3qCfykcdFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2OXY32vQFhCjvl3LRSXL2NeAUR3dj/r98eoUXke2xQZaKxXlwWeMAdmPlvKFj6hqCGI9eD4HSFerVaihlg+9YFfK6+qKNMHieRuUiJQYRCJhbkIuzzjDY0OAm8bnJTwXxg3C8LrYt3u6Qaj79U+FTRKLgQ1QT8Z00yT8SevWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksi4nwo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksi4nwo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73CA1F000E9;
	Thu, 18 Jun 2026 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781779322;
	bh=36J+0U9ym2f+2scfvGRRidPyWrejCq4VO3qCfykcdFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ksi4nwo5tAD+eRsLnAplEWkdaKBG+y+Obo15GgBzN2K13c32gauJpbGtF4P4q6/DK
	 440+B1Oc3LYInkmxbbMdErIfa8Vr2DUzXCKEQbxvFojgjnts3PQn9ly2BzV822Lnd5
	 Z4fzb24UZyIvDBxmTufQ4T/+pDdp/q41FdqGJ6PGvfjzeJVI+WEylqJp7unDf04oNO
	 vkstGv6CawpK/z+rRcWQbhzYaJkkBXfD/FfjpsOcvofThwhMO9lQR3I9pZSiPO3d9E
	 HVPpJynWEPu0DYgnv50cWqW+iQekndcVKG35ufMkOOaTrC7jZ/XjwLMIaspwxR2VXg
	 bvwLkjnRR/BZg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Brendan
 Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae
 Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Alvin
 Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 6/7] rust: block: rnull: use vertical import style
In-Reply-To: <20260521-miscdev-use-format-v3-6-56240ca70d0c@linux.dev>
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
 <0PiZH74SfWsWu8rrtNNGSXiguyGA-RS0v47NHp-o95E3pnz6cvuI0ellv5ot27YxuiD5hbtO2AhgGz8lOA-LYQ==@protonmail.internalid>
 <20260521-miscdev-use-format-v3-6-56240ca70d0c@linux.dev>
Date: Thu, 18 Jun 2026 12:41:41 +0200
Message-ID: <87pl1of7ve.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alvin Sun" <alvin.sun@linux.dev> writes:

> Convert `use` imports to vertical layout for better readability and
> maintainability.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


