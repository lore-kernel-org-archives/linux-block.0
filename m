Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C5218592;
	Tue, 23 Jun 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220371; cv=none; b=k4+1R4iY9rMclE/9Zw12gbOg/zQnmFcRLBhil5lE8MgEiWcAuLqkfGaUzyPR35mpFAGI04dqsrJ79fOXFDdnlR3F8SJ0EoZIdgR74fmlUmIfGrDOmre88zkcQpasg+91Mrn4SQ/TODHobMCDOnYRGfdgXpvjC4Hk1IHEfFdjijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220371; c=relaxed/simple;
	bh=LuXejG0zn+L5dDE9r+JIoNsNQIfW2IgJExa7sTKqB7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALC6IxDqo9hDbg1um8wHC9kpy4kGp5yV1JofRi2Q7mEplEt9e6/EB30mQRx/fwEaQPN+0TXcJt3IB8eGz/Ufn5H9xx4UpzsOrp8kMsa1j2LsXeIWF7JSqCECknUNsE1rkRxpj5DC7jjTw5pQuMRGlW3BnP4yuBBPOPAmf74Kq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViufDM0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViufDM0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922CF1F000E9;
	Tue, 23 Jun 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782220370;
	bh=+rzFpQ8O/10QiSxDOc9EPIkCdPQE1on2cJQrgpHbAZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ViufDM0EZ7iUxbOYXY2wdI5lAjc9KlTZkhijrIJU9IXCwHIq77eaTYi1q+b++HSJt
	 jRu44bv9q4fNbTcplpUTdl0GDJZVn840Fzexjq6sM7GPsYSYiTwtSkcLVYnzJSyZXC
	 XfMSaa+2lXkLKi3I8GME16fOL0/IlJBx82RnEsWbIgLgfIOVvDS8Fqgg/B4uDOaU0P
	 8Yzb+3txaIfMRxZ3u8Rw2Mf2i/3MpTM5foSzb9RR+Z7S8KQiluZIW5EyK08LEoiVk6
	 4B8eyMNZnIAxVokQYMJlAOvP7Ap0MNQAr72k2+A6DrfvBqVFG4VbXV4/dMqiiLtFsS
	 GX+wqSW8Cjyqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, Uladzislau
 Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Igor
 Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
In-Reply-To: <DJAGDGPKZ4HX.M47NMAU53PCJ@garyguo.net>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
 <DJAGDGPKZ4HX.M47NMAU53PCJ@garyguo.net>
Date: Tue, 23 Jun 2026 15:10:44 +0200
Message-ID: <87echxpfl7.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Thu Jun 4, 2026 at 9:11 PM BST, Andreas Hindborg wrote:
>> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
>> places such as the `XArray`.
>>
>> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
>> implement `ForeignOwnable`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/owned.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index 456e239e906e..5eacdf327d12 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -15,6 +15,8 @@
>>      ptr::NonNull, //
>>  };
>>  
>> +use kernel::types::ForeignOwnable;
>> +
>>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>>  /// is implemented on types from the C side.
>>  ///
>> @@ -108,6 +110,7 @@ pub trait Ownable {
>>  ///
>>  /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
>>  /// - The `T` value is pinned.
>> +#[repr(transparent)]
>
> AFAIT this `#[repr(transparent)]` isn't actually needed.

I'll drop it.

>
>>  pub struct Owned<T: Ownable> {
>>      ptr: NonNull<T>,
>>  }
>> @@ -185,3 +188,46 @@ fn drop(&mut self) {
>>          unsafe { T::release(self.ptr.as_mut()) };
>>      }
>>  }
>> +
>> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
>> +// pointer satisfy alignment requirements of `T`.
>> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
>
> You should drop the `'static` bound and put where bound on the GAT below
> instead. See how `Box` is doing it.

I will take a look.


Best regards,
Andreas Hindborg


