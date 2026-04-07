Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AE2F83AE;
	Tue,  7 Apr 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590792; cv=none; b=Kq35ssqnevxym/YnmNbDwgtza23ODIiXSRedjmLhry38rzbCnJxBFv7q62O3i2NmCKZambRNAo8M7YsRna73vygez3SuL2YauKa8h9IvYgB1eiHlBTat/cSZ/qPV9xJHJZXonE6i6j+gUVyPOKchkq8O5DIzRKZ3Vkpcv1pYSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590792; c=relaxed/simple;
	bh=CGezKdEqDPdo1kPCwuUYGddzvOOGAGtk2UxFXojRw1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK4NevkHr9IKdA389JVEAVbXw8GwYKJkwWfw8eLzeYZxlRBMNc3tDAycuLef9VC/hzH7qGduMNf/uyzthW9b2g2CFdJpoXF3EywtI9p/VboVJUGWgT1G6n4ZDYYk5T44GJuhhWGz2+Fokr7FXieK+NR6WC0iBWgAK/EKDpv+ZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGI2ToMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGI2ToMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475BC116C6;
	Tue,  7 Apr 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775590792;
	bh=CGezKdEqDPdo1kPCwuUYGddzvOOGAGtk2UxFXojRw1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGI2ToMRaUBAZVtejPVUq+e50ea/lP7efouoxy/kxmec44WkUdcbfxeDKvy+NBH1I
	 lekyMnxmXkrJZAdHX/bmB0KrMI9UqXmhXX0qmMpjy1OD2MwCaAi/NEpcCnRciWPR0z
	 0IgKByy8pEpqVSWX9WfKXZypizebnKZYmpngAkydT7MQb1VgAbohRz7fq668Q6dvOv
	 4660d/sfvox9Dh9lgwP54A/lPT6vSgoFoxAFw5dZQ9BQAAq9Km8NNFG1j1WAnmmicb
	 c4NpgbDr10Fi7rCCwJSS5OsYI8o9fCq0+bmyvf/XwaGmyXmBcai9/7Z4ZpfPUqkGKv
	 /KEaSzJFvOboA==
Date: Tue, 7 Apr 2026 21:35:26 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 32/33] rust: kbuild: support global per-version flags
Message-ID: <adVcfpoZGH2Rf899@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-33-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405235309.418950-33-ojeda@kernel.org>

On Mon, Apr 06, 2026 at 01:53:08AM +0200, Miguel Ojeda wrote:
> Sometimes it is useful to gate global Rust flags per compiler version.
> For instance, we may want to disable a lint that has false positives in
> a single version [1].
> 
> We already had helpers like `rustc-min-version` for that, which we use
> elsewhere, but we cannot currently use them for `rust_common_flags`,
> which contains the global flags for all Rust code (kernel and host),
> because `rustc-min-version` depends on `CONFIG_RUSTC_VERSION`, which
> does not exist when `rust_common_flags` is defined.
> 
> Thus, to support that, introduce `rust_common_flags_per_version`,
> defined after the `include/config/auto.conf` inclusion (where
> `CONFIG_RUSTC_VERSION` becomes available), and append it to
> `rust_common_flags`, `KBUILD_HOSTRUSTFLAGS` and `KBUILD_RUSTFLAGS`.
> 
> In addition, move the expansion of `HOSTRUSTFLAGS` to the same place,
> so that users can also override per-version flags [2].
> 
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mTaA2tjhkLKf0-2hrrrt9rxWPgy6SfNSbponbGOegQvA@mail.gmail.com/ [2]
> Link: https://patch.msgid.link/20260307170929.153892-1-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas
