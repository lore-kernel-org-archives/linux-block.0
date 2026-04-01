Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB06480978;
	Wed,  1 Apr 2026 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084482; cv=none; b=GVcVfeA+kqiSE0zKc2tfS52uMbh7koOsejM1hr5dSnPCvOF6huKDf1RVwe8Lmd7fKJIn7wRS4FoIksxI7xRwO6qbBj/D02LxF8X2S9AHEFJwLPA9X7LL6jao4m4XdklUmS3XMNr3GOi3OWIFlhJtoYobLHvAY/BX0P7t6A+Zj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084482; c=relaxed/simple;
	bh=6656iS8Z953zXAk/bn8KpSt1Oh4C8fXwc0OPqmLk+Wg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=H6oiCU8dCdKRLq+eEgp2azymStObej3kqEwbctfCpomTiQNxJEbLpXPTCrJq1pO3CdjvaBW58tsTacfPyvGvyYGCYIqLF44ZiLKWk6e5IfVFtRwhUC+26WR+so1HKwe/B8vAsHDRI4OthMKcva5yJ+8i2eP5maIqgd0GSxXWLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnZUWOir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnZUWOir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E7BC2BCAF;
	Wed,  1 Apr 2026 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084481;
	bh=6656iS8Z953zXAk/bn8KpSt1Oh4C8fXwc0OPqmLk+Wg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=RnZUWOirA715kbUPApG8z/29huJIEsdvuiYpn4e51BGl8Ih9SKFkc8mSpA7VTChiB
	 x9CVKCriNZkE9qjuaipqjo+nCQVG45LC+x9BJfMr26Ka2UW9mJ3orbH1f+2MVf8rKs
	 g5Zxd3sc+h9Awoqdt/jrZcCCNplpoC8xYVYMJ5lSdUcmrwD+FiH36uWGgU4rjiWVNO
	 ugNNPXvHlZzVsQ58hUHNyoop8UyO3R2aa7bYcrnxq//E7woWnwm2eFwJwJ/08jWKAM
	 uYP7EZaf1nmiAP00xNPx4xm9mZO8bt0go7da8uTuzQNPOnpLq+/734ONfHKrXmysCf
	 jJVgMm6it7WKw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 24/33] docs: rust: quick-start: update minimum Ubuntu
 version
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
In-Reply-To: <20260401114540.30108-25-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-25-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434466.73816.13717819961434434560.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=430; i=tamird@kernel.org;
 h=from:subject:message-id; bh=6656iS8Z953zXAk/bn8KpSt1Oh4C8fXwc0OPqmLk+Wg=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7vYT5udIq//NWh3249c6Zw3aa2uE1ildkhcKim49
 Glpsf7MjoksDGJcDJZiiiyJoof2pqfe3iOb+e44zBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjoGPMwMUpAFMtfoaRYYZs6f3+qpndGzVXCi3h9u8KjP8wX+SNtVZRiJHZvG0PrRn+yr6UuBJ
 UWq+RY6pw/fwCn9/Xfx5LiJtkZDJlt7jYZ7ZpfAA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:31 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Ubuntu 25.04 is out of support [1], and Ubuntu 25.10 is the latest
> supported one.
> 
> Moreover, Ubuntu 25.10 is the first that provides a recent enough Rust
> given the minimum bump -- they provide 1.85.1 [2].
> 
> Thus update it.
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
