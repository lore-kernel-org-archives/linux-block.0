Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF10231835;
	Thu, 18 Jun 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785100; cv=none; b=bUoM7lDSAQMgtNefn+qd0FI4m+cYJBx2MeDVaCfbqSISJ0vOyuPPl9KVVdvhg8bjaLlbECSWgsAo5JJYsCep+yMGAoqJqnBHXpzcCUl+MkD70KikV8arYDY2Y1p0wibT7Woe+8a/xBgFYEnJUZH0p8tb/nFesUql8yBgRWZN8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785100; c=relaxed/simple;
	bh=E5eHkD8jSDxo44aAWmdU2ah76kkPQfs4cllD4dt0GAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFbMb8ip4tvErIMMbIafVZWuCoj2xpI4ABs8EnrP8DKXzEfyUEcjqASZrQGkm8xglDRMwVo8J7s2JSGWLOtY9lIV7VFS3QjF0hBKfcdpSE5hb4ONq/ipuh/mkjqtxNDzh/nugZQ2KKfa773jItmmulsCuSxLt2I95AMpEVsL510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdW0olbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdW0olbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12091F00A3A;
	Thu, 18 Jun 2026 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781785099;
	bh=E5eHkD8jSDxo44aAWmdU2ah76kkPQfs4cllD4dt0GAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SdW0olbJ7B4eSr2uWbvKHs7RpsKSbu3Co1Pe45Ejhqm/z8SdwFNmec3Fq03vyl13G
	 nyLreBbeFE4MX37eN0K3CCnNjsbFQVuiDuQMArbzVuMsb6oszIMiJZHImXnzobVfpD
	 BMslA14Yb1qZIK15QB9kkVEI5reyFb8qNahz/iCHf0mIzCiNZPEBbi/nkAbCk86Dqi
	 /vSNE3+ESnmLOZtBxfGKabjS7Ar2QEkchgfSgAVmYu+0TnZza54dJww3jHyIf6dLzH
	 AUN6BNih0561i26OWaHKcjIze3M2X2dfYYCsKR2vpOhnS4h0ke3/WGgKJTuOfgYAKK
	 bI5gRCML7SJJw==
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
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Alvin Sun
 <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 2/7] rust: macros: auto-insert ThisModule in #[vtable]
In-Reply-To: <20260521-fix-fops-owner-v2-2-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-2-fd99079c5a04@linux.dev>
Date: Thu, 18 Jun 2026 14:11:31 +0200
Message-ID: <87ik7gf3po.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Auto-add `type ThisModule: ::kernel::ModuleMetadata;` as a required
> associated type on the trait side if not already defined, and
> auto-insert `type ThisModule = crate::LocalModule;` on the impl side
> if not explicitly provided, eliminating the need to manually declare
> and implement `ThisModule` in every vtable trait and impl.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



