Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493C2D77E6;
	Tue, 23 Jun 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220380; cv=none; b=f6rV8hRsk7M8qmhcT0kAXzq2iAjK2ZGR28nnAcnjGOrpQztqtiGeZpDtj6SFpsKAf0O8sJf2LKiGcHBIgFWC+ZDVaTeIMrPXjZebdtirGJN6efWPgjWx26p9jJPqqz66j1C+Neq8tzFLgtCpHiB3q8BTBIbpCpV7y10irSsSioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220380; c=relaxed/simple;
	bh=F6dLBYzjtySNXdlF/ueDqVKFUqsZiLEsVnSYHRCs39c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p8OdVsMBMiu6PmB6dJK8n2qN9aTgq3TPWyZRV0ZPnptk7jRyRd3Z19E2qoD+WKwh6+0b3TPRTMYqh8cN8qGASqsThUJgMfk3pTPElN6SlicgPHy8H0iSKbFt01Yvylfn1mzrkAv9fsUU4i1LqQXobGjIRwVES5YUIs77fmJ8WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLxbvif4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLxbvif4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D151F00A3A;
	Tue, 23 Jun 2026 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782220379;
	bh=8Phdfqke0BCmhfc0oBfjNrqGUeVtsij2zEYdCciFrjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TLxbvif4peVjybpzPACL2R6+EOftsA4RL/WHYu2NfjIJb4nO+Rp0EnDsa5BN94xeZ
	 ZsOQDq2DKWAFC1a5u0Q+k8BO0R7+erFAA6/QI5e8JarlMRkJ1u1iSSIyBJ44mMaLXN
	 X1QixsoCdk60pFdaSEQbhkazqlAGZibmpF5HBHKZIgjmIAFxgPcXbHPuZhwsTNqEgn
	 vxr3cW01mAE9ooGjLqhBsA6PO7WQVIV2xEnEr/GYA0jnm0OyNpxbAFZNDY/0MCHbkw
	 XDn/gxkjeEeTsBiOYrsQx1U99GagLanBoJ8AUSBoZLbyuELioTYmiVVPTeWZdDhm8a
	 gBaGy/Nou1o5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
In-Reply-To: <ajKGv5ioLSassmND@google.com>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
 <ajKGv5ioLSassmND@google.com>
Date: Tue, 23 Jun 2026 15:12:33 +0200
Message-ID: <878q85pfi6.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Thu, Jun 04, 2026 at 10:11:17PM +0200, Andreas Hindborg wrote:
>> From: Asahi Lina <lina@asahilina.net>
>> 
>> This allows Page references to be returned as borrowed references,
>> without necessarily owning the struct page.
>> 
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> [ Andreas: Fix formatting and add a safety comment. ]
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/page.rs | 38 +++++++++++++++++++++++++-------------
>>  1 file changed, 25 insertions(+), 13 deletions(-)
>> 
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 3bdcee0e16a8..844c75e54134 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>> @@ -10,6 +10,11 @@
>>      bindings,
>>      error::code::*,
>>      error::Result,
>> +    types::{
>> +        Opaque,
>> +        Ownable,
>> +        Owned, //
>> +    },
>>      uaccess::UserSliceReader, //
>>  };
>>  use core::{
>> @@ -105,7 +110,7 @@ pub const fn page_align(addr: usize) -> Option<usize> {
>>  ///
>>  /// [`VBox`]: kernel::alloc::VBox
>>  /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
>> -pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
>> +pub struct BorrowedPage<'a>(ManuallyDrop<NonNull<Page>>, PhantomData<&'a Page>);
>
> BorrowedPage<'a> is no longer needed because it's just &Page.

I'll add some cleaning then.


Best regards,
Andreas Hindborg



