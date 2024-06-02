Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AC6EB55
	for <linux-block@vger.kernel.org>; Sun,  2 Jun 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717358913; cv=none; b=p3AARYtEHmAVh9PTlHVHgw+o/S8Wx+C7NsK4hF1/PSZWS9QzpMLUuDAxFWUIitx5KfFYKHDhJe8p9JrTpSg6aTotQAu4CTxXw3KAipR6CB7MePgWZS3zA0waYQXtM5w9e4/kT/W/Efypa85ruxBOpJQn5lfpLP9wB8a1lNKkXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717358913; c=relaxed/simple;
	bh=gv4I+6GwieHWb1tCZwkuxK2HBNpvWMgBBANkH9gcGFI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRjiT/92Ru9CXuj2CK6MMdsUJVrNqxIz0R1n/YYA8UK+jVhTBQheBYSpNGvFNkGgBAwuIkH2EFY2TZBf2IdOMZGPo5q9KxbX+vycJYX3u/jihbGmwp96E7X7w76PANJPn/RxqYh7E+AVJwchc7vkU95dtHtAgzECNjIj+Bphc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TgkdRr5S; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TgkdRr5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717358903; x=1717618103;
	bh=P2Rf7NAHbdic8e+BaXjdvaGsbpV8QnHus543Acbv554=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TgkdRr5SQFQrB931NHcoVHOO5KrG9oBgwpsV+/vll9ZUdtM8Ja107iPjlTq6+CBJ4
	 uF3Wk/VWzq0ItmfHzYphoGKuXhB2pbYWBwxkjn6UfsBnC7XCpMvMr4XBvyINmAd99K
	 DWQDuE42AOeBoHRL0yiGmxaQf47kB4oBs4XJ+0NEx1kDqy8e7JUNmg+KJOVX+89gg5
	 v96cqj+kPQtWTaVLZJfYWhnhK4bLLpTUtPJfRa6dbyjBTkdDMQz9y41ikuadiwPYz+
	 VRMJmFctdSp9bcq+ZDooVmR6JjSEMUF7lzEW7HCnrtZ/AqEMkVpx087Ql9113ig2Nh
	 Lstfc9XuqfKjg==
Date: Sun, 02 Jun 2024 20:08:17 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me>
In-Reply-To: <20240601134005.621714-2-nmi@metaspace.dk>
References: <20240601134005.621714-1-nmi@metaspace.dk> <20240601134005.621714-2-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4c05c8f4489a2cc3a02925d2bd580e9a09740315
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.06.24 15:40, Andreas Hindborg wrote:
> +/// A generic block device.
> +///
> +/// # Invariants
> +///
> +///  - `gendisk` must always point to an initialized and valid `struct g=
endisk`.
> +pub struct GenDisk<T: Operations, S: GenDiskState =3D Added> {

I am curious, do you need the type state for this struct? AFAIU you are
only using it to configure the `GenDisk`, so could you also use a config
struct that is given to `GenDisk::new`. That way we can avoid the extra
traits and generic argument.

Since there are so many options, a builder config struct might be a good
idea.

> +    tagset: Arc<TagSet<T>>,
> +    gendisk: *mut bindings::gendisk,
> +    _phantom: core::marker::PhantomData<S>,
> +}
> +
> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `A=
rc` to a
> +// `TagSet` It is safe to send this to other threads as long as T is Sen=
d.
> +unsafe impl<T: Operations + Send, S: GenDiskState> Send for GenDisk<T, S=
> {}
> +
> +/// Disks in this state are allocated and initialized, but are not yet
> +/// accessible from the kernel VFS.
> +pub enum Initialized {}
> +
> +/// Disks in this state have been attached to the kernel VFS and may rec=
eive IO
> +/// requests.
> +pub enum Added {}
> +
> +mod seal {
> +    pub trait Sealed {}
> +}
> +
> +/// Typestate representing states of a `GenDisk`.
> +///
> +/// This trait cannot be implemented by downstream crates.
> +pub trait GenDiskState: seal::Sealed {
> +    /// Set to true if [`GenDisk`] should call `del_gendisk` on drop.
> +    const DELETE_ON_DROP: bool;
> +}
> +
> +impl seal::Sealed for Initialized {}
> +impl GenDiskState for Initialized {
> +    const DELETE_ON_DROP: bool =3D false;
> +}
> +impl seal::Sealed for Added {}
> +impl GenDiskState for Added {
> +    const DELETE_ON_DROP: bool =3D true;
> +}
> +
> +impl<T: Operations> GenDisk<T, Initialized> {
> +    /// Try to create a new `GenDisk`.
> +    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {

Since there is no non-try `new` function, I think we should name this
function just `new`.

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

There is no `data` in the mentioned call above.

> +        // `__blk_mq_alloc_disk` above.
> +        Ok(GenDisk {
> +            tagset,
> +            gendisk,
> +            _phantom: PhantomData,
> +        })
> +    }
> +

[...]

> +impl<T: Operations> OperationsVTable<T> {
> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - The caller of this function must ensure `bd` is valid
> +    ///   and initialized. The pointees must outlive this function.

Until when do the pointees have to be alive? "must outlive this
function" could also be the case if the pointees die immediately after
this function returns.

> +    /// - This function must not be called with a `hctx` for which
> +    ///   `Self::exit_hctx_callback()` has been called.
> +    /// - (*bd).rq must point to a valid `bindings:request` for which
> +    ///   `OperationsVTable<T>::init_request_callback` was called

Missing `.` at the end.

> +    unsafe extern "C" fn queue_rq_callback(
> +        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        bd: *const bindings::blk_mq_queue_data,
> +    ) -> bindings::blk_status_t {
> +        // SAFETY: `bd.rq` is valid as required by the safety requiremen=
t for
> +        // this function.
> +        let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
> +
> +        // One refcount for the ARef, one for being in flight
> +        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +
> +        // SAFETY: We own a refcount that we took above. We pass that to=
 `ARef`.
> +        // By the safety requirements of this function, `request` is a v=
alid
> +        // `struct request` and the private data is properly initialized=
.
> +        let rq =3D unsafe { Request::aref_from_raw((*bd).rq) };

I think that you need to require that the request is alive at least
until `blk_mq_end_request` is called for the request (since at that
point all `ARef`s will be gone).
Also if this is not guaranteed, the safety requirements of
`AlwaysRefCounted` are violated (since the object can just disappear
even if it has refcount > 0 [the refcount refers to the Rust refcount in
the `RequestDataWrapper`, not the one in C]).

> +
> +        // SAFETY: We have exclusive access and we just set the refcount=
 above.
> +        unsafe { Request::start_unchecked(&rq) };
> +
> +        let ret =3D T::queue_rq(
> +            rq,
> +            // SAFETY: `bd` is valid as required by the safety requireme=
nt for this function.
> +            unsafe { (*bd).last },
> +        );
> +
> +        if let Err(e) =3D ret {
> +            e.to_blk_status()
> +        } else {
> +            bindings::BLK_STS_OK as _
> +        }
> +    }
> +
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
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure.
> +    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) =
{}
> +
> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure.
> +    unsafe extern "C" fn poll_callback(
> +        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        _iob: *mut bindings::io_comp_batch,
> +    ) -> core::ffi::c_int {
> +        T::poll().into()
> +    }
> +
> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure. Thi=
s
> +    /// function may only be called onece before `exit_hctx_callback` is=
 called

Typo: "onece"

> +    /// for the same context.
> +    unsafe extern "C" fn init_hctx_callback(
> +        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        _tagset_data: *mut core::ffi::c_void,
> +        _hctx_idx: core::ffi::c_uint,
> +    ) -> core::ffi::c_int {
> +        from_result(|| Ok(0))
> +    }
> +
> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure.
> +    unsafe extern "C" fn exit_hctx_callback(
> +        _hctx: *mut bindings::blk_mq_hw_ctx,
> +        _hctx_idx: core::ffi::c_uint,
> +    ) {
> +    }
> +
> +    /// This function is called by the C kernel. A pointer to this funct=
ion is
> +    /// installed in the `blk_mq_ops` vtable for the driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function may only be called by blk-mq C infrastructure. `se=
t` must
> +    /// point to an initialized `TagSet<T>`.
> +    unsafe extern "C" fn init_request_callback(
> +        _set: *mut bindings::blk_mq_tag_set,
> +        rq: *mut bindings::request,
> +        _hctx_idx: core::ffi::c_uint,
> +        _numa_node: core::ffi::c_uint,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The `blk_mq_tag_set` invariants guarantee that al=
l
> +            // requests are allocated with extra memory for the request =
data.

What guarantees that the right amount of memory has been allocated?
AFAIU that is guaranteed by the `TagSet` (but there is no invariant).

> +            let pdu =3D unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::=
<RequestDataWrapper>();
> +
> +            // SAFETY: The refcount field is allocated but not initializ=
ed, this
> +            // valid for write.
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu).write(AtomicU=
64::new(0)) };
> +
> +            Ok(0)
> +        })
> +    }

[...]

> +    /// Notify the block layer that a request is going to be processed n=
ow.
> +    ///
> +    /// The block layer uses this hook to do proper initializations such=
 as
> +    /// starting the timeout timer. It is a requirement that block devic=
e
> +    /// drivers call this function when starting to process a request.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must have exclusive ownership of `self`, that is
> +    /// `self.wrapper_ref().refcount() =3D=3D 2`.
> +    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`. By
> +        // existence of `&mut self` we have exclusive access.

We don't have a `&mut self`. But the safety requirements ask for a
unique `ARef`.

> +        unsafe { bindings::blk_mq_start_request(this.0.get()) };
> +    }
> +
> +    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>> {
> +        // We can race with `TagSet::tag_to_rq`
> +        match this.wrapper_ref().refcount().compare_exchange(
> +            2,
> +            0,
> +            Ordering::Relaxed,
> +            Ordering::Relaxed,
> +        ) {
> +            Err(_old) =3D> Err(this),
> +            Ok(_) =3D> Ok(this),
> +        }
> +    }
> +
> +    /// Notify the block layer that the request has been completed witho=
ut errors.
> +    ///
> +    /// This function will return `Err` if `this` is not the only `ARef`
> +    /// referencing the request.
> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
> +        let this =3D Self::try_set_end(this)?;
> +        let request_ptr =3D this.0.get();
> +        core::mem::forget(this);
> +
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`. By
> +        // existence of `&mut self` we have exclusive access.

Same here, but in this case, the `ARef` is unique, since you called
`try_set_end`. You could make it a `# Guarantee` of `try_set_end`: "If
`Ok(aref)` is returned, then the `aref` is unique."

> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK=
_STS_OK as _) };
> +
> +        Ok(())
> +    }
> +
> +    /// Return a pointer to the `RequestDataWrapper` stored in the priva=
te area
> +    /// of the request structure.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `this` must point to a valid allocation.
> +    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<Request=
DataWrapper> {
> +        let request_ptr =3D this.cast::<bindings::request>();
> +        let wrapper_ptr =3D
> +            // SAFETY: By safety requirements for this function, `this` =
is a
> +            // valid allocation.

Formatting: move the safety comment above the `let`.

---
Cheers,
Benno

> +            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<Requ=
estDataWrapper>() };
> +        // SAFETY: By C api contract, wrapper_ptr points to a valid allo=
cation
> +        // and is not null.
> +        unsafe { NonNull::new_unchecked(wrapper_ptr) }
> +    }

[...]

