Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBD1FF1B5;
	Wed,  6 Aug 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508993; cv=pass; b=KLtpFbf7ml32eE4JDPRYNMACuGMYFnJ2FYQ+RQVHX+LtmZL6+xG0mDcQEF0oFDpoUdE/I0UBY7ARRSEJkrHMnbvHSTGL8xXerT/4uK9qg6wFGYbIcbCRcd1+WO9J0ai59RNtT9OYdeuCfLBJjs21WwYm3hlKYHikEP2wBjyKoow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508993; c=relaxed/simple;
	bh=1cOkmZJkB0uHYNjR5I9uMLGbyaJg6tg2a+VXSC/TTUs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nVcvqFnII3a8tFQmoRDoom/F8FuRQyI4X3djcNUK2ChjCvR+Txun/Nay9xzCeSrWQlmrtKD/1Yk5OJMUw5AROE/cXyIkcR511yp/vReitZ1uTjVTqb1Rg9Xng6RQUKzmHiMQSSpHOok84T6mKsRi14Xkh9eGPmVEtSgqVlzP3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jCM04/sE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jCM04/sE"
ARC-Seal: i=1; a=rsa-sha256; t=1754508973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dlIc3qcQhKiUlm5a0yCRbhrlYuFAWymDypWbT6Ip2LtuuDirvVAcng9VbcSPPy+hFKjH74tFmnO9V3VcQdOnOThKpRahN89+ozGzQgX9sIB8cfMLxgIsbBrwBqCaWRn+JOcrHW2J58k6lbq19ju1KXePqw8q4Rwa97aDS/o6cEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754508973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o5Z5QH9Q2M8oNoEfEvJfM14eQoMIrZAJ2fEy/12QmyQ=; 
	b=L4awVM2YyHr4pBkJlPT4lkoPFcPDwxD6EGyGBbZpjEZuXgUlj8NojDwhAstuMrMRmRZGzVzr6pOt1ze+AM4EnCHUn3rTTnSpKmyrQHW8uD32uHZ54+WUqQlrexgjIHLFdeJKbJh4oHSWZ5ZvNS2Vk54W7i+Evoc8dy9Vb/VfHyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754508973;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=o5Z5QH9Q2M8oNoEfEvJfM14eQoMIrZAJ2fEy/12QmyQ=;
	b=jCM04/sE5U0Zy58VpT+3TlFr7Yr7irmohiL6M2N7vcSeUdR/m3S+C9AMhgRxo1Uj
	vdhW9btgq6wsmEmfU9bcfFBRz/CkGzcGdpFtkYP+EEVcViQ+Yge2FrDmrpMi5usMdSG
	3ZWpY36Vfrdn1tZCoSwlYCfV/RN7kpyZcgXWgROM=
Received: by mx.zohomail.com with SMTPS id 1754508970819867.341545264823;
	Wed, 6 Aug 2025 12:36:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 12/16] rnull: enable configuration via `configfs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 16:35:55 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <03D084B5-5844-4BC5-902C-14E53AC13DC9@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> drivers/block/rnull/Kconfig      |   2 +-
> drivers/block/rnull/configfs.rs  | 220 =
+++++++++++++++++++++++++++++++++++++++
> drivers/block/rnull/rnull.rs     |  58 ++++++-----
> rust/kernel/block/mq/gen_disk.rs |   2 +-
> 4 files changed, 253 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
> index 6dc5aff96bf4..7bc5b376c128 100644
> --- a/drivers/block/rnull/Kconfig
> +++ b/drivers/block/rnull/Kconfig
> @@ -4,7 +4,7 @@
>=20
> config BLK_DEV_RUST_NULL
> tristate "Rust null block driver (Experimental)"
> - depends on RUST
> + depends on RUST && CONFIGFS_FS

Should this really be a dependency? IIUC, the driver still works with =
this
unset, it just doesn=E2=80=99t have this feature?

> help
>  This is the Rust implementation of the null block driver. Like
>  the C version, the driver allows the user to create virutal block
> diff --git a/drivers/block/rnull/configfs.rs =
b/drivers/block/rnull/configfs.rs
> new file mode 100644
> index 000000000000..6c0e3bbb36ec
> --- /dev/null
> +++ b/drivers/block/rnull/configfs.rs
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::{NullBlkDevice, THIS_MODULE};
> +use core::fmt::Write;
> +use kernel::{
> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> +    c_str,
> +    configfs::{self, AttributeOperations},
> +    configfs_attrs, new_mutex,
> +    page::PAGE_SIZE,
> +    prelude::*,
> +    str::CString,
> +    sync::Mutex,
> +};
> +use pin_init::PinInit;
> +
> +pub(crate) fn subsystem() -> impl =
PinInit<kernel::configfs::Subsystem<Config>, Error> {
> +    let item_type =3D configfs_attrs! {
> +        container: configfs::Subsystem<Config>,
> +        data: Config,
> +        child: DeviceConfig,
> +        attributes: [
> +            features: 0,
> +        ],
> +    };
> +
> +    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, =
try_pin_init!(Config {}))
> +}
> +
> +#[pin_data]
> +pub(crate) struct Config {}

This still builds:

diff --git a/drivers/block/rnull/configfs.rs =
b/drivers/block/rnull/configfs.rs
index 3ae84dfc8d62..2e5ffa82e679 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -24,10 +24,9 @@ pub(crate) fn subsystem() -> impl =
PinInit<kernel::configfs::Subsystem<Config>, E
         ],
     };
=20
-    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, =
try_pin_init!(Config {}))
+    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, Config =
{})
 }
=20
-#[pin_data]
 pub(crate) struct Config {}

Perhaps due to:

// SAFETY: the `__pinned_init` function always returns `Ok(())` and =
initializes every field of
// `slot`. Additionally, all pinning invariants of `T` are upheld.
unsafe impl<T> PinInit<T> for T {
    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), =
Infallible> {
        // SAFETY: `slot` is valid for writes by the safety requirements =
of this function.
        unsafe { slot.write(self) };
        Ok(())
    }
}


> +
> +#[vtable]
> +impl AttributeOperations<0> for Config {
> +    type Data =3D Config;
> +
> +    fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +        writer.write_str("blocksize,size,rotational\n")?;
> +        Ok(writer.bytes_written())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Config {
> +    type Child =3D DeviceConfig;
> +
> +    fn make_group(
> +        &self,
> +        name: &CStr,
> +    ) -> Result<impl PinInit<configfs::Group<DeviceConfig>, Error>> {
> +        let item_type =3D configfs_attrs! {
> +            container: configfs::Group<DeviceConfig>,
> +            data: DeviceConfig,
> +            attributes: [
> +                // Named for compatibility with C null_blk
> +                power: 0,
> +                blocksize: 1,
> +                rotational: 2,
> +                size: 3,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(
> +            name.try_into()?,
> +            item_type,
> +            // TODO: cannot coerce new_mutex!() to impl PinInit<_, =
Error>, so put mutex inside

Isn=E2=80=99t this related to [0] ?


> +            try_pin_init!( DeviceConfig {
> +                data <- new_mutex!( DeviceConfigInner {
> +                    powered: false,
> +                    block_size: 4096,
> +                    rotational: false,
> +                    disk: None,
> +                    capacity_mib: 4096,
> +                    name: name.try_into()?,
> +                }),
> +            }),
> +        ))
> +    }
> +}
> +
> +#[pin_data]
> +pub(crate) struct DeviceConfig {
> +    #[pin]
> +    data: Mutex<DeviceConfigInner>,
> +}
> +
> +#[pin_data]
> +struct DeviceConfigInner {
> +    powered: bool,
> +    name: CString,
> +    block_size: u32,
> +    rotational: bool,
> +    capacity_mib: u64,
> +    disk: Option<GenDisk<NullBlkDevice>>,
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for DeviceConfig {
> +    type Data =3D DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +
> +        if this.data.lock().powered {
> +            writer.write_fmt(fmt!("1\n"))?;
> +        } else {
> +            writer.write_fmt(fmt!("0\n"))?;
> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        let power_op: bool =3D core::str::from_utf8(page)?
> +            .trim()
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?

nit: I=E2=80=99d import that if I were you, but it=E2=80=99s your call.

> +            !=3D 0;
> +
> +        let mut guard =3D this.data.lock();=20
> +
> +        if !guard.powered && power_op {
> +            guard.disk =3D Some(NullBlkDevice::new(
> +                &guard.name,
> +                guard.block_size,
> +                guard.rotational,
> +                guard.capacity_mib,
> +            )?);
> +            guard.powered =3D true;
> +        } else if guard.powered && !power_op {
> +            drop(guard.disk.take());
> +            guard.powered =3D false;
> +        }

nit: the guard is not used here, but it is still alive. This is harmless =
in
this case, but as I general pattern, I find that using closures cuts =
back on
the scope, i.e.:

this.with_locked_data(|data| {
    // use the guard
});

// Guard is already free here, no surprises.=20
=20
> +
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<1> for DeviceConfig {
> +    type Data =3D DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        let text =3D core::str::from_utf8(page)?.trim();
> +        let value =3D text
> +            .parse::<u32>()
> +            .map_err(|_| kernel::error::code::EINVAL)?;
> +
> +        GenDiskBuilder::validate_block_size(value)?;
> +        this.data.lock().block_size =3D value;
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<2> for DeviceConfig {
> +    type Data =3D DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +
> +        if this.data.lock().rotational {
> +            writer.write_fmt(fmt!("1\n"))?;
> +        } else {
> +            writer.write_fmt(fmt!("0\n"))?;
> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        this.data.lock().rotational =3D core::str::from_utf8(page)?
> +            .trim()
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?
> +            !=3D 0;
> +
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<3> for DeviceConfig {
> +    type Data =3D DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", =
this.data.lock().capacity_mib))?;
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        let text =3D core::str::from_utf8(page)?.trim();
> +        let value =3D text
> +            .parse::<u64>()
> +            .map_err(|_| kernel::error::code::EINVAL)?;
> +
> +        this.data.lock().capacity_mib =3D value;
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/block/rnull/rnull.rs =
b/drivers/block/rnull/rnull.rs
> index d07e76ae2c13..d09bc77861e4 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -1,28 +1,26 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> //! This is a Rust implementation of the C null block driver.
> -//!
> -//! Supported features:
> -//!
> -//! - blk-mq interface
> -//! - direct completion
> -//! - block size 4k

Why are these three removed?

> -//!
> -//! The driver is not configurable.
> +
> +mod configfs;
>=20
> use kernel::{
>     alloc::flags,
> -    block::mq::{
> +    block::{
>         self,
> -        gen_disk::{self, GenDisk},
> -        Operations, TagSet,
> +        mq::{
> +            self,
> +            gen_disk::{self, GenDisk},
> +            Operations, TagSet,
> +        },
>     },
>     error::Result,
> -    new_mutex, pr_info,
> +    pr_info,
>     prelude::*,
> -    sync::{Arc, Mutex},
> +    sync::Arc,
>     types::ARef,
> };
> +use pin_init::PinInit;
>=20
> module! {
>     type: NullBlkModule,
> @@ -35,33 +33,39 @@
> #[pin_data]
> struct NullBlkModule {
>     #[pin]
> -    _disk: Mutex<GenDisk<NullBlkDevice>>,
> +    configfs_subsystem: =
kernel::configfs::Subsystem<configfs::Config>,
> }
>=20
> impl kernel::InPlaceModule for NullBlkModule {
>     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> =
{
>         pr_info!("Rust null_blk loaded\n");
>=20
> -        // Use a immediately-called closure as a stable `try` block
> -        let disk =3D /* try */ (|| {
> -            let tagset =3D Arc::pin_init(TagSet::new(1, 256, 1), =
flags::GFP_KERNEL)?;
> -
> -            gen_disk::GenDiskBuilder::new()
> -                .capacity_sectors(4096 << 11)
> -                .logical_block_size(4096)?
> -                .physical_block_size(4096)?
> -                .rotational(false)
> -                .build(format_args!("rnullb{}", 0), tagset)
> -        })();
> -
>         try_pin_init!(Self {
> -            _disk <- new_mutex!(disk?, "nullb:disk"),
> +            configfs_subsystem <- configfs::subsystem(),
>         })
>     }
> }
>=20
> struct NullBlkDevice;
>=20
> +impl NullBlkDevice {
> +    fn new(
> +        name: &CStr,
> +        block_size: u32,
> +        rotational: bool,
> +        capacity_mib: u64,
> +    ) -> Result<GenDisk<Self>> {
> +        let tagset =3D Arc::pin_init(TagSet::new(1, 256, 1), =
flags::GFP_KERNEL)?;
> +
> +        gen_disk::GenDiskBuilder::new()
> +            .capacity_sectors(capacity_mib << (20 - =
block::SECTOR_SHIFT))
> +            .logical_block_size(block_size)?
> +            .physical_block_size(block_size)?
> +            .rotational(rotational)
> +            .build(fmt!("{}", name.to_str()?), tagset)
> +    }
> +}
> +
> #[vtable]
> impl Operations for NullBlkDevice {
>     #[inline(always)]
> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
> index 39be2a31337f..7ab049ec591b 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -50,7 +50,7 @@ pub fn rotational(mut self, rotational: bool) -> =
Self {
>=20
>     /// Validate block size by verifying that it is between 512 and =
`PAGE_SIZE`,
>     /// and that it is a power of two.
> -    fn validate_block_size(size: u32) -> Result {
> +    pub fn validate_block_size(size: u32) -> Result {
>         if !(512..=3Dbindings::PAGE_SIZE as u32).contains(&size) || =
!size.is_power_of_two() {
>             Err(error::code::EINVAL)
>         } else {
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

=E2=80=94 Daniel

[0]: https://github.com/Rust-for-Linux/linux/issues/1181

