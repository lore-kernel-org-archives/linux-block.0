Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707338E8BE;
	Wed,  5 Aug 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954579; cv=none; b=mlH7rU1FnV8ez1a4JyeizQX+AaaYa48aEjuGYal/d0ASw1IWhTAx848pwXaDSlU7MCn97Tq1WEu1nD79tanNp+DahDhSDstXeUFDqQxWQ6r2s+eBvEBVcGtDnXEVM/5fLfKTgNM00YaYvFllv7UhNLYQTDxl2bmsHJWCsvHb6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954579; c=relaxed/simple;
	bh=Ubge1xIhaMVtNlK1W4+X5SNrqz3ntDqZDTmYPkn/nf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HF5SHRX7b8TVjro75voyyGTBa4i6eVuvPDVBTBbR+hDIkK/bl43DfCRGrb7axmsq1iAcg30IPQNKl0x2oxdPoUyqmjc2UuW4opmEAUiOz2npY/C8PHmH597rtLk/SzIGxSU7+IwAW2XXtIciojwsJ8TUk2c18Ekxo7j5oE+VczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKIksMlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKIksMlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD051F000E9;
	Wed,  5 Aug 2026 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785954578;
	bh=Ubge1xIhaMVtNlK1W4+X5SNrqz3ntDqZDTmYPkn/nf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oKIksMlRhAGkTOqGfbYfo2uxbddIDPJ6yRuC1+qz0HD367Nw3b5uYOY7dJs6so52h
	 lPBCXxoBowrthLhtQuXnRCtfrCBvaNpishqA1ly4MRtnADuozm09vt/3ADBMG9VT1p
	 sHCeYqeSdkUWyfKQYQmHKenSMrN7+VuS0ZRKwMl8uXLFyKsxYTnc5tw/MCBeLUmmLI
	 ggBxcCdCTCPM7IIkH1PxMMHu9hGrczfwaqeUHJHXEbvL8qOtOBtF2pJmv5nEOHNnOL
	 mF6nK8TqTY51otnDD0UUyZIImdB35MGEF+GZ7VXF4qwBwGi4jMOtjwSIlPD0dmk2Gk
	 7iT75Pb8pB9+Q==
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
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>
References: <UWdIvfYijKEB-nyPuUo4FRBSzoE63d32sYuIQ9Cn-wWmceZpbNq-V2rcl_vTofMvOWAuXSPSc6YnxpYgwiMmjw==@protonmail.internalid>
 <20260628100731.64885-1-trev@trevrosa.dev>
Date: Wed, 05 Aug 2026 20:29:21 +0200
Message-ID: <87se4s775q.fsf@t14s.mail-host-address-is-not-set>
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


