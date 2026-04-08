Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC73BB9E1;
	Wed,  8 Apr 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649289; cv=none; b=CEABTiappWsqXZowg4983qe9cOk1CBVnuNtyhhKkpfzcGVk0wB/dL7kXjtcxJATpyZiW8KMoFjpTDwplkyVXN1oIBMjtaLbNWyG62RPpoS9v3shnw89TsIHc5eaL0lb2tw+w4g8rLfKV3Brs/iNaAcFbDDB5zNhCXEVE+kI8aWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649289; c=relaxed/simple;
	bh=MA4d5fmu8ycPYDqnj6TGa+JGYzSgcY/0NWIkLvFzBgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=renYW3csHmcSc/4GxTJWy8C1KZI34ha2+l0aHibRVmXB6ENGT4RkrRt7g0u3diBepjnlwN5PPq7oDgprjTsatqhXYIKE6t8yR4ip80ucWiT6qrsoh+MEwtVTXVJ39ryG1aO6jmlYcvSVMFWXop7ZN85JbNOtC5gTzUdQZeihzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSpon30t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSpon30t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70368C19421;
	Wed,  8 Apr 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775649289;
	bh=MA4d5fmu8ycPYDqnj6TGa+JGYzSgcY/0NWIkLvFzBgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uSpon30tvzkTfS7qtJ3EEJ/MmbBlGC7JQxCib7bKKB9Hx5QZ5zBnKqt0BWOuXoHpF
	 0ZqGrd/gni34h1C6GP0iagG+vdvDa/zuYJU9zefs3X9GgSlqJuPo3Qe78yQGdo0Fbd
	 GDRb0Wpw28RQKRtt86wQ9B0V2JUuYqJV/6SE807lC96NIVCkfHqhBJ+2FH72Bq1QjJ
	 Ob6dnX9w1r9luRnZ2h8Jr3db6fkmm1ehN/vkMUENuRM4hzV7c49MUEdczgp0rIGQyZ
	 WLk3qKZUrAEWRj8kJVse6ggIazbN+DClwtYpeDtrfTvXq6P6gbYWagmNsbUAv3rkZb
	 TgY3HvvBXGM/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/79] block: rust: change `queue_rq` request type to
 `Owned`
In-Reply-To: <CAH5fLggq-1pReNsRtgRfm0Y_PiQvUsXbMMkPkyO9kuhqzB3wrA@mail.gmail.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-5-de9a7af4b469@kernel.org>
 <abfU_itQLa4jDy5L@google.com> <87ikamrbo7.fsf@kernel.org>
 <CAH5fLggq-1pReNsRtgRfm0Y_PiQvUsXbMMkPkyO9kuhqzB3wrA@mail.gmail.com>
Date: Wed, 08 Apr 2026 13:54:35 +0200
Message-ID: <87qzopwttw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Mar 23, 2026 at 1:08=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Alice Ryhl <aliceryhl@google.com> writes:
>>
>> > On Mon, Feb 16, 2026 at 12:34:52AM +0100, Andreas Hindborg wrote:
>> >> Simplify the reference counting scheme for `Request` from 4 states to=
 3
>> >> states. This is achieved by coalescing the zero state between block l=
ayer
>> >> owned and uniquely owned by driver.
>> >>
>> >> Implement `Ownable` for `Request` and deliver `Request` to drivers as
>> >> `Owned<Request>`. In this process:
>> >>
>> >>  - Move uniqueness assertions out of `rnull` as these are now guarant=
eed by
>> >>    the `Owned` type.
>> >>  - Move `start_unchecked`, `try_set_end` and `end_ok` from `Request` =
to
>> >>    `Owned<Request>`, relying on type invariant for uniqueness.
>> >>
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >
>> > It would be a lot cleaner if we could implement HrTimerPointer for
>> > Owned<Request> and entirely get rid of the refcount in request so we
>> > don't need ARef<Request> at all.
>> >
>> > Is there a reason we *need* ARef here?
>>
>> There is. Real drivers will need to dma map the data buffers in
>>  `Request` to a device. This requires taking a reference on the pages to
>>  be mapped, which in turn requires taking a reference on the `Request`.
>>
>> We could split up the reference counts into multiple fields, but that
>> would be less efficient.
>
> So how exactly is the refcount used here? Can you elaborate?

I can try to be more clear.

`Request` objects are created when a driver initializes a device. A
driver initializes a number `Request` equal to the queue depth the
driver supports. That is, if a driver/device supports 16 in-flight
requests, the driver allocates and initializes 16 `Request` objects up
front.

When the kernel wants to issue IO to a block device, it finds an idle
`Request` object and sets it up for the IO operation. Then:

1. The block layer hands off the request to the driver. Ownership of the
request is transferred to the driver. At this point, the driver has a
unique reference to the request (`Owned<Request>`).

2. The driver DMA maps the pages of the request. We have to make sure
the request is not handed back to the block layer while the pages are
mapped. To this end, we take a refcount on the request. The reference
that the driver holds is no longer unique (`ARef<Request>`).

3. The driver instructs a device to carry out the request. The driver
releases its refcount on the request and the device takes a refcount.

4. When the device finishes processing the request, ownership is
transferred back to the driver. The device releases it's refcount and
the driver takes a refcount.

5. DMA mappings are torn down. The refcount associated with the DMA
mappings is released.

6. The driver transfers ownership of the request back to the block
layer. To do this, the request must be uniquely owned by the driver.

When the device is done processing a request and we have to transfer
ownership of the request back to the driver, we use an API function
called `tag_to_rq`. This function takes an integer tag and may return a
request reference. For this function to be safe, we have to be able to
assert that the integer tag passed to the function is naming a request
object that it is valid to obtain a reference to. It is not sound to
create references to requests that are not currently in flight. Thus, we
must be able to know this information. The current implementation relies
on the refcount to discover this information:

/// There are three states for a request that the Rust bindings care about:
///
/// - 0: The request is owned by C block layer or is uniquely referenced (b=
y [`Owned<_>`]).
/// - 1: The request is owned by Rust abstractions but is not referenced.
/// - 2+: There is one or more [`ARef`] instances referencing the request.

So, we are using 1 refcount field to encode all the information we need.

Further, in the current implementation, for step 3, the device does not
actually take a refcount on the request. If a driver drops all
references to a request, the refcount lands on 1. We use this to
indicate that the request has been leaked and to know that `tag_to_rq`
is safe. In a situation where the request is DMA mapped, the refcount
would be 2 while the device is processing the request.

Here is a sequence diagram of the flow:

  Block Layer            Driver                 Device
  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80            =E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80                 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80
      |                     |                      |
      |                     |                      |
  (1) |  hand off request   |                      |
      |-------------------->|                      |
      |                     |  Owned<Request>      |
      |                     |  refcount =3D 0        |
      |                     |                      |
      |                     |                      |
  (2) |                DMA map pages               |
      |                     |---------.            |
      |                     |  into_shared()       |
      |                     |  ARef<Request>       |
      |                     |  refcount =3D 2        |
      |                     |  map_pages()         |
      |                     |  refcount =3D 3        |
      |                     |                      |
      |                     |                      |
  (3) |              submit to device              |
      |                     |--------------------->|
      |                     |  (drop driver ref)   |
      |                     |  refcount =3D 2        |
      |                     |  (DMA ref remains)   |
      |                     |                      |
      |                     |                      |
      |                     |  .----------------.  |
      |                     |  |  Device does   |  |
      |                     |  |  DMA to/from   |  |
      |                     |  |  mapped pages  |  |
      |                     |  '----------------'  |
      |                     |                      |
      |                     |                      |
  (4) |              completion IRQ                |
      |                     |<---------------------|
      |                     |  refcount =3D 2        |
      |                     |  tag_to_rq(tag)      |
      |                     |  ARef<Request>       |
      |                     |  refcount =3D 3        |
      |                     |                      |
      |                     |                      |
  (5) |            tear down DMA mappings          |
      |                     |---------.            |
      |                     |  (drop DMA ref)      |
      |                     |  refcount =3D 2        |
      |                     |                      |
      |                     |                      |
  (6) |  hand back request  |                      |
      |<--------------------|                      |
      |                     |  try_from_shared()   |
      |                     |  cmpxchg(2 -> 0)     |
      |                     |  Owned<Request>      |
      |                     |  refcount =3D 0        |
      |                     |  end_ok()            |
      |                     |                      |


We might be able to get by without shared references (`ARef<Request>`)
and only use an owned reference (`Owned<Request>`) if we add additional
fields to the `Reqeuest` structure. We need to track if the request is
in a state where we can return an `Owned<Requst>` from `tag_to_rq` , and
we need to track if any of the pages of the request are mapped for DMA,
so that we can end the request.

I am not convinced that having the additional fields is worth it for
simplifying the reference counting scheme.

> With regards to the Owned series, I still think we should split it up
> so that the patches making ARef+Owned work like Arc/UniqueArc is
> separate follow-up series.

I'll take that into consideration when sending the next spin of that series.


Best regards,
Andreas Hindborg



