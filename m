Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A840148E;
	Wed,  1 Apr 2026 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084425; cv=none; b=bA7hnA+X+xzMkABLnfnupisKstn+rE41mVabdXAy7OlOMvvroL1Z2Z8eH8wHHPCgHDtD42VaEGw19Wy7hWQoeerm6xbIET4umdLKRSsdPW1/TDsxL9GqxNKAiXhaBFo5lXWEeZ5X+8eizwmcMGCmhYqG7iw9vA/CuNGEQQf6Ggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084425; c=relaxed/simple;
	bh=9r+j9aJtexiSdsnA3tlntaKZ+10b/6Dtb9uN5qz0dUA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Gzf1VpCix1493Keldd5XVqTZ/SdfuK5+CeJMntTklk4hz+b8YUE4O7caIkW0GcR9XwwfAecqKsWVzVUE2hQt/fGG+cp4q3mQUwV3eNephhCSGUyn63PAcXccClCmFtuaL8ueM2HMgEnkklhjMBBhy7lQkVK79yuWIhdWPqAJ+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNCiRvfR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNCiRvfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56866C4CEF7;
	Wed,  1 Apr 2026 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084425;
	bh=9r+j9aJtexiSdsnA3tlntaKZ+10b/6Dtb9uN5qz0dUA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=TNCiRvfRAoSiNwWajo6d0tXBALrIB8uy30x62v/7vE1DSF0tGUGBWvB9FNsMOGiOL
	 r088gtwia8jZfrou5153siQUWg+QidfxbyYB4Ypow5AdBNPcZhSf05qfgKMPzQ41a9
	 ZXJJmDCivwRwYQbl0M8qhWW5DfT1+KZpXMWTHvGtTkPFHjox09+X+JH6M8f8ul03/R
	 bfWcSI1kXTIk26Acc7x2QdVjBUaonzABDS6685jJZTEk+a1LrIQVA/Fz+zAzT95oPw
	 IRSzJuq6+jnD9s7fnI9D/EamdCfX7ZbISJfeRtyPKPcuVCXdSxdB5slSxvZxxG9joo
	 AfLBw3t3VswhA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/33] rust: block: update `const_refs_to_static` MSRV
 TODO comment
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
In-Reply-To: <20260401114540.30108-14-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-14-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434450.73816.3437422593454602087.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=tamird@kernel.org;
 h=from:subject:message-id; bh=9r+j9aJtexiSdsnA3tlntaKZ+10b/6Dtb9uN5qz0dUA=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFzvbH589QYvn/4oPv4Xey3uvd0h7plq9692z5dJ5b
 wRSd+gWd0xkYRDjYrAUU2RJFD20Nz319h7ZzHfHYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdAx1jBi5OAZjqgpMM/6NnThCWnqBawfDCSNE+6vHTZwuXfX7lr3Th9K4XsjobdTYzMrS9mlI
 WcW7lHu1jfq8uugXyGtpkcCwxlc5QjlVaIdopxQAA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:20 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index c8b0ecb17082..912cb805caf5 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -140,9 +140,7 @@ pub fn build<T: Operations>(
>              devnode: None,
>              alternative_gpt_sector: None,
>              get_unique_id: None,
> -            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
> -            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
> -            // <https://github.com/rust-lang/rust/issues/119618>
> +            // TODO: Set to `THIS_MODULE`.

Good first issue?

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
