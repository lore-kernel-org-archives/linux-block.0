Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CB4A02;
	Thu,  7 Aug 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553832; cv=none; b=SImiOc91RLjHu4WDOoCAMaIlfv47UGlDj9YMP0q/939XAURRf15tItDkNfrmI69YHdx/1fWcuu4rzchpABWpfG6nrfQcJbZQGy6IxrjcnxPFawa+DUZkzlAxmY/L8WLHd6C6FPI34Ns0s1DIMtzP1/fvItVktLkRgW/Ves9TMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553832; c=relaxed/simple;
	bh=DigsrD5oXyoi+hw/E7nzS9uA860Z7qmA03IEuU7gOx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+9lEKvuuxW3wAFYN2aDrO0I2M+AWEINwLWriOdl23+geuWw7d/CgwnQf2/6Mdg/7FGpjUGqUCi1onLRaeO6haDzYJitLQDmVooi0Uh+XLzinR4Gnae+zYZwyCuD/ne0YlyZNqU/Of4Mh5GfCUHR8ITBsRkATbipCb71zDalxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHpHOCww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHpHOCww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5C3C4CEEB;
	Thu,  7 Aug 2025 08:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553831;
	bh=DigsrD5oXyoi+hw/E7nzS9uA860Z7qmA03IEuU7gOx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gHpHOCwwxhBsxmCQGOWcBCNjqTZucQ4ckqY3O/z+siorf+Zrq3101A4QRUc6Z/xhJ
	 aiMBYZgh5VbBBMvwaHXtZPsibo8bA3DQxeewFDGt8h2NqXYuAlIrl2bY0t94hGbBMH
	 gbFRolP9EV0k+mk7qZ/QdRHoM/Kr4nIJLpyjXPHxg5qDyLn+/4YOUQWZX0uWs75zcb
	 vHCN7ryyYgU2jfcLA69gWUUFSItdEI4UZqOAwMaR8CXmw/n52hha/WghmlOk5KpNTD
	 GtV6btzd67wyfyrplhAmnPCvsM4Rk4+3xLUOFltxDjCh9bHjML7oFzFuC0X4H4jHS0
	 lpOwAJKvrNcBg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/16] rnull: enable configuration via `configfs`
In-Reply-To: <03D084B5-5844-4BC5-902C-14E53AC13DC9@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
 <ja8Fq-6i7ve2g9-WET0f6gi7n7LRRoxxmur2UiowKZQN-_n2RVtLR7TGMJKyQfvrwIwgY7N1xFkPLp25-yrPsA==@protonmail.internalid>
 <03D084B5-5844-4BC5-902C-14E53AC13DC9@collabora.com>
Date: Thu, 07 Aug 2025 10:02:52 +0200
Message-ID: <87v7mz7e4z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Allow rust null block devices to be configured and instantiated via
>> `configfs`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> drivers/block/rnull/Kconfig      |   2 +-
>> drivers/block/rnull/configfs.rs  | 220 +++++++++++++++++++++++++++++++++=
++++++
>> drivers/block/rnull/rnull.rs     |  58 ++++++-----
>> rust/kernel/block/mq/gen_disk.rs |   2 +-
>> 4 files changed, 253 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
>> index 6dc5aff96bf4..7bc5b376c128 100644
>> --- a/drivers/block/rnull/Kconfig
>> +++ b/drivers/block/rnull/Kconfig
>> @@ -4,7 +4,7 @@
>>
>> config BLK_DEV_RUST_NULL
>> tristate "Rust null block driver (Experimental)"
>> - depends on RUST
>> + depends on RUST && CONFIGFS_FS
>
> Should this really be a dependency? IIUC, the driver still works with this
> unset, it just doesn=E2=80=99t have this feature?

It does not and I do not intend for it to operate without configfs.

I did not try to build without configfs enabled, but the rnull driver
has calls to symbols provided by the configfs subsystem, so it really
should not work without configfs loaded.

>
>> help
>>  This is the Rust implementation of the null block driver. Like
>>  the C version, the driver allows the user to create virutal block
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/confi=
gfs.rs
>> new file mode 100644
>> index 000000000000..6c0e3bbb36ec
>> --- /dev/null
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -0,0 +1,220 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::{NullBlkDevice, THIS_MODULE};
>> +use core::fmt::Write;
>> +use kernel::{
>> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>> +    c_str,
>> +    configfs::{self, AttributeOperations},
>> +    configfs_attrs, new_mutex,
>> +    page::PAGE_SIZE,
>> +    prelude::*,
>> +    str::CString,
>> +    sync::Mutex,
>> +};
>> +use pin_init::PinInit;
>> +
>> +pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<C=
onfig>, Error> {
>> +    let item_type =3D configfs_attrs! {
>> +        container: configfs::Subsystem<Config>,
>> +        data: Config,
>> +        child: DeviceConfig,
>> +        attributes: [
>> +            features: 0,
>> +        ],
>> +    };
>> +
>> +    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, try_pi=
n_init!(Config {}))
>> +}
>> +
>> +#[pin_data]
>> +pub(crate) struct Config {}
>
> This still builds:
>
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/config=
fs.rs
> index 3ae84dfc8d62..2e5ffa82e679 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -24,10 +24,9 @@ pub(crate) fn subsystem() -> impl PinInit<kernel::conf=
igfs::Subsystem<Config>, E
>          ],
>      };
>
> -    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, try_pin=
_init!(Config {}))
> +    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, Config =
{})
>  }
>
> -#[pin_data]
>  pub(crate) struct Config {}
>
> Perhaps due to:
>
> // SAFETY: the `__pinned_init` function always returns `Ok(())` and initi=
alizes every field of
> // `slot`. Additionally, all pinning invariants of `T` are upheld.
> unsafe impl<T> PinInit<T> for T {
>     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible>=
 {
>         // SAFETY: `slot` is valid for writes by the safety requirements =
of this function.
>         unsafe { slot.write(self) };
>         Ok(())
>     }
> }

Hmm, when I apply this change it does not work out for me:

      RUSTC [M] drivers/block/rnull/rnull.o
    error[E0277]: the trait bound `Config: PinInit<Config, kernel::error::E=
rror>` is not satisfied
      --> /home/aeh/src/linux-rust/rnull-up-v6.16-rc1/drivers/block/rnull/c=
onfigfs.rs:27:66
        |
    27  |     kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, =
Config {})
        |     --------------------------------                             =
^^^^^^^^^ the trait `PinInit<Config, kernel::error::Error>` is not implemen=
ted for `Config`
        |     |
        |     required by a bound introduced by this call
        |
        =3D help: the following other types implement trait `PinInit<T, E>`:
                  <AlwaysFail<T> as PinInit<T, ()>>
                  <ChainPinInit<I, F, T, E> as PinInit<T, E>>
                  <ChainInit<I, F, T, E> as PinInit<T, E>>
                  <core::result::Result<T, E> as PinInit<T, E>>
    note: required by a bound in `Subsystem::<Data>::new`
      --> /home/aeh/src/linux-rust/rnull-up-v6.16-rc1/rust/kernel/configfs.=
rs:151:20
        |
    148 |     pub fn new(
        |            --- required by a bound in this associated function
    ...
    151 |         data: impl PinInit<Data, Error>,
        |                    ^^^^^^^^^^^^^^^^^^^^ required by this bound in=
 `Subsystem::<Data>::new`

    error[E0277]: the trait bound `Config: PinInit<Config, kernel::error::E=
rror>` is not satisfied
      --> /home/aeh/src/linux-rust/rnull-up-v6.16-rc1/drivers/block/rnull/c=
onfigfs.rs:17:30
        |
    17  | pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsy=
stem<Config>, Error> {
        |                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^ the trait `PinInit<Config, kernel::error::Error>` is n=
ot implemented for `Config`
        |
        =3D help: the following other types implement trait `PinInit<T, E>`:
                  <AlwaysFail<T> as PinInit<T, ()>>
                  <ChainPinInit<I, F, T, E> as PinInit<T, E>>
                  <ChainInit<I, F, T, E> as PinInit<T, E>>
                  <core::result::Result<T, E> as PinInit<T, E>>
    note: required by a bound in `Subsystem::<Data>::new`
      --> /home/aeh/src/linux-rust/rnull-up-v6.16-rc1/rust/kernel/configfs.=
rs:151:20
        |
    148 |     pub fn new(
        |            --- required by a bound in this associated function
    ...
    151 |         data: impl PinInit<Data, Error>,
        |                    ^^^^^^^^^^^^^^^^^^^^ required by this bound in=
 `Subsystem::<Data>::new`

    error: aborting due to 2 previous errors

I rebased on rust-6.17. What did you apply this series to?

>
>
>> +
>> +#[vtable]
>> +impl AttributeOperations<0> for Config {
>> +    type Data =3D Config;
>> +
>> +    fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize=
> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +        writer.write_str("blocksize,size,rotational\n")?;
>> +        Ok(writer.bytes_written())
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::GroupOperations for Config {
>> +    type Child =3D DeviceConfig;
>> +
>> +    fn make_group(
>> +        &self,
>> +        name: &CStr,
>> +    ) -> Result<impl PinInit<configfs::Group<DeviceConfig>, Error>> {
>> +        let item_type =3D configfs_attrs! {
>> +            container: configfs::Group<DeviceConfig>,
>> +            data: DeviceConfig,
>> +            attributes: [
>> +                // Named for compatibility with C null_blk
>> +                power: 0,
>> +                blocksize: 1,
>> +                rotational: 2,
>> +                size: 3,
>> +            ],
>> +        };
>> +
>> +        Ok(configfs::Group::new(
>> +            name.try_into()?,
>> +            item_type,
>> +            // TODO: cannot coerce new_mutex!() to impl PinInit<_, Erro=
r>, so put mutex inside
>
> Isn=E2=80=99t this related to [0] ?

No, I think this is a type inference problem.

>
>
>> +            try_pin_init!( DeviceConfig {
>> +                data <- new_mutex!( DeviceConfigInner {
>> +                    powered: false,
>> +                    block_size: 4096,
>> +                    rotational: false,
>> +                    disk: None,
>> +                    capacity_mib: 4096,
>> +                    name: name.try_into()?,
>> +                }),
>> +            }),
>> +        ))
>> +    }
>> +}
>> +
>> +#[pin_data]
>> +pub(crate) struct DeviceConfig {
>> +    #[pin]
>> +    data: Mutex<DeviceConfigInner>,
>> +}
>> +
>> +#[pin_data]
>> +struct DeviceConfigInner {
>> +    powered: bool,
>> +    name: CString,
>> +    block_size: u32,
>> +    rotational: bool,
>> +    capacity_mib: u64,
>> +    disk: Option<GenDisk<NullBlkDevice>>,
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<0> for DeviceConfig {
>> +    type Data =3D DeviceConfig;
>> +
>> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<=
usize> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +
>> +        if this.data.lock().powered {
>> +            writer.write_fmt(fmt!("1\n"))?;
>> +        } else {
>> +            writer.write_fmt(fmt!("0\n"))?;
>> +        }
>> +
>> +        Ok(writer.bytes_written())
>> +    }
>> +
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        let power_op: bool =3D core::str::from_utf8(page)?
>> +            .trim()
>> +            .parse::<u8>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?
>
> nit: I=E2=80=99d import that if I were you, but it=E2=80=99s your call.

OK.

>
>> +            !=3D 0;
>> +
>> +        let mut guard =3D this.data.lock();
>> +
>> +        if !guard.powered && power_op {
>> +            guard.disk =3D Some(NullBlkDevice::new(
>> +                &guard.name,
>> +                guard.block_size,
>> +                guard.rotational,
>> +                guard.capacity_mib,
>> +            )?);
>> +            guard.powered =3D true;
>> +        } else if guard.powered && !power_op {
>> +            drop(guard.disk.take());
>> +            guard.powered =3D false;
>> +        }
>
> nit: the guard is not used here, but it is still alive. This is harmless =
in
> this case, but as I general pattern, I find that using closures cuts back=
 on
> the scope, i.e.:
>
> this.with_locked_data(|data| {
>     // use the guard
> });
>
> // Guard is already free here, no surprises.

I don't see `with_locked_data` anywhere in the kernel crate? It would be
a method on `Mutex`? Or would you add the method to `DeviceConfig`?

>
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<1> for DeviceConfig {
>> +    type Data =3D DeviceConfig;
>> +
>> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<=
usize> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
>> +        Ok(writer.bytes_written())
>> +    }
>> +
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        if this.data.lock().powered {
>> +            return Err(EBUSY);
>> +        }
>> +
>> +        let text =3D core::str::from_utf8(page)?.trim();
>> +        let value =3D text
>> +            .parse::<u32>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?;
>> +
>> +        GenDiskBuilder::validate_block_size(value)?;
>> +        this.data.lock().block_size =3D value;
>> +        Ok(())
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<2> for DeviceConfig {
>> +    type Data =3D DeviceConfig;
>> +
>> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<=
usize> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +
>> +        if this.data.lock().rotational {
>> +            writer.write_fmt(fmt!("1\n"))?;
>> +        } else {
>> +            writer.write_fmt(fmt!("0\n"))?;
>> +        }
>> +
>> +        Ok(writer.bytes_written())
>> +    }
>> +
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        if this.data.lock().powered {
>> +            return Err(EBUSY);
>> +        }
>> +
>> +        this.data.lock().rotational =3D core::str::from_utf8(page)?
>> +            .trim()
>> +            .parse::<u8>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?
>> +            !=3D 0;
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl configfs::AttributeOperations<3> for DeviceConfig {
>> +    type Data =3D DeviceConfig;
>> +
>> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<=
usize> {
>> +        let mut writer =3D kernel::str::Formatter::new(page);
>> +        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
>> +        Ok(writer.bytes_written())
>> +    }
>> +
>> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>> +        if this.data.lock().powered {
>> +            return Err(EBUSY);
>> +        }
>> +
>> +        let text =3D core::str::from_utf8(page)?.trim();
>> +        let value =3D text
>> +            .parse::<u64>()
>> +            .map_err(|_| kernel::error::code::EINVAL)?;
>> +
>> +        this.data.lock().capacity_mib =3D value;
>> +        Ok(())
>> +    }
>> +}
>> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
>> index d07e76ae2c13..d09bc77861e4 100644
>> --- a/drivers/block/rnull/rnull.rs
>> +++ b/drivers/block/rnull/rnull.rs
>> @@ -1,28 +1,26 @@
>> // SPDX-License-Identifier: GPL-2.0
>>
>> //! This is a Rust implementation of the C null block driver.
>> -//!
>> -//! Supported features:
>> -//!
>> -//! - blk-mq interface
>> -//! - direct completion
>> -//! - block size 4k
>
> Why are these three removed?

Because the list is stale and I did not want to maintain it.


Best regards,
Andreas Hindborg




