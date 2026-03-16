Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAE37BE9F
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653044; cv=none; b=PlwFRea7LhMMNz3p9WlNBkdeunzlw+22/GXj7GZ7F8JG/e7W9sE8Rxk/oyiqWeV6lMyjIhqnjJB3AkIKn90EsJuNbJWu9ZY4xBS+bWePn3CmtGdZiBQlXafxGsodF3SMZQcUUIKX9M64KF8QlzUSkVtSDmpvYf28ihPval27L4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653044; c=relaxed/simple;
	bh=GqtwUZuYaFKAfOkEOlIPoJDqx1ip62yiWDGH5TApDww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGj74355oT7dNDs6ZtM0jY1zHZlI4QsFf5TKi1UGVcZqsHPpXbG2wVVtE3mXdbMt+fu8x9QzWqj3I0G0T4Aapj5oNQGrKqPEKQYuh6qILbMo6yB9Zw8EqxgS/jRmKu3PiCOaHtu/mSjlKKQfW9BS+P+7B+LHgY/kWoMtP+Jr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8V54pFd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8V54pFd"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485345e2fdfso23633185e9.2
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773653040; x=1774257840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJekOo29lf5mJautU95qylonu6gRgxCG19qcBQDNZqA=;
        b=I8V54pFdJJca/ScD9MOsD46SQYZtwcnBiMUPCGsrebaYH8DzLoyEG52agvEVI2Cu2N
         mTMpZnZ+VBb/U81UjyhvsuVlkfFqkopaPDDPfpeU0/xFdaz16qOcD/xSmUvcsTbSeNHc
         mS9Z9Q39HZz6e17/u73EJ8y4H9+s0VbcIgaKA9mEwoAm+7NXZMKcqAF2iFh1yH7o0ZGp
         SWhImTegaEwQVBc8KD16bhxXdr3QncOmiYoJ1AxrKvYVClbSbGrZ5wF7Mf8lhHGtFVtU
         MNckdMBwtFJa4awEKX0TcQCkWbN/4DST2jqn3kdSkHMepNIZxU8c23aGFRDNDzB7YVGF
         8yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653040; x=1774257840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJekOo29lf5mJautU95qylonu6gRgxCG19qcBQDNZqA=;
        b=lhCdfnmdpT0wTSToLolIjBEaxm4EYavu7g2pCzQpzWS5/Nl2SYdNyIx5LHqt8+mcG8
         jeV0ozLlT4ECzqY7RM0K247amlXYAVgcIh/l6Btop40Pi5LgAyqEz7CHPB2e7jY7kT0g
         2jLbM7MCjgK5lULCg5/MTWabMqo32IswNNqzbOKE54gmM6dDhY6dEoJXKzZGWyjLXpHn
         NoFePyX1vHfBrCB63Pj2EDDWaxiRKCmYBj2T0XuT8Q2o2HHP7FD93FhzWNCl/uaJE6U5
         Y91eUXnJ+rLcXek0hCzz+SWpEoKuFyN4EQ9pdaFrwP3lE4A8SxOKS+I2j5aunAz+3xBc
         Zf8g==
X-Forwarded-Encrypted: i=1; AJvYcCUyhUhUyBDliJ7QM6rQMcAiQiWO4nd9rvBLby51JyZ9HXqioPAb8faQjkLO6ULZM4ly9qorcT1UuT2Wtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gPE19S6jIlEMarnUrVWm9DJfHLDQYiHdqo7ka14EI/qXRLcV
	AxPdb04ibTMo3IwNehv/PmJzVZnUJhyNKy384kvTLyuOtW8Tw1ZFBOHhbtTAYWnX15Iy16dpDUl
	uwL0pOQCbS0PFiyuPjg==
X-Received: from wmqu15.prod.google.com ([2002:a05:600c:19cf:b0:485:34c3:177])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-485564981e5mr208897415e9.0.1773653039981;
 Mon, 16 Mar 2026 02:23:59 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:23:58 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-3-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-3-de9a7af4b469@kernel.org>
Message-ID: <abfMLujw4GbncLVR@google.com>
Subject: Re: [PATCH 03/79] block: rnull: add macros to define configfs attributes
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:34:50AM +0100, Andreas Hindborg wrote:
> Defining configfs attributes in rust is a bit verbose at the moment. Add
> some macros to make the attribute definition less verbose.
> 
> The configfs Rust abstractions should eventually provide procedural macros
> for this task. When we get more users of the configfs Rust abstractions, we
> shall consider this task.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/block/rnull/configfs.rs        | 134 +++++++++------------------------
>  drivers/block/rnull/configfs/macros.rs | 128 +++++++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> index ea38b27a9011c..eafa71dfc40d3 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -1,20 +1,41 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use super::{NullBlkDevice, THIS_MODULE};
> +use super::{
> +    NullBlkDevice,
> +    THIS_MODULE, //
> +};
>  use kernel::{
> -    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> +    block::mq::gen_disk::{
> +        GenDisk,
> +        GenDiskBuilder, //
> +    },
>      c_str,
> -    configfs::{self, AttributeOperations},
> +    configfs::{
> +        self,
> +        AttributeOperations, //
> +    },
>      configfs_attrs,
> -    fmt::{self, Write as _},
> +    fmt::{
> +        self,
> +        Write as _, //
> +    },
>      new_mutex,
>      page::PAGE_SIZE,
>      prelude::*,
> -    str::{kstrtobool_bytes, CString},
> -    sync::Mutex,
> +    str::{
> +        kstrtobool_bytes,
> +        CString, //
> +    },
> +    sync::Mutex, //
> +};
> +use macros::{
> +    configfs_simple_bool_field,
> +    configfs_simple_field, //
>  };
>  use pin_init::PinInit;
>  
> +mod macros;
> +
>  pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
>      let item_type = configfs_attrs! {
>          container: configfs::Subsystem<Config>,
> @@ -166,99 +187,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
>      }
>  }
>  
> -#[vtable]
> -impl configfs::AttributeOperations<1> for DeviceConfig {
> -    type Data = DeviceConfig;
> -
> -    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> -        let mut writer = kernel::str::Formatter::new(page);
> -        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
> -        Ok(writer.bytes_written())
> -    }
> -
> -    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> -        if this.data.lock().powered {
> -            return Err(EBUSY);
> -        }
> -
> -        let text = core::str::from_utf8(page)?.trim();
> -        let value = text.parse::<u32>().map_err(|_| EINVAL)?;
> -
> -        GenDiskBuilder::validate_block_size(value)?;
> -        this.data.lock().block_size = value;
> -        Ok(())
> -    }
> -}
> -
> -#[vtable]
> -impl configfs::AttributeOperations<2> for DeviceConfig {
> -    type Data = DeviceConfig;
> -
> -    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> -        let mut writer = kernel::str::Formatter::new(page);
> -
> -        if this.data.lock().rotational {
> -            writer.write_str("1\n")?;
> -        } else {
> -            writer.write_str("0\n")?;
> -        }
> -
> -        Ok(writer.bytes_written())
> -    }
> -
> -    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> -        if this.data.lock().powered {
> -            return Err(EBUSY);
> -        }
> -
> -        this.data.lock().rotational = kstrtobool_bytes(page)?;
> -
> -        Ok(())
> -    }
> -}
> -
> -#[vtable]
> -impl configfs::AttributeOperations<3> for DeviceConfig {
> -    type Data = DeviceConfig;
> -
> -    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> -        let mut writer = kernel::str::Formatter::new(page);
> -        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
> -        Ok(writer.bytes_written())
> -    }
> -
> -    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> -        if this.data.lock().powered {
> -            return Err(EBUSY);
> -        }
> -
> -        let text = core::str::from_utf8(page)?.trim();
> -        let value = text.parse::<u64>().map_err(|_| EINVAL)?;
> -
> -        this.data.lock().capacity_mib = value;
> -        Ok(())
> -    }
> -}
> -
> -#[vtable]
> -impl configfs::AttributeOperations<4> for DeviceConfig {
> -    type Data = DeviceConfig;
> -
> -    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> -        let mut writer = kernel::str::Formatter::new(page);
> -        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
> -        Ok(writer.bytes_written())
> -    }
> +configfs_simple_field!(DeviceConfig, 1, block_size, u32, check GenDiskBuilder::validate_block_size);
> +configfs_simple_bool_field!(DeviceConfig, 2, rotational);
> +configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
> +configfs_simple_field!(DeviceConfig, 4, irq_mode, IRQMode);
>  
> -    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> -        if this.data.lock().powered {
> -            return Err(EBUSY);
> -        }
> +impl core::str::FromStr for IRQMode {
> +    type Err = Error;
>  
> -        let text = core::str::from_utf8(page)?.trim();
> -        let value = text.parse::<u8>().map_err(|_| EINVAL)?;
> -
> -        this.data.lock().irq_mode = IRQMode::try_from(value)?;
> -        Ok(())
> +    fn from_str(s: &str) -> Result<Self> {
> +        let value: u8 = s.parse().map_err(|_| EINVAL)?;
> +        value.try_into()
>      }
>  }
> diff --git a/drivers/block/rnull/configfs/macros.rs b/drivers/block/rnull/configfs/macros.rs
> new file mode 100644
> index 0000000000000..53ce9d5dbdc8a
> --- /dev/null
> +++ b/drivers/block/rnull/configfs/macros.rs
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::DeviceConfig;
> +use core::{fmt::Write, str::FromStr};
> +use kernel::{page::PAGE_SIZE, prelude::*};
> +
> +pub(crate) fn show_field<T: fmt::Display>(value: T, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +    let mut writer = kernel::str::Formatter::new(page);
> +    writer.write_fmt(fmt!("{}\n", value))?;
> +    Ok(writer.bytes_written())
> +}
> +
> +pub(crate) fn store_with_power_check<F>(this: &DeviceConfig, page: &[u8], store_fn: F) -> Result
> +where
> +    F: FnOnce(&DeviceConfig, &[u8]) -> Result,
> +{
> +    if this.data.lock().powered {
> +        return Err(EBUSY);
> +    }
> +    store_fn(this, page)
> +}
> +
> +pub(crate) fn store_number_with_power_check<F, T>(
> +    this: &DeviceConfig,
> +    page: &[u8],
> +    store_fn: F,
> +) -> Result
> +where
> +    F: FnOnce(&DeviceConfig, T) -> Result,
> +    T: FromStr,
> +{
> +    if this.data.lock().powered {
> +        return Err(EBUSY);
> +    }
> +
> +    let text = core::str::from_utf8(page)?.trim();
> +    let value = text.parse::<T>().map_err(|_| EINVAL)?;
> +
> +    store_fn(this, value)
> +}
> +
> +macro_rules! configfs_attribute {
> +    (
> +        $type:ty,
> +        $id:literal,
> +        show: |$show_this:ident, $show_page:ident| $show_block:expr,
> +        store: |$store_this:ident, $store_page:ident| $store_block:expr
> +        $(,)?
> +    ) => {
> +        #[vtable]
> +        impl configfs::AttributeOperations<$id> for $type {
> +            type Data = $type;
> +
> +            fn show($show_this: &$type, $show_page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +                $show_block
> +            }
> +
> +            fn store($store_this: &$type, $store_page: &[u8]) -> Result {
> +                $store_block
> +            }
> +        }
> +    };
> +}
> +pub(crate) use configfs_attribute;
> +
> +// Specialized macro for simple boolean fields that just store kstrtobool_bytes result.
> +macro_rules! configfs_simple_bool_field {
> +    ($type:ty, $id:literal, $field:ident) => {
> +        crate::configfs::macros::configfs_attribute!($type, $id,
> +            show: |this, page| crate::configfs::macros::show_field(this.data.lock().$field, page),
> +            store: |this, page|
> +              crate::configfs::macros::store_with_power_check(this, page, |this, page| {
> +                this.data.lock().$field = kstrtobool_bytes(page)?;
> +                Ok(())
> +            })
> +        );
> +    };
> +}
> +pub(crate) use configfs_simple_bool_field;
> +
> +// Specialized macro for simple numeric fields that just parse and assign
> +macro_rules! configfs_simple_field {
> +    // Simple direct assignment
> +    ($type:ty, $id:literal, $field:ident, $field_type:ty) => {
> +        crate::configfs::macros::configfs_attribute!($type, $id,
> +            show: |this, page| crate::configfs::macros::show_field(this.data.lock().$field, page),
> +            store: |this, page| crate::configfs::macros::store_number_with_power_check(
> +                this,
> +                page,
> +                |this, value: $field_type| {
> +                    this.data.lock().$field = value;

I think there's a TOCTOU issue here. You take the lock to perform a
power check in store_number_with_power_check(), then you release the
lock and check again in `store`. But `powered` could have changed in the
meantime.

Alice
