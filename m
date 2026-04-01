Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDF47DD48;
	Wed,  1 Apr 2026 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084405; cv=none; b=CtPaJSGFeeXoNl1yVZ2hO+UzZ7L6gJnxrkPLjJeFu9eu9xgrXzi69UIx1ecjGaLDJCO4M+9CqiUJ/Y/00Q+qtLBVbeT2eXlg2eCzsFLKUFigF9waBbqLJp9FJjgU9jb3ckQ/Xqiaf9+BNoxGeUSc3YbbVu9Kdg92n7fQN7QfgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084405; c=relaxed/simple;
	bh=oOFcElemP5A7wKciwQSJtcDjY7nR2WhKiKPxc1QU1AE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=paP0CauP/u1xfvyucA6wLKhDUufuFyjpTpqp2Y/ls3n/6gPe9ypmBU7jvvKpQMb8mqnDVcKRdfHjkmvBMHSgEPY9MXVicrVqge5GJ6Y7T7X0G+/padqjYW2aoXE74sn2YSbY4cyOf1rlHLQYEWolHZloShew6cH6gVbMSOm9dEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfevY7C1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfevY7C1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A1AC2BCB2;
	Wed,  1 Apr 2026 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084404;
	bh=oOFcElemP5A7wKciwQSJtcDjY7nR2WhKiKPxc1QU1AE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=rfevY7C1b5TrlF3FJhGmdswzRil6yigf3cumL5j7c2Yi/75Zo/Oc+JEx+z2RPd8Xh
	 hxUy3OwtZ0si2kHEQ+t+aFj86IJkz616rQvvphqmHWBYUSl95h+F3dbGEdVw7jB6Gf
	 z/fVRMVbCh+bReJhMbmMOPAOG0Jn+77dz4FxvgMtQfPbuW17nMwiP3s9/L+M8EFygA
	 8loKiM2+bAT04zCjFNhKIijsUYh2raA/4A9NUw0DQrsgrIvjQncm5jjSxF6tOSJoiT
	 K0AhRukOzBZLNH4BYWCOVdK6Z9r4yzVV+TLBpYfwEgBaA81laNLmee8pl34GozLiV8
	 U8Ei3ddqh50Bg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/33] rust: kbuild: make `--remap-path-prefix`
 workaround conditional
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
In-Reply-To: <20260401114540.30108-10-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-10-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434441.73816.15326490215165782904.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=486; i=tamird@kernel.org;
 h=from:subject:message-id; bh=oOFcElemP5A7wKciwQSJtcDjY7nR2WhKiKPxc1QU1AE=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFzuxWc8K3b29/8DJlgcp1w4JF/jIF93QPNXv/NrPx
 /zAyXi2joksDGJcDJZiiiyJoof2pqfe3iOb+e44zBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjoGPMwMUpAFN9vIThv+Prwmmi3lJMAVNWcD55r9/MzOFr79wi3rvX+8zbxbpNwQz/Q/rXnZF
 91W6rmuz4+O6+l9d1Vt/6WMDWt8ZLbelc31YnXgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:16 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> The Internal Compiler Error that the comment mentions [1] was fixed in
> Rust 1.87.0 [2]. And, for other workarounds, we plan on limiting where
> we apply them [3].
> 
> Thus limit the ICE one too.
> 
> This will help to make sure the workaround is not needed anymore on
> newer versions.
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
