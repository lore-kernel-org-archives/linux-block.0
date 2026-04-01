Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A948481AA2;
	Wed,  1 Apr 2026 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084523; cv=none; b=q7A0lN/1FZ8w6cMTRiyvF/ud37/xrzYoy44eQWoMpm3aRoCDqsw2Ck0Z/gEE3KKyOIeJsrIwytelqrjBOClVau2roCmJS2BqyHkTUeMK9vn5mMh2zyN3jZn+mL95zqTxE3WqasgnSAOFl0Zp6CMNHOjVvaBskqVogloU1tZVsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084523; c=relaxed/simple;
	bh=mIoLqdGB6FEaivDOYbSVC5sMk8eFMcAZ8xp8MdTnV0k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EnUueJXsbNkT5FuDlfIP18VERE38VEVHSIjRB0uqM619OnSvXCWEZ1iLj0FA/QQZnvkSifBGINvwkE41KvWrSFV9WxWvhnIu9EdTwMT0IARsv6Xph/+cRG0/UaEQgkLDyx1FbDQoVH58Iwq7CUAGr73PlScOrFNyfRYt36BVYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXyGeWKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXyGeWKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BBFC2BCB0;
	Wed,  1 Apr 2026 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084522;
	bh=mIoLqdGB6FEaivDOYbSVC5sMk8eFMcAZ8xp8MdTnV0k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=ZXyGeWKi13Ct8X9D0547XxKoA9LfoDtpV+LhRj3iXOQd+bnjQ22veAr1KWQzEnIDA
	 kCTGsTKkVr/gscyEmrZwOvWOWJ7En260oBqHLZzHIzEAlkTuiEm6eUc5UILdqgZy+H
	 HXAequvu6ZpIY4U3LMW8wzpcshrEKczrtsPGEnHRqS7XkcXKcwcDDz47C4fWwDAXKO
	 OIQVKkdK/nf9H0jRFaReCDhlcyWz4+4QQtQPnKMye0CMmsL4cTMnrf7NbrpD+fnPzG
	 ktDfNcL8YfxyQiu9pd7SwNmlkrwL9bKsRyvSsH9EF8GOZzd/XyeyosIPxWhon0MbUH
	 E+D3sywT0mp+Q==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 33/33] rust: kbuild: allow `clippy::precedence` for
 Rust < 1.86.0
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
In-Reply-To: <20260401114540.30108-34-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-34-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434476.73816.11744805605122440072.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=490; i=tamird@kernel.org;
 h=from:subject:message-id; bh=mIoLqdGB6FEaivDOYbSVC5sMk8eFMcAZ8xp8MdTnV0k=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7s6hUfb+jyd9vbK0ZWKNtIml3vZzdZu5eWV+2r4r
 rMtuaq8YyILgxgXg6WYIkui6KG96am398hmvjsOM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFSr3mdk+LXi1KaghwuXvXvryuIh3xizmzukzafohmvWRgutvqoD3IwMq9NSuvc
 +cVOd5nUvf9cfyV0no/Naz6wyyv7a/lP08aU4HgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:40 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> The Clippy `precedence` lint was extended in Rust 1.85.0 to include
> bitmasking and shift operations [1]. However, because it generated
> many hits, in Rust 1.86.0 it was split into a new `precedence_bits`
> lint which is not enabled by default [2].

Might be good to retain some of this in a code comment.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
