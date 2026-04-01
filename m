Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF803F7E93;
	Wed,  1 Apr 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046558; cv=none; b=KqHwJCBYzrpC2fskELLD8e2eccYmGkH7pRFf76g+gy3gBPo4ZNkZQkqEE+R7665atE0TKm6ogaJQ9kQLogj6kHm2CWT7Ks3CG9Kh1WuRlecMuuPCozora+QQ/sRWbNpeC7NyR0+3+D4avh+syHhuuu2LPRvvU5+YcgGfEawwEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046558; c=relaxed/simple;
	bh=LI9WhSdEEdZ3tG3mKql7VBDkTBXQLZ/gbuOGi0yNUv8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=DqVBxH+ynrYk4PPN9o0Ke2+zSXnJsD9s78vUtFYykrVrYVUN3lIJoqBkUkHCtHe1Aq8GNT2yu6hxv/1Dhd6betNQfBqJiS07oTVAkyhEBxGz1uVFE354jPCLrKaol85xnN7n6tbGRv73xE3JBVJXLROqbKhuzeVHwIuYIr2QVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNc4Unp+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNc4Unp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C95C2BCB2;
	Wed,  1 Apr 2026 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775046558;
	bh=LI9WhSdEEdZ3tG3mKql7VBDkTBXQLZ/gbuOGi0yNUv8=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=cNc4Unp+PRYooUmgGFFye5pDT1W9gMHh2kYwCyjV+QfNlITpPwQ/dJuvgfcNRQ2RU
	 OLAaelo2Y0M4WDZzhqq4RFZXh9vweX3G+C/5TXnNYfixFZeSPwJ1TncBCwnYdhO4+N
	 iUJBSVjzKvnbJsWNKBdcqSDoCCVgRcPImXqZXrY2LM7yFKn2M2coddn/epy+7pRRuJ
	 7kjR5sUlRh74ki1EVprakY7r7VdQLjXSDpn81irF7Wy3aK4ONAC6bsjxvO3qaEeF2y
	 Ih/6O0he7vcr4VTXsIepdeDgBSoaXWc/+n1c+XHcoTMZbv3F14pd5Q4viy/bXvnp97
	 pRV5GgtSPhWxA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 14:29:08 +0200
Message-Id: <DHHTHIT2GZIG.P942QFSTQ32M@kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier"
 <nsc@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <christian@brauner.io>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam
 R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki"
 <urezki@gmail.com>, <linux-block@vger.kernel.org>, "moderated for
 non-subscribers" <linux-arm-kernel@lists.infradead.org>, "Alexandre Ghiti"
 <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Rae
 Moar" <raemoar63@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, <llvm@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 21/33] gpu: nova-core: bindings: remove unneeded
 `cfg_attr`
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-22-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-22-ojeda@kernel.org>

On Wed Apr 1, 2026 at 1:45 PM CEST, Miguel Ojeda wrote:
> These were likely copied from the `bindings` and `uapi` crates, but are
> unneeded since there are no `cfg(test)`s in the bindings.
>
> In addition, the issue that triggered the addition in those crates
> originally is also fixed in `bindgen` (please see the previous commit).
>
> Thus remove them.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>
