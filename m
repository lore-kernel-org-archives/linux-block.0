Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612D4205D
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748726; cv=none; b=msjPd/fOhY2VWEow99yioqOC6ZUwzzxwFVctkO1eq/74Fa0vohq04dEShD7XzT/rJvFpJlJV3YARo/C5EsqVlwDldPl34Ia+i2o7AeTPxwE43fGsDMXb7wv4XIAJN3FS2HrUXan64iJDXjtcLdT8tg9Y1OHcxuKw8CWcbgluIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748726; c=relaxed/simple;
	bh=1DV64RzpVMCAX55Iauonqozdn6VLZrNKEpB/bDsTJ/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utl5QnY/P0oxmgtD5LFuZhjWvBoaEbUIMflnvSoF0bsMa1hZ5gHGVe6plPBBMEtFZLA16g6ZtN3Jk49zpxeE4OHm2PqhXxpsRzQx5fhLXPHP9zEhsUx0ZGIGCMRuJj/yipcQ+9lAQxmcjrhcNFwrkKR5CX9PgcjrjvPsc0Wu6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nOw5w8Z6; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nOw5w8Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=eybudsxja5hwfk6bdmj344og6i.protonmail; t=1723748716; x=1724007916;
	bh=1DV64RzpVMCAX55Iauonqozdn6VLZrNKEpB/bDsTJ/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nOw5w8Z6boJ9LfhZXXmr/kh0bam8ZVCAkMt4H669lq0cgjMWERD29gQFhQAhCYV5u
	 ePXLouJ+zmfB70A44QDNrr8sSf3FmMBwtiGaUGb+LYXUrdqQHyxbUYSrfE6bHVq1Et
	 IezjH8YnKD3KEOq328T/Bx0wcYryszKdzksWR8FGycJ7G9UVtK1GB9elXFFDuZKJmf
	 OMsBi1gpz3ndAbamSzEYr79WoK3B463KU8UMCFC86CJ41pCsW16wLDGRY9Mth8BCWl
	 ws95SeyVUD0hYYnoGYiywaQmkItsbdkJ0QTg3SaH6iVxRoB/l4YQz0bpTsF5f0RAMY
	 /Ciaa2rB03N1A==
Date: Thu, 15 Aug 2024 19:05:09 +0000
To: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <10ae8a5a-5dbc-4d6a-8f86-30236dacc5b3@proton.me>
In-Reply-To: <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
References: <20240815074519.2684107-1-nmi@metaspace.dk> <20240815074519.2684107-3-nmi@metaspace.dk> <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d6c547810c6ff8f844f72e469f2489227a3f6a48
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 10:04, Alice Ryhl wrote:
> On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>
>> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic lo=
ck
>> class key without registering the key. This is incorrect use of the API,
>> which causes a `WARN` trace. This patch fixes the issue by using a stati=
c
>> lock class key, which is more appropriate for the situation anyway.
>>
>> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module"=
)
>> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
>> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Gener=
al/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.2=
0lock.20warning
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> LGTM. This makes me wonder if there's some design mistake in how we
> handle lock classes in Rust.

So `LockClassKey::new` doesn't initialize the `lock_class_key` and is
also movable. I think in this case we either just overlooked it or
thought that the C side would initialize it.

For those people that know about this, are there APIs that initialize
`lock_class_key` themselves? (ie not a function to initialize a lock
class key, but rather an API like `__blk_mq_alloc_disk`)
Because if it is usually expected that the class key is already
initialized, then I think we should change our abstraction.

Additionally, I think that it needs to be pinned, since it contains an
`struct hlist_node` (I might be wrong on this, but that looks and sounds
like an intrusive linked list).

Also the `new` function is probably prone for misuse, since it will
create a new lock class key every time it is run. But as I learned in
[1], the more common use-case is a single lock class key for several
locks. Therefore it might be a good idea to at least rename it to
`new_dynamic` or similar and add appropriate documentation pointing to
`static_lock_class!`.

[1]: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/top=
ic/.E2.9C.94.206.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doc=
test.20lock.20warning/near/460074755

---
Cheers,
Benno

