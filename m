Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50701304BCD
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557216; cv=none; b=pTfviFkIbk4gGZsliVhB5DQbenuZc9uFsZrt1b2H2p+c1EJ05GslxwTAHQEYspsqiwIc4l4Dd/AAks78a1FEP9Oq4qnrfeAN7edlpEiENG40KkZAy/a1XV47TYj+El92ybygl3C4ITNlWR4T9eJzF+J3qPcRTmy8Tb1bsJSOIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557216; c=relaxed/simple;
	bh=+kjcilcNnl42PP01ue6qyMU4wvoCvOkJFn4w3QhQiE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/84caVdlW8hLubefQoLvR0GDaXK18SrOP99M1z+VYUCTYytFf7N51sqlKELwgO3ryNLdNv9aApt+MFRB3Ri/L0MmMeVHraGaciUEuvFGBq++A34pro+XfFYi8SFOBzKj0CF76hXlR6FvbKfhFrYpddzNk1HPnJEKHezAjyvKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCBv+Gud; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCBv+Gud"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so2914a12.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760557212; x=1761162012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n8UZ7d2MXJ0mooKHeN+kYs3Duy/o2bf41dETvsjc+Y=;
        b=hCBv+GudA8Kjk8kAVhntF6p5TOViFuMZ145Y4yhVaalaoco6Y0KyR5Ev2eQaD1eAWf
         GXJdkVh9DgfuPzcPS596VQ+0Eaw3KP0zvsWbhEN3FhTDvz/Rc01Zzx43jaSLMNdI774n
         sA0wCO3hV5wLfac1NC2fwfgJcbQjbKUOwFjNhYw7U1oNt/EZ26jubdtkoNBJOaXy2tTq
         94VSW7yLel3ju3b53wwvKJkb5BHpPka9dOAzHNPGo1FM+epnXW+0R16mzDJdu7bW2ojS
         Xp7VqjRVTa0nI0NpNqLsF71RR+Je/q9G1Yx+IggRmVgExoOPNo1/Wp4uE4vxTguzIZZt
         TfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557212; x=1761162012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n8UZ7d2MXJ0mooKHeN+kYs3Duy/o2bf41dETvsjc+Y=;
        b=TWaKPcwcDe7IK3/+gVHAiRNBh+X1Bfo6GTjL/zgk8Vyna+jqcDuXNsf0brIOoHdltY
         WXRxHRMg03hnTO7D+AGcYmHs0l2/kdeUwdnqJ1G75Em//kSxrHMbVThXP9LlEmLmlDPf
         NrP9wj2BqnS5mJA6spo68q3/mwcAAiggVZUDBmP0le/ah4U9BNM/HAT4ya67B0Kq1t6U
         +pTMFjytsXYyCzGlheB0pU0c/wl1hFm3skBtN7ogtRhwfhBc31XkNlvOeYNssHsU/l9b
         dxM+MmnMRrvM9guvVQlfNZ9gF7LCfV3C7nKa84bbPwf2JOjfZ0TPzQnssnwggeLsONKz
         Gp0A==
X-Forwarded-Encrypted: i=1; AJvYcCWiK23uQLcLTdHZ7uP/froOfHytfeaY5NKnuPHFqihIrPb7jqlWR6OCWrRWCJTeIuU/+Sjw5kJ531X2QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKySlrU93vgPijO1mNKBONDnLF5blXXt15a2OBFz8vOAixaJ9
	4QB+I+eVdoNEv1WOVgJoQQF1otyqhL+USzxYbuXNIQTkyOu+VvyNCYLOgJRc4BZv1nuE+cRcvW0
	PZ22xLmeg843fZAwFYRMlQ7p7RSegpzsuLR2PdREr
X-Gm-Gg: ASbGncuz1xFTl4zD7rM7IrXIKGAXmExDvPoZSqu2akPrcOdl+vjMdRMerU8/KiJ70AS
	xKtOsAXdceZoecYLa6NI+DNjA8u605Rwby80oL2D07teYLmtRldgldDjdz/gj3bKdqMgXBYy2Fl
	qRDTOCgpFTkg84BQxs4a4LUDyr+QOHJUqUXcMNlfEh7dUNf1p8TALtCb4U30mimEgZ77bjF/Y0g
	hjxdxpFh2BgMGrD2l/NG+f+Uhd5TBr3IrfjRBYzkiIyt16GPSt8HbFhdg8P2mBsGHW1WLvZtQ==
X-Google-Smtp-Source: AGHT+IH1hNKXb4/pUf1qyCZudGyGSw9NF8uf8Lrdu7RzgqVV4GV74DwVE6/60XlICJ44BkpiAsKuFWJqqSWZYx9QXyA=
X-Received: by 2002:a05:6402:3246:20b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-63bebfa2921mr171979a12.2.1760557211329; Wed, 15 Oct 2025
 12:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 15 Oct 2025 12:39:59 -0700
X-Gm-Features: AS18NWB8AyHrypSBGVaV1zRPTZvCdB6mfFLenAU_JFgUJqaxeHd248FJTuy2y7E
Message-ID: <CAGSQo03-9H58F6GKBta2fH0CjrYNpJcTW=vtyEsL4k3m-YuDMg@mail.gmail.com>
Subject: Re: [PATCH v17 07/11] rust: debugfs: use `kernel::fmt`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
> callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
> support for read-only files").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/debugfs.rs                   |  2 +-
>  rust/kernel/debugfs/callback_adapters.rs |  7 +++----
>  rust/kernel/debugfs/file_ops.rs          |  6 +++---
>  rust/kernel/debugfs/traits.rs            | 10 +++++-----
>  4 files changed, 12 insertions(+), 13 deletions(-)
>

Reviewed-by: Matthew Maurer <mmaurer@google.com>


On Wed, Oct 15, 2025 at 12:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
> callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
> support for read-only files").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/debugfs.rs                   |  2 +-
>  rust/kernel/debugfs/callback_adapters.rs |  7 +++----
>  rust/kernel/debugfs/file_ops.rs          |  6 +++---
>  rust/kernel/debugfs/traits.rs            | 10 +++++-----
>  4 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index 381c23b3dd83..8c35d032acfe 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -8,12 +8,12 @@
>  // When DebugFS is disabled, many parameters are dead. Linting for this =
isn't helpful.
>  #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
>
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::str::CStr;
>  #[cfg(CONFIG_DEBUG_FS)]
>  use crate::sync::Arc;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt;
>  use core::marker::PhantomData;
>  use core::marker::PhantomPinned;
>  #[cfg(CONFIG_DEBUG_FS)]
> diff --git a/rust/kernel/debugfs/callback_adapters.rs b/rust/kernel/debug=
fs/callback_adapters.rs
> index 6c024230f676..a260d8dee051 100644
> --- a/rust/kernel/debugfs/callback_adapters.rs
> +++ b/rust/kernel/debugfs/callback_adapters.rs
> @@ -5,10 +5,9 @@
>  //! than a trait implementation. If provided, it will override the trait=
 implementation.
>
>  use super::{Reader, Writer};
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt;
> -use core::fmt::Formatter;
>  use core::marker::PhantomData;
>  use core::ops::Deref;
>
> @@ -76,9 +75,9 @@ fn deref(&self) -> &D {
>
>  impl<D, F> Writer for FormatAdapter<D, F>
>  where
> -    F: Fn(&D, &mut Formatter<'_>) -> fmt::Result + 'static,
> +    F: Fn(&D, &mut fmt::Formatter<'_>) -> fmt::Result + 'static,
>  {
> -    fn write(&self, fmt: &mut Formatter<'_>) -> fmt::Result {
> +    fn write(&self, fmt: &mut fmt::Formatter<'_>) -> fmt::Result {
>          // SAFETY: FormatAdapter<_, F> can only be constructed if F is i=
nhabited
>          let f: &F =3D unsafe { materialize_zst() };
>          f(&self.inner, fmt)
> diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_o=
ps.rs
> index 50fead17b6f3..9ad5e3fa6f69 100644
> --- a/rust/kernel/debugfs/file_ops.rs
> +++ b/rust/kernel/debugfs/file_ops.rs
> @@ -3,11 +3,11 @@
>
>  use super::{Reader, Writer};
>  use crate::debugfs::callback_adapters::Adapter;
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::seq_file::SeqFile;
>  use crate::seq_print;
>  use crate::uaccess::UserSlice;
> -use core::fmt::{Display, Formatter, Result};
>  use core::marker::PhantomData;
>
>  #[cfg(CONFIG_DEBUG_FS)]
> @@ -65,8 +65,8 @@ fn deref(&self) -> &Self::Target {
>
>  struct WriterAdapter<T>(T);
>
> -impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
> -    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
> +impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          self.0.write(f)
>      }
>  }
> diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.r=
s
> index ab009eb254b3..ad33bfbc7669 100644
> --- a/rust/kernel/debugfs/traits.rs
> +++ b/rust/kernel/debugfs/traits.rs
> @@ -3,10 +3,10 @@
>
>  //! Traits for rendering or updating values exported to DebugFS.
>
> +use crate::fmt;
>  use crate::prelude::*;
>  use crate::sync::Mutex;
>  use crate::uaccess::UserSliceReader;
> -use core::fmt::{self, Debug, Formatter};
>  use core::str::FromStr;
>  use core::sync::atomic::{
>      AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, A=
tomicU32, AtomicU64,
> @@ -24,17 +24,17 @@
>  /// explicitly instead.
>  pub trait Writer {
>      /// Formats the value using the given formatter.
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result;
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
>  }
>
>  impl<T: Writer> Writer for Mutex<T> {
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          self.lock().write(f)
>      }
>  }
>
> -impl<T: Debug> Writer for T {
> -    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +impl<T: fmt::Debug> Writer for T {
> +    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>          writeln!(f, "{self:?}")
>      }
>  }
>
> --
> 2.51.0
>
>
