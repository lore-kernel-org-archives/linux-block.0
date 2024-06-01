Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9313EFE5;
	Sat,  1 Jun 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717233374; cv=none; b=dRtb4yhqAYYWWADy2ugsugmjc9pDEk7u5bmUL/m5hZdGPaEOxZusTEXDm002n8FwMsI3p95JOg6RPOrh/ByhgHx4GgeAaJDwMcghUnxNZKCeomUhsLRaJnhU8vYSSnypCYAF4FskJF+oChc6JixW9hF7akivuLtButWEPM86OBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717233374; c=relaxed/simple;
	bh=valRT79Qyh8MqljC8cw+qpWMGMEcVYjXDrKWZFTYhuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlnRoqpMfw/qXibnivp/RWuF7uZnCGj8mgpb1aKMsKSz8j1xL018iaeSQJot/xeEXgTv7opCqLjM4g2gHTfhxh16Y6kD601fPPkvDhuqfZCX+K0O5UohAJk4UFFpzClLco4E1YSyAb6uk5clYaXfvOwxXde7HPG43M63zCoBVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ktJwwC6A; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ktJwwC6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717233364; x=1717492564;
	bh=XSHQKn8Qe0ezivdh2WpMnm74QPZf/l0QE6ECgprOFW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ktJwwC6ANSJRgcP1fd72xGNtggWoVSmB8/YgPHKZkn7rcyKt7832MGmWe8XykhbvA
	 iFlgGz7G/34HxSfdClYqv+BBqod10gGcKNJOIyrmP8XoJLD4qkJRZOpU6TUOsjub1b
	 i3IrD4SToqlRNMkzUm5Pvjq1xHA8XtZYFNRF3RTIfWLIltSovvV3t9EalYMUimuqvQ
	 dKgG33RRBXtE2W6T7iDryvHEDHKaN1j7uvE6Znuh8I8vJ1kYoID3Tmq6LkelYlc5pI
	 jGdV0JvInK5LwdVlx3LaezO0gvi8I9y+zl1iHB/U2Np1mKOekag3qjEPXoebSVZdA0
	 /YyUYOgmnC3BA==
Date: Sat, 01 Jun 2024 09:15:59 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v3 2/3] rust: block: add rnull, Rust null_blk implementation
Message-ID: <2021ea8f-a3df-46c6-8fdf-61b1df231773@proton.me>
In-Reply-To: <20240601081806.531954-3-nmi@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk> <20240601081806.531954-3-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 750ec28b436cee911f397833a294bd2d4dcc5890
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.06.24 10:18, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> This patch adds an initial version of the Rust null block driver.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/Kconfig  |  9 +++++
>  drivers/block/Makefile |  3 ++
>  drivers/block/rnull.rs | 78 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/block/rnull.rs

I left two comments below, but it already seems fine to me:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

>=20
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5b9d4aaebb81..ed209f4f2798 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -354,6 +354,15 @@ config VIRTIO_BLK
>  =09  This is the virtual block driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>=20
> +config BLK_DEV_RUST_NULL
> +=09tristate "Rust null block driver (Experimental)"
> +=09depends on RUST
> +=09help
> +=09  This is the Rust implementation of the null block driver. For now i=
t
> +=09  is only a minimal stub.
> +
> +=09  If unsure, say N.
> +
>  config BLK_DEV_RBD
>  =09tristate "Rados block device (RBD)"
>  =09depends on INET && BLOCK
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 101612cba303..1105a2d4fdcb 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -9,6 +9,9 @@
>  # needed for trace events
>  ccflags-y=09=09=09=09+=3D -I$(src)
>=20
> +obj-$(CONFIG_BLK_DEV_RUST_NULL) +=3D rnull_mod.o
> +rnull_mod-y :=3D rnull.o
> +
>  obj-$(CONFIG_MAC_FLOPPY)=09+=3D swim3.o
>  obj-$(CONFIG_BLK_DEV_SWIM)=09+=3D swim_mod.o
>  obj-$(CONFIG_BLK_DEV_FD)=09+=3D floppy.o
> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
> new file mode 100644
> index 000000000000..c69ea7e7436e
> --- /dev/null
> +++ b/drivers/block/rnull.rs
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! This is a Rust implementation of the C null block driver.
> +//!
> +//! Supported features:
> +//!
> +//! - blk-mq interface
> +//! - direct completion
> +//! - block size 4k
> +//!
> +//! The driver is not configurable.
> +
> +use kernel::{
> +    alloc::flags,
> +    block::mq::{
> +        self,
> +        gen_disk::{self, GenDisk},
> +        Operations, TagSet,
> +    },
> +    error::Result,
> +    new_mutex, pr_info,
> +    prelude::*,
> +    sync::{Arc, Mutex},
> +    types::ARef,
> +};
> +
> +module! {
> +    type: NullBlkModule,
> +    name: "rnull_mod",
> +    author: "Andreas Hindborg",
> +    license: "GPL v2",
> +}
> +
> +struct NullBlkModule {
> +    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice, gen_disk::Added>>>>,
> +}
> +
> +impl kernel::Module for NullBlkModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust null_blk loaded\n");
> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), flags::=
GFP_KERNEL)?;
> +
> +        let disk =3D {
> +            let block_size: u16 =3D 4096;
> +            if block_size % 512 !=3D 0 || !(512..=3D4096).contains(&bloc=
k_size) {
> +                return Err(kernel::error::code::EINVAL);
> +            }
> +
> +            let mut disk =3D gen_disk::GenDisk::try_new(tagset)?;
> +            disk.set_name(format_args!("rnullb{}", 0))?;
> +            disk.set_capacity_sectors(4096 << 11);
> +            disk.set_queue_logical_block_size(block_size.into());
> +            disk.set_queue_physical_block_size(block_size.into());
> +            disk.set_rotational(false);
> +            disk.add()
> +        }?;

Personally, I would prefer to put the `?` into the line above.

> +
> +        let disk =3D Box::pin_init(new_mutex!(disk, "nullb:disk"), flags=
::GFP_KERNEL)?;
> +
> +        Ok(Self { _disk: disk })
> +    }
> +}
> +
> +struct NullBlkDevice;
> +
> +#[vtable]
> +impl Operations for NullBlkDevice {
> +    #[inline(always)]
> +    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
> +        mq::Request::end_ok(rq)
> +            .map_err(|_e| kernel::error::code::EIO)
> +            .expect("Fatal error - expected to be able to end request");

I expected something more along the lines of: "expected to be able to
end request, since `NullBlkDevice` never takes refcounts on Requests and
as such the ARef must be unique, but `end_ok` only fails if that is not
the case". But maybe that would fit better in a comment, what do you
think?

> +
> +        Ok(())
> +    }
> +
> +    fn commit_rqs() {}
> +}
> --
> 2.45.1
>=20

