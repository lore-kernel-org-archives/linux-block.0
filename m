Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C17225762;
	Wed, 27 Aug 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317771; cv=pass; b=n+1toI2uLUqkdxfQQpfdrch93Jvw8RZEN4LQFbeUzKAdxaXJFmODWu2kakKFFNmQUcxe0tPpKVFqS/Tq5YCs7CPyPW9Fb4cUvgDZ11oBczkBm8y+l+5u48r2wNS3128P23nkopc+EYBUuhEqaZIRITDwrOVFQHGtIb966uba824=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317771; c=relaxed/simple;
	bh=V6MwqDZYp4KXZoHxeXb4Ga52iDgtT9V7NJZ8rlaumRw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aXmzCO3evWrnSv8qq9dfaadLbAvTiq3HJDmM+13eWHrNGOpb4Qo88NTxklMgMxNvTIQ1Ol8Rwj6104boe3I/W59SDap18WxTN3cCz0uUtsxaP+FWa8j8INJ2YT2qzPbTFQcO4hEcWdg7udZlo4/HItcOwifojOgSObb+0i4znq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Xgh4A9rd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Xgh4A9rd"
ARC-Seal: i=1; a=rsa-sha256; t=1756317750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOsEPVwZd8mB++6sUmx5Dkh6c0lPYR8zHtIwGNMyNYxnfMv9JvvTM1aT8Tbn0Naysy5A1RbiLh1aLPqYoFcPZFdyfxDvdaBHk7RFgcO2y7Vjen45+zGZ8Y0BX4yxW3hvnpjaLNWIxVYnifaSc0kE0dU5PWfmZge4A5EIc5OHBhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756317750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/C8OJPYgzbnrNpiyIgEQUTiiJPNNtcwftn4jSEMBx1Q=; 
	b=W0CMmQH7k4DO0z+kPBIKYtikqwdxAxvEyRuGM3logQibKIbPNHmUJDUmhVlL16XAbiqROPEVdRaMemO4K9ifa2b7mC7LSyF3mFNRqxDFIWP7isiigXYbf784/k4OtwhpZ7H6jDgBxQSFCpbDUuD9EXTQCvfNV5AZMQepdP8aeOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756317750;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/C8OJPYgzbnrNpiyIgEQUTiiJPNNtcwftn4jSEMBx1Q=;
	b=Xgh4A9rdbSSKm02jKckKCsEe6UfpDw3mJ/udn7dogx1qTuMIblOUuyBtwQ/ZWbjj
	vNSVSTIye81sG97cy6ARS++TlWUz7qNIGqyxYOxR3VlFJ4+/OGu6lIAV9b20izozPXI
	wF4jJ201xeOQzjDZXKOthOQmQazCSAGH8l8UxsKQ=
Received: by mx.zohomail.com with SMTPS id 1756317747818761.8503283605801;
	Wed, 27 Aug 2025 11:02:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 18/18] rnull: add soft-irq completion support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-18-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 15:02:12 -0300
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
Message-Id: <2C68673E-5A65-4BCF-ADE4-8ED33370546C@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-18-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> rnull currently only supports direct completion. Add option for =
completing
> requests across CPU nodes via soft IRQ or IPI.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> drivers/block/rnull/configfs.rs | 59 =
+++++++++++++++++++++++++++++++++++++++--
> drivers/block/rnull/rnull.rs    | 32 ++++++++++++++--------
> 2 files changed, 78 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/block/rnull/configfs.rs =
b/drivers/block/rnull/configfs.rs
> index 46710a1e1af4..8498e9bae6fd 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -1,7 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> use super::{NullBlkDevice, THIS_MODULE};
> -use core::fmt::Write;
> +use core::fmt::{Display, Write};
> use kernel::{
>     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>     c_str,
> @@ -36,7 +36,7 @@ impl AttributeOperations<0> for Config {
>=20
>     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
>         let mut writer =3D kernel::str::Formatter::new(page);
> -        writer.write_str("blocksize,size,rotational\n")?;
> +        writer.write_str("blocksize,size,rotational,irqmode\n")?;
>         Ok(writer.bytes_written())
>     }
> }
> @@ -58,6 +58,7 @@ fn make_group(
>                 blocksize: 1,
>                 rotational: 2,
>                 size: 3,
> +                irqmode: 4,
>             ],
>         };
>=20
> @@ -72,6 +73,7 @@ fn make_group(
>                     rotational: false,
>                     disk: None,
>                     capacity_mib: 4096,
> +                    irq_mode: IRQMode::None,
>                     name: name.try_into()?,
>                 }),
>             }),
> @@ -79,6 +81,34 @@ fn make_group(
>     }
> }
>=20
> +#[derive(Debug, Clone, Copy)]
> +pub(crate) enum IRQMode {
> +    None,
> +    Soft,
> +}
> +
> +impl TryFrom<u8> for IRQMode {
> +    type Error =3D kernel::error::Error;
> +
> +    fn try_from(value: u8) -> Result<Self> {
> +        match value {
> +            0 =3D> Ok(Self::None),
> +            1 =3D> Ok(Self::Soft),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl Display for IRQMode {
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> =
core::fmt::Result {
> +        match self {
> +            Self::None =3D> f.write_str("0")?,
> +            Self::Soft =3D> f.write_str("1")?,
> +        }
> +        Ok(())
> +    }
> +}
> +
> #[pin_data]
> pub(crate) struct DeviceConfig {
>     #[pin]
> @@ -92,6 +122,7 @@ struct DeviceConfigInner {
>     block_size: u32,
>     rotational: bool,
>     capacity_mib: u64,
> +    irq_mode: IRQMode,
>     disk: Option<GenDisk<NullBlkDevice>>,
> }
>=20
> @@ -121,6 +152,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> =
Result {
>                 guard.block_size,
>                 guard.rotational,
>                 guard.capacity_mib,
> +                guard.irq_mode,
>             )?);
>             guard.powered =3D true;
>         } else if guard.powered && !power_op {
> @@ -205,3 +237,26 @@ fn store(this: &DeviceConfig, page: &[u8]) -> =
Result {
>         Ok(())
>     }
> }
> +
> +#[vtable]
> +impl configfs::AttributeOperations<4> for DeviceConfig {
> +    type Data =3D DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> =
Result<usize> {
> +        let mut writer =3D kernel::str::Formatter::new(page);
> +        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        let text =3D core::str::from_utf8(page)?.trim();
> +        let value =3D text.parse::<u8>().map_err(|_| EINVAL)?;
> +
> +        this.data.lock().irq_mode =3D IRQMode::try_from(value)?;
> +        Ok(())
> +    }
> +}
> diff --git a/drivers/block/rnull/rnull.rs =
b/drivers/block/rnull/rnull.rs
> index a19c55717c4f..1ec694d7f1a6 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -4,6 +4,7 @@
>=20
> mod configfs;
>=20
> +use configfs::IRQMode;
> use kernel::{
>     block::{
>         self,
> @@ -53,35 +54,44 @@ fn new(
>         block_size: u32,
>         rotational: bool,
>         capacity_mib: u64,
> +        irq_mode: IRQMode,
>     ) -> Result<GenDisk<Self>> {
>         let tagset =3D Arc::pin_init(TagSet::new(1, 256, 1), =
GFP_KERNEL)?;
>=20
> +        let queue_data =3D Box::new(QueueData { irq_mode }, =
GFP_KERNEL)?;
> +
>         gen_disk::GenDiskBuilder::new()
>             .capacity_sectors(capacity_mib << (20 - =
block::SECTOR_SHIFT))
>             .logical_block_size(block_size)?
>             .physical_block_size(block_size)?
>             .rotational(rotational)
> -            .build(fmt!("{}", name.to_str()?), tagset, ())
> +            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
>     }
> }
>=20
> +struct QueueData {
> +    irq_mode: IRQMode,
> +}
> +
> #[vtable]
> impl Operations for NullBlkDevice {
> -    type QueueData =3D ();
> +    type QueueData =3D KBox<QueueData>;
>=20
>     #[inline(always)]
> -    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, =
_is_last: bool) -> Result {
> -        mq::Request::end_ok(rq)
> -            .map_err(|_e| kernel::error::code::EIO)
> -            // We take no refcounts on the request, so we expect to =
be able to
> -            // end the request. The request reference must be unique =
at this
> -            // point, and so `end_ok` cannot fail.
> -            .expect("Fatal error - expected to be able to end =
request");

Same comment here as on the last patch. Otherwise LGTM.

> -
> +    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, =
_is_last: bool) -> Result {
> +        match queue_data.irq_mode {
> +            IRQMode::None =3D> mq::Request::end_ok(rq)
> +                .map_err(|_e| kernel::error::code::EIO)
> +                // We take no refcounts on the request, so we expect =
to be able to
> +                // end the request. The request reference must be =
unique at this
> +                // point, and so `end_ok` cannot fail.
> +                .expect("Fatal error - expected to be able to end =
request"),
> +            IRQMode::Soft =3D> mq::Request::complete(rq),
> +        }
>         Ok(())
>     }
>=20
> -    fn commit_rqs(_queue_data: ()) {}
> +    fn commit_rqs(_queue_data: &QueueData) {}
>=20
>     fn complete(rq: ARef<mq::Request<Self>>) {
>         mq::Request::end_ok(rq)
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

