Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35942F49EE;
	Mon,  1 Sep 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736707; cv=pass; b=D3mSN2o/py6DFxLfRofAp3cwkc6Ca3pyyD6IfA37tcM3e3BdyW4xwIKhIT1+bF81G1PCzk2JGMHyv6/t9PcOTyxy2s6M8IXQRbM3YjU72v/X1w2CETU2Ss066vITaDb8Tmii0oHWG5E77CZC8ghOJtyzejmCuDMBhw3Cb3GG+FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736707; c=relaxed/simple;
	bh=vuDGbWqm/9R0IuGxg+X+dpyc5ApWMnq2yOclMM/FivU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ICRGpq9T7BC6zPqoTzJ8CLV0knOvssov9ot9HJCzGZmdtvF81awpozL75ILvCsMPF8wI8KVRYhLzfCz5EdJ7Ige5215FnyfVLWPiKNl0j6eU+cKgllc5eff8Uucmei0bo8/LpAuGPfp5CEsDhtxEwrH3/Hsci5h1unBtiSlOOYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Y6gX0L/q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Y6gX0L/q"
ARC-Seal: i=1; a=rsa-sha256; t=1756736683; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZOsYZVzca7zCva+XosLo++okG+IJSbfsTFLNqsKr6pi1sd5Jxa7YmrHniSOVewp2oMbh1hqD3+Pos1R+zxQnS5Dr4hUs6lHIYRe89PCxqBup5dn6bokSN8kW+oA2+BzJXwF9NmPdVORkb0395cJKjk9NQ04x4xnguJHXTBzQ6rg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756736683; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W9FCfUG14h2oKCNBF9TsJGENC4lLTZfUyNoDD35vGNw=; 
	b=BLS6zkLKnABRpdHAbXCwhOHDMZMab6Fq8fzxCSZr2dIY8L3YxtzD5Dqy4K4b4pFviAw0KGl4FsPhv8X0RKG8UBRUhsnTnDIOVyaVG95LoLV9OxjwmRtHhW8qpf5FSuw7hS+VVBeR76sEVYoQ/NtGLBGQWScAcwWlNAVoKptu94Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756736683;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=W9FCfUG14h2oKCNBF9TsJGENC4lLTZfUyNoDD35vGNw=;
	b=Y6gX0L/qMhN+HAwqWwxOG9cYN7F1EMSbg4gbVdlOT0Mxk3ooSgm4/yvEp30LjNLH
	PiZkZNQvidOXgLT/ge7LPNJkoJuekxsWIhsY38hVH+c5r8t3mDWHYB9JhDxzgioYBMo
	wJQfX2PCI0S7GTQvRGu/aiyXhvPrZz34wTDoGf10=
Received: by mx.zohomail.com with SMTPS id 1756736681642725.040873569627;
	Mon, 1 Sep 2025 07:24:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 17/18] rust: block: add remote completion to `Request`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <877bymidos.fsf@t14s.mail-host-address-is-not-set>
Date: Mon, 1 Sep 2025 11:24:24 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <532104CE-269D-4C38-A248-AF6417C4151F@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-17-ec65006e2f07@kernel.org>
 <R-quyDdhLT8rgM7vBTBx_6hUbT6VXlKvJ0ueHYeoye0JcLGz6WqNuPJQGEn3yBbnokSWZaUWbsLlh-bVJQeSpQ==@protonmail.internalid>
 <680BB9D0-3720-44EC-A25D-83806F635D8D@collabora.com>
 <877bymidos.fsf@t14s.mail-host-address-is-not-set>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 29 Aug 2025, at 08:12, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> Hi Andreas,
>>=20
>>> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>>>=20
>>> Allow users of rust block device driver API to schedule completion =
of
>>> requests via `blk_mq_complete_request_remote`.
>>>=20
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>> drivers/block/rnull/rnull.rs       |  9 +++++++++
>>> rust/kernel/block/mq.rs            |  6 ++++++
>>> rust/kernel/block/mq/operations.rs | 19 +++++++++++++++----
>>> rust/kernel/block/mq/request.rs    | 17 +++++++++++++++++
>>> 4 files changed, 47 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/block/rnull/rnull.rs =
b/drivers/block/rnull/rnull.rs
>>> index 8255236bc550..a19c55717c4f 100644
>>> --- a/drivers/block/rnull/rnull.rs
>>> +++ b/drivers/block/rnull/rnull.rs
>>> @@ -82,4 +82,13 @@ fn queue_rq(_queue_data: (), rq: =
ARef<mq::Request<Self>>, _is_last: bool) -> Res
>>>    }
>>>=20
>>>    fn commit_rqs(_queue_data: ()) {}
>>> +
>>> +    fn complete(rq: ARef<mq::Request<Self>>) {
>>> +        mq::Request::end_ok(rq)
>>> +            .map_err(|_e| kernel::error::code::EIO)
>>> +            // We take no refcounts on the request, so we expect to =
be able to
>>> +            // end the request. The request reference must be =
unique at this
>>> +            // point, and so `end_ok` cannot fail.
>>> +            .expect("Fatal error - expected to be able to end =
request");
>>> +    }
>>> }
>>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>>> index 6e546f4f3d1c..c0ec06b84355 100644
>>> --- a/rust/kernel/block/mq.rs
>>> +++ b/rust/kernel/block/mq.rs
>>> @@ -77,6 +77,12 @@
>>> //!     }
>>> //!
>>> //!     fn commit_rqs(_queue_data: ()) {}
>>> +//!
>>> +//!     fn complete(rq: ARef<Request<Self>>) {
>>> +//!         Request::end_ok(rq)
>>> +//!             .map_err(|_e| kernel::error::code::EIO)
>>> +//!             .expect("Fatal error - expected to be able to end =
request");
>>> +//!     }
>>> //! }
>>> //!
>>> //! let tagset: Arc<TagSet<MyBlkDevice>> =3D
>>> diff --git a/rust/kernel/block/mq/operations.rs =
b/rust/kernel/block/mq/operations.rs
>>> index 6fb256f55acc..0fece577de7c 100644
>>> --- a/rust/kernel/block/mq/operations.rs
>>> +++ b/rust/kernel/block/mq/operations.rs
>>> @@ -42,6 +42,9 @@ fn queue_rq(
>>>    /// Called by the kernel to indicate that queued requests should =
be submitted.
>>>    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
>>>=20
>>> +    /// Called by the kernel when the request is completed.
>>> +    fn complete(rq: ARef<Request<Self>>);
>>> +
>>>    /// Called by the kernel to poll the device for completed =
requests. Only
>>>    /// used for poll queues.
>>>    fn poll() -> bool {
>>> @@ -143,13 +146,21 @@ impl<T: Operations> OperationsVTable<T> {
>>>        T::commit_rqs(queue_data)
>>>    }
>>>=20
>>> -    /// This function is called by the C kernel. It is not =
currently
>>> -    /// implemented, and there is no way to exercise this code =
path.
>>> +    /// This function is called by the C kernel. A pointer to this =
function is
>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>    ///
>>>    /// # Safety
>>>    ///
>>> -    /// This function may only be called by blk-mq C =
infrastructure.
>>> -    unsafe extern "C" fn complete_callback(_rq: *mut =
bindings::request) {}
>>> +    /// This function may only be called by blk-mq C =
infrastructure. `rq` must
>>> +    /// point to a valid request that has been marked as completed. =
The pointee
>>> +    /// of `rq` must be valid for write for the duration of this =
function.
>>> +    unsafe extern "C" fn complete_callback(rq: *mut =
bindings::request) {
>>> +        // SAFETY: This function can only be dispatched through
>>> +        // `Request::complete`. We leaked a refcount then which we =
pick back up
>>> +        // now.
>>> +        let aref =3D unsafe { Request::aref_from_raw(rq) };
>>> +        T::complete(aref);
>>> +    }
>>>=20
>>>    /// This function is called by the C kernel. A pointer to this =
function is
>>>    /// installed in the `blk_mq_ops` vtable for the driver.
>>> diff --git a/rust/kernel/block/mq/request.rs =
b/rust/kernel/block/mq/request.rs
>>> index 3848cfe63f77..f7f757f7459f 100644
>>> --- a/rust/kernel/block/mq/request.rs
>>> +++ b/rust/kernel/block/mq/request.rs
>>> @@ -135,6 +135,23 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), =
ARef<Self>> {
>>>        Ok(())
>>>    }
>>>=20
>>> +    /// Complete the request by scheduling `Operations::complete` =
for
>>> +    /// execution.
>>> +    ///
>>> +    /// The function may be scheduled locally, via SoftIRQ or =
remotely via IPMI.
>>> +    /// See `blk_mq_complete_request_remote` in [`blk-mq.c`] for =
details.
>>> +    ///
>>> +    /// [`blk-mq.c`]: srctree/block/blk-mq.c
>>> +    pub fn complete(this: ARef<Self>) {
>>> +        let ptr =3D =
ARef::into_raw(this).cast::<bindings::request>().as_ptr();
>>> +        // SAFETY: By type invariant, `self.0` is a valid `struct =
request`
>>> +        if !unsafe { bindings::blk_mq_complete_request_remote(ptr) =
} {
>>> +            // SAFETY: We released a refcount above that we can =
reclaim here.
>>> +            let this =3D unsafe { Request::aref_from_raw(ptr) };
>>> +            T::complete(this);
>>> +        }
>>> +    }
>>> +
>>>    /// Return a pointer to the [`RequestDataWrapper`] stored in the =
private area
>>>    /// of the request structure.
>>>    ///
>>>=20
>>> --
>>> 2.47.2
>>>=20
>>>=20
>>=20
>> I had another look here. While I do trust your reasoning, perhaps we =
should
>> remove the call to expect()?
>>=20
>> If it is not called ever as you said, great, removing the expect() =
will not
>> change the code behavior. If it is, be it because of some minor =
oversight or
>> unexpected condition, we should produce some error output instead of =
crashing
>> the kernel. Maybe we should use a warn() here instead? Or maybe =
dev/pr_err as
>> applicable?
>=20
> I think for the example, I would like to keep the `expect`. For
> demonstration purposes.

I think examples is definitely one place we don=E2=80=99t want to teach =
people to
use unwrap and expect because that will kill the system IIUC.

>=20
> We could do `warn!` instead for the rnull driver I guess. But the IO
> queue that would hit this code would start to hang pretty fast, since =
no
> IO would complete. I don't think the kernel can recover from this =
hang.
>=20

No I/O would complete for that device, but that doesn't mean that the =
system is
unusable IIUC, specially if other devices are available?

>=20
> Best regards,
> Andreas Hindborg

In any case, perhaps this is only my opinion and others may see this
differently, so I won't complain if you want to keep it.


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

