Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46B3563ED;
	Mon,  2 Feb 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026843; cv=none; b=M5gw0TqLknX1ZghNdqRxGBVDERZPPhSV1oMa74Ev6FsXBx+YPbpHwxLAwBvRWiCmLK1+XViM4tAmMxEOTsJaaYjjK5zXRPMg/Koc99zDlwmCjqcvNNpFF+cAXaSYeCsmWAeNLNBCLxNu8gyCMMSMGJ0Uzbgg/2o/66xzOofHrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026843; c=relaxed/simple;
	bh=SPlQg0EyU4/DCh7w2oS8RGOQsjsSnbyrEHo3KSL1y1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWc5re8mhjpI9P7mpVSwJTIG4QxDbHBDzI0Mt/ACpK9tdjLpf2bycuftCxK9YoAbYGIzoc6U+DfSbJwo34CeMKbTsXuZw/ASVTXU/1J1q3KFw4kwfrGaEM0dr0VMElFynbKNBIGF3J/o4W1oSyFko+fS1jh1uMGfksM16HKDOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQK92qyI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQK92qyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4150BC116C6;
	Mon,  2 Feb 2026 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026843;
	bh=SPlQg0EyU4/DCh7w2oS8RGOQsjsSnbyrEHo3KSL1y1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HQK92qyIX300LRHc2aMK3ubwx7dgLYNuRzLyUUyPldXvf3QcHTBEDznZO9XmT4/xY
	 CIU2+TouJ8b0UyXd4vzERXzW5Cf/dUF760N11p4gF3cvmqGdeP6kbv4bIv4CmGBiEz
	 CDCnliVNe1XhjJ92SpkO91ctMJIVid5sN0XpQW6xEMqM9ZRi57oVT6jhJCBSG61PPe
	 R4n80mZejwHKCRPr4cKNCtNbgTV/LVPVx//RFH3C/pvvRBkuacSHU2tA3lconM/VEr
	 SyWvAEe6FO1M+FglA7GJxmfGwSWOjAC0xiQefn+pDeRSa4TkXkDF8gUy6JFDJawicR
	 x2altsxN3dX5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Oliver Mangold
 <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Paul
 Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 3/4] rust: Add missing SAFETY documentation for
 `ARef` example
In-Reply-To: <06C410F4-8534-43B4-8DE1-039F70B26E5A@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-3-b5b243df1250@pm.me>
 <06C410F4-8534-43B4-8DE1-039F70B26E5A@collabora.com>
Date: Mon, 02 Feb 2026 10:52:12 +0100
Message-ID: <87tsvzpj5f.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Almeida <daniel.almeida@collabora.com> writes:

>> On 17 Nov 2025, at 07:08, Oliver Mangold <oliver.mangold@pm.me> wrote:
>>=20
>> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>>=20
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/sync/aref.rs | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index 4226119d5ac9..937dcf6ed5de 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>     /// # Examples
>>     ///
>>     /// ```
>> -    /// use core::ptr::NonNull;
>> -    /// use kernel::sync::aref::{ARef, RefCounted};
>> +    /// # use core::ptr::NonNull;
>> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>>     ///
>>     /// struct Empty {}
>>     ///
>> -    /// # // SAFETY: TODO.
>> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not=
 count references and
>> +    /// // never frees the underlying object. Thus we can act as having=
 a refcount on the object
>
> nit: perhaps saying =E2=80=9Can increment on the refcount=E2=80=9D is cle=
arer?

OK


    /// // SAFETY: The `RefCounted` implementation for `Empty` does not cou=
nt references and never
    /// // frees the underlying object. Thus we can act as owning an increm=
ent on the refcount for
    /// // the object that we pass to the newly created `ARef`.

>
>> +    /// // that we pass to the newly created `ARef`.
>>     /// unsafe impl RefCounted for Empty {
>>     ///     fn inc_ref(&self) {}
>>     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
>> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>     ///
>>     /// let mut data =3D Empty {};
>>     /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
>> -    /// # // SAFETY: TODO.
>> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>>     /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>>     /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>>     ///
>>=20
>> --=20
>> 2.51.2
>>=20
>>=20
>>=20
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Thanks.


Best regards,
Andreas Hindborg


