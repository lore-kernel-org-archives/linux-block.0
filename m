Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EF365A13
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609884; cv=none; b=kGSlJtBEfWfLxJPGiboJX48BzPX1h+h/SQiRxnGWt++INwusi6FTTNVhz1VPxYqDNfLPGgzBWiba6eHfui/QxOg/yb9LI1+KgQuJjD7ODmsC7wo0J2nESvXZSxPYfnx7wjW+moOGQUjQyYYNVaajWaTmLy+Ujl08jxUqUPwd0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609884; c=relaxed/simple;
	bh=LCZsbY0WlkLDQaB+g3+Nolk280ujbFsPA+yQ4pCMsbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsJJgZ01clzCcTz7qgSqI5ihVCUWtjGXI+l3BuhUZRBl7a/K4W6I4wxdg+wjUBgwegSCnVohIj55B1qxKJxutTmnuWkEGsPK1layrNMzyjycN+H1qWxkhdNRJsBlhmQW2/y9aMNhnoKTRpOwllN290kgERpT/RwrGmDmrzGo4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkXXRdn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkXXRdn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C8EC2BCB3
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771609884;
	bh=LCZsbY0WlkLDQaB+g3+Nolk280ujbFsPA+yQ4pCMsbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XkXXRdn3F6OLSGvMtoYhWea3hwd7rj5rpPY1A0NzIFJ46pP+XBJ+Wmx2xxNeH2r5R
	 riw7uuD3bICVYvFIlvFq7fNsUyepUVK2MDRofNPl5YJjj4Om4kLbNc58JEHkbq2krs
	 qtKwUi6siUfzvgnuw4ZpRDlPweBfJwcWaUEyz/pqiWA3L89qqfhbEp/n66PfDh9kKB
	 j+VaAZNnLReB60nfZ0zJ2LOkKqaUq2QapC68G0xW4ueYzSjEJX/l4Xk/Pu31c0iEWf
	 mzmMewilVRHoJfNkcj9Q/ucVcVCEf1BQS6ME2Q+YSJqnSL++oEhOnSrUAuNgpGrBNC
	 eOaxrD4f35RzQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3870d178a9aso19722601fa.0
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 09:51:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeVmmW/p4gKK0UzNvpLCABOnrW+I26mmbnemOP5SBwSTnWQbnI86zPaFYr3qO/w5Wo9A9wo83q5cukWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwKmbgiZO5jTHq7fCC0gnzf+/xTFX2hkor4df3lFYu26D65gW
	bI8RDdHnQsU0482p1Pay6jCMTO6kIOmBypMAa71PfoKauLhuGpZrRNlw4VRmLQqDPzTzf99S4f8
	oQ8Y3q6tzRBlH1E4sQi3AOZx3HkyVpII=
X-Received: by 2002:a2e:be1a:0:b0:383:24fe:4eaf with SMTP id
 38308e7fff4ca-389a5de4d48mr1328121fa.30.1771609883065; Fri, 20 Feb 2026
 09:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org> <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
In-Reply-To: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Feb 2026 12:50:46 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9n2N5fCVdEF-jLsjLhAiyY7HLHA1dbanmxqEj1vuqfuKw@mail.gmail.com>
X-Gm-Features: AaiRm50BHJk8sWqZZGVukWMOtaBDUYkSm_Z-CQij1pvKGbmHOip5UB_YSDsNkM0
Message-ID: <CAJ-ks9n2N5fCVdEF-jLsjLhAiyY7HLHA1dbanmxqEj1vuqfuKw@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
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
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:34=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >
> > +    /// Create a `&Page` from a raw `struct page` pointer
>
> Please end sentences with a period.
>
> > +        // SAFETY: By function safety requirements, ptr is not null an=
d is
>
> Please use Markdown in comments: `ptr`.
>
> > +    /// `ptr` must be valid for use as a reference for the duration of=
 `'a`.
>
> Since we will likely try to starting introducing at least a subset of
> the Safety Standard soon, we should try to use standard terms.
>
> So I think this "valid for use as a reference" is not an established
> one, no? Isn't "convertible to a shared reference" the official term?
>
>   https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conve=
rsion
>
> In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
> stabilized for 1.95.0, so we should probably starting using those were
> applicable as we bump the minimum, but we should probably use already
> a similar wording as the standard library for the safety section and
> the comment:
>
>   "`ptr` must be [convertible to a reference](...)."
>
> where the term is a link to that section. Cc'ing Benno.
>
> I have created a (future) issue for that:
>
>   https://github.com/Rust-for-Linux/linux/issues/1225
>
> Cc'ing Tamir since this is close to the cast work, so it may interest
> him as well.

Thanks Miguel -- FWIW there's no current cast work on my plate, I
believe everything was merged except for provenance which was a bit
too hard to work with given MSRV.
