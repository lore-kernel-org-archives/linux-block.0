Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08014F11D;
	Sat,  1 Jun 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717243517; cv=none; b=JJQPj2XlZVuRjtxF83YHEGsTeQ8LDPCo0NqCOkHw+azuVT6Y3/xj0guLjMZW1zVExHK0O5SxLyJLoF3CjDqa0UlqtCaE0bTOoLRKvarAE3HrUel3Tup5uqGvu/0AU7Xr1/zkL8lCSlOJlmGH8Au491svaSgDrrQsBm58pVgJuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717243517; c=relaxed/simple;
	bh=DsN/1amsqM8cu1/fMXEEj56TsbKtVvc2uJbDvsjVfW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqP+MVqgArdllKnsntcsKsxzw/IttMnNU9R6cqvzsB4RKB9RcIzAyMxnFpnG9OTp+/tKoAsoxwZLXaUe0BovW3xDrXZ7hiHP3MgoXVI1BCcoGmfoBhlgVMfonSxA8yK4m2prrjExOtgvt8QhbZFoGEtWQ6xJRmMP1OIhu9p3kVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=d4nejng1; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="d4nejng1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717243513; x=1717502713;
	bh=fnwhnTGCPs27zFajfymGkj5Js3/VS4EavIJ+ATMewR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d4nejng1rlokHUAqMxs5ReintutcycKMCAS9EWKJK0Ccjow9OCmWPYQIeAfCBxX7l
	 0F1osZlIz6OIdlD07QfreNFgpbgyihG/L1mDPHV6u3jtwgzwWpALaWFXJ4TLDSAbtO
	 kSQZVcfov1HeOphYlziBrghMTB035d8VTx8mWYZUN2XbCVgD7u+Ds3e+YSmnTDvivB
	 yl/W9NRjAT4MZcqie38U6+iSp06lvLQiVv2ISRLOXvvti8y7kd5BE7PfmjFAMDnexQ
	 ylSkdj6zfjpP/yyq4JgFA7uCDvIGwsZM02eRqDNptlmH62VAvgoyJO4wcH/KSXqBOY
	 vwXgfKlVFkS8w==
Date: Sat, 01 Jun 2024 12:05:10 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/3] rust: block: introduce `kernel::block::mq` module
Message-ID: <696d50c4-a2b0-4c72-890e-be27f48f0fb3@proton.me>
In-Reply-To: <87ikysor3q.fsf@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk> <20240601081806.531954-2-nmi@metaspace.dk> <47a8ce04-3901-49ae-abac-a7d85901f980@proton.me> <87ikysor3q.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d422cc806e8f74df9d24b8e0498c32173c71b22e
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.06.24 13:11, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 01.06.24 10:18, Andreas Hindborg wrote:
>>> +    /// This function is called by the C kernel. A pointer to this fun=
ction is
>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function may only be called by blk-mq C infrastructure.
>>> +    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk=
_mq_hw_ctx) {
>>> +        T::commit_rqs()
>>> +    }
>>> +
>>> +    /// This function is called by the C kernel. It is not currently
>>> +    /// implemented, and there is no way to exercise this code path.
>>
>> Is it also possible to completely remove it? ie use `None` in the
>> VTABLE, or will the C side error?
>=20
> No, this pointer is not allowed to be null. It must be a callable
> function, hence the stub. It will be populated soon enough when I send
> patches for the remote completion logic.

Makes sense.

[...]

>>> +impl<T: Operations> TagSet<T> {
>>> +    /// Try to create a new tag set
>>> +    pub fn try_new(
>>> +        nr_hw_queues: u32,
>>> +        num_tags: u32,
>>> +        num_maps: u32,
>>> +    ) -> impl PinInit<Self, error::Error> {
>>> +        try_pin_init!( TagSet {
>>> +            // INVARIANT: We initialize `inner` here and it is valid a=
fter the
>>> +            // initializer has run.
>>> +            inner <- unsafe {kernel::init::pin_init_from_closure(move =
|place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
>>> +                let place =3D place.cast::<bindings::blk_mq_tag_set>()=
;
>>> +
>>> +                // SAFETY: pin_init_from_closure promises that `place`=
 is writable, and
>>> +                // zeroes is a valid bit pattern for this structure.
>>> +                core::ptr::write_bytes(place, 0, 1);
>>> +
>>> +                /// For a raw pointer to a struct, write a struct fiel=
d without
>>> +                /// creating a reference to the field
>>> +                macro_rules! write_ptr_field {
>>> +                    ($target:ident, $field:ident, $value:expr) =3D> {
>>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((=
*$target).$field), $value)
>>> +                    };
>>> +                }
>>> +
>>> +                // SAFETY: pin_init_from_closure promises that `place`=
 is writable
>>> +                    write_ptr_field!(place, ops, OperationsVTable::<T>=
::build());
>>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queue=
s);
>>> +                    write_ptr_field!(place, timeout , 0); // 0 means d=
efault which is 30 * HZ in C
>>> +                    write_ptr_field!(place, numa_node , bindings::NUMA=
_NO_NODE);
>>> +                    write_ptr_field!(place, queue_depth , num_tags);
>>> +                    write_ptr_field!(place, cmd_size , core::mem::size=
_of::<RequestDataWrapper>().try_into()?);
>>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F=
_SHOULD_MERGE);
>>> +                    write_ptr_field!(place, driver_data , core::ptr::n=
ull_mut::<core::ffi::c_void>());
>>> +                    write_ptr_field!(place, nr_maps , num_maps);
>>
>> Did something not work with my suggestion?
>=20
> I did not want to change it if we are rewriting it to `Opaque::init`
> in a cycle or two, which I think is a better solution.

Ah I was suggesting to do it now, but emulate the `Opaque::init`
function (I should have been clearer about that).
I tried to do exactly that, but failed to easily implement it, since the
fields of `blk_mq_tag_set` include some structs, which of course do not
implement `Zeroable`.

Instead I came up with the following solution, which I find a lot nicer:

    pub fn try_new(
        nr_hw_queues: u32,
        num_tags: u32,
        num_maps: u32,
    ) -> impl PinInit<Self, error::Error> {
        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, wh=
ich all are allowed to be 0.
        let tag_set: bindings::blk_mq_tag_set =3D unsafe { core::mem::zeroe=
d() };
        let tag_set =3D bindings::blk_mq_tag_set {
            ops: OperationsVTable::<T>::build(),
            nr_hw_queues,
            timeout: 0, // 0 means default which is 30Hz in C
            numa_node: bindings::NUMA_NO_NODE,
            queue_depth: num_tags,
            cmd_size: core::mem::size_of::<RequestDataWrapper>().try_into()=
?,
            flags: bindings::BLK_MQ_F_SHOULD_MERGE,
            driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
            nr_maps: num_maps,
            ..tag_set
        };
        try_pin_init!(TagSet {
            inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_=
set), |tag_set| {
                // SAFETY: we do not move out of `tag_set`.
                let tag_set =3D unsafe { Pin::get_unchecked_mut(tag_set) };
                // SAFETY: `tag_set` is a reference to an initialized `blk_=
mq_tag_set`.
                error::to_result(unsafe { bindings::blk_mq_alloc_tag_set(ta=
g_set) })
            }),
            _p: PhantomData,
        })
    }

I haven't tested it though, let me know if you have any problems.

---
Cheers,
Benno

