Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22C3570D0;
	Wed, 27 Aug 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303854; cv=pass; b=SifoixzvkeC9k0oj0J6s/w/X2kecb2bOhmNTAecDal2UZAZBLZvgH7y+iPQfUPM5Eyd5fs9esg+ISriXe3mXvUG46JDJ3aRksdRemwOUkHcepk+NGX7WhoSohRd7ch5g8PoUgC6zxDm2ccl8u6c/uh9WMJkmxN7WKrPlKShWjcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303854; c=relaxed/simple;
	bh=ojISwd1qY2TCNOEld/0A0K0KGIXLObHFwDe20BaZZ4M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dIWGgtks1F+soQr1Ch117y+tmiGeY+qJ507ms/FlP9Fx8d77Tj4cOSnnjI7vGtIeF60YCFAOXvOcmVNLSfibuV3ZP6ULALp2Zy8AtdL8j3ovxwlSHt/VVQqJ6UfzPWYVjQmbX63tmnPWutrGOo/Wyu2e5rxEyyMwvbHeejOubHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=W2969Unj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="W2969Unj"
ARC-Seal: i=1; a=rsa-sha256; t=1756303832; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RwcRNVMFT6yrjsBxZMp+1Aox92yYTjEe1s3tQAUyZwAmX2iC6USlR27aoLRRpEZPDomgRRgIIWg8uGzW3WJV6SA7qX0zba4ocsXRsZLVEmo3hx70CrzVQxc5taSx2W+56ERAEF1wDJkMG6TyAWZFp4QOWMVe0IGR+pXkSes5EhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756303832; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J4BlMs46TcKuQ6XUE/j+iarthoa+EByDQJ4eXRSVSGY=; 
	b=ANqsVKHiHXkLC139grGm0R8DJp/uYJJsY8XwCdCEZi8qQ35AkUYeJhy1hXEGPgyEMoBlou5omQ4Ow+sElsn9s2ysl3o/m8LiCBN0jtnV1J1i7hjg919hOj0Z81sGdlkA+9hAXUe/td3OldKckoj+3EdoiAnyozyBAaI6beoxX1I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756303832;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=J4BlMs46TcKuQ6XUE/j+iarthoa+EByDQJ4eXRSVSGY=;
	b=W2969Unj2f9FGUrgx0gazecLv/huveuk7ftXS7noEhzxp8e3GJN4YIX6hGD891vY
	Lp1aeMYEooBdoWtUZ4bI7RtNO/6MaWD/PwN5MUX+VrWtL0LOSkvYJuksegJ/qv/yweL
	vYhGVhwvQQilrObpIvCZIMDspxIgQyvf1Jsnljhc=
Received: by mx.zohomail.com with SMTPS id 1756303829655926.757398195364;
	Wed, 27 Aug 2025 07:10:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 14/18] rnull: enable configuration via `configfs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-14-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 11:10:13 -0300
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
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19FC4705-9925-4717-9B69-3D2705BC3833@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-14-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> drivers/block/rnull/Kconfig      |   2 +-
> drivers/block/rnull/configfs.rs  | 207 =
+++++++++++++++++++++++++++++++++++++++
> drivers/block/rnull/rnull.rs     |  59 +++++------
> rust/kernel/block/mq/gen_disk.rs |   2 +-
> 4 files changed, 240 insertions(+), 30 deletions(-)
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
> help
>  This is the Rust implementation of the null block driver. Like
>  the C version, the driver allows the user to create virutal block
> diff --git a/drivers/block/rnull/configfs.rs =
b/drivers/block/rnull/configfs.rs
> new file mode 100644
> index 000000000000..46710a1e1af4
> --- /dev/null
> +++ b/drivers/block/rnull/configfs.rs
> @@ -0,0 +1,207 @@
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
> +    str::{kstrtobool_bytes, CString},
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
> +            try_pin_init!( DeviceConfig {
> +                data <- new_mutex!(DeviceConfigInner {
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
> +            writer.write_str("1\n")?;
> +        } else {
> +            writer.write_str("0\n")?;
> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        let power_op =3D kstrtobool_bytes(page)?;
> +        let mut guard =3D this.data.lock();
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
> +        let value =3D text.parse::<u32>().map_err(|_| EINVAL)?;
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
> +            writer.write_str("1\n")?;
> +        } else {
> +            writer.write_str("0\n")?;
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
> +        this.data.lock().rotational =3D kstrtobool_bytes(page)?;
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
> +        let value =3D text.parse::<u64>().map_err(|_| EINVAL)?;
> +
> +        this.data.lock().capacity_mib =3D value;
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/block/rnull/rnull.rs =
b/drivers/block/rnull/rnull.rs
> index d07e76ae2c13..8690ff5f974f 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -1,28 +1,25 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> //! This is a Rust implementation of the C null block driver.
> -//!
> -//! Supported features:
> -//!
> -//! - blk-mq interface
> -//! - direct completion
> -//! - block size 4k
> -//!
> -//! The driver is not configurable.
> +
> +mod configfs;
>=20
> use kernel::{
> -    alloc::flags,
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
> @@ -35,33 +32,39 @@
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
GFP_KERNEL)?;
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
> index 20f1d46c774d..6b1b846874db 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -51,7 +51,7 @@ pub fn rotational(mut self, rotational: bool) -> =
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
