Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6C1F5434
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054474; cv=none; b=n3SUdzY1qed6XeSxrPDsIxmjF7PvZaW9UXEXddApd3zUUx4FknOBpz5WneI12nQSDs7pDuLCqBD2pLN1npXqsL9mca6Sytz8tMSXthjgGpMNinMxMxRiwA7UtEVVyp8aA+/vQ87aGFD+prze9OroV+h1KZCOBRjxgzdkR4fP8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054474; c=relaxed/simple;
	bh=YaNwe9xitCHR0bQsjB3tJM4gLzlD3dmys6SrUXAAmSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7vvKjTF1Cdd4PHAtYByHZjHzgOByTugZZ+THa/wWGZ0EsggRYgtvFLnj6cVnkFAoH5iF0UFVdsrgxqLyjdWFu/ZtGe08mCOFfnAdOn46j7mvBySrXJh9E+SHoT3+s/5Y8hvEoybUXuh/I7R6Ib+fy4JrLO4TbamXOeeJDQ2gwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iULdbCju; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iULdbCju"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso8624086d6.3
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740054471; x=1740659271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VN0guRXo/TXLi41VPHWODKcSAtNlTkbpk1DGYeKunVs=;
        b=iULdbCju0u9sy6SQSpLeCQ4pIa6IdkJ4PhEVc8jkZtwt2lif6fqWdfpk7/Ry5IPNWO
         p4dxdo5iHp0Syy/WFMm55nuNYi4x7AU31JmMOCwfD8FfoiTCTYii20QAxxM3Z+44HwMc
         Jorfzw3KDsIuofmFCWY0oOO2GrQ3c6HX9o6FHL7DAhH7R5Z911vPT6var59GkKJXd6+t
         PoYP5CmGdGmmkalldJn+LDRATFEENnxyyOcHuXkJqlwDFZI2VSwJsqfMpqIHtx51K8OH
         vRmzkQmAVrSzJXDnPtm4cXwFf83Xm6dCKk0nihXF2aMryBhk+8yzFBSwVoFF7dhMITmK
         NUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054471; x=1740659271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN0guRXo/TXLi41VPHWODKcSAtNlTkbpk1DGYeKunVs=;
        b=YthW1c4dI/hEfqwqGiMcygiWVApL8u1sqCN6IxVEgooGNec/Pr+nEbD3h0U9kv6eq2
         IcEfYTIgQxrZN1gGM8QUuvA4fKvz2z1Y2F2GbK2jNhypCtlSbmxTcOX4xP+aHynkG8gG
         Ayb+Tz4kiiVXSG773zplW98uUl3JP9JQgfrwZQCFaHqGb7DR8Wqc2M3m4bE9d6n7kB0j
         G24rURopJj+YcDoK2jsHILFvfgbQg4Fbr6XT8LKaqC+T1mBtwzxxK2P0gcpYSD25thJP
         SbhoEVTUMNGPu5yp8E5TWBMlZ5fICsRzFVCi0g7qdL41EJThYDc74TpfjfePm6TvdOg/
         93zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUifScM1tbiKVb/HOzqDE218CH0r1LohYTUe0PEDe9rrLGeU7wImhA6v13tLOHnyqknzHpV2g24qNipg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2yH4McFrDwjmGSoKhirkwwxyfcLfsPVGNWkXv0pkA7xbKah3
	xJri9FabfymUlaI/9+has/wKwVQSmUulZ000xU5E+GPUC1YW2KjRtaczMbP41l38sSLPmrlLTtO
	W/FpL+ZHf9kkK1nWTc9HBCga0sWliETpr73m8
X-Gm-Gg: ASbGncsioJkjLVHbYbLR53OMZAOkpXVIbeKepIlkpFRt1de6IISuoDqHF/KVFEdfVMF
	4sjZ2T92ynSkSQjrTx/OBFUFBnCKczMHfTBayI3iyA+qerjmcQYm2RgLbgqioaxoJUSIBnY+k5Q
	==
X-Google-Smtp-Source: AGHT+IFNVnESFkkM5fzQC/jSeYc3dguhIMLyK4DBeC8RA+sMRt5pB4tBCnOjWdSCZSaM7ZWcTPjNgdEHp7s32/0Yid0=
X-Received: by 2002:a05:6214:f23:b0:6e4:2e12:3a0c with SMTP id
 6a1803df08f44-6e66ce28e77mr317727456d6.39.1740054471332; Thu, 20 Feb 2025
 04:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-4-gary@garyguo.net>
In-Reply-To: <20250219201602.1898383-4-gary@garyguo.net>
From: David Gow <davidgow@google.com>
Date: Thu, 20 Feb 2025 20:27:37 +0800
X-Gm-Features: AWEUYZm_fm4aq3QwK3n1GWvksYk7OxFAf-E3RC9EmkOpICMnxSR4mVS9WbDAgoc
Message-ID: <CABVgOS=0O0+xEwEWL1gFZfwKaBDx_oz2RDS9up=yfRFFcv7eRA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rust: block: convert `block::mq` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, 
	Francesco Zardi <frazar00@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b0db09062e9200d1"

--000000000000b0db09062e9200d1
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 04:17, Gary Guo <gary@garyguo.net> wrote:
>
> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
>
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Thanks very much. I can confirm this fixes 32-bit UML.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  rust/kernel/block/mq/operations.rs |  7 +--
>  rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
>  rust/kernel/sync/refcount.rs       | 14 ++++++
>  3 files changed, 40 insertions(+), 51 deletions(-)
>
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index 864ff379dc91..c399dcaa6740 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -10,9 +10,10 @@
>      block::mq::Request,
>      error::{from_result, Result},
>      prelude::*,
> +    sync::Refcount,
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
> +use core::marker::PhantomData;
>
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>          let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
>
>          // One refcount for the ARef, one for being in flight
> -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +        request.wrapper_ref().refcount().set(2);
>
>          // SAFETY:
>          //  - We own a refcount that we took above. We pass that to `ARef`.
> @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
>
>              // SAFETY: The refcount field is allocated but not initialized, so
>              // it is valid for writes.
> -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
>
>              Ok(0)
>          })
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 7943f43b9575..7c782d70935e 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -8,12 +8,13 @@
>      bindings,
>      block::mq::Operations,
>      error::Result,
> +    sync::Refcount,
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  use core::{
>      marker::PhantomData,
>      ptr::{addr_of_mut, NonNull},
> -    sync::atomic::{AtomicU64, Ordering},
> +    sync::atomic::Ordering,
>  };
>
>  /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
> @@ -37,6 +38,9 @@
>  /// We need to track 3 and 4 to ensure that it is safe to end the request and hand
>  /// back ownership to the block layer.
>  ///
> +/// Note that driver can still obtain new `ARef` even if there is no `ARef`s in existence by using
> +/// `tag_to_rq`, hence the need to distinct B and C.
> +///
>  /// The states are tracked through the private `refcount` field of
>  /// `RequestDataWrapper`. This structure lives in the private data area of the C
>  /// [`struct request`].
> @@ -98,13 +102,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>      ///
>      /// [`struct request`]: srctree/include/linux/blk-mq.h
>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
> -        // We can race with `TagSet::tag_to_rq`
> -        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
> -            2,
> -            0,
> -            Ordering::Relaxed,
> -            Ordering::Relaxed,
> -        ) {
> +        // To hand back the ownership, we need the current refcount to be 2.
> +        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
> +        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
> +        // atomics directly.
> +        if this
> +            .wrapper_ref()
> +            .refcount()
> +            .as_atomic()
> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed)
> +            .is_err()
> +        {
>              return Err(this);
>          }
>
> @@ -168,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
>      /// - 0: The request is owned by C block layer.
>      /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
>      /// - 2+: There are [`ARef`] references to the request.
> -    refcount: AtomicU64,
> +    refcount: Refcount,
>  }
>
>  impl RequestDataWrapper {
>      /// Return a reference to the refcount of the request that is embedding
>      /// `self`.
> -    pub(crate) fn refcount(&self) -> &AtomicU64 {
> +    pub(crate) fn refcount(&self) -> &Refcount {
>          &self.refcount
>      }
>
> @@ -184,7 +192,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
>      /// # Safety
>      ///
>      /// - `this` must point to a live allocation of at least the size of `Self`.
> -    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
>          // SAFETY: Because of the safety requirements of this function, the
>          // field projection is safe.
>          unsafe { addr_of_mut!((*this).refcount) }
> @@ -200,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
>  // mutate `self` are internally synchronized`
>  unsafe impl<T: Operations> Sync for Request<T> {}
>
> -/// Store the result of `op(target.load())` in target, returning new value of
> -/// target.
> -fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
> -    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
> -
> -    // SAFETY: Because the operation passed to `fetch_update` above always
> -    // return `Some`, `old` will always be `Ok`.
> -    let old = unsafe { old.unwrap_unchecked() };
> -
> -    op(old)
> -}
> -
> -/// Store the result of `op(target.load)` in `target` if `target.load() !=
> -/// pred`, returning [`true`] if the target was updated.
> -fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
> -    target
> -        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
> -            if x == pred {
> -                None
> -            } else {
> -                Some(op(x))
> -            }
> -        })
> -        .is_ok()
> -}
> -
>  // SAFETY: All instances of `Request<T>` are reference counted. This
>  // implementation of `AlwaysRefCounted` ensure that increments to the ref count
>  // keeps the object alive in memory at least until a matching reference count
>  // decrement is executed.
>  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>      fn inc_ref(&self) {
> -        let refcount = &self.wrapper_ref().refcount();
> -
> -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
> -
> -        #[cfg(CONFIG_DEBUG_MISC)]
> -        if !updated {
> -            panic!("Request refcount zero on clone")
> -        }
> +        self.wrapper_ref().refcount().inc();
>      }
>
>      unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> @@ -252,10 +226,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>          let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
>
>          #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
> +        let is_zero = refcount.dec_and_test();
>
>          #[cfg(CONFIG_DEBUG_MISC)]
> -        if new_refcount == 0 {
> +        if is_zero {
>              panic!("Request reached refcount zero in Rust abstractions");
>          }
>      }
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> index a6a683f5d7b8..3d7a1ffb3a46 100644
> --- a/rust/kernel/sync/refcount.rs
> +++ b/rust/kernel/sync/refcount.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
>
> +use core::sync::atomic::AtomicI32;
> +
>  use crate::types::Opaque;
>
>  /// Atomic reference counter.
> @@ -30,6 +32,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
>          self.0.get()
>      }
>
> +    /// Get the underlying atomic counter that backs the refcount.
> +    ///
> +    /// NOTE: This will be changed to LKMM atomic in the future.
> +    #[inline]
> +    pub fn as_atomic(&self) -> &AtomicI32 {
> +        let ptr = self.0.get() as *const AtomicI32;
> +        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
> +        // integer that is layout-wise compatible with `AtomicI32`. All values are valid for
> +        // `refcount_t`, despite some of the values are considered saturated and "bad".
> +        unsafe { &*ptr }
> +    }
> +
>      /// Set a refcount's value.
>      #[inline]
>      pub fn set(&self, value: i32) {
> --
> 2.47.2
>
>

--000000000000b0db09062e9200d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgb5eiumDbmk5rvtqYH/SnllP9Wk2E
xvVnZzEsTRE1K9owGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjIwMTIyNzUxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAB35kTMMToJzQfpWAwPIjjzpgUMqbGqkmfTXKUWtyUSN/Ha9
uW8wYnCGEOUEO1QuFr23zzDuKwAzZErxDU1eeaMf7duHLLVQK5i4/RB2utQxi/cYBl8FUZX90tVm
Ru2BAgsIDP+tjESW8WQMUbG+7OlS1UN7blxqGIE0GYbPUWfMfq1sn/TH9oVEI5tSXVHy78jgIMwT
EV0xfWx0nOqqhNyCcR/PwrDs97mnlrMr6qunhrKZatu8g+5liKDb1CGbvzy2nj62XJ3Ioh/oJft5
yAipNW9bAgJPFWibcEjENb89IqStmcqiLUrsdaPwxfxd/l555Bp82GoQLK0lHk5d58M=
--000000000000b0db09062e9200d1--
