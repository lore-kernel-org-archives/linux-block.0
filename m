Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117C3806A4;
	Mon,  6 Apr 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485752; cv=none; b=j8M5wxLqww3sNpaBmTkK7HpD1Rux04v0/xr+kpbhiGeFAddI8+QEE8ejRoObtn20/sMRC0470Es20QrUK8nRcanht248H+cH7MDS6jnL0sS88lUBtmbK6LH9D2lP7wQXx3Qc66sLoYxJ5D8rjUNKRrZmIctWmukicKfUq/WE5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485752; c=relaxed/simple;
	bh=HnyXrN8Ze7oWN5RU90Xg4dEPZvkzNdPtLR2J7oWKONc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=b3TnVOKAd/47X26CVuz0L5WkVn0cIyYZiq64bVnUBgdZBy1iifY3Ut1DNPYnoIRyaEplri35ET8NQ7CRjEsOnt0pHVVbGV3WbJZH/xhGYr7guNBsMvTwJOUs0H6uBVwjgJoNSppBvoxk9gl0TLUDclpr1Il32IPxjujEr97tPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwTzkeF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwTzkeF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2070BC4CEF7;
	Mon,  6 Apr 2026 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775485752;
	bh=HnyXrN8Ze7oWN5RU90Xg4dEPZvkzNdPtLR2J7oWKONc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=lwTzkeF2x01R3fvgfnFiK7WfggVTtKgdI5PqAS3VuDqpIEjjdug3qWS7vtmd2KSdV
	 oTrDkT9uQ1/xp613yCRhmPXrgauzZR0SgdLw4cgb2Er+qKxCTR1UB18MekNP57ce2d
	 Dq+NCKPaveS/azu5fgX/lqg7329U84tez02UUqDJPJCyN8pddAgwpNDLQ0IkSpW1Jz
	 PtO3C6UpQrHPaXGREoTIC5FN/oFA5HuOyD8AMahOMQs/0AlImyQbF6YnkNDQHi8ivV
	 onmaDI0oyY05cOCK9W8+TufsXgVJdXN34et90aGjxYMba+57r4m5OtP1bI9SzohIux
	 tfdhwuQhJ5scQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 07/33] rust: allow globally
 `clippy::incompatible_msrv`
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
In-Reply-To: <20260405235309.418950-8-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-8-ojeda@kernel.org>
Date: Mon, 06 Apr 2026 10:28:56 -0400
Message-Id: <177548573697.95472.13544191227699996309.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=648; i=tamird@kernel.org;
 h=from:subject:message-id; bh=HnyXrN8Ze7oWN5RU90Xg4dEPZvkzNdPtLR2J7oWKONc=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJmXD+szR8md2/bwyZ1F0fYvj7t/r54Rzbf5hV3T8oV7h
 Q3jI+P3d0xkYRDjYrAUU2RJFD20Nz319h7ZzHfHYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdAx1jBi5OAZjqWT8Y/lmwJW9eJT3XMkOlYcLcExldDysMMzaVTNBntZYMfuz17zPD/3gXC6d
 lAllJAu0+OzxTQy8apMZvPH53ovG7oKmxvzfv4QUA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Mon, 06 Apr 2026 01:52:43 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> diff --git a/Makefile b/Makefile
> index a63684c36d60..78f5ee173eda 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -486,6 +486,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Wclippy::as_underscore \
>  			    -Wclippy::cast_lossless \
>  			    -Wclippy::ignored_unit_patterns \
> +			    -Aclippy::incompatible_msrv \

Could you add a reference to the upstream bug report [0] here?

Link: https://github.com/rust-lang/rust-clippy/issues/14425 [0]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
