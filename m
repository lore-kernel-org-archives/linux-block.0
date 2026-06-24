Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF5353EC0;
	Wed, 24 Jun 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328589; cv=none; b=M86YYailUi6O2IYmMEF4nCtY3Z9JypsedvqkG+ZhtSB9rsnOoL+pSmHpgn+g1MCPzg/ZB21Q9B7VQ7bD4PFTdnIBz+ohXS4Ajwwh6ET363Shg7CLHmR94vqmtOHmsGoIom6KgXWTL4BOA9OvIsGmvrm+8u0eZXDjb3z4WnQHn6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328589; c=relaxed/simple;
	bh=KrEIkLxcPGYN34vBeTlzsqHNKqQFfNJZucq2NDeLFds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYvgb6VKokOoOZ6yyHynixK+Zr90FhORSyBAMOJ/L/xkSwbNIpBCiFqzHFdXo014r67Z4tXBlxXcM6WI7K2yOdVr1Oelmz8fS+JTyMlFDz0hfZPD69o3y+XN3e6auHQH/eQQnocQX12p0fHmJ0EjHy10CpNKMgSkKnhXZ36UkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnOgRR5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnOgRR5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EEF1F00A3A;
	Wed, 24 Jun 2026 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782328587;
	bh=KrEIkLxcPGYN34vBeTlzsqHNKqQFfNJZucq2NDeLFds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XnOgRR5KS/l4WG/j1n3WoPLzoAlQNFABguQn7ZtgvJG6R/Lk+Pb5+MmbghczBYMQa
	 8cHtbFvfrX5WYSg1jz9tE2kwrJ2AqvMqVWJPvy+db6JmaB6vvJo07jbY9sDcoXbYNp
	 O7OR24FEQHPSBIGrqlv3crUToit8sFF2NfToUqUMU4TP2PU0zH8yp5vZoTYkY35QcD
	 VCwKoUa+xOI1bGGwIGwqheuD2tb3egqLNaoweVgQf4aUeDHy7Fsff3WGaoNewhDe4O
	 0FlfN6+MWzs8cJRqtO4bYBJJy7pGKqvIOKZgeNCvRev/dSJgJReB7ZXgNZTM19S6aI
	 1Qay1fRI6EA1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Daniel
 Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Igor Korotin
 <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v17 08/10] rust: aref: update formatting of use statements
In-Reply-To: <20260623175531.85421-1-work@onurozkan.dev>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
 <20260623175531.85421-1-work@onurozkan.dev>
Date: Wed, 24 Jun 2026 21:16:09 +0200
Message-ID: <87fr2biwau.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Onur =C3=96zkan <work@onurozkan.dev> writes:

> On Thu, 04 Jun 2026 22:11:20 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> Update formatting if use statements in preparation for next commit.
>
> I guess you meant "formatting use statements"? Also, why not doing this in
> the next commit directly?

Because it is an unrelated change.


Best regards,
Andreas Hindborg



