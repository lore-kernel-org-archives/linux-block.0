Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2A3D5C2C;
	Tue, 23 Jun 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217749; cv=none; b=VjlCMG3XAUo6hJqpuuleemVZ8J+LmV53q2KRbC6Z70LuXOazH47xv7pF5rNwJzZNGxo8yrNfsZ8711iaQVwh/Z+qnKSB8PEVu1StSXUOHShKSqWcreLccO23rHAE7E4ncJbbdUxbIvxgCpUUXtCsIEWWPNzOK+zVP+EHo/G5v38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217749; c=relaxed/simple;
	bh=AZA/n+oIZ2Se/sfqnbOS30FAegm93+h0Gc+iPEdrR9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edOmXCcGAW7GTw5pZTgaItkQAXPrvzaW3AJ2tzvjqKACzehyGIkR9eZca04AapPWXjVLAteLE1GcWIqOZLg8RXbxDD8bHMgSk3bJ3vKrgCpbpqe2Zh5pCguJJlfomvV2ZiHiRgw9NkihB4kBqFAX2XhwZFvjp1n/xTYN2PiUE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6yzmLij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6yzmLij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2B1F000E9;
	Tue, 23 Jun 2026 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217747;
	bh=AZA/n+oIZ2Se/sfqnbOS30FAegm93+h0Gc+iPEdrR9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=O6yzmLijucxjukp8wJnRR+NnH7jWmeLbGZLSi7ID5Xqueatpz5RfE53EnooxphSh8
	 3SoCZaVVuswt/P87OrDPW0N6PmZ6d7up5nC4ecUF+RSqo4BulCblqzW8da4PYW7UuY
	 kqxfJ4CJ11IlDfDX6SvVeIO/ODsiUsea1c3NMTKhIqKQ10+zDYK+rgu6VUeYACwPj/
	 wlZ8s/w4tPJG9CjVa5eSJXbcQupy99Mr6qC/9qF1NITLq4SreJXHntjxUUQrS0XdRC
	 9K2NPy7aiRVEUCBFO8jWs8scJhI3/idu1LxKN4vcz3GJxHHdbMgeSxg2WexdLeP4Ke
	 QB9i+qE0bLoGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v4 2/9] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
In-Reply-To: <20260623-fix-fops-owner-v4-2-0daf5f077d5c@linux.dev>
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-2-0daf5f077d5c@linux.dev>
Date: Tue, 23 Jun 2026 14:28:50 +0200
Message-ID: <87bjd1e8zh.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Since `const_refs_to_static` has been stable as of the MSRV bump, a
> `ThisModule` pointer can now be used in const contexts.
>
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
> can provide their `ThisModule` pointer in const contexts such as static
> `file_operations`.
>
> Add a `this_module()` helper to retrieve the `THIS_MODULE` pointer of a
> given module type, and update `__init` to use it instead of the
> `THIS_MODULE` static generated by the `module!` macro.
>
> The `static THIS_MODULE` generated by the `module!` macro is retained
> for backwards compatibility with existing users and removed in a later
> patch once all references have been migrated.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



