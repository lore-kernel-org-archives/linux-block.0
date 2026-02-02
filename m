Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259762D63F6;
	Mon,  2 Feb 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026798; cv=none; b=s8YJ2vUbpVR30HyHR0OaXb9yR5LgWFy9ScYKrkd4OLly1UBN4fmrvZaNQrslK0hZuoy+JyNolXpkANinmxDQC+GpJ9qxU/fs9qXKuXrLBlqV5rY1X4IVuQse5fS4GsUiOWQyStelg4XRTwflC6dFkE/Cwa/1tHpAgM1J9vJsEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026798; c=relaxed/simple;
	bh=AR8WJZlCheylxeYBIiVxCcxzyOcuAsM0oQ9x69QBGeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoHEXogpBdZKkvBYA+pPiwaDHeOlL2ueBOt+rkrWF54gxMjNu3LWybSybTntLInLKdpD3rr9cG8JgJNILo+XhwnKlqI7kw0XJlLBZk7/8lpaUaAPLl/GchBD8lelSA/NzISP3F/viz588M2fS8Mz0xsd76++3MH+NEVHzfsBvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Zk2JPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Zk2JPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4988CC116C6;
	Mon,  2 Feb 2026 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026797;
	bh=AR8WJZlCheylxeYBIiVxCcxzyOcuAsM0oQ9x69QBGeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F3Zk2JPtX9BKsOfGhozTjtxp24jGgOGKlChNCS+jg88F1hIocpFuLVSYIR18rCyVU
	 Moue0o90AkrrRNWLZsD3Ivul0Ujd6NRdOLRfS4mbYhd+jIgh3WaUTu37sqLhjoVDDM
	 ZgNKC4CQQbziV9McP8h+/UTn9ywlHI2QkvLZ2ar9yc3YlJ8hR3SruAEiAa6yi0It27
	 BEnKNuFE3HNDel0CDsOIk6P757sPTcTgYwWOtVRxtchr0rBPAWQmmqwkgUZckaznQa
	 zih68OgLAg6wb4fCu8Re3XEGr9fp/N7elqd9Vgxj/bLH1xzTBTaowCfXgw4AOXcm0E
	 o6qWmBVO6NSqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin
 <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Paul
 Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 2/4] rust: `AlwaysRefCounted` is renamed to
 `RefCounted`.
In-Reply-To: <20251201160030.6956a834.gary@garyguo.net>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-2-b5b243df1250@pm.me>
 <20251201160030.6956a834.gary@garyguo.net>
Date: Mon, 02 Feb 2026 10:48:39 +0100
Message-ID: <87wm0vpjbc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> On Mon, 17 Nov 2025 10:07:57 +0000
> Oliver Mangold <oliver.mangold@pm.me> wrote:
>
>> `AlwaysRefCounted` will become a marker trait to indicate that it is
>> allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
>> types which are also Ownable.
>
> The message needs a rationale for making the change rather than relying
> on the reader to deduce so.
>
> For example:
>
> 	There are types where it may both be referenced counted in some
> 	cases and owned in other. In such cases, obtaining `ARef<T>`
> 	from `&T` would be unsound as it allows creation of `ARef<T>`
> 	copy from `&Owned<T>`.
>
> 	Therefore, we split `AlwaysRefCounted` into `RefCounted` (which
> 	`ARef<T>` would require) and a marker trait to indicate that
> 	the type is always reference counted (and not `Ownable`) so the
> 	`&T` -> `ARef<T>` conversion is possible.

Thanks, I'll mix this in with the one I sent to Daniel.


Best regards,
Andreas Hindborg



