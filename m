Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED533F362
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584614; cv=pass; b=o589NYE5RB9imteSq3IUN359KGcv4Je8QMTk3h4abnkKJo6zlAKHQGkhb8jW/mQw0gyERE0hd1nyRf+/rlcIMDifH2eOyYwyFaolo4ftjZg+WYuw2oWAWrwFX4Jy4gOG7cfRrqbmwQJPMziNdcbl4FwOVkqMRFfk5rcf52B767k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584614; c=relaxed/simple;
	bh=oIngJ6S5SUKbvESTbw5vt2bQmTdKhr5N3+wDe58Yw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rA+38gZ5auM8NnsldhBe2mBaJPmpKPHinp+MBkG+4Ik018OB9t0nT8rmyu8JllNAHAOmz9c811j3ejii0yvosU7g3pjwPqtFOeSmNzspDq6ZBHmOmJ9OELscrd6u33LLcX1BTCFg0XqdxWdx2A0B2MmSgjhDQ6KN62qrVIOqivo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrSMJnVF; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrSMJnVF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43626796202so1760816f8f.3
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 02:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584610; cv=none;
        d=google.com; s=arc-20240605;
        b=UbXtCQoBGdvIMVj1XdKOECS7QYBfObiNTUqyQ/TOBzb1y8W38AwAq+PNl9HWRtMbaE
         EVU7Nfe27MfxJXYEc0gABXpa7kZgfyVvth5XGLdkuSDkQmmwKrQAAj99CAspZq7/LgyJ
         9US5dlxU9bsqT45kSLCJczBCUt1lyDvRrUREmUi3m/l5ESWBcWMx9DTiRrBvWYQEbBe0
         CanF/AY043YzcW8CUE/XYJyqR8sl6dWKL9Fd3zBhnH2UhI2s5GMmHYfYk7eNZIund1sk
         CEVQkvoEMHZS12hz+H+FU7isrhYkk+DaAZP0YQW2J4eLhZghaGNU8Tf/RFytixiVdT/2
         42YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        fh=uINJIT7AkoPXmEkGN3QvvpaX2VVFURNqYaLu2BaDBHw=;
        b=ceF5lUrd7bvH4j2haNeFp13VNJhWJKa9jTdE6vSedn6uhrqZFnlO1dme8HNenAt8p7
         Ln2aWa/Up2IYXjSztIwRQ0YYFnboNNYQhkQqAbFHBRbxrcBy4CZp7t+fjObr7cY1sFWX
         9Hj9KA3HIk50LW7J2ZMAEkDSLBpJDugYwcgspLV4gayC+GQAU564W5utkM7SXxms9Xxt
         n6xru+ecNk5zEhXZDX1BeyCdg0iEgY3yLjJFz22p8DgNb+2VYZ5bXN5m8AkNExppNvMY
         pHDYvrTQg8dl99BSXOiqGJlktKrFUB+64y1Na5TZinzh86bT4VKep4PxBr17iueFYRYH
         G+Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584610; x=1772189410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=WrSMJnVF5uBG1etU8Ao1aJIH79rL4B/ID7aOQVzdXbXEAdapztjr+4Ojw8JeHNFzt2
         dlIX5bMaHjSwAwqSEjpbFcjWcCz/Ytn+K1E6hC7kI3h9qjQUDh33ZJHsKdwmHuuhVGRP
         YFF0cE/9CorGsiF8nd1xmbzJ3t3K/qoPOti9J8BMYJ/xUB/nPHYgwPenjrQey3oTVuLG
         c1sOzkT6SCPTSC1qWfTj6n+lkDppOSu17WoIm0D9qCdM74Q/2YDEWRK19PZ3iOOmz7QI
         hGSxz50RSjTI4gysJQiaeqVVYLKibaZlO+bWe1TNVaOl6HXS7zjCEKcoetqQAgYiZCyB
         y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584610; x=1772189410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=kQGAw81xHTqS4i8qMqqg7MUyPbjunJ4lP/fB3Agafm5grvp0af3iStyZO+YDXNKFqv
         PC/A8FQ0yntpzAy2U1taS+1ThFXTNYjDIeZzXjFAWXfoi372oIeNEJDM7davpb23egjQ
         HN08VaT8Apx2tANCsXX7XVrWiKnXQwHFac+diXSlVp6IVnRnemAtINe+52Gk7n0oWjcJ
         07NLUPfqwesRpxkcVc6iwOovLWH7lThQTU2H+qaNi1DPXW43EiKWTXndLfAlFnCMDa//
         lQfsW88rD9le6pCiA/Uo0Rj7bjuwnW40m8u4tS9BBZPkPuP3i1v0hvArspTFN08mWtGh
         JjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQNsByWCFJ+sMqTqh4sN3LBagCAVnUaPKifsPyJrG2EYR2WFJhxzofjHXSV9SOJcOG/IplfXtI3FVVQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFZh9sztcd1EfCoX3e04zCiOys2cHzZKjskqHRJfO3+i5MpIR
	JXkfaftg/5bplVdV27Bgn57DCqLE/2RAg0QYqIC998bdz0/blcpLqSrE51OjwiHF1FCSU6tvvIx
	FkB+7t6IH+8hiOufrQ+rIV9RkKlcsYQbi9U9ygQrZ
X-Gm-Gg: AZuq6aKVMkUaNsVtSF1z5EJksYS2B53rKIx7gaL4xrjSG0MqIDlgZ+gEAIaqyHUhdZj
	255gJC5F6mJlczMuIrp3jvsw600qlfdPTK9vAnOIurqKs4CzmWe8yyWnG1Fo1PvSkoiPktIInX+
	jC1H9CKpYFpkVpFHXVE8/HjDGyNVH+plBk3m3vd+pgz744v0bVJ0hco2YaYv1M2p6Rex3CSfkUr
	+VBruaC12rvc5J3O2vhJO04SHhmDQpQCDwZX5cHQzeQglXXnjisVTU4fzIachxVQF+VZjCoaF0s
	MFj6aq2UcUFR/S8edskHq3DJFA1tkOrhtZtkDA==
X-Received: by 2002:a05:6000:2409:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-43958e00ce5mr15101201f8f.18.1771584608836; Fri, 20 Feb 2026
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:57 +0100
X-Gm-Features: AaiRm525n9TXR47KvplRQPUHuuUwgU5iN4_ng3kUHWK8LN9TrQcHulfhA1IhjZ4
Message-ID: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 61caddfd89619..efe16a7fdfa5d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// # Examples
>      ///
>      /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>      ///

Either keep the imports visible or delete this empty line. And either
way, it doesn't really fit in this commit.

>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///
>
> --
> 2.51.2
>
>
