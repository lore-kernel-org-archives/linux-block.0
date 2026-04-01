Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165333CE88;
	Wed,  1 Apr 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084368; cv=none; b=bnwdi9UdwpK0dp7aXXDoFBlp+bJEWam3Rickl0OAdYjr8BnrZIveZE3n7bv2Xyzk4W//J+5Q8A6LTPJLWfAvSJR843bu49COk/iRP4GzMT3Lej7vZx9fsekXvUMB2wBXZOxs6u/vSBoVIPlr0gU52g3Z7u6P30mSC25eEmD0dXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084368; c=relaxed/simple;
	bh=ARB27mkqWy48zHjSpe5c7mSg7apze9vr4gstNm/P1dA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CLn6OPKM6gKx8jYFmaK8bhqy1qwBIzlw7CWG9OB66WfpNNZK0DEBN2sAvyq769ouGTH9aaidl2XU+7fkwLDBSfH87XjS6g8eiis3OUmBa00+C5C6zZw/AitM9ZlJxmpE8ORzuwvg7IbC9Nrqw+gqs02okJ838vVHgbzWl5S4nGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSX2Jo1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSX2Jo1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4809DC2BCB5;
	Wed,  1 Apr 2026 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084368;
	bh=ARB27mkqWy48zHjSpe5c7mSg7apze9vr4gstNm/P1dA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=dSX2Jo1vUk8hHc6gSekzst2vH2DiO7wZ6u4beWxHN6DVag1hSDpfVxZig8BZqa+bD
	 wHlv9NAlTPwhU/5YXo2CA8Ei6wNqOZ8/nLpYVgOOdYcm1zfBUsWRfpaiKCY4Jps1RG
	 9i6RxukwkTR2YCbr57la6zwGNhonLkn99aq1wPZ7VT2QoMnVwAYowp/1fMO51Re26E
	 TABn3IhQMybvZV8qPytb8kneaw1xNx7b9VeBd7g0EgaLXlXLh82c3onZzwa+NlPG3W
	 hcibdBWYOWEOw90C6j681RTs8g0W7sezYjGQ9+EbN7MxFHn/Bvu+yavZFPq3imqpQK
	 KUt5j6UWP96ig==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/33] rust: bump Clippy's MSRV and clean
 `incompatible_msrv` allows
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
In-Reply-To: <20260401114540.30108-3-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-3-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434433.73816.8766024986606345244.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=403; i=tamird@kernel.org;
 h=from:subject:message-id; bh=ARB27mkqWy48zHjSpe5c7mSg7apze9vr4gstNm/P1dA=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFzsxPz5uG3k8Tj7ir4KoUcXix9PWt0Ys/8uk0vf3x
 vEzkUmfOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEx1UTTD/1L+44y5J4+waIo3pf15Py11ZY+jryrPC2mWBK/kjy84KxgZ2qzvZ/h
 m3M2+YXO9YNu6hUv38i1xFF8vziQ+Vem3T/xmNgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:09 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Following the Rust compiler bump, we can now update Clippy's MSRV we
> set in the configuration, which will improve the diagnostics it generates.
> 
> Thus do so and clean a few of the `allow`s that are not needed anymore.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
