Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9F34404B;
	Wed,  5 Aug 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922012; cv=none; b=Lf98nSm4WTQ+MvHt6v9p/tISDZdrGz3Bmznr1XMzWVUQhK+Jg0SdtgujVE0jUXfOwxUWG6UT8INYPvvHWMJCsNc2xM6InRMT/OxlbtrJ7/2h3795MnJJ53QAfOSui16aXGHs7j0Y8snpztfQi8tvRut8OgtgH5REDatk9CIn8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922012; c=relaxed/simple;
	bh=Ubge1xIhaMVtNlK1W4+X5SNrqz3ntDqZDTmYPkn/nf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYLPv/z6PAspwzUnDB1USen/8BPQjLRChs8a/ccMBKBQYDUmaST/eJI50QJAWgxBzrtbFGYqryVbSTUTMjwJigLEA2wtGfMyIZQr0n8MHuCMWU5gxMbJ3CE42Jt1i279x0+GcVUl71gSiBa2cQeDaL+RBxBv/e491ur/0ABGbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQyTH42u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQyTH42u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187241F00A3A;
	Wed,  5 Aug 2026 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922010;
	bh=Ubge1xIhaMVtNlK1W4+X5SNrqz3ntDqZDTmYPkn/nf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JQyTH42uXQexz55JjOim55HIDMLIO8rx5JZA6mc0pfSqhqVsFV4t0AR1xby9i8PcZ
	 u4bljuEIXHSw4A97VrATcDzUwdrzZR6zOZYHkvM3wFgCJMC5CwS6f02Phd0buLNvqA
	 +D9nqehMXxxoccLfCQ05Fro9k0IWl4RwjxNy+cSHoS56plJjC5F/DUVgUyHZVbFMFc
	 zrekZqd2pIIvBUCihrZJ6gr9fdxZVrhVK8oZNlI2t7oIXvMKeLw8FHsCz3OV9vBsjk
	 tEeBiJq9cDNJdc3hlz+2xUCzIIAaw9Tm0baqz3Jl4gW23olatVRjxDwhgoUVEfFOzq
	 pLYXqXeWlPKcQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com,
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 viro@zeniv.linux.org.uk, brauner@kernel.org, igor.korotin@linux.dev,
 vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, m.wilczynski@samsung.com,
 boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk,
 daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com,
 j@jananu.net, lossin@kernel.org, acourbot@nvidia.com,
 markus.probst@posteo.de, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 bjorn3_gh@protonmail.com, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, sergeh@kernel.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jack@suse.cz, ljs@kernel.org,
 liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org,
 ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
In-Reply-To: <20260628095132.47753-1-trev@trevrosa.dev>
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev>
Date: Wed, 05 Aug 2026 11:26:34 +0200
Message-ID: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Trevor Chan" <trev@trevrosa.dev> writes:

> `AlwaysRefCounted::inc_ref` is a function that shouldn't be called lightly.
>
> To prevent accidentally calling it, change `inc_ref` to be an associated function.
>
> Modify all `AlwaysRefCounted` implementors to work with this change.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1177
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Trevor Chan <trev@trevrosa.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


