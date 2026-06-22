Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4903A382F;
	Mon, 22 Jun 2026 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121568; cv=none; b=loHp926iZotaQo+Y1Q9iVDeSBY7BYjQLFzCGKxg1oPZ7jQW0WM1nKg49JAYsc5uwZGTSPLCd8CNAzpoPNMQ/XxXjBzRXm8avnup8psJs7snbq8qeKOncORrRDZZodATXDUEjFqBiB6JDBKKOMjNqsRHz+idBZ3ZUsGqlha5F4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121568; c=relaxed/simple;
	bh=Q00CUE1AZx2Is/tR2ZY+tJyYPGGBbW4ZIr/9ZAf2s/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTf9I7/lAyAEyY96Ahd9hjdxjy7I9W+kowwaaa/BYWmdD9NQf3hP3awxU4akK7jex2viyRb1z19GSKosnu991DITw6W0RP9l+E7DRHo3oZyZFLleoco4MclX5+O+Tx6UXAxmk15nPTFTA9WJ7nIRr6gQkcYRXH1YLlJWidP/OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m27Mm4H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m27Mm4H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C2D1F00A3A;
	Mon, 22 Jun 2026 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121564;
	bh=Q00CUE1AZx2Is/tR2ZY+tJyYPGGBbW4ZIr/9ZAf2s/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m27Mm4H+bNsp/UDzGbjPabw8c3K52wf9UvHVc04VXLJqtFs2HQ68r8BWa7uMKa6Uz
	 S5Ie1fqQgf9OQCGrT50avcE/nsutuav9+kJz6dZkE2eH55R6B5ANRZ/RPCLhlLPhN1
	 jPj4Vr4Xlr9NTE7DvZBi8Stc8apcARyyfE+JEBIH5VIuohm1SPrugrQ9W6RqrwOJra
	 fc79nL/Q9WEkS4VUMWrmYkX/J8miWIsFI/oN5Yn1v2AzEfv6WGLC7/q8FGAX2/3EVy
	 vzWdtoGdFg+SriZ2BTaJODZoVQnfiNUTRT5zARyVT/H30Zio5IOpRiQUXpMwpcyKBM
	 3duxEp7ZNlfsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 6/6] rust: configfs: use `LocalModule` for `THIS_MODULE`
In-Reply-To: <20260622-fix-fops-owner-v3-6-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-6-49d45cb37032@linux.dev>
Date: Mon, 22 Jun 2026 11:38:11 +0200
Message-ID: <87pl1iewzg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
> macro with `this_module::<LocalModule>()`, and update
> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



