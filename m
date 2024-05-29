Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E21C2300
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006727; cv=none; b=cFBuRFlVKIQeKVdYdIBhztQyxpGwAOkcBafX/pMtoxWw8YgfBr6B8W6IAB1c/v3IpmYRLfBU6+I4kzGVPzizwG9sUoytU0X7YWY6eiUa3wbrqxNA664IdLlcgYsoiSUYF9m/uSuZmY/Hqc2VGYPB1uHh+ydA3SSjelmk69IlJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006727; c=relaxed/simple;
	bh=x1uIa9qFl9MgT/+Tx/DjJcUTbZlrr3u+Ap8fVtd1sLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieE8RZP2tVPRW37eTeBAO6d1xfr1ZtO5gIB71rhqJcRD1Kjqu4y1/SxbzaKYIgEizE0HKk+7djbXrpvp8pQRBQZTmI/xIRzuDatpuuFAnVmiTLk3togLyMQsfuyAA86d/B0h5TNPfG0U/vIRMLR9RoMWtmKFe12OXn4fepb79Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MCrudcvg; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MCrudcvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717006717; x=1717265917;
	bh=mN6rlRNn3MkvqaT7Si8e5huY2ekoNIjInihot9QvrPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MCrudcvgNlJeeflA2EBSvfCIOeskq0dvDX2YsuYAvQJ63WhS8gWkK5eAmjD2iqwfz
	 Cily2ftzbGdbeRVtbzJ8hTNaNoeo7adV/9RWPftXl6YOZJ307jTdE4yWu++5mX3ZxR
	 1dPpKdUv09gdMWd0HZ3j1RKll2NEMzugYj6KP5NPOGxp6jmSMhuVRGrP6R/UlV/lqK
	 1Fu3JzXCWLu3wx2Mi7K1S0hxm8ShNBtsyhH6Kz3bNgOH1+Fc6i/9r5E8vZMc6yrNXJ
	 QIXhYjIClctyfzb+dUGU2VU5VVvdtWPRx7pck8OODWa0DuTBhutdfAX4fAOaP2QNJc
	 QVP161Q5juXGA==
Date: Wed, 29 May 2024 18:18:30 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk implementation
Message-ID: <8ae158cd-d2ee-4698-8034-9fe1e31c7ca5@proton.me>
In-Reply-To: <87o78orcvz.fsf@metaspace.dk>
References: <20240521140323.2960069-1-nmi@metaspace.dk> <20240521140323.2960069-3-nmi@metaspace.dk> <d7b963f0-060f-44c0-8358-fb8dbd064575@proton.me> <87o78orcvz.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9bdbafa95f62c59fba69a44ced9d95829d0411dc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.05.24 15:00, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 21.05.24 16:03, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> This patch adds an initial version of the Rust null block driver.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>> ---
>>>  drivers/block/Kconfig   |  9 +++++
>>>  drivers/block/Makefile  |  3 ++
>>>  drivers/block/rnull.rs  | 86 +++++++++++++++++++++++++++++++++++++++++
>>>  rust/kernel/block/mq.rs |  4 +-
>>>  4 files changed, 101 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/block/rnull.rs
>>>
>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index 5b9d4aaebb81..ed209f4f2798 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -354,6 +354,15 @@ config VIRTIO_BLK
>>>  =09  This is the virtual block driver for virtio.  It can be used with
>>>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>>>
>>> +config BLK_DEV_RUST_NULL
>>> +=09tristate "Rust null block driver (Experimental)"
>>> +=09depends on RUST
>>> +=09help
>>> +=09  This is the Rust implementation of the null block driver. For now=
 it
>>> +=09  is only a minimal stub.
>>> +
>>> +=09  If unsure, say N.
>>> +
>>>  config BLK_DEV_RBD
>>>  =09tristate "Rados block device (RBD)"
>>>  =09depends on INET && BLOCK
>>> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
>>> index 101612cba303..1105a2d4fdcb 100644
>>> --- a/drivers/block/Makefile
>>> +++ b/drivers/block/Makefile
>>> @@ -9,6 +9,9 @@
>>>  # needed for trace events
>>>  ccflags-y=09=09=09=09+=3D -I$(src)
>>>
>>> +obj-$(CONFIG_BLK_DEV_RUST_NULL) +=3D rnull_mod.o
>>> +rnull_mod-y :=3D rnull.o
>>> +
>>>  obj-$(CONFIG_MAC_FLOPPY)=09+=3D swim3.o
>>>  obj-$(CONFIG_BLK_DEV_SWIM)=09+=3D swim_mod.o
>>>  obj-$(CONFIG_BLK_DEV_FD)=09+=3D floppy.o
>>> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
>>> new file mode 100644
>>> index 000000000000..1d6ab6f0f26f
>>> --- /dev/null
>>> +++ b/drivers/block/rnull.rs
>>> @@ -0,0 +1,86 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! This is a Rust implementation of the C null block driver.
>>> +//!
>>> +//! Supported features:
>>> +//!
>>> +//! - blk-mq interface
>>> +//! - direct completion
>>> +//! - block size 4k
>>> +//!
>>> +//! The driver is not configurable.
>>> +
>>> +use kernel::{
>>> +    alloc::flags,
>>> +    block::mq::{
>>> +        self,
>>> +        gen_disk::{self, GenDisk},
>>> +        Operations, TagSet,
>>> +    },
>>> +    error::Result,
>>> +    new_mutex, pr_info,
>>> +    prelude::*,
>>> +    sync::{Arc, Mutex},
>>> +    types::ARef,
>>> +};
>>> +
>>> +module! {
>>> +    type: NullBlkModule,
>>> +    name: "rnull_mod",
>>> +    author: "Andreas Hindborg",
>>> +    license: "GPL v2",
>>> +}
>>> +
>>> +struct NullBlkModule {
>>> +    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice, gen_disk::Added>>>>,
>>> +}
>>> +
>>> +fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<Null=
BlkDevice, gen_disk::Added>> {
>>
>> Any reason that this is its own function and not in the
>> `NullBlkModule::init` function?
>=20
> Would you embed it inside the `init` function? To what end? I don't
> think that would read well.

I just found it strange that you have this extracted into its own
function, since I just expected it to be present in the init function.
Does this look really that bad?:

    impl kernel::Module for NullBlkModule {
        fn init(_module: &'static ThisModule) -> Result<Self> {
            pr_info!("Rust null_blk loaded\n");
            let block_size: u16 =3D 4096;
            if block_size % 512 !=3D 0 ||
!(512..=3D4096).contains(&block_size) {
                return Err(kernel::error::code::EINVAL);
            }

            let disk =3D {
                let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1),
flags::GFP_KERNEL)?;
                let mut disk =3D gen_disk::try_new(tagset)?;
                disk.set_name(format_args!("rnullb{}", 0))?;
                disk.set_capacity_sectors(4096 << 11);
                disk.set_queue_logical_block_size(block_size.into());
                disk.set_queue_physical_block_size(block_size.into());
                disk.set_rotational(false);
                disk.add()
            };
            let disk =3D Box::pin_init(
                new_mutex!(disk, "nullb:disk"),
                flags::GFP_KERNEL,
            )?;

            Ok(Self { _disk: disk })
        }
    }

>>> +    let block_size: u16 =3D 4096;
>>> +    if block_size % 512 !=3D 0 || !(512..=3D4096).contains(&block_size=
) {
>>> +        return Err(kernel::error::code::EINVAL);
>>> +    }
>>> +
>>> +    let mut disk =3D gen_disk::try_new(tagset)?;
>>> +    disk.set_name(format_args!("rnullb{}", 0))?;
>>> +    disk.set_capacity_sectors(4096 << 11);
>>> +    disk.set_queue_logical_block_size(block_size.into());
>>> +    disk.set_queue_physical_block_size(block_size.into());
>>> +    disk.set_rotational(false);
>>> +    disk.add()
>>> +}
>>> +
>>> +impl kernel::Module for NullBlkModule {
>>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>>> +        pr_info!("Rust null_blk loaded\n");
>>> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), flags=
::GFP_KERNEL)?;
>>> +        let disk =3D Box::pin_init(
>>> +            new_mutex!(add_disk(tagset)?, "nullb:disk"),
>>> +            flags::GFP_KERNEL,
>>> +        )?;
>>> +
>>> +        Ok(Self { _disk: disk })
>>> +    }
>>> +}
>>> +
>>> +struct NullBlkDevice;
>>> +
>>> +#[vtable]
>>> +impl Operations for NullBlkDevice {
>>> +    #[inline(always)]
>>> +    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result=
 {
>>> +        mq::Request::end_ok(rq)
>>> +            .map_err(|_e| kernel::error::code::EIO)
>>> +            .expect("Failed to complete request");
>>
>> This error would only happen if `rq` is not the only ARef to that
>> request, right?
>=20
> Yes, it should never happen. If it happens, something is seriously
> broken and panic is adequate.
>=20
> Other drivers might want to retry later or something, but in this case
> it should just work.

In that case, I think the error message should reflect that and not just
be a generic "failed to complete request" error.

>>> +
>>> +        Ok(())
>>> +    }
>>> +
>>> +    fn commit_rqs() {}
>>> +
>>> +    fn complete(rq: ARef<mq::Request<Self>>) {
>>
>> Am I correct in thinking that this function is never actually called,
>> since all requests that are queued are immediately ended?
>=20
> Yes, re my other email. It is a callback that cannot be triggered for
> now. I will move it to a later patch where it belongs.
>=20
>>
>>> +        mq::Request::end_ok(rq)
>>> +            .map_err(|_e| kernel::error::code::EIO)
>>> +            .expect("Failed to complete request")
>>> +    }
>>> +}
>>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>>> index efbd2588791b..54e032bbdffd 100644
>>> --- a/rust/kernel/block/mq.rs
>>> +++ b/rust/kernel/block/mq.rs
>>> @@ -51,6 +51,7 @@
>>>  //!
>>>  //! ```rust
>>>  //! use kernel::{
>>> +//!     alloc::flags,
>>>  //!     block::mq::*,
>>>  //!     new_mutex,
>>>  //!     prelude::*,
>>> @@ -77,7 +78,8 @@
>>>  //!     }
>>>  //! }
>>>  //!
>>> -//! let tagset: Arc<TagSet<MyBlkDevice>> =3D Arc::pin_init(TagSet::try=
_new(1, 256, 1))?;
>>> +//! let tagset: Arc<TagSet<MyBlkDevice>> =3D
>>> +//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>>
>> This change should probably be in the patch before (seems like an
>> artifact from rebasing).
>=20
> Yes, thank you for spotting that. I thought I checked that this was
> building, so this is strange to me. Maybe I failed to build the
> doctests between the two patches. It is weird that kernel robot did not
> pick this up. Maybe it is not building doctests?

Hmm, that is strange...

---
Cheers,
Benno

