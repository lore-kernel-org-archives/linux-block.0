Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CC23F429
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276412; cv=none; b=jsq/x2tNLgcL9s2fQYiQlt5RuL62XcCSmVoJWetbMlCMOb2OSWh3AsmzYcXW3xUxocfcYIQTno+CEF9peXfABOtNoGQqQ8KKGJHCmZtWBH1el89JfphFxrpjoVt2qmTlHbohfVRUj+S2Ql2/iRPtw1CVxStggD3ePo7LuMdcIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276412; c=relaxed/simple;
	bh=m1XkeAEKgnYB+1UGxur6dH6wOd+HzUrXUozfaL+/uQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urD/NBukgRKFMl9DFhOeSk5yVg95+4lGdi+BdzyGWxI31M8NUugSWSs3aDf8gv0bjj8WtFKnE4jah98RKwHE01xyRxkCxzs1nLdgfo+n1vq+KflLqfWHpPxHtL2d63BIAKDGvi4l6RH0u/BoQU3x4d5Zl9YIDzH3gTXrlTb4tnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acJyscNx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acJyscNx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2958db8ae4fso28431905ad.2
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762276410; x=1762881210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usbtFusXECf+ztp+zNDIhf2MMecxiC++PMfHrUtumrQ=;
        b=acJyscNx1YvB+GtAkExmVtzeAcptRjQEGsQCayEOdRuLV7/0RcbB04/pqPyiRN2XtJ
         Pcz+OmJtgJiO4CRBChWae0sdCs6iz+aN49E97+//aNQo66IBEdAEO3PuMxKUUN+aSPAm
         NCdWzX1AKD+z8Ke03KqBm4toO2t/O1c/e/L/mzcmDGeFEVW/oTwbI9ArzOHPqjZXaBVB
         gNYzPIPnD9v0XO7+goVMtBAz+yiZ1r8bzbb1LT9nf1ZE0s+ss/JQgFI/LCYrw5tG4u3t
         AI2+Jby6Z6NDC7+uG5yar0OdoEYNQ8zzAzs4TU+ifGAeMTfcb5gJ52Ly/2T5+SShxshS
         dUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276410; x=1762881210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usbtFusXECf+ztp+zNDIhf2MMecxiC++PMfHrUtumrQ=;
        b=TK6IHY4c+XDqIwow7qrXvRxWRVx5U7cWRXS7hYis4t/dFoKoQe7bi8JOhwFTXyzNVO
         4eH7HbYSl7qZPa/T9LMSRbndrlMTGZzNuYkjpehA6+qT71v2vMXxFJPseyB1KuKYaziw
         BtFgVhM1sAd97pnGEc8RpkK9C9TfLQFRo8f/u0PW+0mjGWg5jHbgLd7fKcjKxBcT25Lt
         qyY74eouhpOwh8ir8XYFQuY5j2xw8K0m0PSMqPO8MZdhAnqKg0kyGrFjjX9NDn/7TaQ/
         GJSxfnQSobrEUiwF6ggOYyzTr9dAFtw5KZS4Qd6Be53q0jtyMeWg9GYsr93FrU+qtn+v
         i2cA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6I0N1Xg1ZKCk6LHt0ff0Cu2S66g8riu/dcKGF0hEoGLR2CV0XleWscU0nb1TLCjgQwWvTJhSe0omog==@vger.kernel.org
X-Gm-Message-State: AOJu0YztvXYQKEpxNmMyQmn8HWIHHZ+YkF5XE3zkt1gvGhyYHZqdQz3G
	nBLN33tmopt0XKX3BW0+SpBlOtLdN/jObeSIfDLUUMnMGHtS4IENqmFc
X-Gm-Gg: ASbGnctHhi/qimuJrgLnKoIxg08qjsN2g0vQyiBxg9Opm4lrH3/jBEE+PXtGbeFM08l
	vCSMtj414c9LdHfBt5BfgPtcmPw0XsEgjd2xeYlQmMPoK6s57bg67i4otM3j4wvIZiNs/88LQbU
	9zscZDvc5uHjaBUJ8EUAGRbVv3Wo/zLj0mDEw08gri79ADHITkVoOUkK4QLwZxLMBuzzeAUEQfr
	iw/7yTLPqlTVToLGop/PhOAWmMyyuOCtwooCvjjTtjUhvF3el8grP3RBuQUhGR50ekPIyrWRK63
	GleohVkvOKacMCyogUP+HIpZEeAiIxeJ2sChEHruCSE4UNjws/8O/hITKoQhXtoKQzyyTbtG3B9
	EkO3clXS2FYY23OmPW61gAzOSTyiyad2gN2ZjBWg19ufwlm9+KPbP9uDlamt0170XVS3RfXgVxS
	pp6V5YFHl3eQOqcc+XhAY=
X-Google-Smtp-Source: AGHT+IHEPM6IeTHqwRglV3CNNPvXG1HRbfYSUDnDZvEYFFaMOFPrf9AoRvdMvHe2ekdTYstoOgW7Og==
X-Received: by 2002:a17:903:3bc7:b0:295:bedb:8d7 with SMTP id d9443c01a7336-2962add071cmr4121695ad.48.1762276410092;
        Tue, 04 Nov 2025 09:13:30 -0800 (PST)
Received: from shankari-IdeaPad.. ([2409:408c:9413:f347:f0d6:3544:e27:d190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019982c7sm32643875ad.25.2025.11.04.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:13:29 -0800 (PST)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re:[PATCH v2] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Tue,  4 Nov 2025 22:43:16 +0530
Message-Id: <20251104171316.6672-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012142012.166230-1-shankari.ak0208@gmail.com>
References: <20251012142012.166230-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 12, 2025 at 07:50:12PM +0530, Shankari Anand wrote:
> Update call sites in the block subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> Changelog:
> v1 -> v2:
> Rebased it on top of the latest linux-next upstream commit
> Dropped 1/7 from the subject as it might lead to confusion of it being a series
> Link of v1: https://lore.kernel.org/lkml/20250716090712.809750-1-shankari.ak0208@gmail.com/
> 
> The original patch of moving ARef and AlwaysRefCounted to sync::aref is here:
> (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  
>  drivers/block/rnull/rnull.rs       | 3 +--
>  rust/kernel/block/mq.rs            | 5 ++---
>  rust/kernel/block/mq/operations.rs | 4 ++--
>  rust/kernel/block/mq/request.rs    | 8 ++++++--
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 1ec694d7f1a6..a9d5e575a2c4 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -17,8 +17,7 @@
>      error::Result,
>      pr_info,
>      prelude::*,
> -    sync::Arc,
> -    types::ARef,
> +    sync::{aref::ARef, Arc},
>  };
>  use pin_init::PinInit;
>  
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index 637018ead0ab..1fd0d54dd549 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -20,7 +20,7 @@
>  //! The kernel will interface with the block device driver by calling the method
>  //! implementations of the `Operations` trait.
>  //!
> -//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
> +//! IO requests are passed to the driver as [`kernel::sync::aref::ARef<Request>`]
>  //! instances. The `Request` type is a wrapper around the C `struct request`.
>  //! The driver must mark end of processing by calling one of the
>  //! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
> @@ -61,8 +61,7 @@
>  //!     block::mq::*,
>  //!     new_mutex,
>  //!     prelude::*,
> -//!     sync::{Arc, Mutex},
> -//!     types::{ARef, ForeignOwnable},
> +//!     sync::{aref::ARef, Arc, Mutex},
>  //! };
>  //!
>  //! struct MyBlkDevice;
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index f91a1719886c..8ad46129a52c 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -9,8 +9,8 @@
>      block::mq::{request::RequestDataWrapper, Request},
>      error::{from_result, Result},
>      prelude::*,
> -    sync::Refcount,
> -    types::{ARef, ForeignOwnable},
> +    sync::{aref::ARef, Refcount},
> +    types::ForeignOwnable,
>  };
>  use core::marker::PhantomData;
>  
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index c5f1f6b1ccfb..ce3e30c81cb5 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -8,8 +8,12 @@
>      bindings,
>      block::mq::Operations,
>      error::Result,
> -    sync::{atomic::Relaxed, Refcount},
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    sync::{
> +        aref::{ARef, AlwaysRefCounted},
> +        atomic::Relaxed,
> +        Refcount,
> +    },
> +    types::Opaque,
>  };
>  use core::{marker::PhantomData, ptr::NonNull};
> 
> base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae 
> -- 
> 2.34.1
> 
Hello, can this patch be reviewed?

Thanks,
Shankari
