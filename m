Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B7288DF
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717240280; cv=none; b=jd2gT8lKctOKwmgw+41SPo5xga+RpniSFjnh9YcGJ99SIUtL/TtUXaV1/9EgAeRkYP2hQ/UEO69CZnoEjAxmlUwrBlk5SPmBM9MFex7ZWA6oTvCFXR2/jC5gXXUpzIHAFFJc9+sR6XoYoGqg95fBgZV3wNkIsDraIk8G/yE3m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717240280; c=relaxed/simple;
	bh=21N+PVuembHrqSBNJBTVoVgQuu3mMVXmFN4nRBYEHgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HP9BX2r5uVIfskn85DY+K8mDAtjhMFkH4xUuNoFn8QZHduqF1cXKaknMeGI2lhMrE3IpUvgKq4hf71VgiwZEpI5P2LX+jQFP8E3ZdebJ3dhD5Mu8YoaJbOwSgNg5EUUO3Z9DdCiihNHb4kq9S8CcQ05lIQKV3UTeIE9jerKoP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=tF1gPEep; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="tF1gPEep"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6341cf2c99so306329666b.0
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717240276; x=1717845076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye/eFIIg5/G1qr1KkNcR29iqsvNe7JD8BDAscA4I/gc=;
        b=tF1gPEepT/610atnyrTn82H9m4bozGy+zY3hUxcwfmljPhx6+2W0Me5oRr9IihWDEQ
         +IqC21zl4RDWXMyTGlqRWLaZ93iGmbtXZ+ar5XVPlAsy2zQQVptdsmDqWLNGECoF8SpX
         TGFBYqaoU11LrTkfdt5H04a4SGwJkUSVaXZrfV97tuBJwk3T6WFUXKJFX2PLbtAZXrMm
         wswcMJR3f5Gl2IMgxnxOfhBkW8sTeTAsWuZlO9pRxWPwrFKKA09LlJZnYD/4i+6GVwnz
         CMYFRRUWpCjQYdMkwWANwgzv3ODR2gJOl2IxFsVjBqzX4j3SUDdEjk32hPI3dG5QLKUD
         7QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717240276; x=1717845076;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ye/eFIIg5/G1qr1KkNcR29iqsvNe7JD8BDAscA4I/gc=;
        b=eRweumwB7w0bjL9uOllcBt4JHR9EFz6kOtv6JRaBR25VCZJxnNDngH3f3PEDbU2oIV
         p49nhMT9EVQkiGURH4Vbxkpt+OX64OVQy7LraBAznKmyrl+uYwxVrQ4SyaHbmI3WzK7I
         3ow1Rku+ELY5hO8ITIK9UTdlubyPdd1BxPWv4dt8bbXpDHwDeBRGPljXAyrRujDs/ecL
         1tNOLMaOt9RElGlogR/viAbtYZBTJ2OC10T0NtNTAfDLrd3S22mBl7TsmVGHhTgXV61B
         RSBPgHN5Lu2A6cB1kJO4yCWAXsu7j6LTpCGveVGPDKomsg+MMCPDjJlgp4OV6KqihOyP
         HrYA==
X-Forwarded-Encrypted: i=1; AJvYcCXgc1ZHGiPHAhNnXpnUWJRRss2mlSWV7tUejHsDTb7BzIRIqQfowqDFx8R/kcmLVgIgjR8JWzl/LiUd76mkMMxCUB7eu7hWhYEnoig=
X-Gm-Message-State: AOJu0Ywt7iDDMngrhpH2tvbw8DkTKutZZxk350wK1Qz1QroHhA/EjjAX
	hzvFGEVgJ0hVck3fS6yakxLqK0wZkEAhl/MHl5Gx4fejLyW1ZoGhumjKQ4XlsJQ=
X-Google-Smtp-Source: AGHT+IFytQ5yIPI3lBnNUgqxPc+2VPf3VD9PmRwyD0eSmowzhfwvJg9iPrDwl4lTyDJgoRGNIzyRlg==
X-Received: by 2002:a17:906:6d06:b0:a68:b0f2:1d95 with SMTP id a640c23a62f3a-a68b0f21f73mr81382566b.71.1717240276238;
        Sat, 01 Jun 2024 04:11:16 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c5539b80sm24885166b.168.2024.06.01.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 04:11:15 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <47a8ce04-3901-49ae-abac-a7d85901f980@proton.me> (Benno Lossin's
	message of "Sat, 01 Jun 2024 09:43:47 +0000")
References: <20240601081806.531954-1-nmi@metaspace.dk>
	<20240601081806.531954-2-nmi@metaspace.dk>
	<47a8ce04-3901-49ae-abac-a7d85901f980@proton.me>
Date: Sat, 01 Jun 2024 13:11:05 +0200
Message-ID: <87ikysor3q.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

> On 01.06.24 10:18, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> [...]
>
>> +impl<T: Operations> GenDisk<T, Initialized> {
>> +    /// Try to create a new `GenDisk`.
>> +    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {
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
>
> AFAIK the 1.78 upgrade already is in rust-next (and also should appear
> in v6.10-rc2, right?) do you have this on your radar?

I am tracking this and I plan to add support in a later patch.

>
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
>> +        // `__blk_mq_alloc_disk` above.
>> +        Ok(GenDisk {
>> +            tagset,
>> +            gendisk,
>> +            _phantom: PhantomData,
>> +        })
>> +    }
>
> [...]
>
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
>
> Is it also possible to completely remove it? ie use `None` in the
> VTABLE, or will the C side error?

No, this pointer is not allowed to be null. It must be a callable
function, hence the stub. It will be populated soon enough when I send
patches for the remote completion logic.

>
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function may only be called by blk-mq C infrastructure.
>> +    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request)=
 {}
>
> [...]
>
>> +impl<'a> RawWriter<'a> {
>> +    /// Create a new `RawWriter` instance.
>> +    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
>> +        *(buffer.last_mut().ok_or(EINVAL)?) =3D 0;
>> +
>> +        // INVARIANT: We null terminated the buffer above.
>> +        Ok(Self { buffer, pos: 0 })
>> +    }
>> +
>> +    pub(crate) fn from_array<const N: usize>(
>> +        a: &'a mut [core::ffi::c_char; N],
>> +    ) -> Result<RawWriter<'a>> {
>
> You could change the return type to be `RawWriter<'a>` and check using
> `build_assert!` that `N > 0`. Then you can also call `unwrap_unchecked`
> on the result that you get below.
>
> I don't know if we want that, but it is a possibility.

I guess we could potentially make the type generic over a const buffer
size. But let's put a pin in that for now. I'll look into that down the roa=
d.

>
>> +        Self::new(
>> +            // SAFETY: the buffer of `a` is valid for read and write as=
 `u8` for
>> +            // at least `N` bytes.
>> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cas=
t::<u8>(), N) },
>> +        )
>> +    }
>> +}
>
> [...]
>
>> +/// Store the result of `op(target.load())` in target, returning new va=
lue of
>> +/// taret.
>> +fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64=
) -> u64 {
>> +    let old =3D target.fetch_update(Ordering::Relaxed, Ordering::Relaxe=
d, |x| Some(op(x)));
>> +
>> +    // SAFETY: Because the operation passed to `fetch_update` above alw=
ays
>> +    // return `Some`, `old` will always be `Ok`.
>> +    let old =3D unsafe { old.unwrap_unchecked() };
>> +
>> +    op(old)
>> +}
>> +
>> +/// Store the result of `op(target.load)` in `target` if `target.load()=
 !=3D
>> +/// pred`, returning previous value of target
>
> The function returns a bool, not a u64 (value). From the body I read
> that you return whether the value was updated.

Thanks =F0=9F=91=8D

>
>> +fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64=
, pred: u64) -> bool {
>> +    let x =3D target.load(Ordering::Relaxed);
>> +    loop {
>> +        if x =3D=3D pred {
>> +            break;
>> +        }
>> +        if target
>> +            .compare_exchange_weak(x, op(x), Ordering::Relaxed, Orderin=
g::Relaxed)
>> +            .is_ok()
>> +        {
>> +            break;
>> +        }
>
> If this fails, you are not re-reading the value of `target`, so if
> someone else just set it to `pred`, you will still continue to try to
> set it from `x` to `op(x)`, but it might never have the value `x` again.
> This would lead to a potentially infinite loop, right?

Yea, that is not good. I should have moved the assignment of `x` into the l=
oop

>
>> +    }
>
> Do you think you can also implement this using `fetch_update`? I guess
> this would do what you want, right?:
>
>     target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
>         if x =3D=3D pred {
>             None
>         } else {
>             Some(op(x))
>         }
>     }).is_ok()

Makes sense, I will steal that.

>
>> +
>> +    x =3D=3D pred
>> +}
>
> [...]
>
>> +impl<T: Operations> TagSet<T> {
>> +    /// Try to create a new tag set
>> +    pub fn try_new(
>> +        nr_hw_queues: u32,
>> +        num_tags: u32,
>> +        num_maps: u32,
>> +    ) -> impl PinInit<Self, error::Error> {
>> +        try_pin_init!( TagSet {
>> +            // INVARIANT: We initialize `inner` here and it is valid af=
ter the
>> +            // initializer has run.
>> +            inner <- unsafe {kernel::init::pin_init_from_closure(move |=
place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
>> +                let place =3D place.cast::<bindings::blk_mq_tag_set>();
>> +
>> +                // SAFETY: pin_init_from_closure promises that `place` =
is writable, and
>> +                // zeroes is a valid bit pattern for this structure.
>> +                core::ptr::write_bytes(place, 0, 1);
>> +
>> +                /// For a raw pointer to a struct, write a struct field=
 without
>> +                /// creating a reference to the field
>> +                macro_rules! write_ptr_field {
>> +                    ($target:ident, $field:ident, $value:expr) =3D> {
>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((*=
$target).$field), $value)
>> +                    };
>> +                }
>> +
>> +                // SAFETY: pin_init_from_closure promises that `place` =
is writable
>> +                    write_ptr_field!(place, ops, OperationsVTable::<T>:=
:build());
>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues=
);
>> +                    write_ptr_field!(place, timeout , 0); // 0 means de=
fault which is 30 * HZ in C
>> +                    write_ptr_field!(place, numa_node , bindings::NUMA_=
NO_NODE);
>> +                    write_ptr_field!(place, queue_depth , num_tags);
>> +                    write_ptr_field!(place, cmd_size , core::mem::size_=
of::<RequestDataWrapper>().try_into()?);
>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_=
SHOULD_MERGE);
>> +                    write_ptr_field!(place, driver_data , core::ptr::nu=
ll_mut::<core::ffi::c_void>());
>> +                    write_ptr_field!(place, nr_maps , num_maps);
>
> Did something not work with my suggestion?

I did not want to change it if we are rewriting it to `Opaque::init`
in a cycle or two, which I think is a better solution.


Best regards,
Andreas
