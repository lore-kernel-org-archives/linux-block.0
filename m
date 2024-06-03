Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311E10949
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416084; cv=none; b=H+zbhHHVkaQ0h7/aYaXM4KAe8ap7UwmSQQvTbJpCHSJi5mWxe3evasL0+Tp8QUQ8yQjLsJ/Y/oPp1Toi/5TZ8yLLWbJMghLDemPEZxLJumY8hy4IOdHbkDq+KJYoMUAdedZ3ImCNzDxHUDvEBilkJO9lmvnnQ4edLO1mmrq4Xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416084; c=relaxed/simple;
	bh=d2mjs4XZMkNeQ+HUqicIdUBGMGtIr9dkOylyvyZRNZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ww8gz5AiMjlsjOO8YqGcZsudSRgC+jVIowoGk6d1jweW4TSrUO6eulVdwZoxISvmHcYtbM9dfSQ1d2mTD4YO5TLX1NwCqzfP5I1KE/uz3RHepvhDxRgmU+5d0egUBZNX9bAE69N+29ZREFg0A4cultq+5jamnHpCLmHHSlzE6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=n1fh4Nc5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="n1fh4Nc5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42135a45e2aso13727565e9.3
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717416079; x=1718020879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3xUCui7cLPYCBQDbqvkFkoK4V/RGmuP0R9MYWDAsMY=;
        b=n1fh4Nc5ojKHDmx2jtkEIFajYeIujNdPSiQcJ+YAb2UE9fGbCKL3tz7MrQy2/Mfhtf
         D54WihHka7zQt+iW8Wl3mX4WWoN+VoypLB5dVTT+ZGYHB+vUxIpwVA39XPmPSVZOYiyA
         qLvCM8NmDYSLbWQC+0glftOL8j2kHoznCK9Rukrmvt9Xq8nQSr4ji/sHET5p3WLqMHUP
         Yb+huY7gKjTsksCZFUl30OicOKwFzjndxMn9iJ0Pt7CpzqFwAci5Inx9ea/cjbBQrQ4T
         ocYf/jwI8HsM9EOTp/TX6hZSU+Ze2Y1THZb5iLIVvkJTidU78FQYTNHO1GX7JgM/m/dG
         lgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416079; x=1718020879;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3xUCui7cLPYCBQDbqvkFkoK4V/RGmuP0R9MYWDAsMY=;
        b=qZVImISUT4l9k0S8+tbddl+IM4je7oIbrIpEr66s7SorM5rr4pupwvtGPr6wIO56VF
         3PvE9lgTHbBS20Fp6ViPmZPOxDQhiH0H4qmlG7f5svq6J5kSKn8xPj5zxJqlCoVbMSHo
         Rd1qh0xlmdKxECaudwgNLY4e9nuy+nXLUMQH9Q8rqd0ap8R7R5BqONXTriUeEVbPh1D7
         m4eabd89LM/Ia9qh5LKAoEhgeqyytlxj2vNTRgHD2sAVBckH2wzOU2EfCLVCNlxPGnXs
         jvqQIdYz87s6XZXnhVClWoSrImmdzjcNxx6uH06sFZ0GjrbZPGgrV2tvDkQoVyNRHV+r
         T5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWwdUsRPBr3J2aBMiHpSgDg0K/Rh4BweAPxTdA/xWV/J9FCmwBDV88PtUhjmR0NIUU6nCiQJyBO7nvh3lqHGjhv4e+Kh9ixRi63Q=
X-Gm-Message-State: AOJu0Yzxi978Ci4dUZUG6wDE5G7jPnHPNIm+BCIJn1wvKoFtb5XmlOkE
	q+r/9gRN34aGUkmMHe5WHphDmfV5xKEHMxXoujvMaXiqU2wcVABtoV1QQhSIOTzIjntYShrvvQA
	/
X-Google-Smtp-Source: AGHT+IEUTn+YwahcCQswRuuEjn2b/mncaQi5c822nBTE41ro1vWLUXwe/FYhGZ+7jdgFe0px3+VKbQ==
X-Received: by 2002:a05:600c:198b:b0:41a:b30e:42a3 with SMTP id 5b1f17b1804b1-4212e0bfd84mr66395065e9.37.1717416078969;
        Mon, 03 Jun 2024 05:01:18 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127069305sm145639915e9.22.2024.06.03.05.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:01:18 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,  Bart Van
 Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me> (Benno Lossin's
	message of "Sun, 02 Jun 2024 20:08:17 +0000")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-2-nmi@metaspace.dk>
	<b6b8e3e6-a2b9-4ddd-bf0f-e924d5d65653@proton.me>
Date: Mon, 03 Jun 2024 14:01:10 +0200
Message-ID: <87mso2me0p.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

> On 01.06.24 15:40, Andreas Hindborg wrote:
>> +/// A generic block device.
>> +///
>> +/// # Invariants
>> +///
>> +///  - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
>> +pub struct GenDisk<T: Operations, S: GenDiskState =3D Added> {
>
> I am curious, do you need the type state for this struct? AFAIU you are
> only using it to configure the `GenDisk`, so could you also use a config
> struct that is given to `GenDisk::new`. That way we can avoid the extra
> traits and generic argument.
>
> Since there are so many options, a builder config struct might be a good
> idea.

I agree, let's do a builder. That would actually make some things a bit
simpler.


>
>> +    tagset: Arc<TagSet<T>>,
>> +    gendisk: *mut bindings::gendisk,
>> +    _phantom: core::marker::PhantomData<S>,
>> +}
>> +
>> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `=
Arc` to a
>> +// `TagSet` It is safe to send this to other threads as long as T is Se=
nd.
>> +unsafe impl<T: Operations + Send, S: GenDiskState> Send for GenDisk<T, =
S> {}
>> +
>> +/// Disks in this state are allocated and initialized, but are not yet
>> +/// accessible from the kernel VFS.
>> +pub enum Initialized {}
>> +
>> +/// Disks in this state have been attached to the kernel VFS and may re=
ceive IO
>> +/// requests.
>> +pub enum Added {}
>> +
>> +mod seal {
>> +    pub trait Sealed {}
>> +}
>> +
>> +/// Typestate representing states of a `GenDisk`.
>> +///
>> +/// This trait cannot be implemented by downstream crates.
>> +pub trait GenDiskState: seal::Sealed {
>> +    /// Set to true if [`GenDisk`] should call `del_gendisk` on drop.
>> +    const DELETE_ON_DROP: bool;
>> +}
>> +
>> +impl seal::Sealed for Initialized {}
>> +impl GenDiskState for Initialized {
>> +    const DELETE_ON_DROP: bool =3D false;
>> +}
>> +impl seal::Sealed for Added {}
>> +impl GenDiskState for Added {
>> +    const DELETE_ON_DROP: bool =3D true;
>> +}
>> +
>> +impl<T: Operations> GenDisk<T, Initialized> {
>> +    /// Try to create a new `GenDisk`.
>> +    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {
>
> Since there is no non-try `new` function, I think we should name this
> function just `new`.

Right, I am still getting used to the new naming scheme. Do you know if
it is documented anywhere?

>
>> +        let lock_class_key =3D crate::sync::LockClassKey::new();
>> +
>> +        // SAFETY: `tagset.raw_tag_set()` points to a valid and initial=
ized tag set
>> +        let gendisk =3D from_err_ptr(unsafe {
>> +            bindings::__blk_mq_alloc_disk(
>> +                tagset.raw_tag_set(),
>> +                core::ptr::null_mut(), // TODO: We can pass queue limit=
s right here
>> +                core::ptr::null_mut(),
>> +                lock_class_key.as_ptr(),
>> +            )
>> +        })?;
>> +
>> +        const TABLE: bindings::block_device_operations =3D bindings::bl=
ock_device_operations {
>> +            submit_bio: None,
>> +            open: None,
>> +            release: None,
>> +            ioctl: None,
>> +            compat_ioctl: None,
>> +            check_events: None,
>> +            unlock_native_capacity: None,
>> +            getgeo: None,
>> +            set_read_only: None,
>> +            swap_slot_free_notify: None,
>> +            report_zones: None,
>> +            devnode: None,
>> +            alternative_gpt_sector: None,
>> +            get_unique_id: None,
>> +            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_stat=
ic feature to
>> +            // be merged (unstable in rustc 1.78 which is staged for li=
nux 6.10)
>> +            // https://github.com/rust-lang/rust/issues/119618
>> +            owner: core::ptr::null_mut(),
>> +            pr_ops: core::ptr::null_mut(),
>> +            free_disk: None,
>> +            poll_bio: None,
>> +        };
>> +
>> +        // SAFETY: gendisk is a valid pointer as we initialized it above
>> +        unsafe { (*gendisk).fops =3D &TABLE };
>> +
>> +        // INVARIANT: `gendisk` was initialized above.
>> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in th=
e call to
>
> There is no `data` in the mentioned call above.

Thanks, I'll move the comment to the patch it belongs in =F0=9F=91=8D

>
>> +        // `__blk_mq_alloc_disk` above.
>> +        Ok(GenDisk {
>> +            tagset,
>> +            gendisk,
>> +            _phantom: PhantomData,
>> +        })
>> +    }
>> +
>
> [...]
>
>> +impl<T: Operations> OperationsVTable<T> {
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - The caller of this function must ensure `bd` is valid
>> +    ///   and initialized. The pointees must outlive this function.
>
> Until when do the pointees have to be alive? "must outlive this
> function" could also be the case if the pointees die immediately after
> this function returns.

It should not be plural. What I intended to communicate is that what
`bd` points to must be valid for read for the duration of the function
call. I think that is what "The pointee must outlive this function"
states? Although when we talk about lifetime of an object pointed to by
a pointer, I am not sure about the correct way to word this. Do we talk
about the lifetime of the pointer or the lifetime of the pointed to
object (the pointee). We should not use the same wording for the pointer
and the pointee.

How about:

    /// - The caller of this function must ensure that the pointee of `bd` =
is
    ///   valid for read for the duration of this function.

>
>> +    /// - This function must not be called with a `hctx` for which
>> +    ///   `Self::exit_hctx_callback()` has been called.
>> +    /// - (*bd).rq must point to a valid `bindings:request` for which
>> +    ///   `OperationsVTable<T>::init_request_callback` was called
>
> Missing `.` at the end.

Thanks.

>
>> +    unsafe extern "C" fn queue_rq_callback(
>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        bd: *const bindings::blk_mq_queue_data,
>> +    ) -> bindings::blk_status_t {
>> +        // SAFETY: `bd.rq` is valid as required by the safety requireme=
nt for
>> +        // this function.
>> +        let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
>> +
>> +        // One refcount for the ARef, one for being in flight
>> +        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
>> +
>> +        // SAFETY: We own a refcount that we took above. We pass that t=
o `ARef`.
>> +        // By the safety requirements of this function, `request` is a =
valid
>> +        // `struct request` and the private data is properly initialize=
d.
>> +        let rq =3D unsafe { Request::aref_from_raw((*bd).rq) };
>
> I think that you need to require that the request is alive at least
> until `blk_mq_end_request` is called for the request (since at that
> point all `ARef`s will be gone).
> Also if this is not guaranteed, the safety requirements of
> `AlwaysRefCounted` are violated (since the object can just disappear
> even if it has refcount > 0 [the refcount refers to the Rust refcount in
> the `RequestDataWrapper`, not the one in C]).

Yea, for the last invariant of `Request`:

  /// * `self` is reference counted by atomic modification of
  ///   self.wrapper_ref().refcount().

I will add this to the safety comment at the call site:

  //  - `rq` will be alive until `blk_mq_end_request` is called and is
  //    reference counted by `ARef` until then.


>
>> +
>> +        // SAFETY: We have exclusive access and we just set the refcoun=
t above.
>> +        unsafe { Request::start_unchecked(&rq) };
>> +
>> +        let ret =3D T::queue_rq(
>> +            rq,
>> +            // SAFETY: `bd` is valid as required by the safety requirem=
ent for this function.
>> +            unsafe { (*bd).last },
>> +        );
>> +
>> +        if let Err(e) =3D ret {
>> +            e.to_blk_status()
>> +        } else {
>> +            bindings::BLK_STS_OK as _
>> +        }
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_=
mq_hw_ctx) {
>> +        T::commit_rqs()
>> +    }
>> +
>> +    /// This function is called by the C kernel. It is not currently
>> +    /// implemented, and there is no way to exercise this code path.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request)=
 {}
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn poll_callback(
>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        _iob: *mut bindings::io_comp_batch,
>> +    ) -> core::ffi::c_int {
>> +        T::poll().into()
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure. Th=
is
>> +    /// function may only be called onece before `exit_hctx_callback` i=
s called
>
> Typo: "onece"

Since you keep finding typos in my patches, I took this morning to fix
my spelling setup in Emacs. It was a deep rabbit hole, but I think I got
it now =F0=9F=A4=9E

>
>> +    /// for the same context.
>> +    unsafe extern "C" fn init_hctx_callback(
>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        _tagset_data: *mut core::ffi::c_void,
>> +        _hctx_idx: core::ffi::c_uint,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| Ok(0))
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn exit_hctx_callback(
>> +        _hctx: *mut bindings::blk_mq_hw_ctx,
>> +        _hctx_idx: core::ffi::c_uint,
>> +    ) {
>> +    }
>> +
>> +    /// This function is called by the C kernel. A pointer to this func=
tion is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure. `s=
et` must
>> +    /// point to an initialized `TagSet<T>`.
>> +    unsafe extern "C" fn init_request_callback(
>> +        _set: *mut bindings::blk_mq_tag_set,
>> +        rq: *mut bindings::request,
>> +        _hctx_idx: core::ffi::c_uint,
>> +        _numa_node: core::ffi::c_uint,
>> +    ) -> core::ffi::c_int {
>> +        from_result(|| {
>> +            // SAFETY: The `blk_mq_tag_set` invariants guarantee that a=
ll
>> +            // requests are allocated with extra memory for the request=
 data.
>
> What guarantees that the right amount of memory has been allocated?
> AFAIU that is guaranteed by the `TagSet` (but there is no invariant).

It is by C API contract. `TagSet`::try_new` (now `new`) writes
`cmd_size` into the `struct blk_mq_tag_set`. That is picked up by
`blk_mq_alloc_tag_set` to allocate the right amount of space for each reque=
st.

The invariant here is on the C type. Perhaps the wording is wrong. I am
not exactly sure how to express this. How about this:

            // SAFETY: We instructed `blk_mq_alloc_tag_set` to allocate req=
uests
            // with extra memory for the request data when we called it in
            // `TagSet::new`.

>
>> +            let pdu =3D unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast:=
:<RequestDataWrapper>();
>> +
>> +            // SAFETY: The refcount field is allocated but not initiali=
zed, this
>> +            // valid for write.
>> +            unsafe { RequestDataWrapper::refcount_ptr(pdu).write(Atomic=
U64::new(0)) };
>> +
>> +            Ok(0)
>> +        })
>> +    }
>
> [...]
>
>> +    /// Notify the block layer that a request is going to be processed =
now.
>> +    ///
>> +    /// The block layer uses this hook to do proper initializations suc=
h as
>> +    /// starting the timeout timer. It is a requirement that block devi=
ce
>> +    /// drivers call this function when starting to process a request.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must have exclusive ownership of `self`, that is
>> +    /// `self.wrapper_ref().refcount() =3D=3D 2`.
>> +    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>
> We don't have a `&mut self`. But the safety requirements ask for a
> unique `ARef`.

Thanks, I'll rephrase to:

        // SAFETY: By type invariant, `self.0` is a valid `struct request` =
and
        // we have exclusive access.

>
>> +        unsafe { bindings::blk_mq_start_request(this.0.get()) };
>> +    }
>> +
>> +    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>> {
>> +        // We can race with `TagSet::tag_to_rq`
>> +        match this.wrapper_ref().refcount().compare_exchange(
>> +            2,
>> +            0,
>> +            Ordering::Relaxed,
>> +            Ordering::Relaxed,
>> +        ) {
>> +            Err(_old) =3D> Err(this),
>> +            Ok(_) =3D> Ok(this),
>> +        }
>> +    }
>> +
>> +    /// Notify the block layer that the request has been completed with=
out errors.
>> +    ///
>> +    /// This function will return `Err` if `this` is not the only `ARef`
>> +    /// referencing the request.
>> +    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>> +        let this =3D Self::try_set_end(this)?;
>> +        let request_ptr =3D this.0.get();
>> +        core::mem::forget(this);
>> +
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>
> Same here, but in this case, the `ARef` is unique, since you called
> `try_set_end`. You could make it a `# Guarantee` of `try_set_end`: "If
> `Ok(aref)` is returned, then the `aref` is unique."

Makes sense. I have not seen `# Guarantee` used anywhere. Do you have a lin=
k for that use?

>
>> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BL=
K_STS_OK as _) };
>> +
>> +        Ok(())
>> +    }
>> +
>> +    /// Return a pointer to the `RequestDataWrapper` stored in the priv=
ate area
>> +    /// of the request structure.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - `this` must point to a valid allocation.
>> +    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<Reques=
tDataWrapper> {
>> +        let request_ptr =3D this.cast::<bindings::request>();
>> +        let wrapper_ptr =3D
>> +            // SAFETY: By safety requirements for this function, `this`=
 is a
>> +            // valid allocation.
>
> Formatting: move the safety comment above the `let`.

Thanks.

I'll send a new version shortly.


BR Andreas
