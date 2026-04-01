Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917D4779B2;
	Wed,  1 Apr 2026 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084467; cv=none; b=SanRsjR++UJBkhMAavtyg0aNdITvuv7TyQp0pA1alYRbIvxPE+LvMuqBgLDWUVoOgerIku3qs9j637sry/SahHnLcfEFJthpUbJy1h60pXVL/jToA8eQ2r46uDom6VuzH0fml2cTncjgYoWN4QLmuTtJ/B2X5R4Na3/4hyuqe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084467; c=relaxed/simple;
	bh=LzgaJ83Rv9pU4dQmi5pVMrmBrHvBC5e78go2tjHZcUw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=okz+EwiQNr9WLw1NzrUYlaTsAGqoRAkGYRfMMgj2BHh0vVtSgpn3kw2fCmpKYKViwoQCQ+B5Y3EA2OtVeCeOD29FVSdmbG83jO53g7Z5/9SppgDNNwzwvW7MZiqrc7yWo7QeArmdUxK6R+HLh9/SSQ/L2Kct4NlMYn28C4wkaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUrzfe8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUrzfe8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B37C2BC9E;
	Wed,  1 Apr 2026 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084466;
	bh=LzgaJ83Rv9pU4dQmi5pVMrmBrHvBC5e78go2tjHZcUw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=nUrzfe8NhDQtpCvFinZVfgnt+tjQMOtFRIGAge4DLGYxrMoQoEQ86XmqX8MSuc5Ud
	 txs3xwHIDwocyZXQNb8jfz80mh53Jd3wusB05jFNLe2fZYgGPLD3nUtGFreumspUTm
	 IAjMDmuiHUSjuwSg00b5B+WSMN62p00RXD9mocBhaqNA3Z+o7B4jWYwGDTUpQeGfbU
	 PfL9deFZ1hdxZ037QHqHZwJAwprww4p/wwBhY1w9e1tRkHHwxiuYOLMQPqidV4AVLZ
	 uqzeLbgTQ+ENe3R61hPcesdN9JHCGklBcMT6RDuu6hjy6GsrjpcDvSx2HJMRbK4sqB
	 EqCJGUn9bUPPg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 21/33] gpu: nova-core: bindings: remove unneeded
 `cfg_attr`
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
In-Reply-To: <20260401114540.30108-22-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-22-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434461.73816.5410904852576871478.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=497; i=tamird@kernel.org;
 h=from:subject:message-id; bh=LzgaJ83Rv9pU4dQmi5pVMrmBrHvBC5e78go2tjHZcUw=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7tI1RtVf7/3VF2vMEx1i8aDGZv9ug9+b7OYN+Fqj
 7LpjPMnOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz10/cM/yP3ruBYcveqWSf7c9aSQN+rd7vL/k1+czI4vmvCx2fH6/IYGQ4vurz
 s3Km+wk3Xq9Kzd2z6cj3qyOaHxU6TS+sf5DBwT2AAAA==
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:28 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> These were likely copied from the `bindings` and `uapi` crates, but are
> unneeded since there are no `cfg(test)`s in the bindings.
> 
> In addition, the issue that triggered the addition in those crates
> originally is also fixed in `bindgen` (please see the previous commit).
> 
> Thus remove them.
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
