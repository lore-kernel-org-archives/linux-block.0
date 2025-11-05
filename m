Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19848333452;
	Wed,  5 Nov 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375050; cv=none; b=IVL1KT7AiPE+2FSh7rRJlz/GdJSxl7ItuUgK8i+WZJdeQsWnX4D4ka8s1cpZlezgikbjj1CAyHHvufCityMsYJN2Uji+sn9lR9AgD46L1nr3ANCw+zMVuXiRtzEGxVNnRz68NwnMqtYTwoETMahyq2CbELpc8rfQCrccRmEx5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375050; c=relaxed/simple;
	bh=UTReFefAF+6gXiQ2Z4l2YL1BSXnOxNYuKlBMTtxjWIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMJbRKoBfog4zAy9ix2YpQq8dQeip5c34lZmj6Q7mK8oAS/aS8mS35Rj2RGU4T8chAja9MeRerPhZmqFR6IoyaQ0QyEYC3Z8Qq04veVsb7D9jL7OM8tg6CtM4HMGzxFslLkzHluYPx4kkWU3pbk0QdL9FlaZQPdFnXWQTivnu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVCDzFWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVCDzFWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB13C4CEF5;
	Wed,  5 Nov 2025 20:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762375049;
	bh=UTReFefAF+6gXiQ2Z4l2YL1BSXnOxNYuKlBMTtxjWIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HVCDzFWsS3mRiRwZ9n4zO6J8K02zYN0I+IDaIP/Qz2UQK1klAzX7Nql2a+Lq88N9S
	 1QIAM8LMu7LN4W3ABBVxdIFeN4eP3A5H7zln5NUyCTdJdhtcJEFCzoAzjXkqNvlNZy
	 zBGQW3SUx1QyIwIF4KPwQlGCYHquKyutKQr1CkQRqE+ETagIJLGGt2kfh+f39GN8qZ
	 4tZaPXQTIymYqgRNXKvJYKFNVcc+H8u1atTD5WUN3YZlRMiH9cVCYzOj4oF/+u6N4m
	 qd2tvSpxS5PDZ4df5JxMXxxQ21LeK45fJChPRSdQXeJggqljFmafCalkdLc9Ec6DXG
	 6N4AgiuUUz45A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Shankari Anand <shankari.ak0208@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Shankari
 Anand <shankari.ak0208@gmail.com>
Subject: Re:[PATCH v2] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
In-Reply-To: <20251104171316.6672-1-shankari.ak0208@gmail.com>
References: <20251012142012.166230-1-shankari.ak0208@gmail.com>
 <2EAsrR9pInr4r9ZEowYQNdH4LHuonKsTkjkqwn36aqxjRO7jOAlYZOaWyRzgdl-YU_bxzR50-VFWQHwcl479iA==@protonmail.internalid>
 <20251104171316.6672-1-shankari.ak0208@gmail.com>
Date: Wed, 05 Nov 2025 21:37:19 +0100
Message-ID: <87tsz86wsg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shankari Anand" <shankari.ak0208@gmail.com> writes:

> On Sun, Oct 12, 2025 at 07:50:12PM +0530, Shankari Anand wrote:
>> Update call sites in the block subsystem to import `ARef` and
>> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>>
>> This aligns with the ongoing effort to move `ARef` and
>> `AlwaysRefCounted` to sync.
>>
>> Suggested-by: Benno Lossin <lossin@kernel.org>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1173
>> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
>> ---
>> Changelog:
>> v1 -> v2:
>> Rebased it on top of the latest linux-next upstream commit
>> Dropped 1/7 from the subject as it might lead to confusion of it being a series
>> Link of v1: https://lore.kernel.org/lkml/20250716090712.809750-1-shankari.ak0208@gmail.com/
>>
>> The original patch of moving ARef and AlwaysRefCounted to sync::aref is here:
>> (commit 07dad44aa9a93)
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
>>
>>
>> Gradually the re-export from types.rs will be eliminated in the
>> future cycle.
>> ---
>>
>>  drivers/block/rnull/rnull.rs       | 3 +--
>>  rust/kernel/block/mq.rs            | 5 ++---
>>  rust/kernel/block/mq/operations.rs | 4 ++--
>>  rust/kernel/block/mq/request.rs    | 8 ++++++--
>>  4 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
>> index 1ec694d7f1a6..a9d5e575a2c4 100644
>> --- a/drivers/block/rnull/rnull.rs
>> +++ b/drivers/block/rnull/rnull.rs
>> @@ -17,8 +17,7 @@
>>      error::Result,
>>      pr_info,
>>      prelude::*,
>> -    sync::Arc,
>> -    types::ARef,
>> +    sync::{aref::ARef, Arc},
>>  };
>>  use pin_init::PinInit;
>>
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> index 637018ead0ab..1fd0d54dd549 100644
>> --- a/rust/kernel/block/mq.rs
>> +++ b/rust/kernel/block/mq.rs
>> @@ -20,7 +20,7 @@
>>  //! The kernel will interface with the block device driver by calling the method
>>  //! implementations of the `Operations` trait.
>>  //!
>> -//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
>> +//! IO requests are passed to the driver as [`kernel::sync::aref::ARef<Request>`]
>>  //! instances. The `Request` type is a wrapper around the C `struct request`.
>>  //! The driver must mark end of processing by calling one of the
>>  //! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
>> @@ -61,8 +61,7 @@
>>  //!     block::mq::*,
>>  //!     new_mutex,
>>  //!     prelude::*,
>> -//!     sync::{Arc, Mutex},
>> -//!     types::{ARef, ForeignOwnable},
>> +//!     sync::{aref::ARef, Arc, Mutex},
>>  //! };
>>  //!
>>  //! struct MyBlkDevice;
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
>> index f91a1719886c..8ad46129a52c 100644
>> --- a/rust/kernel/block/mq/operations.rs
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -9,8 +9,8 @@
>>      block::mq::{request::RequestDataWrapper, Request},
>>      error::{from_result, Result},
>>      prelude::*,
>> -    sync::Refcount,
>> -    types::{ARef, ForeignOwnable},
>> +    sync::{aref::ARef, Refcount},
>> +    types::ForeignOwnable,
>>  };
>>  use core::marker::PhantomData;
>>
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
>> index c5f1f6b1ccfb..ce3e30c81cb5 100644
>> --- a/rust/kernel/block/mq/request.rs
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -8,8 +8,12 @@
>>      bindings,
>>      block::mq::Operations,
>>      error::Result,
>> -    sync::{atomic::Relaxed, Refcount},
>> -    types::{ARef, AlwaysRefCounted, Opaque},
>> +    sync::{
>> +        aref::{ARef, AlwaysRefCounted},
>> +        atomic::Relaxed,
>> +        Refcount,
>> +    },
>> +    types::Opaque,
>>  };
>>  use core::{marker::PhantomData, ptr::NonNull};
>>
>> base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
>> --
>> 2.34.1
>>
> Hello, can this patch be reviewed?

I think I already ACK'ed this patch [1]. I can't apply patches for
block. Jens or Miguel should apply this.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/87cy965edf.fsf@kernel.org

