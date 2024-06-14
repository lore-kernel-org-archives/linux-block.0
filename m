Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2A19AD91;
	Fri, 14 Jun 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368981; cv=none; b=aTNfdsBVNucGu35kBrcMH+1a6XomFS9DLOAaXFgf5ToZkAnQHoe8gMiZNv+DYtGpQ6HGHZxxfcEzkGq3QqyhRbh58k3hfK07DPn0VKuo3fOPcawe1KIEfi4icDsNit5PFTXBl+qfg1te05XrWUXF7s9Le+zps2RvBFofBvquWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368981; c=relaxed/simple;
	bh=R35MwdhkDzAwQQIkOBIkyiAwfm1duRkanzr02CqKYFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRF2VrbVnfza8ukAQpbzlWeRShTO4uEG+tlFgnsyMevaTNkRyiEsHkEwfjPCyu7uTWFY01fPycM7XEhsdEpz3kbyron79KQrPMdnqLpkZbio0xhKMo5Mb55JpyT5Ino9RNctRscH29rpIvFmL+XLHFmx12RU2ryWuVno8OLeNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fo0v88/d; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fo0v88/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718368971; x=1718628171;
	bh=/P4Ipyi5V6XC49ifR6u6XzXB7A6kcDydd2cvy9jsBTs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fo0v88/dWr1ArYRzF6gRPHiUh6wNMMwjTG545+fQA16wqy3rMw0m3Ji9M1PSyZjdN
	 DY3/CrNeJggZTkIva5imy27cnX4KCUK7nKumSxnF+LpRkjICj4WIuLPvdnFj56wWfv
	 yjFw++7rnh2CJN/xYBZkjMoCe+o9HW9Twuhc2rRx/XO4mJ5AMhM70qe0AUzC42KHDT
	 AX+UsBmsEtzoV9+7uv0/gu3ixqrxNThB8YlyZmSCAOTBeEqMhZOhFDFJg7sPxwcETI
	 SqcnT8LJMRaZXtQzW1uVJoGDcjQFRJKt3ZVxB75MiyZerO4A2IONn3GZtDFmoXYjuv
	 1wTo+R5/J1AfA==
Date: Fri, 14 Jun 2024 12:42:45 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v6 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <e9a36116-6cb9-479a-a883-dd36f78a8577@proton.me>
In-Reply-To: <20240611114551.228679-2-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk> <20240611114551.228679-2-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9d41ef20cbfc7aaec43b1f1474cb4170cff5c190
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.06.24 13:45, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add initial abstractions for working with blk-mq.
>=20
> This patch is a maintained, refactored subset of code originally publishe=
d
> by Wedson Almeida Filho <wedsonaf@gmail.com> [1].
>=20
> [1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268b=
bd4382a891/rust/kernel/blk/mq.rs
>=20
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/bindings/bindings_helper.h    |   3 +
>  rust/helpers.c                     |  16 ++
>  rust/kernel/block.rs               |   5 +
>  rust/kernel/block/mq.rs            |  98 +++++++++++
>  rust/kernel/block/mq/gen_disk.rs   | 215 ++++++++++++++++++++++++
>  rust/kernel/block/mq/operations.rs | 245 ++++++++++++++++++++++++++++
>  rust/kernel/block/mq/raw_writer.rs |  55 +++++++
>  rust/kernel/block/mq/request.rs    | 253 +++++++++++++++++++++++++++++
>  rust/kernel/block/mq/tag_set.rs    |  86 ++++++++++
>  rust/kernel/error.rs               |   6 +
>  rust/kernel/lib.rs                 |   2 +
>  11 files changed, 984 insertions(+)
>  create mode 100644 rust/kernel/block.rs
>  create mode 100644 rust/kernel/block/mq.rs
>  create mode 100644 rust/kernel/block/mq/gen_disk.rs
>  create mode 100644 rust/kernel/block/mq/operations.rs
>  create mode 100644 rust/kernel/block/mq/raw_writer.rs
>  create mode 100644 rust/kernel/block/mq/request.rs
>  create mode 100644 rust/kernel/block/mq/tag_set.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

