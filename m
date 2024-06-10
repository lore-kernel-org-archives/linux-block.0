Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D941BF2A;
	Mon, 10 Jun 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050053; cv=none; b=EeJODszRJDI+mfia87QL3dZlNPIfLmVWA0Tige44rSphLKt/tqhWx6wr5IJlAZNKQwJPaanCIVepPle1pJ1cmNLm78cRhaRwSqUkIvi01y0doL/5y2fvVNz0KgstLg3vwrtouBJg9j+xCC24ZjbC/oKiePOpSM/JYyQi74SzhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050053; c=relaxed/simple;
	bh=gsBPbPnYKAP9lMCqyZCeXmja+Pyc5B6zW7EZJXPlBQA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+I7CCU4eEfscR6VEaJPO3T/eVZbLLGrzbKMCZJw/aHSij+nKZ6lrFBPspsHKf5oNYtZCsYdIUnFxGpwDmuTJpYgVakJwlW5SMRJidPesDp/TCZE8RNuw68XxzvU1WHRjL8uZWRlYT5OlhccIMNFfA04ruIIq5uvzsyP1BtBDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QFQj0aQ9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QFQj0aQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718050042; x=1718309242;
	bh=YaudkvTAFLJ++bghqSZYe4gWhD1sK1cupANwv9nOdZM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QFQj0aQ9UrLzFPF+gUn/CRwt+AHtSb9LsJY4rF4T2VFnEqLHBmNtCZBr4e6aT2bkV
	 0Rlas9rDr3JslF05T+X3blo3fG7H3RznctbNms5RALorGyqc5KYbdigVI+3ob01Mkw
	 tj/fp4+NItpsf3IWKVU0Bcs1symzYPWXe7ko/49glT/fvmBg22SyQbEqhCUQyRU/xs
	 Fo5kLuVlUuy0hfU00FRUBZkcJx9HArKjNZURqsK8pUqqXI3tQjQdC2aTJtD+uBKq0K
	 ZUdA9B+9VJZG7wHxWZCQSNoZzmLeROleKM6lwudahQ4KvMSav+1M6I2ON4tnkwji7T
	 BN99wZZ0a0kJw==
Date: Mon, 10 Jun 2024 20:07:15 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v5 2/3] rust: block: add rnull, Rust null_blk implementation
Message-ID: <f05832b5-de63-46a0-b623-ae9ef18c2648@proton.me>
In-Reply-To: <20240603191455.968301-3-nmi@metaspace.dk>
References: <20240603191455.968301-1-nmi@metaspace.dk> <20240603191455.968301-3-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e8280eca314cd33587780377548bd7cae8afc414
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.06.24 21:14, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> This patch adds an initial version of the Rust null block driver.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/Kconfig  |  9 ++++++
>  drivers/block/Makefile |  3 ++
>  drivers/block/rnull.rs | 73 ++++++++++++++++++++++++++++++++++++++++++

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

