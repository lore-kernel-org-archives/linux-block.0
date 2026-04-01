Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0547F2CE;
	Wed,  1 Apr 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084451; cv=none; b=FHmYj/aCuJ0qqw6ivUBCospPsYVGXLQ0y5fg8YBLhaBhidtuzjrWsAgHYvDIA5a64ujYGxRcTj0Danb7ASPI5suQSjTivjmQfh36TJP1NaAgbqzu3AvNnzWHFyqsw2R7ULxLza8FOQMJz9d0ITThrnvGSXCr1gjW0VrBtycgtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084451; c=relaxed/simple;
	bh=L8JME5DgePBPrx4n+T2YtWB9P6u86oez5ABp2z3CNBA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rDZg7SJx0o4TFxhU7u1bwvBHBcneEVH4GA7XOPn9MjN+l69bLRVTbpcLDABMLR/SUWmRYXLJAmFcSXD/bQs1nuifaWPdbrrgXlLKefG+415hlzkYQuahiE5vznc9K6Jp9t+fsdajMHCAxkBbQkz09zP5uy49DHcgD77/R8oBSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQSUAheh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQSUAheh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F8BC2BCB3;
	Wed,  1 Apr 2026 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084450;
	bh=L8JME5DgePBPrx4n+T2YtWB9P6u86oez5ABp2z3CNBA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=XQSUAhehK0geqbt+sp4fwR2MHzqQqgmyyza2UnqK99FLKtZPX8PbhFgagoLwnWdAi
	 A9uW7qhg1C+WKQNNQJ4vNBoC8JXS68HsTSryHtezbW548hEJOquK/PM01kl/j89c/f
	 ih8g3oNWTWFO1MaLODitg52leiBGTbkxz6aYWXplYU8puqoYtpqPyG7/ywmv6jdkg4
	 AyB4hcxDwgZeGNJgnI9m68RvOZW/AzDoZ8pLjYB1WsSkifuvQnIeNfN/pFZtBdF4K6
	 0PalwENmSLkuvFHYnm6l5DnOL2jZ9sMtoZUArx9XSiQcwfnoLzFHlQYB3YabNlWmEO
	 jrlC7XHARUJRw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 18/33] rust: kbuild: remove "dummy parameter"
 workaround for `bindgen` < 0.71.1
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
In-Reply-To: <20260401114540.30108-19-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-19-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434456.73816.17651402081142880831.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=315; i=tamird@kernel.org;
 h=from:subject:message-id; bh=L8JME5DgePBPrx4n+T2YtWB9P6u86oez5ABp2z3CNBA=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7tsuPi/M7kgl+fS9lvTjjNurz7ibmbL2VVoZaIdt
 un9n7tMHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKb6VCgjw4v/PZN5Nk0NjzqeHyr4dklm/dxVmTFP/8cu6j8cxxydxMHI8DJEqva
 J+w4L6+f+33+wndDmXuhZ3uDQ1f5l0UW7+TdO8QIA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:25 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Until the version bump of `bindgen`, we needed to pass a dummy parameter
> to avoid failing the `--version` call.
> 
> Thus remove it.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
