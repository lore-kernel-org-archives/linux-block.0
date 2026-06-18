Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF633B585D;
	Thu, 18 Jun 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778776; cv=none; b=E48SLtgaFcIb6tWkXEV1a7gdnVsbC/+PTOhiTbAvNq0motcEUM+QvWQtAB0rS7JCyVgG3chau57RCjE5j0xSdYwFlqCOnRN6HaOh75k7YjIgjMQSDgt6K4VsRgKcC7EnE3giSpwn8y5e55+NxPPfaC+XMX3ecIs5F9WykuT3sEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778776; c=relaxed/simple;
	bh=sBK2EBVdEfIaXP4f3ODcBmMzm4ub1HbR0JZAfwOnkb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGllxYcHMYnn9vx4NqOI7gMQUau34Eyq3dNzNuT/KtKPSEzKlz6erkzP9xdTWfEuLHjjE9EN86dOgi6hR3eyjDd5tpHu3OD4dAJ9HVdxFiDmiDEaiYiadHkmSN/ZAbIfNlK7eGLPSA29seOufa9Ptg2bFg1eKNGw4aSL9vGKYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhPA/y4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhPA/y4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9C11F00A3D;
	Thu, 18 Jun 2026 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781778775;
	bh=sBK2EBVdEfIaXP4f3ODcBmMzm4ub1HbR0JZAfwOnkb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GhPA/y4BhrpOqea45L3TQAYwf+u0iQH0NW2Nvo/JKdvaC0yei6/bBBD85l8FTPEFB
	 RwTanXyUSbnIV1cnTCjdnPFwXI2zd1MK0nW2XwXHZgHH+2JzfSwQHOplsoxXmkCqYY
	 zOlrHamcLDbgySu5af+qwxNIxXJVL8y1ytdwKDwoKEGRCeFEb9YyHk7AK34Xlvq5mX
	 ugRdb6NGSN5iJfyA0mc/U/3zdHhokKlqZgxSmVOIy7sqLRcMS/Yyuf+hO1JSD2ed6g
	 VIr4NRjC0Nw0kUl8e74nPmkt+kkCxkNEagPFCjy2Fr9DRrAaeLMIAJwnDwNGpkd63X
	 Iqs3EAzytRHvA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alvin Sun <alvin.sun@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org, Alvin
 Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 4/5] rust: block: mq: use vertical import style
In-Reply-To: <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
 <_FgQUCxXpugLyjMMqjxl9574cGo5dirs0Z56uf8wKnoy8aMjc5Df-xtNCJtnb8DLYca2o0VVi2WUOWL-gsc3Yg==@protonmail.internalid>
 <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev>
Date: Thu, 18 Jun 2026 12:29:52 +0200
Message-ID: <87v7bgf8f3.fsf@t14s.mail-host-address-is-not-set>
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

Cc: Jens Axboe <axboe@kernel.dk>

Best regards,
Andreas Hindborg



