Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73046248861;
	Wed, 20 May 2026 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245978; cv=none; b=Mg2hJBHFxC//YO1mG2HJ52ceoXySdqX7oMgNsuGPDvbSuJZD35v0JUh8DLDvp/kjyY/cAPzmHDHDy+VfFCcqLuV+c4LTpRMzPeBiug1IFhrfS02pdqtJvZ3DWwO/bg3PT328mCFtQJcVf0Tm2KoQtDLUyoWmADJ6XSXHYaxhqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245978; c=relaxed/simple;
	bh=OhxPlsHFS3WkHVFvDkktyvaP2WqfHmWGXiPxNfdae8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/lg8is5Fcjg2us5ooGXKhb0cPrXFNUGHcXZYQBiQM7So2Bfle4ZuqK1SI0uAGoEuh07IBkH6EkwqVaNDLAhtUGBhKrTXkBb6H5OPIF5UYf2LDcVvUfCLgbhDoJUmunFNsw+QvsEf6nITVfgm/5+tgbO6dYSGkkukWe8K+hvbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=dGJUZoRO; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dGJUZoRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779245967; x=1779505167;
	bh=rp3fOUjmeAJUrxkgd76ciW0ALtSAYMyZqh+1GyS7/5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dGJUZoROHW+EIvo6ugxMZIXbDut/iSK/NE2RgVJQuJW1tS4/2NORTMhXOeaxNZ8jQ
	 m2iVzkxhbDOiaApvBR0eaOwffqY4vUi9mYZ+FeQtdu0D2o9LmSR2/jIBDMinIEhOoE
	 /DnWTqh6H/ehuH8ZIoyl0Dp5K6VWiqAtFdK72dpUXQmN5mdOg0hf6yh3wgbwPbO31A
	 gAvMbC/mHf7FRiV1gYNY+s+o3bHLR/KKZNWMQswSsQYAzbYUV4Vvdj8uc0uUatsA8Z
	 voAyzfKwVkz9l5UTeyoF+4P2mh6WUQ7wv0fv+0mswKkZn1L1u4oED+ovsXDcaGgVuq
	 phWYPhpHchAhA==
X-Pm-Submission-Id: 4gKx8X0GQRz1DDXM
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
Subject: Re: [PATCH v2 4/5] rust: block: mq: use vertical import style
Date: Wed, 20 May 2026 05:59:20 +0300
Message-ID: <20260520025922.35078-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev> <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 10:40:11 +0800=0D
Alvin Sun <alvin.sun@linux.dev> wrote:=0D
=0D
> Convert `use` imports to vertical layout for better readability and=0D
> maintainability.=0D
> =0D
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/block/mq/gen_disk.rs   | 21 +++++++++++++++++----=0D
>  rust/kernel/block/mq/operations.rs | 17 +++++++++++++----=0D
>  rust/kernel/block/mq/request.rs    | 12 +++++++++---=0D
>  rust/kernel/block/mq/tag_set.rs    | 24 +++++++++++++++++++-----=0D
>  4 files changed, 58 insertions(+), 16 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs=0D
> index 912cb805caf51..6f599f654f37f 100644=0D
> --- a/rust/kernel/block/mq/gen_disk.rs=0D
> +++ b/rust/kernel/block/mq/gen_disk.rs=0D
> @@ -7,14 +7,27 @@=0D
>  =0D
>  use crate::{=0D
>      bindings,=0D
> -    block::mq::{Operations, TagSet},=0D
> -    error::{self, from_err_ptr, Result},=0D
> -    fmt::{self, Write},=0D
> +    block::mq::{=0D
> +        Operations,=0D
> +        TagSet, //=0D
> +    },=0D
> +    error::{=0D
> +        self,=0D
> +        from_err_ptr,=0D
> +        Result, //=0D
> +    },=0D
> +    fmt::{=0D
> +        self,=0D
> +        Write, //=0D
> +    },=0D
>      prelude::*,=0D
>      static_lock_class,=0D
>      str::NullTerminatedFormatter,=0D
>      sync::Arc,=0D
> -    types::{ForeignOwnable, ScopeGuard},=0D
> +    types::{=0D
> +        ForeignOwnable,=0D
> +        ScopeGuard, //=0D
> +    },=0D
>  };=0D
>  =0D
>  /// A builder for [`GenDisk`].=0D
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/op=
erations.rs=0D
> index 8ad46129a52c4..187b0b7791db9 100644=0D
> --- a/rust/kernel/block/mq/operations.rs=0D
> +++ b/rust/kernel/block/mq/operations.rs=0D
> @@ -6,11 +6,20 @@=0D
>  =0D
>  use crate::{=0D
>      bindings,=0D
> -    block::mq::{request::RequestDataWrapper, Request},=0D
> -    error::{from_result, Result},=0D
> +    block::mq::{=0D
> +        request::RequestDataWrapper,=0D
> +        Request, //=0D
> +    },=0D
> +    error::{=0D
> +        from_result,=0D
> +        Result, //=0D
> +    },=0D
>      prelude::*,=0D
> -    sync::{aref::ARef, Refcount},=0D
> -    types::ForeignOwnable,=0D
> +    sync::{=0D
> +        aref::ARef,=0D
> +        Refcount, //=0D
> +    },=0D
> +    types::ForeignOwnable, //=0D
>  };=0D
>  use core::marker::PhantomData;=0D
>  =0D
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs=0D
> index ce3e30c81cb5e..4e0579660e906 100644=0D
> --- a/rust/kernel/block/mq/request.rs=0D
> +++ b/rust/kernel/block/mq/request.rs=0D
> @@ -9,13 +9,19 @@=0D
>      block::mq::Operations,=0D
>      error::Result,=0D
>      sync::{=0D
> -        aref::{ARef, AlwaysRefCounted},=0D
> +        aref::{=0D
> +            ARef,=0D
> +            AlwaysRefCounted, //=0D
> +        },=0D
>          atomic::Relaxed,=0D
> -        Refcount,=0D
> +        Refcount, //=0D
>      },=0D
>      types::Opaque,=0D
>  };=0D
> -use core::{marker::PhantomData, ptr::NonNull};=0D
> +use core::{=0D
> +    marker::PhantomData,=0D
> +    ptr::NonNull, //=0D
> +};=0D
>  =0D
>  /// A wrapper around a blk-mq [`struct request`]. This represents an IO =
request.=0D
>  ///=0D
> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_s=
et.rs=0D
> index dae9df408a862..c1fd3e047af50 100644=0D
> --- a/rust/kernel/block/mq/tag_set.rs=0D
> +++ b/rust/kernel/block/mq/tag_set.rs=0D
> @@ -8,13 +8,27 @@=0D
>  =0D
>  use crate::{=0D
>      bindings,=0D
> -    block::mq::{operations::OperationsVTable, request::RequestDataWrappe=
r, Operations},=0D
> -    error::{self, Result},=0D
> +    block::mq::{=0D
> +        operations::OperationsVTable,=0D
> +        request::RequestDataWrapper,=0D
> +        Operations, //=0D
> +    },=0D
> +    error::{=0D
> +        self,=0D
> +        Result, //=0D
> +    },=0D
>      prelude::try_pin_init,=0D
> -    types::Opaque,=0D
> +    types::Opaque, //=0D
> +};=0D
> +use core::{=0D
> +    convert::TryInto,=0D
> +    marker::PhantomData, //=0D
> +};=0D
> +use pin_init::{=0D
> +    pin_data,=0D
> +    pinned_drop,=0D
> +    PinInit, //=0D
>  };=0D
> -use core::{convert::TryInto, marker::PhantomData};=0D
> -use pin_init::{pin_data, pinned_drop, PinInit};=0D
>  =0D
>  /// A wrapper for the C `struct blk_mq_tag_set`.=0D
>  ///=0D
> =0D
> -- =0D
> 2.43.0=0D
> =0D
> =0D
