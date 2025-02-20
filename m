Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB42641C2;
	Thu, 20 Feb 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079133; cv=none; b=VURyDzIjPksblULk2fKcpJVMNcdljW/IwSC34v/EKS+NZ85ca8BQ0ENaDHgglb7QpmPd2qBT3OVI5h3F8MS1w7+hQpB4q3vnXfhXuZyqsqDfDVOo4AuxbJY6QJDLGxQdt4FXEh9SFWLucL91384kGpb+Ij81AgbefRnWt7GyKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079133; c=relaxed/simple;
	bh=4d1KNIx+INvlRFOF2ii16MQOHOzRY+Sq2mlvYHJFWXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=maPzpqCUNJlsUpmOLMceq+aFmpQZPsZZm9Lj3Nqn6rJbXZG1uiIzNf74wel+PktLxQh2wsNkxURa3FT45Fi8Abdo0vYLnObBPkqYfgpMMiHlxc66BmPMcQDK6mzjugvRz2AICpWTRs5/JSxUxbgpSeBDIHFO71i3SPVgcB90rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsnlYSb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsnlYSb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43AEC4CED6;
	Thu, 20 Feb 2025 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740079132;
	bh=4d1KNIx+INvlRFOF2ii16MQOHOzRY+Sq2mlvYHJFWXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YsnlYSb63skk/fWlHJtmIfHJag4qUEnaxKf53MBGT67M9wYVeRLnpj5qniNRURqgl
	 SgJDds7mUqBUsVOb22i9WI7MIK3EzSaSMvYgsBIh2u7hpvN2pauxVs3zWnMqxEJxnW
	 Udp4wxHheMO0dg9qjGe+WkKaB+NhDLsfTpGv/dLuDwIk1XjN48XywcU/cTIaAg3/im
	 dwqLYVWGz7mb5+Ma587cAwV6D4RavsJzBGsbvNRH+RTdPYSmlKVgEuGr3nA8vOg4ym
	 WGvuPg+2dcCd3DpxFNs2zyxbtF0Wac+ZF+tWN3Sa9/waj+0BDW3pMIcwQlKGGySP3o
	 9IXQaLGAEHWQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Gary Guo <gary@garyguo.net>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,  Trevor
 Gross <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,  Will
 Deacon <will@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Mark
 Rutland <mark.rutland@arm.com>,  Jens Axboe <axboe@kernel.dk>,  Francesco
 Zardi <frazar00@gmail.com>,  rust-for-linux@vger.kernel.org,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <CAJ-ks9mEqo72Cwq5_BMtdLPjGSb_sQbm_p+TV_u=iNuYSnuPKQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Wed, 19 Feb 2025 17:53:43 -0500")
References: <20250219201602.1898383-1-gary@garyguo.net>
	<20250219201602.1898383-4-gary@garyguo.net>
	<CAJ-ks9=10h9ha403aqL20Yk+y0oXpgvR=hbxA2+6T_CvbXN2bA@mail.gmail.com>
	<CAJ-ks9mEqo72Cwq5_BMtdLPjGSb_sQbm_p+TV_u=iNuYSnuPKQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 20 Feb 2025 20:18:37 +0100
Message-ID: <8734g8ifw2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tamir Duberstein <tamird@gmail.com> writes:

> On Wed, Feb 19, 2025 at 5:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrot=
e:
>> >
>> > Currently there's a custom reference counting in `block::mq`, which us=
es
>> > `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
>> > architectures. We cannot just change it to use 32-bit atomics, because
>> > doing so will make it vulnerable to refcount overflow. So switch it to
>> > use the kernel refcount `kernel::sync::Refcount` instead.
>> >
>> > There is an operation needed by `block::mq`, atomically decreasing
>> > refcount from 2 to 0, which is not available through refcount.h, so
>> > I exposed `Refcount::as_atomic` which allows accessing the refcount
>> > directly.
>> >
>> > Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>> > Signed-off-by: Gary Guo <gary@garyguo.net>
>> > ---
>> >  rust/kernel/block/mq/operations.rs |  7 +--
>> >  rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
>> >  rust/kernel/sync/refcount.rs       | 14 ++++++
>> >  3 files changed, 40 insertions(+), 51 deletions(-)
>> >
>> > diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq=
/operations.rs
>> > index 864ff379dc91..c399dcaa6740 100644
>> > --- a/rust/kernel/block/mq/operations.rs
>> > +++ b/rust/kernel/block/mq/operations.rs
>> > @@ -10,9 +10,10 @@
>> >      block::mq::Request,
>> >      error::{from_result, Result},
>> >      prelude::*,
>> > +    sync::Refcount,
>> >      types::ARef,
>> >  };
>> > -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic=
::Ordering};
>> > +use core::marker::PhantomData;
>> >
>> >  /// Implement this trait to interface blk-mq as block devices.
>> >  ///
>> > @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>> >          let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
>> >
>> >          // One refcount for the ARef, one for being in flight
>> > -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
>> > +        request.wrapper_ref().refcount().set(2);
>> >
>> >          // SAFETY:
>> >          //  - We own a refcount that we took above. We pass that to `=
ARef`.
>> > @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
>> >
>> >              // SAFETY: The refcount field is allocated but not initia=
lized, so
>> >              // it is valid for writes.
>> > -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).w=
rite(AtomicU64::new(0)) };
>> > +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).w=
rite(Refcount::new(0)) };
>>
>> Could we just make the field pub and remove refcount_ptr? I believe a
>> few callers of `wrapper_ptr` could be replaced with `wrapper_ref`.
>
> I took a stab at this to check it was possible:
> https://gist.github.com/tamird/c9de7fa6e54529996f433950268f3f87

The access method uses a raw pointer because it is not always safe to
reference the field.

I think line 25 in your patch is UB as the field is not initialized.

At any rate, such a change is orthogonal. You could submit a separate
patch with that refactor.


Best regards,
Andreas Hindborg



