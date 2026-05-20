Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654852FFFA5
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245993; cv=none; b=QARgq30uEE93nIrmz+FZHcwdZWKD0WZTq2Ge3MOKdMlxn0mSylrqId4kJkX6d4e58Qyf3Q1IBiX84+oK758U8hVx8tkdnCVsFUs48jpBCPG6EQAoG/4jJ7r6Cq70gsohUKnh718ljp30rwuuhyGmm2gK+bNLzPDWy7gNWRso52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245993; c=relaxed/simple;
	bh=ndq7djO5Vz9L5XMUHKZft0Mlsh4PvKioYaIJspTeF8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4oNv1qgXIt20Qdh74WqQymOzBlQqA1zBn6u576iFluObzHMGW/T/Q3pjagorxl+DFUeYaU7o8EWgob/nIPMgrCslb1LKURoXEPRS9qveF7f1eCBkJ2S+Ob9AkThV538Ura1mLJZT2osTnIGIhdw7Q+j3+wvcg7gO/IEUgz5Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=awDWTzVG; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="awDWTzVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779245984; x=1779505184;
	bh=5D0Ta5NjIvVby0FlgcU2krulv3FIHt6oByCRoo/rrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=awDWTzVGhJzx1jt5myiYzTG/0BiTXxHhEp1SapLeNsuyy/a/pqTj6djhrJU0JuGSZ
	 bnjJidREl315D/Ktkqcwz4EnkHp1XypL17mJzUqjFKiaEMYisSB/Zd9/clDg1sx6vA
	 j+TBajWWzaRHJL2kVkuJYz2K9LOLmnHhEJ9hSVPFw38E6ye4wg4YOQREWb7v6q/u5v
	 jbxuV090DibIu1sMJTuE2Hsovrr0zkiqiqinSIs5dZaWUKVETloqpucUObzKqAyZlO
	 YWC8cMXgPkEcs8rDthpdKoU9j7SDxrrEumbdVFcArG64qLnel9CV7as0icQlFfqBr7
	 OGDYGag2yAevQ==
X-Pm-Submission-Id: 4gKx8t0H96z2Scq8
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2 5/5] rust: block: mq: remove redundant imports and format
Date: Wed, 20 May 2026 05:59:39 +0300
Message-ID: <20260520025941.35532-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520-miscdev-use-format-v2-5-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev> <20260520-miscdev-use-format-v2-5-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 10:40:12 +0800=0D
Alvin Sun <alvin.sun@linux.dev> wrote:=0D
=0D
> Drop `Result`, `Pin`, `pin_data`, `pinned_drop`, `PinInit`, and=0D
> `try_pin_init` imports already provided by `kernel::prelude`.=0D
> =0D
> Simplify `error` imports and flatten parameters formatting.=0D
> =0D
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/block/mq/gen_disk.rs   |  7 +++----=0D
>  rust/kernel/block/mq/operations.rs |  5 +----=0D
>  rust/kernel/block/mq/request.rs    |  2 +-=0D
>  rust/kernel/block/mq/tag_set.rs    | 22 ++++------------------=0D
>  4 files changed, 9 insertions(+), 27 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs=0D
> index 6f599f654f37f..a2c45bde75a7c 100644=0D
> --- a/rust/kernel/block/mq/gen_disk.rs=0D
> +++ b/rust/kernel/block/mq/gen_disk.rs=0D
> @@ -12,9 +12,8 @@=0D
>          TagSet, //=0D
>      },=0D
>      error::{=0D
> -        self,=0D
>          from_err_ptr,=0D
> -        Result, //=0D
> +        to_result, //=0D
>      },=0D
>      fmt::{=0D
>          self,=0D
> @@ -67,7 +66,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {=
=0D
>      /// and that it is a power of two.=0D
>      pub fn validate_block_size(size: u32) -> Result {=0D
>          if !(512..=3Dbindings::PAGE_SIZE as u32).contains(&size) || !siz=
e.is_power_of_two() {=0D
> -            Err(error::code::EINVAL)=0D
> +            Err(EINVAL)=0D
>          } else {=0D
>              Ok(())=0D
>          }=0D
> @@ -177,7 +176,7 @@ pub fn build<T: Operations>(=0D
>          // operation, so we will not race.=0D
>          unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) =
};=0D
>  =0D
> -        crate::error::to_result(=0D
> +        to_result(=0D
>              // SAFETY: `gendisk` points to a valid and initialized insta=
nce of=0D
>              // `struct gendisk`.=0D
>              unsafe {=0D
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/op=
erations.rs=0D
> index 187b0b7791db9..0343069b373c7 100644=0D
> --- a/rust/kernel/block/mq/operations.rs=0D
> +++ b/rust/kernel/block/mq/operations.rs=0D
> @@ -10,10 +10,7 @@=0D
>          request::RequestDataWrapper,=0D
>          Request, //=0D
>      },=0D
> -    error::{=0D
> -        from_result,=0D
> -        Result, //=0D
> -    },=0D
> +    error::from_result,=0D
>      prelude::*,=0D
>      sync::{=0D
>          aref::ARef,=0D
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs=0D
> index 4e0579660e906..d10fb7627c870 100644=0D
> --- a/rust/kernel/block/mq/request.rs=0D
> +++ b/rust/kernel/block/mq/request.rs=0D
> @@ -7,7 +7,7 @@=0D
>  use crate::{=0D
>      bindings,=0D
>      block::mq::Operations,=0D
> -    error::Result,=0D
> +    prelude::*,=0D
>      sync::{=0D
>          aref::{=0D
>              ARef,=0D
> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_s=
et.rs=0D
> index c1fd3e047af50..df3f90bfbb817 100644=0D
> --- a/rust/kernel/block/mq/tag_set.rs=0D
> +++ b/rust/kernel/block/mq/tag_set.rs=0D
> @@ -4,8 +4,6 @@=0D
>  //!=0D
>  //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)=
=0D
>  =0D
> -use core::pin::Pin;=0D
> -=0D
>  use crate::{=0D
>      bindings,=0D
>      block::mq::{=0D
> @@ -13,22 +11,14 @@=0D
>          request::RequestDataWrapper,=0D
>          Operations, //=0D
>      },=0D
> -    error::{=0D
> -        self,=0D
> -        Result, //=0D
> -    },=0D
> -    prelude::try_pin_init,=0D
> +    error::to_result,=0D
> +    prelude::*,=0D
>      types::Opaque, //=0D
>  };=0D
>  use core::{=0D
>      convert::TryInto,=0D
>      marker::PhantomData, //=0D
>  };=0D
> -use pin_init::{=0D
> -    pin_data,=0D
> -    pinned_drop,=0D
> -    PinInit, //=0D
> -};=0D
>  =0D
>  /// A wrapper for the C `struct blk_mq_tag_set`.=0D
>  ///=0D
> @@ -47,11 +37,7 @@ pub struct TagSet<T: Operations> {=0D
>  =0D
>  impl<T: Operations> TagSet<T> {=0D
>      /// Try to create a new tag set=0D
> -    pub fn new(=0D
> -        nr_hw_queues: u32,=0D
> -        num_tags: u32,=0D
> -        num_maps: u32,=0D
> -    ) -> impl PinInit<Self, error::Error> {=0D
> +    pub fn new(nr_hw_queues: u32, num_tags: u32, num_maps: u32) -> impl =
PinInit<Self, Error> {=0D
>          let tag_set: bindings::blk_mq_tag_set =3D pin_init::zeroed();=0D
>          let tag_set: Result<_> =3D core::mem::size_of::<RequestDataWrapp=
er>()=0D
>              .try_into()=0D
> @@ -77,7 +63,7 @@ pub fn new(=0D
>                  // SAFETY: we do not move out of `tag_set`.=0D
>                  let tag_set: &mut Opaque<_> =3D unsafe { Pin::get_unchec=
ked_mut(tag_set) };=0D
>                  // SAFETY: `tag_set` is a reference to an initialized `b=
lk_mq_tag_set`.=0D
> -                error::to_result( unsafe { bindings::blk_mq_alloc_tag_se=
t(tag_set.get())})=0D
> +                to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_s=
et.get())})=0D
>              }),=0D
>              _p: PhantomData,=0D
>          })=0D
> =0D
> -- =0D
> 2.43.0=0D
> =0D
> =0D
