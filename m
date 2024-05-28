Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA016F0DD;
	Tue, 28 May 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902883; cv=none; b=FFarb3x2NAv0Zesjj0bjZdamO5VXGdxzxi0lM42UeI4X4GhV3/8vjGcZxSzasuXg1qH1DPaFo58DtvwAB0YePOj954gvXZsC5ECTP2ykWwNhlZC3UKIgO4jGl8HdIGNpiWvoCakM41aKRcjHqZN2TsocR27MGX+ygNG3orBdKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902883; c=relaxed/simple;
	bh=uqJvrqqgKH4Ec/381jSSZ52PTmJenP9/HfohYBBu8t8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeEOk2e5+x9KagiZn0VYCyh7ap4CZTSS8R0ruPycKMdbEmBZLz0x+Z2IAh2S0tM7RmIEmv4cxm2GpJwVKrCR9+MdC6CarjNh7Lt9A7URgvlWYPXMhZkdz/gYFJzmYAhS1oK5f7iag8t1tgsKkoCL1hhOBQ9+NPjXPTaijQUOybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iz7cX5nU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iz7cX5nU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716902877; x=1717162077;
	bh=qqtgzJlmFD04DRomp01Lp8PnnmfNEYuAnmxTd28A+mA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iz7cX5nUCsaHQ52ilcQPLn8UCQS6kbxIvJYCj1eOLRr1srtopY4o2ivbhPDQlUzHK
	 6BHbaaKvpcNWNCqh3e5tW+82RM5JcCp5KvNR4KDm4FubnmbcnFjd0SUN2RaZ7nOYEF
	 QUhuU1pdOxv1xYcM3ISSI4XRFIDyUbndnv83j3AIh5PKZGoB72roa39rIZWMqppKFn
	 gCBMJmFKi4xHXnD1VdGaQbnaJgQ45lqsAV+HDX9FkoZmyslo/h04c/Yv7QumbgATss
	 JNic77RjO0rpHPEGuGRN0V/1iKLivB8I/lQS23qUMmRQ2+opsfoeWRT9Tx0VMhaNhm
	 RKMwSzl2RNm9Q==
Date: Tue, 28 May 2024 13:27:53 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk implementation
Message-ID: <d7b963f0-060f-44c0-8358-fb8dbd064575@proton.me>
In-Reply-To: <20240521140323.2960069-3-nmi@metaspace.dk>
References: <20240521140323.2960069-1-nmi@metaspace.dk> <20240521140323.2960069-3-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dba9a313b25dad8f775da433a567bc08de8caa87
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.05.24 16:03, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> This patch adds an initial version of the Rust null block driver.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/Kconfig   |  9 +++++
>  drivers/block/Makefile  |  3 ++
>  drivers/block/rnull.rs  | 86 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/block/mq.rs |  4 +-
>  4 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/block/rnull.rs
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
> index 000000000000..1d6ab6f0f26f
> --- /dev/null
> +++ b/drivers/block/rnull.rs
> @@ -0,0 +1,86 @@
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
> +fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBl=
kDevice, gen_disk::Added>> {

Any reason that this is its own function and not in the
`NullBlkModule::init` function?

> +    let block_size: u16 =3D 4096;
> +    if block_size % 512 !=3D 0 || !(512..=3D4096).contains(&block_size) =
{
> +        return Err(kernel::error::code::EINVAL);
> +    }
> +
> +    let mut disk =3D gen_disk::try_new(tagset)?;
> +    disk.set_name(format_args!("rnullb{}", 0))?;
> +    disk.set_capacity_sectors(4096 << 11);
> +    disk.set_queue_logical_block_size(block_size.into());
> +    disk.set_queue_physical_block_size(block_size.into());
> +    disk.set_rotational(false);
> +    disk.add()
> +}
> +
> +impl kernel::Module for NullBlkModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust null_blk loaded\n");
> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), flags::=
GFP_KERNEL)?;
> +        let disk =3D Box::pin_init(
> +            new_mutex!(add_disk(tagset)?, "nullb:disk"),
> +            flags::GFP_KERNEL,
> +        )?;
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
> +            .expect("Failed to complete request");

This error would only happen if `rq` is not the only ARef to that
request, right?

> +
> +        Ok(())
> +    }
> +
> +    fn commit_rqs() {}
> +
> +    fn complete(rq: ARef<mq::Request<Self>>) {

Am I correct in thinking that this function is never actually called,
since all requests that are queued are immediately ended?

> +        mq::Request::end_ok(rq)
> +            .map_err(|_e| kernel::error::code::EIO)
> +            .expect("Failed to complete request")
> +    }
> +}
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index efbd2588791b..54e032bbdffd 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -51,6 +51,7 @@
>  //!
>  //! ```rust
>  //! use kernel::{
> +//!     alloc::flags,
>  //!     block::mq::*,
>  //!     new_mutex,
>  //!     prelude::*,
> @@ -77,7 +78,8 @@
>  //!     }
>  //! }
>  //!
> -//! let tagset: Arc<TagSet<MyBlkDevice>> =3D Arc::pin_init(TagSet::try_n=
ew(1, 256, 1))?;
> +//! let tagset: Arc<TagSet<MyBlkDevice>> =3D
> +//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;

This change should probably be in the patch before (seems like an
artifact from rebasing).

---
Cheers,
Benno

>  //! let mut disk =3D gen_disk::try_new(tagset)?;
>  //! disk.set_name(format_args!("myblk"))?;
>  //! disk.set_capacity_sectors(4096);
> --
> 2.44.0
>=20
>=20

