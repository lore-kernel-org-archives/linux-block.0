Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65362D7380;
	Tue, 23 Jun 2026 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220388; cv=none; b=Zsku6JdYL3pnuTCAZzxoWcHCZACrYpXnsoWkKA2RH5dJUj8viRHWQ7yI+kTmNkUM3guDtqKI2IjMnmq+fubfzJXiKgHcuvfd6v12mIc0UkaXVVfxvvxbzmhgyu9v8m5bcuv91C61Y9V7UoSYu/A47E/KcIZcIuTZr5FKbp7aExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220388; c=relaxed/simple;
	bh=qcLfDsGf5XPj73nZRA08ZmnCvcH4OilI07UFYaMsrX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rIkzUdgL93r5WxbgHOcLrQ4yn9ylaqaxgvqbb7D22kHLmIOawUFNI/4gznlGKNl+ZTUOGu1v2p7zsv+mgI7YKiLNGz1xy99AtAnUU5NC4EZsOulRWzN3QQG6pOf3NxdqrMmggr7xk8L3Zprmu+LTXRI/OG/vVYPFboh+wFv80mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjCnwgpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjCnwgpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46C41F00A3D;
	Tue, 23 Jun 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782220387;
	bh=qcLfDsGf5XPj73nZRA08ZmnCvcH4OilI07UFYaMsrX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OjCnwgprBvqVQyzGVVvo6XJUzznS8AnpuvLHrOCQFqN1QVYAEwE/GNzUwv15vVox0
	 RV7qTbnR9HY6Bg1g4XuP+B/sca6oV8MerRA5MOYnkIW7AlhNI/BFy/pEHGefWsXHVC
	 0QPKUgRxjZskNeLVc1ExAFytUesI1m7OuDn8caryOkjGWcnibEErL8YN0/dEn8DNQb
	 I8DV/2fAeAHWsxW5kh76Uvlj8KrzcccHNBBGocme+XQOgne01TRAVsB1vaR45JAdZ8
	 OzDlBA5wSSflDSl0fC3Sw0rbs2ZcKlIxufpPcm8cBKVDKZgrJkVaBExwebq3v40D6G
	 RMmb3OgkINwtw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
In-Reply-To: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
 <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Date: Tue, 23 Jun 2026 15:11:33 +0200
Message-ID: <87bjd1pfju.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> From: Asahi Lina <lina@asahilina.net>
>>
>> This allows Page references to be returned as borrowed references,
>> without necessarily owning the struct page.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> [ Andreas: Fix formatting and add a safety comment. ]
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> This will not compile unless Rust Binder is also updated.

I'll be sure to build test against binder.


Best regards,
Andreas Hindborg



