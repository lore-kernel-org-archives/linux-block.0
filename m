Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E53BE14D;
	Wed, 26 Aug 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736574; cv=none; b=OoF7QMGtk4VpdApYl8e0S4QfZexxcOgxycKVL1qoIv/ECKz2Aqyi4kAe+7Mig9K9eBUPYuIMU8zE8tjGHgrzIXOlqshPACqcFWKRr5pbT3GRgGcncT7/cs2txanmCy8NvMM0p+6sHijpn/VAR9wSUtpTv6t04DQpBvRHko2fCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736574; c=relaxed/simple;
	bh=vE0DFncUbEa7WUezDlJbcmjpQbbiEpMqeMkCvD7YDbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdYzgQmyKcGKmTl9mfPSgAq4opPLv6a+T/ALUBX8538mFeyhckPLL+E+och0kv9TUnkPQ9sW4h8897Ex6tdN9+pu4//DvxwSo3tN4FQgL6SJU3ov0oce54QxRsdCyTiyGSFD4OGXJBXJIxY58oHQYObo+WzDN+w+TblrRNolAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMLbpbtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMLbpbtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9931F01561;
	Wed, 26 Aug 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787736572;
	bh=vE0DFncUbEa7WUezDlJbcmjpQbbiEpMqeMkCvD7YDbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GMLbpbtV6XRD4w6KN91RH1oCiVx72uKzWQqLkbfx2kIDN9D9Eag0gzkEbhDAl0gWt
	 P1YCkvBlGTSdwRH3cp7KuiATo/uaSTYejkU3Vxpztm9iu3uFxILV1ojmRaKWYlikRY
	 Ggw4d12WTNh1bcjG7gDKhj2+I6mDhrKTue5CuHtVBbtjdSc5JxIGzd18mhpGbu9Yql
	 CcB/55rMLKstOxN38hkC+/m6VAXbVIPr7Ta8HzW2B+7BxGx5BXD678vW+tpQrbQfJh
	 g9tTDJTf0faFwf4/6U0eVGbrjKFJOeooMnCeoyi93Y+sF616btPc7GrV1O9Sww9y70
	 JGj0Mli2sglfQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
In-Reply-To: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
 <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Date: Wed, 26 Aug 2026 11:29:08 +0200
Message-ID: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>
>> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Do you want a link to this issue with a regular `Link:` tag?


Best regards,
Andreas Hindborg



