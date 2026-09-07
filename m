Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A684F55A7
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790030; cv=pass; b=mztne1837c6dj75Wl3rU1RnpoyUIKQ0LMgfNwY9QlVu4zt5yuW5+aubg6Bia5LQmFfBrfCRWUUtIy6ryxw5WX47IoKLBrC6qaCmqoyhsZCWqLhYN4f4zoTADvVFDUyJEEnFXVdfah0wb/1RZYcOEW/smaj71ZANMZNDxWHjhTKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790030; c=relaxed/simple;
	bh=HvMD0whYP38ILXbRvW4RQd+DD6z86Cgv8Z7FhShCV6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7PbgbCG4hT/dnAdfl7FsZF2szQfLI1EIDETKwSIc2sZ1vEnle+/sUvOgUu2S0oeDSjOag+kOUI8GgD5LWwaAOjZotxTDOcJ146eXr5oMcaHGsR3boG9XomcYbb5bdpVYc6BGrWIEghkjBJwCGPh5yiPHLPOYCkwWgrXU+LQ2Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQrlrIzN; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQrlrIzN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482dd6ee390so4120358f8f.3
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 07:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788790024; cv=none;
        d=google.com; s=arc-20260327;
        b=H/CeyZe/QX2Edxzl/YJUv/NL9aglw9MGsjobSRl8HKtx9WOEZ0/z92HSjoLT1LOUX0
         ctY/+/3ZoEOlPErcPp9Ln6QcQFPofXmbKf0MK2ntYW0+18Mf+hc0BNzK3/E0g7igFFY3
         NWnYmWC0drOQ8+1y6Zv3Yiw8NE9xstq43h5S4GR6bnMx2q3HqBcx5t8KTnl4x02KnM2+
         O5neNy+gufZ1AO9FXnQ9aKuzhvM92wIPKDlliFPO+yIyOv7dE5VIs2XM9FPaqD68DN9h
         K4T6YUTXwnqUSW8IEvBFRG1HdJ7+QrYqAiPRW/DGfy91it3XNxOnWomfF1SmTZv7xyOt
         gu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vg2AiEFa68ARzliVtiEYWMnugqjIY8Sb5bHhQpyrHpw=;
        fh=KzFf6NqIVeAwNMLwkW1O9lfA09wPwEFsESggc5JvNZA=;
        b=WPtPo4P2ng+WKTKYksCXoNHJ7xF3FJfQIfITwUGSpZQ/mwzhQxBu4LRx5mt+nc+MJ3
         PP4cvFkG/6anACqKwvHZ1uKjo6rv2dq+12XCCwpj1EpZai+avaaO9bb9WNR1rlbeeRvT
         tS0G4ncbyxyBiicKX2PGPcofWAA3y9IP1CRTCgY3VMj9JW4KZtIV1uYAayVzu5T1ys63
         km7bhRez6S4XfkfFl3XB4N76ul4oACKrFWHKrTTMGOMSZvHGIkTGLaN61wtrX02QEef2
         84QbnlP1wnIfgY4iiQZrE52fNZFAMuQi2mSmJ4mZqCfSms66sYbGZrExwPi+7QmUtLFg
         bZSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788790024; x=1789394824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vg2AiEFa68ARzliVtiEYWMnugqjIY8Sb5bHhQpyrHpw=;
        b=aQrlrIzNQyqSfh0XaP2ut8GCXtY2oAawElTBuV+LQljHX0gNJJseP0Tj8aYK3SD1UD
         DxMjndhj5KDlpdyEjZ79evHFe2IvVI6bUG4QUExTHVt3BfH4WcZMyheKZvC4sbHcvvLy
         0un/LJkrtmw4eV8OnJFyUXGOvuzt1Nq0bP0mxJYJNQa1rJ/gwBypWZznL9EtEsx7+ia5
         JB7V11qwc5rDT4HVc+V8HMuvDEwdwaR8EdRawNbtRFNOCyn6VhGnT9LikoOyRyfJNPF3
         UkypSUwLLWWjBO6uU5u0KVpC7c6gx45KQFXmtTtDxEQ3U7M2FcdxMqL+gLfg0yJ7GO4p
         XuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790024; x=1789394824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vg2AiEFa68ARzliVtiEYWMnugqjIY8Sb5bHhQpyrHpw=;
        b=lN0nzqBTu0yqNvYKS2meGHiK9Y4ApZDv7bRcNgYr+lEt7AQTmMM8ri3fw7GuDmBnJP
         57mc7YYWP3/x0d+bEkalzLIUKCuL7EU9FHKrCLoQDWrfaTteh3I4k/szQnX/U1CfnfFd
         VT7c7LW5LmW0dkyfae15xjCVHUCtGAVKfD3/RUtzsl0CSIDTTiV+0GYHKbIe+ET2ypcg
         +oHZAuty+kHo0INDVFc5/qitdF1vxFeapfVew5JMtCM96f4EPPfKIeZIymFtA+dHKlLD
         WU/vUxE71ysAQxOOfle6/hYnKoE86giFyNT4sGfM0llqMKdaFnkTb2RW2z7xZbP0kHkJ
         MheA==
X-Forwarded-Encrypted: i=1; AKwUvBy1wD3jm12dOCTM7yeI7usyOfy4ynFdhByBidCHRJJ4HbVjqVYtxCy2ScXRS0PjmwDG4kv/vO7vvXOVxQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kOzVkt4FBN9XuVsuZFL7/VHV4bw7mCJ4ShLioPQ/+XMFmlLCSb
	8gHCY2iFkI6NvGpZio9cMbTy9FMXQdu4b/1jKDyWBums8uZva73FmteiKm2DSzcLoo+Vpy+cFXl
	eEnyPUtYEHPD0tv+RYv5NbEcx3Y/UK6+BExxWH8Jd
X-Gm-Gg: AYBFou01gzEWSdRjz/wyGucWiG84NuEifMv0IVssNsaKGONpHffkTbvbyFSddfJyKiz
	n5zWZAQJUnj+ua05YxQ+Kb1UVpICL5b0pu8igGEp9VUHxzmmSBTkdtSNEneGT8/C13cknM3tyZ9
	m2mgErSzhYiPwwe2D2zTPXekcd1RDJEsO6pyUD/wMtfWCdcO5nW0MLGLMKlukQQ3lu5z1GqvIHE
	FUhXZuXCSsYtageB/IngAuQyAADK+oodsubRk9p1YZR7ticIBN0rJNFotL08g1B7ZA20kurlZih
	1PFUXkxeq0qtzrLaVYHKgQJosVry98md6hM3OzMl2ILYp1BRk1XSVjAUnhmjiDnt+c4/0T/4ELQ
	uwh20cjs3jpFI9A1mOLeskZpinc9bArQ=
X-Received: by 2002:a05:600c:620e:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-49cff2078b8mr196871015e9.31.1788790023400; Mon, 07 Sep 2026
 07:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org> <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net> <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
 <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set> <2dpwVpJS3VbfQ7CmE3HeY4IJSSMXTP_O9sSP3HHHUD7Z29RNEG4Hc0m8f94jKWjFlekcTXvIBA-QdGYrf8w1sw==@protonmail.internalid>
 <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com> <87zextw4c4.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87zextw4c4.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 16:06:50 +0200
X-Gm-Features: AcwNN1U77QgBa8sE7Mjd0WimH4SDjDY5r-Et6lPB5NUv3A9JgqpUTtiAXpyWSl8
Message-ID: <CAH5fLgjYmvp1Ph3dYXnTKkAvWgNpgCAPeq_7PZhRai6pCNmVmw@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Mon, Sep 7, 2026 at 2:38=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> Alice Ryhl <aliceryhl@google.com> writes:
> >>
> >> > On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> w=
rote:
> >> >>
> >> >> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> >> >> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> >> >> +        // SAFETY: We just successfully allocated a page, so we=
 now have ownership of the newly
> >> >> >> +        // allocated page. We transfer that ownership to the ne=
w `Owned<Page>` object.
> >> >> >> +        // Since `Page` is transparent, we can cast the pointer=
 directly.
> >> >> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >> >> >
> >> >> > This doesn't satisfy the safety requirements of Owned::from_raw()
> >> >> > because the page may be used with vm_insert_page(), which increme=
nts its
> >> >> > refcount and causes it to be shared the vma system, and this occu=
rs
> >> >> > before Page::release() is called.
> >> >>
> >> >> I suppose the existing vm_insert_page() abstraction we have is alre=
ady
> >> >> problematic, because it uses `&Page`?
> >> >>
> >> >> Maybe we want to change the API to use `ARef<Page>` so it already h=
as to be
> >> >> shared? Conceptually it takes a reference count from a `&Page`, whi=
ch isn't
> >> >> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&=
ARef<Page>`
> >> >> to be able to do that op.
> >> >
> >> > Honestly, the problem is the safety requirements of Owned::from_raw(=
).
> >> > Pages have a "special" main reference, and free_page() does more tha=
n
> >> > put_page(). It even does something when the refcount does not hit
> >> > zero.
> >> >
> >> > The correct behavior for Page is to allow the user to hold one
> >> > Owned<Page> whose drop calls free_page(), *plus* any number of
> >> > ARef<Page> references that invoke put_page() on drop. This way, the
> >> > owned page controls the special drop codepath.
> >>
> >> This does not mesh well with the model of `Owned` behaving like
> >> `UniqueArc` to `ARef` behaving like an `Arc`.
> >
> > It's a different case, I agree.
> >
> >> Please help me understand; with page having a main ref and an auxiliar=
y
> >> refcount, if we model that with a single `Owned<Page>` and a number of
> >> `ARef<Page>`, what would happen in the case where the main ref (`Owned=
`)
> >> is dropped first? Is this legal?
> >
> > Yes, it's legal.
> >
> >> My intuition here would be to follow Garry's suggestion and have
> >> `vm_insert_page` take an `ARef<Page>`. Can you elaborate why this is n=
ot
> >> an option?
> >
> > That would be the wrong ownership semantics. The C side increments the
> > refcount rather than take ownership of a passed-in refcount, so the
> > correct argument type is &Page.
>
> Or `&ARef<Page>`? Because with `Page` being `Ownable` it would not be
> OK to increment the refcount from just a `&Page`.

That's just a limitation in your traits. There is no problem with
creating a refcount from just a &Page.

> > Now, for the use-case in Binder I believe we could switch to
> > put_page(), as we don't need the extra stuff from free_page(), in
> > which case we only want ARef<Page> and do not require Owned support.
> > But as long as we are calling free_page(), it needs to not be
> > clonable.
>
> You are calling `__free_page` directly in binder? I could not find this
> with grep except in the C binder. Is this code you are calling into from
> Rust binder?

Via the Drop of Page, not directly of course.

> From `__free_pages()` kernel-doc (`mm/page_alloc.c`):
>
> > If the last reference to this page is speculative, it will be
> > released by put_page() which only frees the first page of a
> > non-compound allocation. [...] **If you want to use the page's
> > reference count to decide when to free the allocation, you should
> > allocate a compound page, and use put_page() instead of
> > __free_pages().**
>
> I guess this is what you are referring to? We could change `Page` to
> this style as well and all would be fine I think?
>
> At any rate, today I learned about Pfn walkers, compaction,
> memory-failure, etc. that take transient refcounts
> pages. With that in mind we need to reformulate the invariant of
> `Ownable` to exclude optimistic transient references.

Yes we can switch Rust Binder to use put_page() and have Page not
implement Ownable at all. That would be okay, because Binder's pages
are not higher order. But this case still does highlight that
Ownable<_> currently does not address the use-case where the
Ownable<T> is a special reference there can only be one of, rather
than a completely unique reference.

For instance, the GPUVM abstraction would be another case where
Ownable<_> could be used if we have this other model where Ownable<_>
and ARef<_> are legal at the same time. Currently GPUVM uses a special
UniqueRefGpuVm type to solve this problem.

Alice
