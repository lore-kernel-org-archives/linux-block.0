Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B48C455176;
	Tue, 25 Aug 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662931; cv=none; b=q9+eaHdeaUm+LPj5lkAt05kseaJD1PqV5fait9BTqVjvoCT3vPOeo1QvfOvdtbn/9lATSGLAj2WaVj44TTWDkdEUED79JOK/08ViMjx1FOqvKoabOWzYcgDZRPt8OF5MpyWR3CWSiZgK24+N2LlRJvtUmBi7ea45pmqKCedKarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662931; c=relaxed/simple;
	bh=VNcoz4Pw6SFuZfea+o/jo++KMcxe/kAZME+DPG+fZOo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NTq2a4KDUx6kRIZVKlBjB89g1j5ad+cxMDUlXL9DkK2ezR2RdVqKQ8vUQfxTgkj7WVmurCxOIv2lWdURVisWbs98Bne2gt94Mk1j5hDr21kj0KS0LVpkm3Xlh7+phTFM5xh3HhqIVFUllyKs23/MK2/fq2BMzJ8kYcwciMY7NM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkp00pUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkp00pUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1972A1F00A3F;
	Tue, 25 Aug 2026 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662929;
	bh=VNcoz4Pw6SFuZfea+o/jo++KMcxe/kAZME+DPG+fZOo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Dkp00pUl9EQ7kOKFQgqA2AIpvWU64bXsCrPAHo2qX5sNnLEOXJ5aBfAY6fhEeaYrk
	 plBRhMhwwqmDXjQzXoAF4Y9UnaE6++ghDotlTwDLqWYKco+ySPZ81338ywjIpV8Yuh
	 kG5jEQvKZwhGsnHdrk1/trpBPttTYxDHgVrm53gWUteDdiXjBJVIq/kI3zv6QlPkIM
	 2f7Z1LsZE/FhsO0XeZBWqSuG8SmpE0fgIDqpLmj6Z7m3FMEITvXj/nUH5oYfWO/l67
	 T3X7eYN53W8nSAZXwL/AS8OsYKZ0bU6cnO/xBj/O/fGL++eW5F8VDSMJZSXdfvsV0M
	 Vf4P8RYBCMHAw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:01:57 +0200
Message-Id: <DKY1M6ZZENAL.152ELCOMXURCU@kernel.org>
Subject: Re: [PATCH v20 1/8] rust: alloc: add `KBox::into_non_null`
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin@linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira Weiny"
 <iweiny@kernel.org>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <driver-core@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-1-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-1-490735672187@kernel.org>

On Mon Aug 24, 2026 at 1:17 PM CEST, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Acked-by: Danilo Krummrich <dakr@kernel.org>
