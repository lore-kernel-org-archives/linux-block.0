Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC6DDA3
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987668; cv=none; b=L9yCbCgsAN2E3QUyL/pcM3x58hVUSDfvzr6fXV9DXqjkUMqCsNb/gJsbh1OstCB++qViEe/GDvhhOURD2mZNabuB5RyzT2TOGLb3Rw+yaM9NKrFRe7klTW1wSeNB5zI+roLjPjEuekVxwFOcnaEjZn1rmNZKzLwHxukyLO4B0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987668; c=relaxed/simple;
	bh=eR/GH5nB0xBfhtJgnBozNwaRheRGE1NTi78E9R/dmoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDy6oE6D2mtvmOayxHAb+CDwAOzOsGwSf3HJYNbW6ZWvdCcF53UNxcHqzjZLv35D6g3YLxmDGQCGIrUatBoPAMYXBylCf+wOHgG8UgM8Z5FTbBsU2gqS9rsqLvMU5CieTR9mRahuoNbmVTRqphu4vTVMVGBRecqBhNRUr8yutrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=16KlXnU9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="16KlXnU9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso2344342a12.3
        for <linux-block@vger.kernel.org>; Wed, 29 May 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716987664; x=1717592464; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7DoM59dtLeTMen13A6x9C/FcI3j7L4Gc5GfAQ1o108=;
        b=16KlXnU9Qg1leChuu41s2KMuYnlN4uTLL2tpV/xrVfJ2QZzlB5h4rB/6gf5mvHFsyL
         9az/D2IQR17LstGnrNH/5SV3dw6kGdWBLBbvkVBBwZbu/ccG3dY7yAGU27g21AvwiYFz
         suOFbwLfSXzKIWeAxGr2sFA8FzR5ZjKcyGuFqEjqikLHOYEfH81SxHtecYdwmC01Ijqx
         NKE2eLXlN1mX69ZfT/YXXmuW728kR6Fym6UF/MRFdVfuHgvfaBSDomsSkZzjOeBg51f4
         KBYo4jontDJCxr5Bcb0cnN0aVskyLAnj8Bovc1mdAo6WTfmvqHG8qc/sWDW3QNMRfskK
         U0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987664; x=1717592464;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7DoM59dtLeTMen13A6x9C/FcI3j7L4Gc5GfAQ1o108=;
        b=QbG0COeqFthaA2SowMuLVWnnAGPESbQkq95LJl3EdPvnvETLxVf4gPZRkjVpdpZy7W
         grjHVTdaNyZj4iX9Cq+D1APgQjk71LPRrbAs3AcddS37GLGEgzObC5lZ18HQTXjQPHaM
         XNCUrS4HkN2jBrDA31EL0W+UfLFduF+sOrlywozTTPKqtEP8UVFcoEgz3ImSsmv4Igll
         Xj8ttrRrozVxuZhPcoF0e9AY0Xn9LDTWE/EMCXgKidwB5SpVrsXGzfsxh8bNHmZhX9an
         PxBvo3yQEugqveq6mR0EUF5VehXBw+88xI+v3BhT3+nravNdOODqMRmL/0BXIjk66My5
         piuA==
X-Forwarded-Encrypted: i=1; AJvYcCXaSlTcjveSLAKBmdEyDuqIgEKugWut7tGSQydfZiOXFAk+9G6KAGXRjsDEgCGSNOleFyVZAvEMI3TIfrjjR1d08QReMXHKGCdptm4=
X-Gm-Message-State: AOJu0YxQxzvBN6NqSTcKING5eeOSN9jq+/8TlC8pC18EOdDxmGPowt8d
	HDeqrIMlP4a9JsLVat/9WTzGSihIGrTvOQo3DBAx42do54HDDw5a9ZRxR8hI4L0=
X-Google-Smtp-Source: AGHT+IEyXlPXjYGmEw3ahMY9PsNYYzyOwtmCbn2fHHzHfMx2Rg+nYZ3fd0cwUIjCg1Ppewwpbsekzg==
X-Received: by 2002:a17:906:3896:b0:a62:1347:ad40 with SMTP id a640c23a62f3a-a62641c6eb2mr915825566b.16.1716987663642;
        Wed, 29 May 2024 06:01:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62dd12b233sm422159566b.2.2024.05.29.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:01:03 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,  Bart Van
 Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <d7b963f0-060f-44c0-8358-fb8dbd064575@proton.me> (Benno Lossin's
	message of "Tue, 28 May 2024 13:27:53 +0000")
References: <20240521140323.2960069-1-nmi@metaspace.dk>
	<20240521140323.2960069-3-nmi@metaspace.dk>
	<d7b963f0-060f-44c0-8358-fb8dbd064575@proton.me>
Date: Wed, 29 May 2024 15:00:48 +0200
Message-ID: <87o78orcvz.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 21.05.24 16:03, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> This patch adds an initial version of the Rust null block driver.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  drivers/block/Kconfig   |  9 +++++
>>  drivers/block/Makefile  |  3 ++
>>  drivers/block/rnull.rs  | 86 +++++++++++++++++++++++++++++++++++++++++
>>  rust/kernel/block/mq.rs |  4 +-
>>  4 files changed, 101 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/block/rnull.rs
>> 
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 5b9d4aaebb81..ed209f4f2798 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -354,6 +354,15 @@ config VIRTIO_BLK
>>  	  This is the virtual block driver for virtio.  It can be used with
>>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>> 
>> +config BLK_DEV_RUST_NULL
>> +	tristate "Rust null block driver (Experimental)"
>> +	depends on RUST
>> +	help
>> +	  This is the Rust implementation of the null block driver. For now it
>> +	  is only a minimal stub.
>> +
>> +	  If unsure, say N.
>> +
>>  config BLK_DEV_RBD
>>  	tristate "Rados block device (RBD)"
>>  	depends on INET && BLOCK
>> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
>> index 101612cba303..1105a2d4fdcb 100644
>> --- a/drivers/block/Makefile
>> +++ b/drivers/block/Makefile
>> @@ -9,6 +9,9 @@
>>  # needed for trace events
>>  ccflags-y				+= -I$(src)
>> 
>> +obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
>> +rnull_mod-y := rnull.o
>> +
>>  obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
>>  obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
>>  obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
>> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
>> new file mode 100644
>> index 000000000000..1d6ab6f0f26f
>> --- /dev/null
>> +++ b/drivers/block/rnull.rs
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This is a Rust implementation of the C null block driver.
>> +//!
>> +//! Supported features:
>> +//!
>> +//! - blk-mq interface
>> +//! - direct completion
>> +//! - block size 4k
>> +//!
>> +//! The driver is not configurable.
>> +
>> +use kernel::{
>> +    alloc::flags,
>> +    block::mq::{
>> +        self,
>> +        gen_disk::{self, GenDisk},
>> +        Operations, TagSet,
>> +    },
>> +    error::Result,
>> +    new_mutex, pr_info,
>> +    prelude::*,
>> +    sync::{Arc, Mutex},
>> +    types::ARef,
>> +};
>> +
>> +module! {
>> +    type: NullBlkModule,
>> +    name: "rnull_mod",
>> +    author: "Andreas Hindborg",
>> +    license: "GPL v2",
>> +}
>> +
>> +struct NullBlkModule {
>> +    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice, gen_disk::Added>>>>,
>> +}
>> +
>> +fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice, gen_disk::Added>> {
>
> Any reason that this is its own function and not in the
> `NullBlkModule::init` function?

Would you embed it inside the `init` function? To what end? I don't
think that would read well.

>
>> +    let block_size: u16 = 4096;
>> +    if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>> +        return Err(kernel::error::code::EINVAL);
>> +    }
>> +
>> +    let mut disk = gen_disk::try_new(tagset)?;
>> +    disk.set_name(format_args!("rnullb{}", 0))?;
>> +    disk.set_capacity_sectors(4096 << 11);
>> +    disk.set_queue_logical_block_size(block_size.into());
>> +    disk.set_queue_physical_block_size(block_size.into());
>> +    disk.set_rotational(false);
>> +    disk.add()
>> +}
>> +
>> +impl kernel::Module for NullBlkModule {
>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>> +        pr_info!("Rust null_blk loaded\n");
>> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>> +        let disk = Box::pin_init(
>> +            new_mutex!(add_disk(tagset)?, "nullb:disk"),
>> +            flags::GFP_KERNEL,
>> +        )?;
>> +
>> +        Ok(Self { _disk: disk })
>> +    }
>> +}
>> +
>> +struct NullBlkDevice;
>> +
>> +#[vtable]
>> +impl Operations for NullBlkDevice {
>> +    #[inline(always)]
>> +    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>> +        mq::Request::end_ok(rq)
>> +            .map_err(|_e| kernel::error::code::EIO)
>> +            .expect("Failed to complete request");
>
> This error would only happen if `rq` is not the only ARef to that
> request, right?

Yes, it should never happen. If it happens, something is seriously
broken and panic is adequate.

Other drivers might want to retry later or something, but in this case
it should just work.

>
>> +
>> +        Ok(())
>> +    }
>> +
>> +    fn commit_rqs() {}
>> +
>> +    fn complete(rq: ARef<mq::Request<Self>>) {
>
> Am I correct in thinking that this function is never actually called,
> since all requests that are queued are immediately ended?

Yes, re my other email. It is a callback that cannot be triggered for
now. I will move it to a later patch where it belongs.

>
>> +        mq::Request::end_ok(rq)
>> +            .map_err(|_e| kernel::error::code::EIO)
>> +            .expect("Failed to complete request")
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> index efbd2588791b..54e032bbdffd 100644
>> --- a/rust/kernel/block/mq.rs
>> +++ b/rust/kernel/block/mq.rs
>> @@ -51,6 +51,7 @@
>>  //!
>>  //! ```rust
>>  //! use kernel::{
>> +//!     alloc::flags,
>>  //!     block::mq::*,
>>  //!     new_mutex,
>>  //!     prelude::*,
>> @@ -77,7 +78,8 @@
>>  //!     }
>>  //! }
>>  //!
>> -//! let tagset: Arc<TagSet<MyBlkDevice>> = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
>> +//! let tagset: Arc<TagSet<MyBlkDevice>> =
>> +//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>
> This change should probably be in the patch before (seems like an
> artifact from rebasing).

Yes, thank you for spotting that. I thought I checked that this was
building, so this is strange to me. Maybe I failed to build the
doctests between the two patches. It is weird that kernel robot did not
pick this up. Maybe it is not building doctests?


Best regards,
Andreas
