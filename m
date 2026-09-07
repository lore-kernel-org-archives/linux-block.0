Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077F448391;
	Mon,  7 Sep 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789536; cv=none; b=c4W41MGjtHK6xfVDxcbm9b7HHuLqGHnrAkd9I24WMRl9mUow7spdxZJYkDu4SM2HyulG7GiUOD0iSY79zlVo5Bp7iEpZARYSbkfaSXyGrkXKJ1ZcNHNZM8hDCDe4bWqp7IzBcQuD7b/pHD9dABscV9JMXp3Z4UjsaqyWNHeed/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789536; c=relaxed/simple;
	bh=FoCP7lPoDfHG2GfC2Z1IJE/VE1BgpSCafAaICpL0ILw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rEdgY+w4GQlKSQuobykD1EvA0Ym+FB2JKitBZRjCrJZ9ZJC7+vsMam8jnHW52CcgyZPOMzZKR4gA8I0NoxrU6/dgiEF8zKGflWQ5GRiXflb8HDNXGLMfjwWyJTF2gYX41UEyeAUWVQTIJkT31XtUsVTswTWAvr92iFFONXRR2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu3IZRZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu3IZRZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7821F00A3A;
	Mon,  7 Sep 2026 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789534;
	bh=I6HvKokTBWQ5qgUPDm6WwxT5+vJL6f+t/uawYA58zoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Wu3IZRZrPimxJw8Xrfy4xfMIQYTFuR01X8avL7jkL6VDDrRR/R5ZOFA2yk6u1qm/w
	 AKoK2kijj6fYGv5w8z+yajL7wx8MHIt41AhSubYNt4+Zd6KlEXkqZX/mbd8drzk9W4
	 BhAcsbTdhvbMQ0uxnwA4wAf3wYS7iFq4rFc1zYtkKv1sUwUKX2MnKP8p3a2Kd5g6iU
	 gI55Yv2wG8TFVCTbExYoWOrB4WMke5xHKiy6gRZJDHOIqxHvyE18ycr3ZJ8xPejC3Y
	 IggNAEHiJaevSjwpzqvJKs3X3UeTqGP8ry5v4xe4lCj+SE0wSrAqt5ojIe9ehxWWS7
	 fBME7tR0VAR4g==
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
In-Reply-To: <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com> <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
 <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
 <2dpwVpJS3VbfQ7CmE3HeY4IJSSMXTP_O9sSP3HHHUD7Z29RNEG4Hc0m8f94jKWjFlekcTXvIBA-QdGYrf8w1sw==@protonmail.internalid>
 <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com>
Date: Mon, 07 Sep 2026 15:58:35 +0200
Message-ID: <87zextw4c4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Mon, Sep 7, 2026 at 2:38=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> Alice Ryhl <aliceryhl@google.com> writes:
>>
>> > On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wro=
te:
>> >>
>> >> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
>> >> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
>> >> >> +        // SAFETY: We just successfully allocated a page, so we n=
ow have ownership of the newly
>> >> >> +        // allocated page. We transfer that ownership to the new =
`Owned<Page>` object.
>> >> >> +        // Since `Page` is transparent, we can cast the pointer d=
irectly.
>> >> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
>> >> >
>> >> > This doesn't satisfy the safety requirements of Owned::from_raw()
>> >> > because the page may be used with vm_insert_page(), which increment=
s its
>> >> > refcount and causes it to be shared the vma system, and this occurs
>> >> > before Page::release() is called.
>> >>
>> >> I suppose the existing vm_insert_page() abstraction we have is already
>> >> problematic, because it uses `&Page`?
>> >>
>> >> Maybe we want to change the API to use `ARef<Page>` so it already has=
 to be
>> >> shared? Conceptually it takes a reference count from a `&Page`, which=
 isn't
>> >> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&AR=
ef<Page>`
>> >> to be able to do that op.
>> >
>> > Honestly, the problem is the safety requirements of Owned::from_raw().
>> > Pages have a "special" main reference, and free_page() does more than
>> > put_page(). It even does something when the refcount does not hit
>> > zero.
>> >
>> > The correct behavior for Page is to allow the user to hold one
>> > Owned<Page> whose drop calls free_page(), *plus* any number of
>> > ARef<Page> references that invoke put_page() on drop. This way, the
>> > owned page controls the special drop codepath.
>>
>> This does not mesh well with the model of `Owned` behaving like
>> `UniqueArc` to `ARef` behaving like an `Arc`.
>
> It's a different case, I agree.
>
>> Please help me understand; with page having a main ref and an auxiliary
>> refcount, if we model that with a single `Owned<Page>` and a number of
>> `ARef<Page>`, what would happen in the case where the main ref (`Owned`)
>> is dropped first? Is this legal?
>
> Yes, it's legal.
>
>> My intuition here would be to follow Garry's suggestion and have
>> `vm_insert_page` take an `ARef<Page>`. Can you elaborate why this is not
>> an option?
>
> That would be the wrong ownership semantics. The C side increments the
> refcount rather than take ownership of a passed-in refcount, so the
> correct argument type is &Page.

Or `&ARef<Page>`? Because with `Page` being `Ownable` it would not be
OK to increment the refcount from just a `&Page`.

> Now, for the use-case in Binder I believe we could switch to
> put_page(), as we don't need the extra stuff from free_page(), in
> which case we only want ARef<Page> and do not require Owned support.
> But as long as we are calling free_page(), it needs to not be
> clonable.

You are calling `__free_page` directly in binder? I could not find this
with grep except in the C binder. Is this code you are calling into from
Rust binder?

From `__free_pages()` kernel-doc (`mm/page_alloc.c`):

> If the last reference to this page is speculative, it will be
> released by put_page() which only frees the first page of a
> non-compound allocation. [...] **If you want to use the page's
> reference count to decide when to free the allocation, you should
> allocate a compound page, and use put_page() instead of
> __free_pages().**

I guess this is what you are referring to? We could change `Page` to
this style as well and all would be fine I think?

At any rate, today I learned about Pfn walkers, compaction,
memory-failure, etc. that take transient refcounts
pages. With that in mind we need to reformulate the invariant of
`Ownable` to exclude optimistic transient references.

Best regards,
Andreas Hindborg


