Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D023FC5A;
	Sun, 13 Sep 2026 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269116; cv=none; b=CAbULuQvPezH/8Jow7BnzhsmP8oXEor9ju67+Gv2rOVhRZdlAYxjBauksivnVcwZPFTtaB/PQ4f5/watVdrEgjU+gcIYuW9gpzcRAnB/AVXiTVDouQlxubUaOLMtgFfcuAh9U3ReWKXnVEa4w1pWgnTNKYK/VBRS12hPXxvDURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269116; c=relaxed/simple;
	bh=lG6My4wnTEsn31dKI0mnQFtd2gAifBlGSMfIxgn83vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC4AWstuiyar9KXut7nHJfE7lDBW4Wbo6pgmw/ijqU+31Tak9sOhpv4EvsYQSwMcOY9S6u4FigKqxKJkdvsBnTscNyRqAxb9aFXi0RKUWjRUhhdvw16npBaN+Va/HjEvj/ri/jiNCAD6tP/Q6+K7ARXQ1DhlbIc8+GEzCMBNECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCR8M2oB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCR8M2oB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ssrb0XY/cPSH8ZAUVROdvAzpy0zzHhYV7tpvfy8CQwA=; b=CCR8M2oB4m+y0ftzq1hl5Cd7Sp
	Eq4utnfvBFq8gG0OogYzPZnaQmzmOp5fGRpwLZZxXeWo5U93OC/Wz+xi6QYk98IdczgUTQT2qoCKU
	KRd5XLKE1z55BO0DvoKqhe880rWuFdw1oBGkG7StPD4m+68dPIwtGr3HiGHt0EP5J31zAOnhXrkq6
	H9YfQ8GzUvx+lR7ad3e/FRHlzs3qPoF6bfrnkWMKjURpXqLuM58MWTSM8LvGJrlpAd2Zzgd3Kprn7
	9QWHr0RTjUAtUGxCv0xeRJ5uWFR4OjKHcnWu/4GD7GYpMcua8HluIaf9wWQfAzw2c47qK2YYb1024
	17XaQfSw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5acl-00000003JyY-1RDO;
	Sun, 13 Sep 2026 03:11:23 +0000
Date: Sun, 13 Sep 2026 04:11:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Lyude Paul <lyude@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Igor Korotin <igor.korotin@linux.dev>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ira Weiny <iweiny@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v21 9/9] rust: page: add `ExclusivePage` for race-free
 page access
Message-ID: <aqYUWzRSade_Ww67@casper.infradead.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-9-e83257373062@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-unique-ref-v21-9-e83257373062@kernel.org>

On Thu, Sep 10, 2026 at 11:00:13AM +0200, Andreas Hindborg wrote:
> `ExclusivePage` wraps a regular page but adds an invariant that the
> page data area does not incur data races. This means `ExclusivePage`
> cannot be mapped to user space or shared with devices, and it
> becomes simpler to directly reference the contents of the page.
> 
> Since `Page` implements `AlwaysRefCounted`, handing out a `&Page`
> from an `ExclusivePage` would allow safe code to obtain an
> `ARef<Page>` to the page and break the aliasing invariant of
> `ExclusivePage`. Thus, do not implement `Deref<Target = Page>` for
> `ExclusivePage`.

Given this description, I wonder if this shouldn't be implemented by
alloc_frozen_pages() / free_frozen_pages().  We'ree certainly trying
to move the C parts of the kernel away from thinking that pages have a
refcount (folios have a refcount; otheer memdescs may or may not have
a refcount).  Do your intended users of this actually have a need for a
refcount?

> +++ b/rust/kernel/page.rs
> @@ -17,7 +17,11 @@
>          AlwaysRefCounted,
>          RefCounted, //
>      },
> -    types::Opaque,
> +    types::{
> +        Opaque,
> +        Ownable,
> +        Owned, //
> +    },

While I'm asking stupid questions, what's the significance of the //
after Owned?  I see it after RefCounted too.

