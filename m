Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43223F99EF;
	Wed,  1 Apr 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055455; cv=none; b=Erd0wd1l+/nDd3eIcqZmK9wTQy9vPdNCA4HpOQWMVq+mKPf+R4kG6EccO1Bfr7LAt1LOQgjj5PMMdB4jz98/9qOeht56tJUM0dMIyw54tLSl1yldYq9PosL3JCvInfIH1ZFBWlfyHhG0OH7i423mhPOlN4Wetf0ZSrinF5aJf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055455; c=relaxed/simple;
	bh=8e2oNK+RNa0NzKd4ZlabYjd8IqP/GM5sHzXlyJGAd+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l7AsgDeNU6Owkwcmm5CEHIX3dc/4YgRmV/1uoG5lEGFaG6K/TxWWsNScwMCBdQBLftLWcm7a4fQFA/CuxYCxj2fSZK5n3HzEu249oWpc9x5QxT9g43omGcoS7+2MHN+d/MbC4y2EAh8Mr8Fsjr/PXdshUEcZLIl7TrI66VpIQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUKes+mM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUKes+mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74290C19421;
	Wed,  1 Apr 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055455;
	bh=8e2oNK+RNa0NzKd4ZlabYjd8IqP/GM5sHzXlyJGAd+w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mUKes+mMPs5iX2Viqpl9YEl86lcLJksX1Gm+Yr6B8QPMTf30lx89O2N4j4uuRrsBt
	 /WvZPEZXGvjv5HHYWLRMgt89uNfXGP2JoNEUA5+6vWs31qT6KXWzmOepYAC6w3/ykq
	 65Mfexkf/2wemcaMM77IqDmD9DJaj3yY175CnUJa1sC+ANoroZ4twvbzpIYHfpWSOs
	 2Zjfn4ErkryA82DEigqSFP4d/XQVInePh1+SDffXkjaaFz1OU76sLVrNgbh2ehMITL
	 vuBN0C9PQLVQShwJWA4kjUmjBbYNtiYIsifnmGW7kksVSKd/ea83EEwhf/sQ9cN1MW
	 b64kr4qjr5Q1w==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:57:24 +0200
Message-Id: <DHHWN1TBVAZS.2EAX0F648ULPU@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
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
Subject: Re: [PATCH 01/33] rust: bump Rust minimum supported version to
 1.85.0 (Debian Trixie)
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <christian@brauner.io>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>
X-Mailer: aerc 0.21.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-2-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-2-ojeda@kernel.org>

On Wed Apr 1, 2026 at 1:45 PM CEST, Miguel Ojeda wrote:
> As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
> we are going to follow Debian Stable's Rust versions as our minimum
> supported version.
>
> Debian Trixie was released with a Rust 1.85.0 toolchain [2], which it
> still uses to this day [3] (i.e. no update to Rust 1.85.1).
>
> Debian Trixie's release happened on 2025-08-09 [4], which means that a
> fair amount of time has passed since its release for kernel developers
> to upgrade.
>
> Thus bump the minimum to the new version.
>
> Then, in later commits, clean up most of the workarounds and other bits
> that this upgrade of the minimum allows us.
>
> pin-init was left as-is since the patches come from upstream. And the
> vendored crates are unmodified, since we do not want to change those.
>
> Note that the minimum LLVM major version for Rust 1.85.0 is LLVM 18 (the
> Rust upstream binaries use LLVM 19.1.7), thus e.g. `RUSTC_LLVM_VERSION`
> tests can also be updated, but there are no suitable ones to simplify.
>
> Ubuntu 25.10 also has a recent enough Rust toolchain [5], and they also
> provide versioned packages with a Rust 1.85.1 toolchain even back to
> Ubuntu 22.04 LTS [6].
>
> Link: https://lwn.net/Articles/1050174/ [1]
> Link: https://www.debian.org/releases/trixie/release-notes/whats-new.en.h=
tml#desktops-and-well-known-packages [2]
> Link: https://packages.debian.org/trixie/rustc [3]
> Link: https://www.debian.org/releases/trixie/ [4]
> Link: https://packages.ubuntu.com/search?suite=3Dall&searchon=3Dnames&key=
words=3Drustc [5]
> Link: https://launchpad.net/ubuntu/+source/rustc-1.85 [6]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Very happy to see this!

Acked-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  Documentation/process/changes.rst | 2 +-
>  scripts/min-tool-version.sh       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
