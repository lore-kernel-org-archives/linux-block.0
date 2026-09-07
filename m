Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87A4A6CEF;
	Mon,  7 Sep 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784723; cv=none; b=oh2VzjaZxRBFdy1l2ZOWmh5tuDNLhseHWWj2i6s5fkuWEPLxvzDv1cIZUHOdM+r3kMhevYPKZnhZ5Ilnf+LYACd6gEgoZopw4jkwTFeOfhO/QiZzP6V2XDENEyLHgulreNgwMfWlOODWpv1HUMXotdg6Ekh8skA8CYvRIGkNlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784723; c=relaxed/simple;
	bh=2KKsXLABCVBrGrYgB3/AEs1QcF1OetznXpcnRKacGxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9jcIcwgJb/ykqLdo9q1TSuWJArzDKdySvdsh5GeE7qJNm0bbZrcn8di8r1Zhy/9YxmVzfss/vh/K4fiATZjEDlOzXU9F4VYuJUSjJmPfIMV75g56jnfY/NnfOVlG6PZIsfJ7OU/JXlyyy8qttgyJBn2tFE3nchQDEmRdlmAfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRYVCxLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRYVCxLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804011F00A3A;
	Mon,  7 Sep 2026 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788784722;
	bh=KD+2zcpvmkcDZ3cJuCNDIPkcI/BtMjbq/CkWlis/PbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kRYVCxLY0/vTJ+fbmiuidiZQ+nIGH/QQuK/Qi8lQ02VhxlPUZ0WJUQjPMPR57SbcW
	 q9ArkX+lA0h0qlH46NRcal31nv+ecnkEemNBrVHbmQ1h71tj5VST7+zO0x6YXSzB3i
	 cPQW6OnsBJ7tUaclciTTf0zGW4oR1lCVNyUm6YsyUC9aGtgib7AnMYkJNGu41k6wdO
	 /F3gYxxJ0BBinS+JZ2un9pBUwwbDdmNSaUG9m9bFQvkpJN3EFGFST8Mmq0yV6ViYwW
	 7xvSkClBpumHKJBZnZ2b9YGNbICmSo0MxgutXJ3cXXgZrZrwS7637pq/UkkfPReY2B
	 x5Ldt7pD8EE7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Lyude Paul
 <lyude@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXY=?=
 =?utf-8?B?w6Vn?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Christian Brauner
 <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Asahi Lina
 <lina+kernel@asahilina.net>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
In-Reply-To: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com> <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Date: Mon, 07 Sep 2026 14:38:23 +0200
Message-ID: <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>>
>> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
>> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
>> >> +        // SAFETY: We just successfully allocated a page, so we now =
have ownership of the newly
>> >> +        // allocated page. We transfer that ownership to the new `Ow=
ned<Page>` object.
>> >> +        // Since `Page` is transparent, we can cast the pointer dire=
ctly.
>> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
>> >
>> > This doesn't satisfy the safety requirements of Owned::from_raw()
>> > because the page may be used with vm_insert_page(), which increments i=
ts
>> > refcount and causes it to be shared the vma system, and this occurs
>> > before Page::release() is called.
>>
>> I suppose the existing vm_insert_page() abstraction we have is already
>> problematic, because it uses `&Page`?
>>
>> Maybe we want to change the API to use `ARef<Page>` so it already has to=
 be
>> shared? Conceptually it takes a reference count from a `&Page`, which is=
n't
>> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<=
Page>`
>> to be able to do that op.
>
> Honestly, the problem is the safety requirements of Owned::from_raw().
> Pages have a "special" main reference, and free_page() does more than
> put_page(). It even does something when the refcount does not hit
> zero.
>
> The correct behavior for Page is to allow the user to hold one
> Owned<Page> whose drop calls free_page(), *plus* any number of
> ARef<Page> references that invoke put_page() on drop. This way, the
> owned page controls the special drop codepath.

This does not mesh well with the model of `Owned` behaving like
`UniqueArc` to `ARef` behaving like an `Arc`.

Please help me understand; with page having a main ref and an auxiliary
refcount, if we model that with a single `Owned<Page>` and a number of
`ARef<Page>`, what would happen in the case where the main ref (`Owned`)
is dropped first? Is this legal?

My intuition here would be to follow Garry's suggestion and have
`vm_insert_page` take an `ARef<Page>`. Can you elaborate why this is not
an option?


Best regards,
Andreas Hindborg

