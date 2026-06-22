Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD739EF23;
	Mon, 22 Jun 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121552; cv=none; b=nSkZ/nQGqu5XCUvS0SKjyxn8bvGT4kktm+GpI90U2pxg/IrCCxIJ7v4Ox7TWZZbqoejU5xml1/wjVWyN/u04J+wqjrF+4Mw8LPK01X9JwR7iJ6uqiYZA+jbN0LYtfe2d+WMwSJx48AfuurJaoyVbeLHND2mY0XF5h+ddSuhNKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121552; c=relaxed/simple;
	bh=KbqDbO/6Da+smogL0j1WQvfUcASLT2JRLggY+SRaKWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUpw5T175O79olFsTupSu9OeJojmTk2Mnfl0eRSKThvvJOcrqw0PnvYj4IAkZIPO2XPxEbb0LSFgc5kFzX2OE3ooh9n9d5WTdKZxJdlIJazhQvKWTqZrm7QGAjiV0JQr6G6NY6lZPxFtUd2tBi/RTnuRk4PllxpQCgXuEcaaRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke7r9MLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke7r9MLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6661F00A3A;
	Mon, 22 Jun 2026 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121549;
	bh=KbqDbO/6Da+smogL0j1WQvfUcASLT2JRLggY+SRaKWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ke7r9MLfedUaZyoTCtG7sAu/d9pO1Gom3CHm8tWeA3mVTQ3A0svce8Ru4ScauJjdV
	 6TOardpjckqB/TUSW7BB8kkig4hfNIBOAXFZ0IaUEAkFwj59Jn2QgrdrzUVI9Oalyi
	 F/jJ6WN9e8wnLlZN0r/hyCaXEg1hlSaBamvZFH7N06eFWZzSvFUp5UajoD1tFwij5L
	 IgRUYaQHeIhTXpwoDVIy6dOrT0bELUVp52mNoCPFKrxrXBzcJ8EdNnSBuH2qVOA1rY
	 U2QXbh+J3lZ7YKhslLZQZ/b7lJHUXWXFPEsyjU8izoMS5FcygtohzQxTWT6IrG6pSO
	 1xh+mOqiV4Rqg==
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
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 1/6] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
In-Reply-To: <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
Date: Mon, 22 Jun 2026 11:44:36 +0200
Message-ID: <87h5muewor.fsf@t14s.mail-host-address-is-not-set>
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
> Move the `THIS_MODULE` static from the `module!` macro into the
> `ModuleMetadata` impl, add a `this_module()` helper, and update `__init`
> to use it.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



