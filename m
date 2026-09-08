Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6853445A;
	Tue,  8 Sep 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869503; cv=none; b=XU70PoMpPBqJt2vBlQvOSFEHUwCcPCskCLo3YjYzu3kgTG4jzW7lZ1QPfpXjVcSviqrLEOipoV16ZTtsNDZ0L7mK8L6VpRSXFC/OE50DY5A7URyur384bFwsde6QtJK6g2mqxlxgjqP3zqUXYs5Dpq2tAi1ekfkoNe4AACXkY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869503; c=relaxed/simple;
	bh=uaQ10Apwu67+uFdsBLzTilasS4liMjcczBaW2+tmNNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEg1n7RMP9s7MXT6cFwmuTAxCgP1ZAVezHH+ZvhSUCTT9FaJggmEpZvUgrcQexPJGd0o6Hv6qE+Gk0uOQ11HJNKFNT5XnmBErkMNo6YeSQGtdMqVAdKOcE8oDF01uD16rglY04Sgb1YbQZ2Xeo0vWC9QE6fV94hhkL1LI/vjY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGMrz+Uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGMrz+Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836221F00A3A;
	Tue,  8 Sep 2026 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869462;
	bh=Iogr4guSukTn7BNwHpl36e5eQOn5fbSrjKYt1mM0zZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NGMrz+UoNf/gzaQ74JTfvoy7vqEpiw+5cmO1q4iP3yGfSAjHDVAN4/CMNqORDPu4n
	 HJl+Qq+4W8rI5VQ2LeiZLjAJlqVYQ4R5FU5MHyCF+oFtznk29zfKuTL5ZLchElsBNb
	 0eJCxdkHcn1mvaRAmCxAu8WD9YZH/RgfqaJKn1EWHoMuT9EFFfyR+r+Ju1UjOUBm3e
	 8KwKksoimiSzXS34OkSVnFOGIYz9tkgwPyHprsro/tRuNIUakklpM4RlWUmnJFCrSY
	 wpu/sO5kJMg1HOOsq68qOmuarpS+zYwOP/2zS07HgExdpFKBauBYGI68RBci+m6JUw
	 k0/p5zwRBIfFg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael
 J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski
 <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, Philipp Stanner
 <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 driver-core@lists.linux.dev, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-usb@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
In-Reply-To: <CAH5fLgjrQDWSPX-81TNdnc=AU3Jge57vUJ_SHCn8=uUyGfRq=g@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com> <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
 <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
 <2dpwVpJS3VbfQ7CmE3HeY4IJSSMXTP_O9sSP3HHHUD7Z29RNEG4Hc0m8f94jKWjFlekcTXvIBA-QdGYrf8w1sw==@protonmail.internalid>
 <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com>
 <87zextw4c4.fsf@t14s.mail-host-address-is-not-set>
 <CAH5fLgjYmvp1Ph3dYXnTKkAvWgNpgCAPeq_7PZhRai6pCNmVmw@mail.gmail.com>
 <87qzj4w2nw.fsf@t14s.mail-host-address-is-not-set>
 <BHf9mFp5zLg4GcKDzWhjsF9lzCPG1Pd8-nPd6b9HODeCiw9Nj9OAjU7aDmN6rnk-koAD37kW_flzkTMbOjp9Tg==@protonmail.internalid>
 <CAH5fLgjrQDWSPX-81TNdnc=AU3Jge57vUJ_SHCn8=uUyGfRq=g@mail.gmail.com>
Date: Tue, 08 Sep 2026 14:10:45 +0200
Message-ID: <87mrtsvt8a.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Sep 8, 2026 at 11:00=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Alice Ryhl <aliceryhl@google.com> writes:
>>
>> > On Mon, Sep 7, 2026 at 3:58=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>> >>
>> >> "Alice Ryhl" <aliceryhl@google.com> writes:
>> >>
>> >> > On Mon, Sep 7, 2026 at 2:38=E2=80=AFPM Andreas Hindborg <a.hindborg=
@kernel.org> wrote:
>> >> >>
>> >> >> Alice Ryhl <aliceryhl@google.com> writes:
>> >> >>
>> >> >> > On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.ne=
t> wrote:
>> >> >> >>
>> >> >> >> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
>> >> >> >> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wr=
ote:
>> >> >> >> >> +        // SAFETY: We just successfully allocated a page, s=
o we now have ownership of the newly
>> >> >> >> >> +        // allocated page. We transfer that ownership to th=
e new `Owned<Page>` object.
>> >> >> >> >> +        // Since `Page` is transparent, we can cast the poi=
nter directly.
>> >> >> >> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
>> >> >> >> >
>> >> >> >> > This doesn't satisfy the safety requirements of Owned::from_r=
aw()
>> >> >> >> > because the page may be used with vm_insert_page(), which inc=
rements its
>> >> >> >> > refcount and causes it to be shared the vma system, and this =
occurs
>> >> >> >> > before Page::release() is called.
>> >> >> >>
>> >> >> >> I suppose the existing vm_insert_page() abstraction we have is =
already
>> >> >> >> problematic, because it uses `&Page`?
>> >> >> >>
>> >> >> >> Maybe we want to change the API to use `ARef<Page>` so it alrea=
dy has to be
>> >> >> >> shared? Conceptually it takes a reference count from a `&Page`,=
 which isn't
>> >> >> >> possible because `Page` is not `AlwaysRefCounted`, so it needs =
a `&ARef<Page>`
>> >> >> >> to be able to do that op.
>> >> >> >
>> >> >> > Honestly, the problem is the safety requirements of Owned::from_=
raw().
>> >> >> > Pages have a "special" main reference, and free_page() does more=
 than
>> >> >> > put_page(). It even does something when the refcount does not hit
>> >> >> > zero.
>> >> >> >
>> >> >> > The correct behavior for Page is to allow the user to hold one
>> >> >> > Owned<Page> whose drop calls free_page(), *plus* any number of
>> >> >> > ARef<Page> references that invoke put_page() on drop. This way, =
the
>> >> >> > owned page controls the special drop codepath.
>> >> >>
>> >> >> This does not mesh well with the model of `Owned` behaving like
>> >> >> `UniqueArc` to `ARef` behaving like an `Arc`.
>> >> >
>> >> > It's a different case, I agree.
>> >> >
>> >> >> Please help me understand; with page having a main ref and an auxi=
liary
>> >> >> refcount, if we model that with a single `Owned<Page>` and a numbe=
r of
>> >> >> `ARef<Page>`, what would happen in the case where the main ref (`O=
wned`)
>> >> >> is dropped first? Is this legal?
>> >> >
>> >> > Yes, it's legal.
>> >> >
>> >> >> My intuition here would be to follow Garry's suggestion and have
>> >> >> `vm_insert_page` take an `ARef<Page>`. Can you elaborate why this =
is not
>> >> >> an option?
>> >> >
>> >> > That would be the wrong ownership semantics. The C side increments =
the
>> >> > refcount rather than take ownership of a passed-in refcount, so the
>> >> > correct argument type is &Page.
>> >>
>> >> Or `&ARef<Page>`? Because with `Page` being `Ownable` it would not be
>> >> OK to increment the refcount from just a `&Page`.
>> >
>> > That's just a limitation in your traits. There is no problem with
>> > creating a refcount from just a &Page.
>>
>> Yes, I agree. The limitation is by design. My point is, `vm_insert_page`
>> can work fine with the `&ARef<Page>` type. So if that would be OK with
>> you, I would patch that as part of this patch.
>
> IMO, Page should implement AlwaysRefcounted and this method should
> take &Page. Anything else just adds limitations that are not needed.
> But I'm ok not implementing Ownable for it.

Ok, I think you have me convinced. Mainly because `Page` as it is has no
benefit of exclusive access.

>> >> > Now, for the use-case in Binder I believe we could switch to
>> >> > put_page(), as we don't need the extra stuff from free_page(), in
>> >> > which case we only want ARef<Page> and do not require Owned support.
>> >> > But as long as we are calling free_page(), it needs to not be
>> >> > clonable.
>> >>
>> >> You are calling `__free_page` directly in binder? I could not find th=
is
>> >> with grep except in the C binder. Is this code you are calling into f=
rom
>> >> Rust binder?
>> >
>> > Via the Drop of Page, not directly of course.
>> >
>> >> From `__free_pages()` kernel-doc (`mm/page_alloc.c`):
>> >>
>> >> > If the last reference to this page is speculative, it will be
>> >> > released by put_page() which only frees the first page of a
>> >> > non-compound allocation. [...] **If you want to use the page's
>> >> > reference count to decide when to free the allocation, you should
>> >> > allocate a compound page, and use put_page() instead of
>> >> > __free_pages().**
>> >>
>> >> I guess this is what you are referring to? We could change `Page` to
>> >> this style as well and all would be fine I think?
>> >>
>> >> At any rate, today I learned about Pfn walkers, compaction,
>> >> memory-failure, etc. that take transient refcounts
>> >> pages. With that in mind we need to reformulate the invariant of
>> >> `Ownable` to exclude optimistic transient references.
>> >
>> > Yes we can switch Rust Binder to use put_page() and have Page not
>> > implement Ownable at all. That would be okay, because Binder's pages
>> > are not higher order.
>>
>> As far as I can tell, we can also switch `Owned<Page>` to allocate the
>> page with `__GFP_COMP` and use `put_page` in drop.
>
> I'm not entirely sure if __GFP_COMP is needed, since the page is order
> zero to begin with, so I don't think it makes a difference.

With alignment on `Page: AlwaysRefCounted`, I think this becomes
orthogonal. When we want to support allocations of more than one page,
we should probably make them compound pages (folios) and manage them
with the refcount (put_page), rather than non-compound high-order pages.
But this can wait.

>> > But this case still does highlight that
>> > Ownable<_> currently does not address the use-case where the
>> > Ownable<T> is a special reference there can only be one of, rather
>> > than a completely unique reference.
>>
>> This is not the use case `Ownable` aims to solve.
>
> Maybe not, but then it doesn't apply to Page.

I agree.

>> > For instance, the GPUVM abstraction would be another case where
>> > Ownable<_> could be used if we have this other model where Ownable<_>
>> > and ARef<_> are legal at the same time. Currently GPUVM uses a special
>> > UniqueRefGpuVm type to solve this problem.
>>
>> I am wondering if we can make case I intend to solve (Ownable is a
>> unique reference) coexist with the "at most one of this ref can exist".
>> The "at most one of this kind" sounds similar to the `ListArc` use case
>> to me, which is a different problem.
>
> I think they can co-exist. If AlwaysRefcounted is implemented, it is
> the ListArc use-case. If Refcounted but not AlwaysRefcounted is
> implemented, it is UniqueArc use-case.

I see.

So for v21 I will implement RefCounted + AlwaysRefCounted for Page and
drop the Ownable implementation, have alloc_page() return ARef<Page>,
keep vm_insert_page() taking &Page, and switch Rust Binder to hold
ARef<Page>.

I will also include the SafePage/ExclusivePage series [1] in v21 as a user
of `Ownable` with a few modifications. It will no longer be possible for
this type to deref to `&Page`, due to `Page: AlwaysRefCounted` and
`vm_insert_page` taking refcounts through `&Page`.

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/rust-for-linux/20260605-page-additions-v2-0-03f=
04c8fdbbf@kernel.org/

