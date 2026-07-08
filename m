Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DD3EF0C9;
	Wed,  8 Jul 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496466; cv=none; b=Oky8FKPFHFom1888qQJIPW/T1Q1slcl2Cngr0gEuLg/oWHWdZAZBhnK9p8xue4SLyK/6OWOpLSUVwqnYAM/fL1W6kouroe/tC4g66seB1ajW/MylqbIhnV68EsD2zX/AeWcF3igzow4KjDtliRb+4lbzyslZBI191iszS3Q1bIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496466; c=relaxed/simple;
	bh=kQi3t//9JIKO0BDRcuw6+XDGAmEoWle1uAhS6hLB43M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAIAKWpmDo1gO4LOKkMUnXS2XSlXIqunCLV+f5gZdUed6MmVzx78XXNpQ5A/fNY+Dqb7I7FVnfs80jMXx5oAnJM10cu6n0DhiEmY4frU7k4xnbG1NCxFW3/iyszX4g/QgbO8AR6TfI2WYhAlJCaVU2VRi9K1QYjmyCSs45asTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 40BC0F40B7A; Wed, 08 Jul 2026 09:40:45 +0200 (CEST)
Date: Wed, 8 Jul 2026 09:40:45 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] block: rnull: use vertical import style
Message-ID: <ak3-_Y0p1D7YnitH@luna>
References: <20260705-rfl-vert-imp-2-v1-1-e6ab69c55095@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-rfl-vert-imp-2-v1-1-e6ab69c55095@gurudas.dev>
Jabber-ID: linkmauve@linkmauve.fr

On Sun, Jul 05, 2026 at 06:36:48PM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>

This one is:
Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>

Thanks!

> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Separating out patches per-subsystem as per the review feedback in [0].
> 
> Tested via:
> 
> 	$ make LLVM=1 rustfmtcheck || echo "fail"
> 	$
> 
> Initially thought that rust-for-linux/rust-block-next was the right base
> branch to use, which is why I didn't group this with [1] based on
> rust-next that I sent out a short while ago. Using rust-next as base for
> this patch.
> 
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> [1]: https://lore.kernel.org/lkml/20260705-rfl-vert-imp-v1-1-2f07946a905f@gurudas.dev/
> ---
>  drivers/block/rnull/configfs.rs | 25 ++++++++++++++++++++-----
>  drivers/block/rnull/rnull.rs    | 13 ++++++++++---
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> index 7c2eb5c0b722..2149b47db697 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -1,15 +1,30 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use super::{NullBlkDevice, THIS_MODULE};
> +use super::{
> +    NullBlkDevice,
> +    THIS_MODULE, //
> +};
>  use kernel::{
> -    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> -    configfs::{self, AttributeOperations},
> +    block::mq::gen_disk::{
> +        GenDisk,
> +        GenDiskBuilder, //
> +    },
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
> +    str::{
> +        kstrtobool_bytes,
> +        CString, //
> +    },
>      sync::Mutex,
>  };
>  
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 0ca8715febe8..d58d2c4c5f63 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -10,12 +10,19 @@
>          self,
>          mq::{
>              self,
> -            gen_disk::{self, GenDisk},
> -            Operations, TagSet,
> +            gen_disk::{
> +                self,
> +                GenDisk, //
> +            },
> +            Operations,
> +            TagSet, //
>          },
>      },
>      prelude::*,
> -    sync::{aref::ARef, Arc},
> +    sync::{
> +        aref::ARef,
> +        Arc, //
> +    },
>  };
>  
>  module! {
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260705-rfl-vert-imp-2-9bba7706d3f0
> 
> Best regards,
> --  
> Guru Das Srinagesh <linux@gurudas.dev>
> 
> 

-- 
Link Mauve
