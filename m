Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497312BF006;
	Mon, 23 Feb 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858865; cv=none; b=NBUgeLpV8ldkUii7rwdrheyuBZxOj1atxwmwdBIl1oNk4xXQODGNRv3iChVU6m78ydpou7hmEwVw69ofPh28lFKvc3U07C6OIx0m+4Wh14w1o/DzPLdNlz0wJhm2OIrtnyCDImVnJ0KLlB8+oiuhUfOpFZ2TctJW2xfYytiErFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858865; c=relaxed/simple;
	bh=B2xz+fKywOWEPJTQNuZF8b8xXnGtl74+wA7wAJ3QkxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmpuFClaojhkD6KLKVIEXMwuOC/4CTi5+Z18LoAf221KOV+a5yFf61+zeKtj+jjMMpDq863j8YDbVPkJA0dmgJVJqBozG+qJeyWMKig+4iXLNzriO/Zy1zoH3Jj3S2iP2KtaIMhotaac8Uw+zBk4DxsuNfldtS63KoteK3Xxerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOrhgw47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOrhgw47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36122C2BC9E;
	Mon, 23 Feb 2026 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771858865;
	bh=B2xz+fKywOWEPJTQNuZF8b8xXnGtl74+wA7wAJ3QkxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HOrhgw47XKZDmMg5MWkMID+V3NSTRD5aXf9oLJqWATirxNXAGLX+AzBhK9DL7ue6Y
	 iRjkFN9I3/9860PJ7I96Gu5l3xhG1Pf/AKFbkpRbHcrSIXFHoNB2OEEWs7mRRV6Izi
	 HGpZclyGYgQs7dVfpAkVYQmkKnaPs9hGG65AGpFxST0PIg6b7LxgokRWLq1Eyxa+Qx
	 wvlDVZdEUlxqyvh9oRaiOrQTzUfjRfh9ud3uQ439zrysDb8s9wZeSTo3VZTKm0OqNO
	 aZ8Uj8uN/cy91LRX9q+l6LK/lc2Rx6W9BDqezQ1KFQv/BIP+k1F/EXHMQMxLhbwijq
	 B35CWCvsJpVnQ==
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
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin.linux@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
In-Reply-To: <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
 <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
Date: Mon, 23 Feb 2026 15:59:59 +0100
Message-ID: <87tsv733ps.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>
>> Add a method to `Page` that allows construction of an instance from `str=
uct
>> page` pointer.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  rust/kernel/page.rs | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 4591b7b01c3d2..803f3e3d76b22 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>> @@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
>>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>>      }
>>
>> +    /// Create a `&Page` from a raw `struct page` pointer
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must be valid for use as a reference for the duration of =
`'a`.
>> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
>> +        // SAFETY: By function safety requirements, ptr is not null and=
 is
>> +        // valid for use as a reference.
>> +        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }
>
> If you're going to do a pointer cast, then keep it simple and just do
> &*ptr.cast().

Ok.


Best regards,
Andreas Hindborg


