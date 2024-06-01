Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD841C92;
	Sat,  1 Jun 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235036; cv=none; b=tlKJS12i5yNHAa6NGytBvllzIm0S5MglNH92uFEUst1fWuSUAJkKcl7Eir/gcBjPY4HF+cAAznGfIF2vcW61Jh2ak994D0QGnAIHOKRGPZ4ggo3D9xmXStwe6usrwpt3ys4RzSutWMRO6fuwRX4bI5LlZld7e0KUuKxcGGnL8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235036; c=relaxed/simple;
	bh=tMG2xoxlyziw+LDyRUzDFAA3+fsPPSHXL4HTUrk0rmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/jNHx6RhAEK/HYC/swDFBtm1bOTncT2k0GfCtKsqAY797wq1OWeduhiUzgx6Aa7vVmPn4Ba/BKhV91+tTWKxVo1/z2cEmLCwtc8UeVECg+n8hRdCazRA21M+q2p/0VTT8OT1MB2STmqV9FrR1aFFpbmR6deLDFMdUMrqmekIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XGEYu5s4; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XGEYu5s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717235032; x=1717494232;
	bh=g851w8cYO5B6HNECyRM57FCl+xPHs+tM3cPtq75ZI4c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XGEYu5s4WgWqmKZ2Z5kyWA/v5AxUc6AqORXE9cvCz3ocaloO7wzj49yNty7aGRCzB
	 1+LXmYcRNEyPwu4w3SiwbXp1f0PsNIS9EcunQpkkcZ1DNymnkztjoW30gcyKAPSCPn
	 S+s9K37ldTpxFKw2DcFcsS02RCUg2cSeKbgRFUcNleRVkke7Nzg2MBzlU5S/8l8jSy
	 o+ZiyBHgIEvqeORSuEze+nCU5sgGd/L6sIgibFeGBj4kSAjSTXgYjLGm0Y8AVvPmSA
	 vQmWrUbkciBNsp93uoTJC6hFa27op+SwNQw6hJwie+KSZaAbMKOnRbCA3bT+w4h6E1
	 spwTMZZ26FI2Q==
Date: Sat, 01 Jun 2024 09:43:47 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <47a8ce04-3901-49ae-abac-a7d85901f980@proton.me>
In-Reply-To: <20240601081806.531954-2-nmi@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk> <20240601081806.531954-2-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cb6fdc560b5f23d63cbf737bea8af0ad2a4b0a10
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.06.24 10:18, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>

[...]

> +impl<T: Operations> GenDisk<T, Initialized> {
> +    /// Try to create a new `GenDisk`.
> +    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {
> +        let lock_class_key =3D crate::sync::LockClassKey::new();
> +
> +        // SAFETY: `tagset.raw_tag_set()` points to a valid and initiali=
zed tag set
> +        let gendisk =3D from_err_ptr(unsafe {
> +            bindings::__blk_mq_alloc_disk(
> +                tagset.raw_tag_set(),
> +                core::ptr::null_mut(), // TODO: We can pass queue limits=
 right here
> +                core::ptr::null_mut(),
> +                lock_class_key.as_ptr(),
> +            )
> +        })?;
> +
> +        const TABLE: bindings::block_device_operations =3D bindings::blo=
ck_device_operations {
> +            submit_bio: None,
> +            open: None,
> +            release: None,
> +            ioctl: None,
> +            compat_ioctl: None,
> +            check_events: None,
> +            unlock_native_capacity: None,
> +            getgeo: None,
> +            set_read_only: None,
> +            swap_slot_free_notify: None,
> +            report_zones: None,
> +            devnode: None,
> +            alternative_gpt_sector: None,
> +            get_unique_id: None,
> +            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_stati=
c feature to
> +            // be merged (unstable in rustc 1.78 which is staged for lin=
ux 6.10)
> +            // https://github.com/rust-lang/rust/issues/119618

AFAIK the 1.78 upgrade already is in rust-next (and also should appear
in v6.10-rc2, right?) do you have this on your radar?

> +            owner: core::ptr::null_mut(),
> +            pr_ops: core::ptr::null_mut(),
> +            free_disk: None,
> +            poll_bio: None,
> +        };
> +
> +        // SAFETY: gendisk is a valid pointer as we initialized it above
> +        unsafe { (*gendisk).fops =3D &TABLE };
> +
> +        // INVARIANT: `gendisk` was initialized above.
> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the=
 call to
> +        // `__blk_mq_alloc_disk` above.
> +        Ok(GenDisk {
> +            tagset,
> +            gendisk,
> +            _phantom: PhantomData,
> +        })
> +    }

[...]

> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure.
> +    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_m=
q_hw_ctx) {
> +        T::commit_rqs()
> +    }
> +
> +    /// This function is called by the C kernel. It is not currently
> +    /// implemented, and there is no way to exercise this code path.

Is it also possible to completely remove it? ie use `None` in the
VTABLE, or will the C side error?

> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure.
> +    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) =
{}

[...]

> +impl<'a> RawWriter<'a> {
> +    /// Create a new `RawWriter` instance.
> +    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
> +        *(buffer.last_mut().ok_or(EINVAL)?) =3D 0;
> +
> +        // INVARIANT: We null terminated the buffer above.
> +        Ok(Self { buffer, pos: 0 })
> +    }
> +
> +    pub(crate) fn from_array<const N: usize>(
> +        a: &'a mut [core::ffi::c_char; N],
> +    ) -> Result<RawWriter<'a>> {

You could change the return type to be `RawWriter<'a>` and check using
`build_assert!` that `N > 0`. Then you can also call `unwrap_unchecked`
on the result that you get below.

I don't know if we want that, but it is a possibility.

> +        Self::new(
> +            // SAFETY: the buffer of `a` is valid for read and write as =
`u8` for
> +            // at least `N` bytes.
> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast=
::<u8>(), N) },
> +        )
> +    }
> +}

[...]

> +/// Store the result of `op(target.load())` in target, returning new val=
ue of
> +/// taret.
> +fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64)=
 -> u64 {
> +    let old =3D target.fetch_update(Ordering::Relaxed, Ordering::Relaxed=
, |x| Some(op(x)));
> +
> +    // SAFETY: Because the operation passed to `fetch_update` above alwa=
ys
> +    // return `Some`, `old` will always be `Ok`.
> +    let old =3D unsafe { old.unwrap_unchecked() };
> +
> +    op(old)
> +}
> +
> +/// Store the result of `op(target.load)` in `target` if `target.load() =
!=3D
> +/// pred`, returning previous value of target

The function returns a bool, not a u64 (value). From the body I read
that you return whether the value was updated.

> +fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64,=
 pred: u64) -> bool {
> +    let x =3D target.load(Ordering::Relaxed);
> +    loop {
> +        if x =3D=3D pred {
> +            break;
> +        }
> +        if target
> +            .compare_exchange_weak(x, op(x), Ordering::Relaxed, Ordering=
::Relaxed)
> +            .is_ok()
> +        {
> +            break;
> +        }

If this fails, you are not re-reading the value of `target`, so if
someone else just set it to `pred`, you will still continue to try to
set it from `x` to `op(x)`, but it might never have the value `x` again.
This would lead to a potentially infinite loop, right?

> +    }

Do you think you can also implement this using `fetch_update`? I guess
this would do what you want, right?:

    target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
        if x =3D=3D pred {
            None
        } else {
            Some(op(x))
        }
    }).is_ok()

> +
> +    x =3D=3D pred
> +}

[...]

> +impl<T: Operations> TagSet<T> {
> +    /// Try to create a new tag set
> +    pub fn try_new(
> +        nr_hw_queues: u32,
> +        num_tags: u32,
> +        num_maps: u32,
> +    ) -> impl PinInit<Self, error::Error> {
> +        try_pin_init!( TagSet {
> +            // INVARIANT: We initialize `inner` here and it is valid aft=
er the
> +            // initializer has run.
> +            inner <- unsafe {kernel::init::pin_init_from_closure(move |p=
lace: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
> +                let place =3D place.cast::<bindings::blk_mq_tag_set>();
> +
> +                // SAFETY: pin_init_from_closure promises that `place` i=
s writable, and
> +                // zeroes is a valid bit pattern for this structure.
> +                core::ptr::write_bytes(place, 0, 1);
> +
> +                /// For a raw pointer to a struct, write a struct field =
without
> +                /// creating a reference to the field
> +                macro_rules! write_ptr_field {
> +                    ($target:ident, $field:ident, $value:expr) =3D> {
> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((*$=
target).$field), $value)
> +                    };
> +                }
> +
> +                // SAFETY: pin_init_from_closure promises that `place` i=
s writable
> +                    write_ptr_field!(place, ops, OperationsVTable::<T>::=
build());
> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues)=
;
> +                    write_ptr_field!(place, timeout , 0); // 0 means def=
ault which is 30 * HZ in C
> +                    write_ptr_field!(place, numa_node , bindings::NUMA_N=
O_NODE);
> +                    write_ptr_field!(place, queue_depth , num_tags);
> +                    write_ptr_field!(place, cmd_size , core::mem::size_o=
f::<RequestDataWrapper>().try_into()?);
> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_S=
HOULD_MERGE);
> +                    write_ptr_field!(place, driver_data , core::ptr::nul=
l_mut::<core::ffi::c_void>());
> +                    write_ptr_field!(place, nr_maps , num_maps);

Did something not work with my suggestion?

---
Cheers,
Benno

> +
> +                // SAFETY: Relevant fields of `place` are initialised ab=
ove
> +                let ret =3D bindings::blk_mq_alloc_tag_set(place);
> +                if ret < 0 {
> +                    return Err(Error::from_errno(ret));
> +                }
> +
> +                Ok(())
> +            })},
> +            _p: PhantomData,
> +        })
> +    }

[...]

