Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843247885C;
	Wed,  1 Apr 2026 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084399; cv=none; b=XPjHypELOKnpRT8kEnVWFJJMwB/9hHKkvSdwPjLbVRyrZzPfPKGE7X3/UUskvH1E9vVJ5O+HFBXbRD4JYZeT334ZH0v4spA5xoTBRc++NfYXUIHfzbrVyDAy1/pUYTc9Q7gNm67pRBWd4zyspbOjTuWp6ThyHDFg2AnxIPeNI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084399; c=relaxed/simple;
	bh=fqu7rrOs0OL/Tb+VSqQKqwQjSGQycaS8iS2//8/RxF0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Dzup9PeBTX2Xth9JBAJQNBID2xFoObgfP50tuwtrvvy2284YmusI+0CN+seVKOYplD/VjtisPldkoxSHXWkoouM41t+IwRF/4vzdj3cOXZMXzt3ZDNQ6LnwV4j2ZX9mKeuX7er1WiUAQaxOWLqUcNklrmhKvDE/04YHx5a5Q7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Yd6ysn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Yd6ysn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D93C116C6;
	Wed,  1 Apr 2026 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084398;
	bh=fqu7rrOs0OL/Tb+VSqQKqwQjSGQycaS8iS2//8/RxF0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=c3Yd6ysnQsGvROMtiSG+i3keeAySaiEerx1F2TBjnnkbqAXThe8bhBC5TmfGTw9Ll
	 iM81wVmrttBVfy5JGtlkpYWTB5ilbanIlMhp0u4XLelpZ54ZBP9JGO7PEfdS98oppP
	 y1H/3B42flzzuBQD0t+C6ViMRYVYqRKw6ppF4wNedlfutWkS1yja1IkZ7vaakl9Efo
	 IKyM2ubpcSiV/tFrD+PTVckV9ziEPjgOBuaWD4QFRsvbkk4PqOy2XpnWUC1wi9waM7
	 +yybB8tYYyxCkeQF+HluEUtULU29DO+VEutqMf9F51Xq320twioy0N0OMyWPyHHuGK
	 7JSnJjlMo5Dpw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/33] rust: kbuild: simplify `--remap-path-prefix`
 workaround
From: Tamir Duberstein <tamird@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
In-Reply-To: <20260401114540.30108-9-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-9-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434440.73816.18221552058190562777.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=tamird@kernel.org;
 h=from:subject:message-id; bh=fqu7rrOs0OL/Tb+VSqQKqwQjSGQycaS8iS2//8/RxF0=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFztxvDld6+gaffHc/FPfFslrHQpc18Fd91tnQkf8u
 4NCctUdHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKY6aQXDb9Y/z4KOTNn7TGbrdYcmuYmuSobSbdGFPlXr2/x/qzq8V2Nk+HB8ce+
 j1zZzz6+zOelcOtmmT6rvz1aj+a/nK5UETLn5jAUA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:15 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:

Does this simplify the workaround, or just remove one instance of it?

> [...]
> 
> Note that commit dda135077ecc ("rust: build: remap path to avoid
> absolute path") re-landed the `--remap-path-prefix` flag (together with
> `--remap-path-scope`), so we keep the workaround, i.e. an alternative
> could have been to simply delete the skip entirely, but since we still
> have it and it will be needed when this gets merged, let's keep it.

The use of "re-landed" is confusing without a mention of commit
8cf5b3f83614 ("Revert "kbuild, rust: use -fremap-path-prefix to make
paths relative""). Though this whole thing might be clearer without a
mention of that history; the important part is that there's no
conditional use of `--remap-path-scope` in the base commit but there
will be when dda135077ecc is merged (the use of "this" in "this gets
merged" is also ambiguous).

>
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 193cf06eea64..708530ee3613 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -142,10 +142,9 @@ rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-a
>  # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
>  doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
>  
> -# `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
> -# since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
> -# 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
> -# issues skipping the flag. The former also applies to `RUSTDOC TK`.
> +# `rustdoc` ICEs on out-of-tree builds in Rust < 1.87.0
> +# (https://github.com/rust-lang/rust/issues/138520). Thus workaround the
> +# issue skipping the flag.

_by_ skipping the flag? this is preexisting, though.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
