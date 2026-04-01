Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985B480956;
	Wed,  1 Apr 2026 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084477; cv=none; b=NKHm1HwhWZBJYz6R/xDpaxI13T+UPvq/2ahYvH5wLNY7EhfuaPubbcKlPR4DmLGAHowj6ltZFmleG5i2bt8mKmvsrPspM1NckX43hnJga35kSyr7uR7ZnFIdgCdlX30+LS/a61TcmagUr2unYFlQV0S1O4i68UQDKLECki+qMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084477; c=relaxed/simple;
	bh=/ydyEhz1DfGzumvhdQVG/OS2phIoiIQNTGMzn2SAkqw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CpMeFxzmYEVIsIpB/293+ansgUut4Egvu2awpTeboeUMb77fa4NoRhUkHAM6jIT8XL0pcEMGIW3vjXaaDva4v5+VXN4fLSjt5ucGY/ZOPVGIBwaDLP3/G+5YIRYO/gClRUXrT93uxtgWhjSDPWbl1+41euppMR/6rLBxWCCCbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di5bTnxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di5bTnxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF2C116C6;
	Wed,  1 Apr 2026 23:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084476;
	bh=/ydyEhz1DfGzumvhdQVG/OS2phIoiIQNTGMzn2SAkqw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=Di5bTnxLkcJhbLRMmhbxvJjKY0SRkVEVWg/GdP1ZUtuebRBulfhXtGIssYtVqr0/J
	 XbYaoQPxt0nen0sXPYp6ql95eED9JB4UKDLcuAXM4toIW+wh/+IgRiDJJ2W0TPTZbx
	 ZRrpoSyzBeVowO7594KsTK3dsPW9L7y36OhRGkOGrPPSxz5OFvKixna8yH6WzDnG2i
	 Fbc2psWZS3oc0Bw7XSvdfVARkvJTB+5A/UqVJyY2TVw9JZDFmfvxqWDatbrKCt/dfB
	 hmVkwcWfF3TI9yCwWruUNtRztqpjPXoknhPCnxmtMeqlZ1s9NBB7OPRWEFjbAO4w7a
	 BrkP/vME8nT6w==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned
 packages
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
In-Reply-To: <20260401114540.30108-24-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-24-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434465.73816.4492182082440539007.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=585; i=tamird@kernel.org;
 h=from:subject:message-id; bh=/ydyEhz1DfGzumvhdQVG/OS2phIoiIQNTGMzn2SAkqw=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7s4Hs3X/Mwf1e/3yfei5X/Nlv0LJig4fzB9vHvai
 hk+7LstOyayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz139mMDFcPbV78tEDfR/rr1/KU/WF3PJ6fadDkEzkx9cmvaIFAiasMf7jrLgo
 8C2izvvSmccbjZ+5aTn9Vk0XX1rsL7Xle8aHNlx0A
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:30 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Now that the minimum supported Rust version is bumped, bump the versioned
> Rust packages [1][2][3][4] to that version for Ubuntu in the Quick
> Start guide.
> 
> In addition, add "may" to the `RUST_LIB_SRC` line since it does not look
> like it is needed from a quick test in a Ubuntu 24.04 LTS container.

RUST_LIB_SRC is also mentioned in the nix section, do you know if it is
still needed there?

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
