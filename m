Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA543126CD;
	Tue, 27 Jan 2026 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518313; cv=none; b=AuaBIU4zyJsmQwLoYkI2cyg4mA+/I4mBc0alhivgeouUpNyvLt69ABOnANjiMIM8FJJuXy9eqdO9aTk51EmtdWrT2+FZm/SaOiDPkneXyCFEPHWOmrjOqwnk/J8imP704TJpR36SfJV/S7HWkxgFugsVCy/4cB0k+JpfN02Kccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518313; c=relaxed/simple;
	bh=eWZS192zY+JH1/Okn1aj/3i4QxS7IWjP9HgKsTFPcSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlSuIpEm+QAS9hN0kU+4Zr6XmgbVMq6B5Y1C68XE2X3reCl4vQ0xAIAZ0ls6uoUpc/02YnykIntmax6vJxHhdyw4tiI7mJ3FqcRFfTkI59RXsApOFbGta59eMp8OW8i3qBwEudketYDIUXRmJxmqaOFL8UhJki3D2onmOjPt4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn9e3aIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn9e3aIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A25C116D0;
	Tue, 27 Jan 2026 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769518313;
	bh=eWZS192zY+JH1/Okn1aj/3i4QxS7IWjP9HgKsTFPcSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gn9e3aIwUX4/KEw7G2O9Yh+AXDZghN2GIqNEStUq1jPcVl2ksSYizF2TdllVyw4lw
	 2zqSeQ6vnpk71f24UVk/oX6wYuvVwL2XJkOqLUoJFbcy9VvvCubB1n7CFiOdCjej3j
	 ePiLqUg4QTs2YPxU/2KPdxy2Nksu19Oyk38BuCMVUdsWHKf1yLVpdIHjPQ7OhjdIWB
	 kPBBHXH0lorfRAzddR2ylH1cqgMB49gikT2JvQ21Jils86k3g9WatA9Hc29jZ2dBf+
	 JfNgddf7J4xWdQcAk7iLDofVU8GbxFflTuxoVzumsVX5UoOO90yMa416jylArN0HeJ
	 no7ICbkFst5pg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/3] block: rnull: remove imports available via prelude
In-Reply-To: <CANiq72nLrYzc0Pt0COX+gpQUgwgF+nO4jYiawdW8MATm_b666g@mail.gmail.com>
References: <20260123172007.136873-1-gary@garyguo.net>
 <795qzMaJiv4J6R3ywJGnvJsSEz1Oo9XKAOGd3DhpySquL_JrdxisQmp0NP1EPBFuvBshX5Tcb-ld4_Pu2nfPFQ==@protonmail.internalid>
 <20260123172007.136873-3-gary@garyguo.net>
 <87wm14rzz9.fsf@t14s.mail-host-address-is-not-set>
 <vyPFmsB12vVX0S344h-FQG2vFsaYSbnXiZCjNhADHtmfDVCf2nh8c1IBOvtwg6wwwxbToCy75fc4BNzgipTsfA==@protonmail.internalid>
 <CANiq72nLrYzc0Pt0COX+gpQUgwgF+nO4jYiawdW8MATm_b666g@mail.gmail.com>
Date: Tue, 27 Jan 2026 13:51:43 +0100
Message-ID: <87tsw7rzfk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Jan 26, 2026 at 7:27=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Is this for Jens or do you want me to pick it up?

I think Jens is supposed to pick the block patches.


Best regards,
Andreas Hindborg


