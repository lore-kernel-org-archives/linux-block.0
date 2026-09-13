Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315933B6E8;
	Sun, 13 Sep 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789292231; cv=none; b=X80xjUhVk40TdFcvYZxtKjcPHpTRGB0aKI7c5zYWDN9xcnrfa5MMFi4NBh1BkPQgdHpLFTvk0qw4xfUc0JMXGBD7FSkFbS9LH3IPs5q8Vm4TewhC6cr+pIO03O5jX8egL7lvK/dHwlyRSU/Fersfpxh4SZFnumBqhNgfKMuiPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789292231; c=relaxed/simple;
	bh=vdwZyUESC/usVPAkdnOVBw1iWK78gw2er94VuCtRjQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWEOmPaPcNQNruS08ABBIa1Ho1l9ud5DA4uU+g4+6BtwJn5mFzYSC6qYOuBhIk6IvHxAYnVTJlaf0bzyQA+ZR8WbvL9U5Ue2ZNfNjSnFpaaH+Ch6tfVBwqdymNx0/gvIG0TviRn+0yhKoIwPHiApLs8LN6v8UjDM31qaQ6EFKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXq3ebKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXq3ebKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B941F000FF;
	Sun, 13 Sep 2026 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789292229;
	bh=TeKLAo2lyBFX9D/j+t1NddJvYANiKwcO6O8pNn5tCYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZXq3ebKyzE91YMdk8KbwizzTYuRfKiJOjlC7hKcGtHQQZJ5nCJUfiu07FF3uqPR7f
	 o6PqZ16b+Hzz787iWq7uAC2vR9/5i/IcYkPHKcuLhWMNuP85R6uSJM7F8FyrlWBS1Q
	 KGIHV9T/yk+v10sUF/WNyxF8c8Po1Eo24e9YNLKt1UalWmzbnS3U12EvMGLOio9tEM
	 ODMte60um3jwtWBD0ubXBYEB7KUwVDXh6qnHC7TqbJBMW531TTW44iAHQTQrd9L9Ll
	 YCzgkk7cH0cJu67QwfwU4dQxrTMaBkv9vzAy6OxG6D2amnqezq/M6SGoPo0FCl+y/h
	 jcgRapmP3RlUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Philipp Stanner
 <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 driver-core@lists.linux.dev, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v21 9/9] rust: page: add `ExclusivePage` for race-free
 page access
In-Reply-To: <aqYUWzRSade_Ww67@casper.infradead.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-9-e83257373062@kernel.org>
 <aqYUWzRSade_Ww67@casper.infradead.org>
Date: Sun, 13 Sep 2026 11:36:53 +0200
Message-ID: <878q55v6fe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Sep 10, 2026 at 11:00:13AM +0200, Andreas Hindborg wrote:
>> `ExclusivePage` wraps a regular page but adds an invariant that the
>> page data area does not incur data races. This means `ExclusivePage`
>> cannot be mapped to user space or shared with devices, and it
>> becomes simpler to directly reference the contents of the page.
>> 
>> Since `Page` implements `AlwaysRefCounted`, handing out a `&Page`
>> from an `ExclusivePage` would allow safe code to obtain an
>> `ARef<Page>` to the page and break the aliasing invariant of
>> `ExclusivePage`. Thus, do not implement `Deref<Target = Page>` for
>> `ExclusivePage`.
>
> Given this description, I wonder if this shouldn't be implemented by
> alloc_frozen_pages() / free_frozen_pages().  We'ree certainly trying
> to move the C parts of the kernel away from thinking that pages have a
> refcount (folios have a refcount; otheer memdescs may or may not have
> a refcount).  Do your intended users of this actually have a need for a
> refcount?

I'm not familiar with that API, but I will take a look. The
`ExclusivePage` would not need a refcount. The reference is intended to
be exclusive, giving mutable access to the page contents.

I could imagine a situation where someone might want to transition a
page reference from exclusive to shared, but I do not have a user for
that at the moment.

>
>> +++ b/rust/kernel/page.rs
>> @@ -17,7 +17,11 @@
>>          AlwaysRefCounted,
>>          RefCounted, //
>>      },
>> -    types::Opaque,
>> +    types::{
>> +        Opaque,
>> +        Ownable,
>> +        Owned, //
>> +    },
>
> While I'm asking stupid questions, what's the significance of the //
> after Owned?  I see it after RefCounted too.

It is a hack to get rustfmt to format the import statements in a Linus
compatible manner [1]. As far as I know, it will go away once rustfmt
learns to do this by itself.

Best regards,
Andreas Hindborg


[1] https://docs.kernel.org/rust/coding-guidelines.html#imports

